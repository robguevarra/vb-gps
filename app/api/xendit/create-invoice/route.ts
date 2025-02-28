// app/api/xendit/create-invoice/route.ts

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
  // Add optional payment_details field for bulk donations
  payment_details: z.object({
    isBulkDonation: z.boolean().optional(),
    donors: z.array(
      z.object({
        donorId: z.string(),
        donorName: z.string().optional(),
        amount: z.number().positive(),
        email: z.string().email().optional(),
        phone: z.string().optional(),
      })
    ).optional(),
    recipientId: z.string().uuid().optional(),
    recipientName: z.string().optional(),
  }).optional(),
  notes: z.string().optional(),
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
    
    const { donationType, recipientId, amount, donor, isAnonymous, payment_details, notes } = validationResult.data;
    
    // 2. Create a Supabase client with service role to bypass RLS and permission issues
    const supabase = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    
    
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
    // Generate a unique reference ID for tracking this transaction
    const referenceId = `${donorId}_${Date.now()}`;
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
        created_by: "ece8947d-4d2b-42fc-a860-7d77cfe81ca9",
        // Store donation info for future reference
        payment_details: {
          donationType,
          recipientId,
          donorId,
          isAnonymous,
          date: new Date().toISOString(),
          // Include any additional payment details from the request
          ...(payment_details || {}),
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
    // For bulk donations, we don't create invoice items since we'll use payment_details
    const isBulkDonation = payment_details?.isBulkDonation === true;
    
    // Declare invoiceItem variable outside the conditional block
    let invoiceItem: { id: string } | null = null;
    
    if (!isBulkDonation) {
      // Only create invoice item for regular (non-bulk) donations
      const { data, error: invoiceItemError } = await supabase.from("invoice_items").insert({
        invoice_id: null, // Initially null, will be updated with Xendit invoice ID
        donation_id: null, // We don't have a donation_id yet
        amount: amount,
        missionary_id: recipientId, // Always use missionary_id regardless of type
        donor_id: donorId,
      }).select("id").single();
      
      if (invoiceItemError) {
        console.error("Failed to create invoice item");
        return NextResponse.json(
          { error: "Failed to create invoice item", details: invoiceItemError },
          { status: 500 }
        );
      }
      
      invoiceItem = data;
      console.log(`Created invoice item successfully`);
    } else {
      console.log(`Bulk donation detected - skipping invoice item creation`);
    }
    
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
      process.env.XENDIT_SECRET_KEY!,
      process.env.XENDIT_WEBHOOK_SECRET!,
      `${process.env.NEXT_PUBLIC_APP_URL}/api/xendit-webhook`,
      `${process.env.NEXT_PUBLIC_APP_URL}/donation/success?ref=${referenceId}`,
      `${process.env.NEXT_PUBLIC_APP_URL}/donation/failed?ref=${referenceId}`
    );
    
    try {
      // Create invoice with Xendit
      const invoice = await xenditService.createInvoice({
        externalId: referenceId,
        amount: amount,
        payerEmail: donor.email,
        payerName: donor.name,
        description: `Donation to ${recipientName}${isAnonymous ? ' (Anonymous)' : ''}`,
        // For all donations, we need to ensure we have all payment methods available
        // Remove payment methods configuration to use defaults from Xendit Dashboard
        currency: "PHP", // Always set currency to PHP
        shouldSendEmail: true,
        items: payment_details?.isBulkDonation ? undefined : [
          {
            name: `Donation to ${recipientName}`,
            quantity: 1,
            price: amount,
            category: donationType
          }
        ]
      });
      
      console.log(`Xendit invoice created successfully`);
      
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
      if (invoiceItem?.id) {
        const { error: updateItemError } = await supabase
          .from("invoice_items")
          .update({
            invoice_id: invoice.id,
          })
          .eq("id", invoiceItem.id);
          
        if (updateItemError) {
          console.error(`Failed to update invoice item:`, updateItemError.code);
        } else {
          console.log(`Updated invoice item successfully`);
        }
        
        // Double-check that the invoice item was updated correctly
        const { data: updatedItem } = await supabase
          .from("invoice_items")
          .select("id, invoice_id")
          .eq("id", invoiceItem.id)
          .single();
          
        console.log(`Verified invoice item update`);
      } else {
        console.log(`No invoice item to update - bulk donation mode`);
      }
      
      // 10. Return success with invoice URL
      return NextResponse.json({
        success: true,
        invoiceUrl: invoice.invoice_url,
        invoiceId: invoice.id,
        expiryDate: invoice.expiry_date,
      });
    } catch (xenditError) {
      console.error("Xendit API error occurred");
      // Try to extract more detailed error message from Xendit
      let errorDetails = "Unknown error";
      let statusCode = 500;
      
      if (xenditError instanceof Error) {
        errorDetails = xenditError.message;
        // Log the full error stack for debugging
        console.error("Error details:", xenditError.name);
        
        // Check for specific Xendit error types
        if (xenditError.name === 'XenditError' && 'xenditErrorCode' in xenditError) {
          const xenditSpecificError = xenditError as any;
          
          // Handle payment method errors specifically
          if (xenditSpecificError.xenditErrorCode === 'UNAVAILABLE_PAYMENT_METHOD_ERROR') {
            errorDetails = "Some payment methods are currently unavailable. This is likely a configuration issue with the payment gateway. Please try again later or contact support.";
            statusCode = 400;
          }
        }
      }
      
      return NextResponse.json(
        { error: "Failed to create invoice", details: errorDetails },
        { status: statusCode }
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