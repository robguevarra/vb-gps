import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from '@supabase/supabase-js'
import { XenditService } from "@/lib/xendit";

// Define an interface for the donation type
interface Donation {
  id: number;
  amount: number;
  date: string;
  status: string;
  payment_status?: string;
  payment_method?: string;
  missionary?: {
    id: string;
    full_name: string;
  };
  donor?: {
    id: string;
    name: string;
    email: string;
  };
}

// Define interfaces for the Supabase query results
interface DonationFromDB {
  id: number;
  amount: number;
  date: string;
  status: string;
  payment_status?: string;
  payment_method?: string;
  missionary: any; // Supabase returns this as a single object or array
  donor: any; // Supabase returns this as a single object or array
}

export async function GET(
  req: NextRequest,
  { params }: { params: { invoiceId: string } }
) {
  try {
    const { invoiceId } = params;
    
    // Define system user ID for operations
    const systemUserId = "fa5060a6-3996-46ea-ae5f-bd3fed7e251a";
    
    if (!invoiceId) {
      return NextResponse.json(
        { error: "Invoice ID is required" },
        { status: 400 }
      );
    }
    
    // 1. Create Supabase client with service role
    const supabase = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // 2. Check if we have the transaction in our database
    const { data: transaction, error: transactionError } = await supabase
      .from("payment_transactions")
      .select("*")
      .eq("invoice_id", invoiceId)
      .maybeSingle();
      
    if (transactionError) {
      console.error("Error fetching transaction:", transactionError);
      return NextResponse.json(
        { error: "Failed to fetch transaction" },
        { status: 500 }
      );
    }
    
    // If no transaction found, check with Xendit directly
    if (!transaction) {
      // Create Xendit service
      const xenditService = new XenditService(
        process.env.XENDIT_SECRET_KEY || "",
        process.env.XENDIT_WEBHOOK_SECRET || "",
        process.env.XENDIT_CALLBACK_URL || "",
        process.env.XENDIT_SUCCESS_REDIRECT_URL || "",
        process.env.XENDIT_FAILURE_REDIRECT_URL || ""
      );
      
      try {
        // Get invoice status from Xendit
        const invoiceStatus = await xenditService.getInvoiceStatus(invoiceId);
        
        // Create a transaction record if it's paid
        if (invoiceStatus.status === "PAID" || invoiceStatus.status === "SETTLED") {
          // Create transaction record
          const { data: newTransaction } = await supabase
            .from("payment_transactions")
            .insert({
              invoice_id: invoiceStatus.id,
              reference_id: invoiceStatus.external_id || `xendit_${invoiceStatus.id}`,
              amount: invoiceStatus.amount,
              status: "paid",
              payment_method: invoiceStatus.payment_method || "unknown",
              payment_channel: invoiceStatus.bank_code || "unknown",
              payment_details: invoiceStatus,
              payer_email: invoiceStatus.payer_email,
              created_by: systemUserId,
              paid_at: new Date(invoiceStatus.paid_at).toISOString(),
            })
            .select("*")
            .single();
        }
        
        return NextResponse.json({
          status: invoiceStatus.status,
          paid: invoiceStatus.status === "PAID" || invoiceStatus.status === "SETTLED",
          invoiceDetails: {
            id: invoiceStatus.id,
            external_id: invoiceStatus.external_id,
            amount: invoiceStatus.amount,
            paid_amount: invoiceStatus.paid_amount,
            status: invoiceStatus.status,
            payment_method: invoiceStatus.payment_method,
            paid_at: invoiceStatus.paid_at,
          },
        });
      } catch (error) {
        console.error("Error fetching from Xendit:", error);
        return NextResponse.json(
          { error: "Invoice not found", details: error instanceof Error ? error.message : "Unknown error" },
          { status: 404 }
        );
      }
    }
    
    // 3. Get associated donations
    interface InvoiceItem {
      id?: number;
      donation_id: number | null;
      reference_id?: string;
      invoice_id?: string;
    }
    
    let invoiceItems: InvoiceItem[] = [];
    
    // Try to find invoice items by invoice_id first
    const { data: itemsByInvoiceId } = await supabase
      .from("invoice_items")
      .select("id, donation_id")
      .eq("invoice_id", invoiceId);
      
    if (itemsByInvoiceId && itemsByInvoiceId.length > 0) {
      invoiceItems = itemsByInvoiceId;
    } else {
      // If no items found and we have a reference_id in the transaction, try that
      if (transaction?.reference_id) {
        const { data: itemsByReference } = await supabase
          .from("invoice_items")
          .select("id, donation_id")
          .eq("reference_id", transaction.reference_id);
          
        if (itemsByReference && itemsByReference.length > 0) {
          invoiceItems = itemsByReference;
          
          // Update these items with the correct invoice_id for future lookups
          for (const item of itemsByReference) {
            if (item.id) {
              await supabase
                .from("invoice_items")
                .update({ invoice_id: invoiceId })
                .eq("id", item.id);
            }
          }
        }
      }
    }
    
    let donations: Donation[] = [];
    
    if (invoiceItems.length > 0) {
      const donationIds = invoiceItems
        .map(item => item.donation_id)
        .filter((id): id is number => id != null);
      
      if (donationIds.length > 0) {
        // Use type casting to handle the Supabase response format
        const { data: donationsData } = await supabase
          .from("donor_donations")
          .select(`
            id,
            amount,
            date,
            status,
            payment_status,
            payment_method,
            missionary:missionary_id(id, full_name),
            donor:donor_id(id, name, email)
          `)
          .in("id", donationIds);
          
        // Process the data to match our expected format
        if (donationsData) {
          donations = donationsData.map((item: DonationFromDB) => {
            // Extract missionary data correctly based on the response structure
            let missionary;
            if (item.missionary) {
              // Handle both object and array structures
              if (Array.isArray(item.missionary)) {
                missionary = item.missionary[0] ? {
                  id: item.missionary[0].id,
                  full_name: item.missionary[0].full_name
                } : undefined;
              } else {
                missionary = {
                  id: item.missionary.id,
                  full_name: item.missionary.full_name
                };
              }
            }
            
            // Extract donor data correctly based on the response structure
            let donor;
            if (item.donor) {
              // Handle both object and array structures
              if (Array.isArray(item.donor)) {
                donor = item.donor[0] ? {
                  id: item.donor[0].id,
                  name: item.donor[0].name,
                  email: item.donor[0].email
                } : undefined;
              } else {
                donor = {
                  id: item.donor.id,
                  name: item.donor.name,
                  email: item.donor.email
                };
              }
            }
            
            return {
              id: item.id,
              amount: item.amount,
              date: item.date,
              status: item.status,
              payment_status: item.payment_status,
              payment_method: item.payment_method,
              missionary,
              donor
            };
          });
        }
      }
    }
    
    // 4. Return transaction status and details
    return NextResponse.json({
      status: transaction.status,
      paid: transaction.status === "paid",
      transactionDetails: {
        id: transaction.id,
        reference_id: transaction.reference_id,
        amount: transaction.amount,
        status: transaction.status,
        payment_method: transaction.payment_method,
        payment_channel: transaction.payment_channel,
        paid_at: transaction.paid_at,
        expires_at: transaction.expires_at,
      },
      donations,
    });
    
  } catch (error) {
    console.error("Error checking invoice status:", error);
    return NextResponse.json(
      { error: "Failed to check invoice status", details: error instanceof Error ? error.message : "Unknown error" },
      { status: 500 }
    );
  }
} 