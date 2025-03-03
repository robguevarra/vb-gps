import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

// Define types for our response objects
interface Recipient {
  id: string;
  full_name?: string;
  name?: string;
  avatar_url?: string;
  logo_url?: string;
}

interface DonationResponse {
  id: string;
  reference_id: string;
  amount: number;
  created_at: string;
  status: string;
  paid_at?: string;
  payment_method?: string;
  donor: {
    id?: string;
    name?: string;
    email?: string;
    phone?: string;
  };
  recipient?: Recipient;
  notes?: string;
}

// Define types for Supabase responses
interface DonorData {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

interface ProfileData {
  id: string;
  full_name: string;
  avatar_url?: string;
}

interface LocalChurchData {
  id: string;
  name: string;
  logo_url?: string;
}

interface DonationData {
  id: string;
  amount: number;
  created_at: string;
  reference_id?: string;
  notes?: string;
  status: string;
  donor_id?: string;
  missionary_id?: string;
  local_church_id?: string;
  donors?: DonorData;
  profiles?: ProfileData;
  local_churches?: LocalChurchData;
}

interface PaymentTransactionData {
  id: string;
  reference_id: string;
  amount: number;
  status: string;
  paid_at?: string;
  payment_method?: string;
  payer_email?: string;
  payer_name?: string;
  created_at: string;
  updated_at: string;
  invoice_id?: string;
}

/**
 * API endpoint to fetch donation details by reference ID
 * 
 * @param req - The incoming request object
 * @returns A JSON response with donation details or an error
 */
export async function GET(req: NextRequest) {
  // Get the reference ID from the query parameters
  const url = new URL(req.url);
  const reference = url.searchParams.get("reference");
  
  // Validate the reference ID
  if (!reference) {
    return NextResponse.json(
      { error: "Missing reference ID" },
      { status: 400 }
    );
  }
  
  // Create a Supabase client
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  );
  
  try {
    console.log(`Fetching donation details for reference: ${reference}`);
    
    // First, try to find the payment transaction
    const { data: paymentData, error: paymentError } = await supabase
      .from("payment_transactions")
      .select(`
        id,
        reference_id,
        amount,
        status,
        paid_at,
        payment_method,
        payer_email,
        payer_name,
        created_at,
        updated_at,
        invoice_id
      `)
      .eq("reference_id", reference)
      .single();
    
    if (paymentError) {
      console.error("Error fetching payment transaction:", paymentError);
      
      // If not found in payment_transactions, try looking in invoice_items
      const { data: invoiceItemData, error: invoiceItemError } = await supabase
        .from("invoice_items")
        .select(`
          id,
          invoice_id,
          donation_id,
          amount,
          missionary_id,
          donor_id,
          created_at
        `)
        .eq("invoice_id", reference)
        .single();
      
      if (invoiceItemError) {
        console.error("Error fetching invoice item:", invoiceItemError);
        return NextResponse.json(
          { error: "Donation not found" },
          { status: 404 }
        );
      }
      
      // If we have a donation_id, try to fetch the associated donation
      let donationDetails = null;
      if (invoiceItemData.donation_id) {
        const { data: relatedDonation, error: relatedError } = await supabase
          .from("donor_donations")
          .select(`
            id,
            amount,
            date,
            source,
            status,
            notes,
            donor_id,
            missionary_id
          `)
          .eq("id", invoiceItemData.donation_id)
          .single();
          
        if (!relatedError) {
          donationDetails = relatedDonation;
        } else {
          console.error("Error fetching related donation:", relatedError);
        }
      }
      
      // Format the response for invoice item data
      const formattedResponse: DonationResponse = {
        id: invoiceItemData.donation_id || invoiceItemData.id,
        reference_id: invoiceItemData.invoice_id,
        amount: invoiceItemData.amount,
        created_at: invoiceItemData.created_at,
        status: donationDetails?.status || "completed",
        donor: {
          id: invoiceItemData.donor_id?.toString()
        },
        notes: donationDetails?.notes
      };
      
      // If we have donation details with missionary info, fetch those separately
      if (invoiceItemData.missionary_id) {
        const { data: missionary } = await supabase
          .from("profiles")
          .select("id, full_name, avatar_url")
          .eq("id", invoiceItemData.missionary_id)
          .single();
          
        if (missionary) {
          formattedResponse.recipient = {
            id: missionary.id,
            full_name: missionary.full_name,
            avatar_url: missionary.avatar_url
          };
        }
      }
      
      // If we have a donor_id, fetch donor details
      if (invoiceItemData.donor_id) {
        const { data: donor } = await supabase
          .from("donors")
          .select("id, name, email, phone")
          .eq("id", invoiceItemData.donor_id)
          .single();
          
        if (donor) {
          formattedResponse.donor = donor;
        }
      }
      
      return NextResponse.json(formattedResponse);
    }
    
    // We found a payment transaction, now format the response
    let formattedResponse: DonationResponse = {
      id: paymentData.id,
      reference_id: paymentData.reference_id,
      amount: paymentData.amount,
      created_at: paymentData.created_at,
      status: paymentData.status,
      paid_at: paymentData.paid_at,
      payment_method: paymentData.payment_method,
      donor: { 
        name: paymentData.payer_name || undefined,
        email: paymentData.payer_email || undefined
      }
    };
    
    // Try to find associated invoice items to get missionary information
    if (paymentData.invoice_id) {
      const { data: invoiceItems, error: invoiceItemsError } = await supabase
        .from("invoice_items")
        .select(`
          id,
          amount,
          missionary_id,
          donor_id
        `)
        .eq("invoice_id", paymentData.invoice_id);
      
      if (!invoiceItemsError && invoiceItems && invoiceItems.length > 0) {
        // Get the first invoice item
        const firstItem = invoiceItems[0];
        
        // If we have a missionary_id, fetch missionary details
        if (firstItem.missionary_id) {
          const { data: missionary } = await supabase
            .from("profiles")
            .select("id, full_name, avatar_url")
            .eq("id", firstItem.missionary_id)
            .single();
            
          if (missionary) {
            formattedResponse.recipient = {
              id: missionary.id,
              full_name: missionary.full_name,
              avatar_url: missionary.avatar_url
            };
          }
        }
        
        // If we have a donor_id, fetch donor details
        if (firstItem.donor_id && !paymentData.payer_name) {
          const { data: donor } = await supabase
            .from("donors")
            .select("id, name, email, phone")
            .eq("id", firstItem.donor_id)
            .single();
            
          if (donor) {
            formattedResponse.donor = {
              ...formattedResponse.donor,
              id: donor.id,
              name: donor.name || formattedResponse.donor.name,
              email: donor.email || formattedResponse.donor.email,
              phone: donor.phone
            };
          }
        }
      } else if (invoiceItemsError) {
        console.error("Error fetching invoice items:", invoiceItemsError);
      }
    }
    
    // If we still don't have recipient information, try to find a donation record
    if (!formattedResponse.recipient && paymentData.reference_id) {
      // Try to find a donation with this reference
      const { data: donationData, error: donationError } = await supabase
        .from("donor_donations")
        .select(`
          id,
          amount,
          date,
          source,
          status,
          notes,
          donor_id,
          missionary_id
        `)
        .eq("payment_id", paymentData.reference_id)
        .single();
      
      if (!donationError && donationData) {
        // Add notes from the donation
        formattedResponse.notes = donationData.notes;
        
        // If we have a missionary_id, fetch missionary details
        if (donationData.missionary_id) {
          const { data: missionary } = await supabase
            .from("profiles")
            .select("id, full_name, avatar_url")
            .eq("id", donationData.missionary_id)
            .single();
            
          if (missionary) {
            formattedResponse.recipient = {
              id: missionary.id,
              full_name: missionary.full_name,
              avatar_url: missionary.avatar_url
            };
          }
        }
      }
    }
    
    return NextResponse.json(formattedResponse);
  } catch (error) {
    console.error("Unexpected error:", error);
    return NextResponse.json(
      { error: "Failed to fetch donation details" },
      { status: 500 }
    );
  }
} 