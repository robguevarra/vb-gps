import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from '@supabase/supabase-js'
import { XenditService, CreateInvoiceParams } from "@/lib/xendit";
import { z } from "zod";
import { cookies } from "next/headers";
import { nanoid } from "nanoid";

// Schema for request validation
const createInvoiceSchema = z.object({
  donationType: z.enum(["missionary", "church"]),
  recipientId: z.string().uuid(),
  amount: z.number().positive(),
  donor: z.object({
    name: z.string().min(1),
    email: z.string().email(),
    phone: z.string().optional(),
  }),
  isAnonymous: z.boolean().optional().default(false),
});

export async function POST(req: NextRequest) {
  try {
    // 1. Parse and validate request body
    const body = await req.json();
    const validationResult = createInvoiceSchema.safeParse(body);
    
    if (!validationResult.success) {
      return NextResponse.json(
        { error: "Invalid request data", details: validationResult.error.format() },
        { status: 400 }
      );
    }
    
    const { donationType, recipientId, amount, donor, isAnonymous } = validationResult.data;
    
    // 2. Create a Supabase client with service role to bypass RLS and permission issues
    const supabase = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Generate a unique reference ID for tracking this transaction
    const referenceId = `${donationType.charAt(0)}_${nanoid(10)}`;
    
    // 3. Look up recipient details
    let recipientName = "";
    
    if (donationType === "missionary") {
      const { data: missionary } = await supabase
        .from("profiles")
        .select("full_name")
        .eq("id", recipientId)
        .single();
        
      recipientName = missionary?.full_name || "Missionary";
    } else {
      const { data: church } = await supabase
        .from("local_churches")
        .select("name")
        .eq("id", recipientId)
        .single();
        
      recipientName = church?.name || "Church";
    }
    
    // 4. Create or get donor record
    let donorId: number; // Change type to number for PostgreSQL BIGINT compatibility
    
    const { data: existingDonor } = await supabase
      .from("donors")
      .select("id")
      .eq("email", donor.email)
      .maybeSingle();
      
    if (existingDonor) {
      donorId = parseInt(existingDonor.id); // Convert to number
      
      // Update donor info if needed
      await supabase
        .from("donors")
        .update({
          name: donor.name,
          phone: donor.phone,
          updated_at: new Date().toISOString(),
        })
        .eq("id", donorId);
    } else {
      // Create new donor
      const { data: newDonor, error: donorError } = await supabase
        .from("donors")
        .insert({
          name: donor.name,
          email: donor.email,
          phone: donor.phone,
        })
        .select("id")
        .single();
        
      if (donorError || !newDonor) {
        return NextResponse.json(
          { error: "Failed to create donor record", details: donorError },
          { status: 500 }
        );
      }
      
      donorId = parseInt(newDonor.id); // Convert to number
    }
    
    // 5. Create payment transaction record
    const { data: transaction, error: transactionError } = await supabase
      .from("payment_transactions")
      .insert({
        reference_id: referenceId,
        amount: amount,
        status: "pending",
        payer_email: donor.email,
        payer_name: donor.name,
        // Use the provided system user ID
        created_by: "fa5060a6-3996-46ea-ae5f-bd3fed7e251a",
        // Store donation info for future reference
        payment_details: {
          donationType,
          recipientId,
          donorId,
          isAnonymous,
          date: new Date().toISOString(),
        },
      })
      .select("id")
      .single();
      
    if (transactionError || !transaction) {
      return NextResponse.json(
        { error: "Failed to create transaction record", details: transactionError },
        { status: 500 }
      );
    }
    
    // IMPORTANT: We don't create the donor_donations record at this point.
    // It will be created by the webhook handler when payment is confirmed.
    
    // 6. Create invoice item record without donor_donation reference
    // This will store the intent to create a donation once payment is confirmed
    const { data: invoiceItem, error: invoiceItemError } = await supabase.from("invoice_items").insert({
      invoice_id: null, // Initially null, will be updated with Xendit invoice ID
      donation_id: null, // We don't have a donation_id yet
      amount: amount,
      missionary_id: recipientId, // Always use missionary_id regardless of type
      donor_id: donorId,
    }).select("id").single();
    
    if (invoiceItemError) {
      console.error("Failed to create invoice item:", invoiceItemError);
      return NextResponse.json(
        { error: "Failed to create invoice item", details: invoiceItemError },
        { status: 500 }
      );
    }
    
    console.log(`Created invoice item with ID ${invoiceItem?.id}`);
    
    // 7. Call Xendit API to create invoice
    // Check if the environment variables for Xendit are properly set
    if (!process.env.XENDIT_SECRET_KEY || 
        !process.env.XENDIT_CALLBACK_URL || 
        !process.env.XENDIT_SUCCESS_REDIRECT_URL || 
        !process.env.XENDIT_FAILURE_REDIRECT_URL) {
      console.error("Missing Xendit environment variables:", {
        secretKey: !!process.env.XENDIT_SECRET_KEY,
        callbackUrl: !!process.env.XENDIT_CALLBACK_URL,
        successUrl: !!process.env.XENDIT_SUCCESS_REDIRECT_URL,
        failureUrl: !!process.env.XENDIT_FAILURE_REDIRECT_URL
      });
      return NextResponse.json(
        { error: "Xendit configuration error", details: "Missing required environment variables" },
        { status: 500 }
      );
    }
    
    const xenditService = new XenditService(
      process.env.XENDIT_SECRET_KEY || "",
      process.env.XENDIT_WEBHOOK_SECRET || "",
      process.env.XENDIT_CALLBACK_URL || "",
      process.env.XENDIT_SUCCESS_REDIRECT_URL || "",
      process.env.XENDIT_FAILURE_REDIRECT_URL || ""
    );
    
    // Create a more descriptive donation description
    const donationDescription = isAnonymous
      ? `Donation to ${donationType === "church" ? "Church: " : ""}${recipientName}`
      : `Donation to ${donationType === "church" ? "Church: " : ""}${recipientName} from ${donor.name}`;
    
    // Make sure amount is a valid number with 2 decimal places  
    const formattedAmount = parseFloat(amount.toFixed(2));
    
    // Simplify - don't attach query parameters to redirect URLs 
    // (this can cause issues with some payment gateways)
    const successUrl = process.env.XENDIT_SUCCESS_REDIRECT_URL;
    const failureUrl = process.env.XENDIT_FAILURE_REDIRECT_URL;
    
    const invoiceParams: CreateInvoiceParams = {
      externalId: referenceId,
      amount: formattedAmount, // Make sure amount is properly formatted with 2 decimal places
      payerEmail: donor.email,
      payerName: donor.name,
      description: donationDescription,
      successRedirectUrl: successUrl,
      failureRedirectUrl: failureUrl,
      // Remove items for simplicity - this can sometimes cause validation errors
    };
    
    // Log the Xendit params for debugging
    console.log("Xendit Invoice Params:", JSON.stringify(invoiceParams, null, 2));
    
    try {
      const invoice = await xenditService.createInvoice(invoiceParams);
      
      console.log(`Xendit invoice created: ${invoice.id}, external_id: ${invoice.external_id}`);
      
      // 8. Update payment_transactions with invoice details
      await supabase
        .from("payment_transactions")
        .update({
          invoice_id: invoice.id,
          invoice_url: invoice.invoice_url,
          expires_at: new Date(invoice.expiry_date).toISOString(),
        })
        .eq("id", transaction.id);
        
      // 9. Update invoice_items with Xendit invoice ID
      const { error: updateItemError } = await supabase
        .from("invoice_items")
        .update({
          invoice_id: invoice.id,
        })
        .eq("id", invoiceItem.id); // Use the invoice item ID instead of reference_id
        
      if (updateItemError) {
        console.error(`Failed to update invoice item with invoice_id ${invoice.id}:`, updateItemError);
      } else {
        console.log(`Updated invoice item with invoice_id ${invoice.id}`);
      }
      
      // Double-check that the invoice item was updated correctly
      const { data: updatedItem } = await supabase
        .from("invoice_items")
        .select("id, invoice_id")
        .eq("id", invoiceItem.id)
        .single();
        
      console.log(`Verified invoice item update:`, JSON.stringify(updatedItem || {}, null, 2));
      
      // 10. Return success with invoice URL
      return NextResponse.json({
        success: true,
        invoiceUrl: invoice.invoice_url,
        invoiceId: invoice.id,
        expiryDate: invoice.expiry_date,
      });
    } catch (xenditError) {
      console.error("Xendit API error:", xenditError);
      // Try to extract more detailed error message from Xendit
      let errorDetails = "Unknown error";
      if (xenditError instanceof Error) {
        errorDetails = xenditError.message;
        // Log the full error stack for debugging
        console.error("Full error:", xenditError.stack);
      }
      
      return NextResponse.json(
        { error: "Failed to create invoice", details: errorDetails },
        { status: 500 }
      );
    }
    
  } catch (error) {
    console.error("Error creating invoice:", error);
    return NextResponse.json(
      { error: "Failed to create invoice", details: error instanceof Error ? error.message : "Unknown error" },
      { status: 500 }
    );
  }
} 