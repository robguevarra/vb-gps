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
    phone: z.string().min(0).optional().default(''),
  }),
  isAnonymous: z.boolean().optional().default(false),
  // Add optional payment_details field for bulk donations
  payment_details: z.object({
    isBulkDonation: z.boolean().optional(),
    donors: z.array(
      z.object({
        donorId: z.string(),
        donorName: z.string().optional().default('Anonymous Donor'),
        amount: z.number().positive(),
        email: z.string().email().optional().default('donor@example.com'),
        phone: z.string().min(0).optional().default(''),
      })
    ).optional(),
    recipientId: z.string().uuid().optional(),
    recipientName: z.string().optional(),
  }).optional(),
  notes: z.string().optional(),
  // Add optional success_redirect_url field
  success_redirect_url: z.string().optional(),
});

export async function POST(req: NextRequest) {
  console.log("📌 API: /api/xendit/create-invoice - Request received");
  
  try {
    // 1. Parse and validate request body
    const rawBody = await req.text();
    
    let body;
    try {
      body = JSON.parse(rawBody);
    } catch (parseError) {
      console.error("📌 JSON parse error:", parseError);
      return NextResponse.json(
        { error: "Invalid JSON in request body", details: parseError instanceof Error ? parseError.message : "Unknown parsing error" },
        { status: 400 }
      );
    }
    
    console.log("📌 Request parsed successfully");
    
    const validationResult = createInvoiceSchema.safeParse(body);
    
    if (!validationResult.success) {
      console.error("📌 Validation error:", validationResult.error.format());
      return NextResponse.json(
        { error: "Invalid request data", details: validationResult.error.format() },
        { status: 400 }
      );
    }
    
    const { donationType, recipientId, amount, donor, isAnonymous, payment_details, notes, success_redirect_url } = validationResult.data;
    
    // 2. Create a Supabase client with service role to bypass RLS and permission issues
    if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
      console.error("📌 Missing Supabase environment variables");
      return NextResponse.json(
        { error: "Server configuration error", details: "Missing Supabase credentials" },
        { status: 500 }
      );
    }
    
    const supabase = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // 3. Look up recipient details
    let recipientName = "";
    
    if (donationType === "missionary") {
      const { data: missionary, error: missionaryError } = await supabase
        .from("profiles")
        .select("full_name")
        .eq("id", recipientId)
        .single();
      
      if (missionaryError) {
        console.error("📌 Error fetching missionary:", missionaryError);
        return NextResponse.json(
          { error: "Failed to fetch missionary details", details: missionaryError.message },
          { status: 500 }
        );
      }
        
      recipientName = missionary?.full_name || "Missionary";
    } else {
      const { data: church, error: churchError } = await supabase
        .from("local_churches")
        .select("name")
        .eq("id", recipientId)
        .single();
      
      if (churchError) {
        console.error("📌 Error fetching church:", churchError);
        return NextResponse.json(
          { error: "Failed to fetch church details", details: churchError.message },
          { status: 500 }
        );
      }
        
      recipientName = church?.name || "Church";
    }
    
    console.log("📌 Recipient name:", recipientName);
    
    // 4. Create or get donor record
    let donorId: number; // Change type to number for PostgreSQL BIGINT compatibility
    
    const { data: existingDonor, error: donorQueryError } = await supabase
      .from("donors")
      .select("id")
      .eq("email", donor.email)
      .maybeSingle();
    
    if (donorQueryError) {
      console.error("📌 Error querying donor:", donorQueryError);
      return NextResponse.json(
        { error: "Failed to query donor record", details: donorQueryError.message },
        { status: 500 }
      );
    }
      
    if (existingDonor) {
      donorId = parseInt(existingDonor.id); // Convert to number
      console.log("📌 Using existing donor:", donorId);
      
      // Update donor info if needed
      const { error: updateError } = await supabase
        .from("donors")
        .update({
          name: donor.name,
          phone: donor.phone,
          updated_at: new Date().toISOString(),
        })
        .eq("id", donorId);
      
      if (updateError) {
        console.error("📌 Error updating donor:", updateError);
        // Non-critical error, continue with existing donor data
      }
    } else {
      console.log("📌 Creating new donor");
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
        console.error("📌 Error creating donor:", donorError);
        return NextResponse.json(
          { error: "Failed to create donor record", details: donorError?.message || "Unknown error" },
          { status: 500 }
        );
      }
      
      donorId = parseInt(newDonor.id); // Convert to number
      console.log("📌 Created new donor:", donorId);
    }
    
    // Generate a unique reference ID for tracking this transaction
    const referenceId = `${donorId}_${Date.now()}`;
    console.log("📌 Generated reference ID:", referenceId);
    
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
      console.error("📌 Error creating transaction:", transactionError);
      return NextResponse.json(
        { error: "Failed to create transaction record", details: transactionError?.message || "Unknown error" },
        { status: 500 }
      );
    }
    
    console.log("📌 Created transaction record:", transaction.id);
    
    // IMPORTANT: We don't create the donor_donations record at this point.
    // It will be created by the webhook handler when payment is confirmed.
    
    // 6. Create invoice item record without donor_donation reference
    // For bulk donations, we don't create invoice items since we'll use payment_details
    const isBulkDonation = payment_details?.isBulkDonation === true;
    console.log("📌 Is bulk donation:", isBulkDonation);
    
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
        console.error("📌 Error creating invoice item:", invoiceItemError);
        return NextResponse.json(
          { error: "Failed to create invoice item", details: invoiceItemError.message },
          { status: 500 }
        );
      }
      
      invoiceItem = data;
      console.log("📌 Created invoice item:", invoiceItem?.id);
    } else {
      console.log("📌 Skipping invoice item creation for bulk donation");
    }
    
    // 7. Call Xendit API to create invoice
    // Check if the environment variables for Xendit are properly set
    if (!process.env.XENDIT_SECRET_KEY || 
        !process.env.XENDIT_CALLBACK_URL || 
        !process.env.XENDIT_SUCCESS_REDIRECT_URL || 
        !process.env.XENDIT_FAILURE_REDIRECT_URL) {
      console.error("📌 Missing Xendit environment variables");
      return NextResponse.json(
        { error: "Xendit configuration error", details: "Missing required environment variables" },
        { status: 500 }
      );
    }
    
    // Determine the appropriate success redirect URL based on the source
    let successRedirectUrl: string;
    
    if (success_redirect_url) {
      // If a custom success redirect URL is provided, use it
      successRedirectUrl = success_redirect_url;
      
      // If it's the staff portal URL but doesn't have the reference ID, add it
      if (successRedirectUrl.includes('staff.victorybulacan.org/giving/thank-you') && 
          !successRedirectUrl.includes('?ref=')) {
        successRedirectUrl = `${successRedirectUrl}${successRedirectUrl.includes('?') ? '&' : '?'}ref=${referenceId}`;
      }
    } else {
      // Check if this request is coming from create-invoicev2 (website)
      // If it has a success_redirect_url that includes victorybulacan.org, it's from the website
      const isFromWebsite = req.headers.get('referer')?.includes('victorybulacan.org') || 
                           (success_redirect_url && success_redirect_url.includes('victorybulacan.org'));
      
      if (isFromWebsite) {
        // For WordPress site (external donations)
        successRedirectUrl = "https://victorybulacan.org/thankyou/";
      } else {
        // For staff portal (internal donations)
        // Make sure we use the full URL including the domain for staff portal
        const baseUrl = process.env.NEXT_PUBLIC_APP_URL || "https://staff.victorybulacan.org";
        successRedirectUrl = `${baseUrl}/giving/thank-you?ref=${referenceId}`;
      }
    }
    
    // Log the final redirect URL for debugging purposes
    console.log(`📌 Using success redirect URL: ${successRedirectUrl}`);
    
    // Determine the appropriate failure redirect URL
    const failureRedirectUrl = `${process.env.NEXT_PUBLIC_APP_URL}/payment/failure?ref=${referenceId}`;
    
    if (!process.env.XENDIT_SECRET_KEY || !process.env.XENDIT_WEBHOOK_SECRET) {
      console.error("📌 Missing Xendit API keys");
      return NextResponse.json(
        { error: "Xendit API configuration error", details: "Missing API keys" },
        { status: 500 }
      );
    }
    
    const xenditService = new XenditService(
      process.env.XENDIT_SECRET_KEY!,
      process.env.XENDIT_WEBHOOK_SECRET!,
      `${process.env.NEXT_PUBLIC_APP_URL}/api/xendit-webhook`,
      successRedirectUrl,
      failureRedirectUrl
    );
    
    try {
      console.log("📌 Creating Xendit invoice for reference:", referenceId);
      
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
        // Add success redirect URL explicitly
        successRedirectUrl: successRedirectUrl,
        items: payment_details?.isBulkDonation ? undefined : [
          {
            name: `Donation to ${recipientName}`,
            quantity: 1,
            price: amount,
            category: donationType
          }
        ]
      });
      
      console.log(`📌 Xendit invoice created successfully: ${invoice.id}`);
      
      // 8. Update payment_transactions with invoice details
      const { error: updateTransactionError } = await supabase
        .from("payment_transactions")
        .update({
          invoice_id: invoice.id,
          invoice_url: invoice.invoice_url,
          expires_at: new Date(invoice.expiry_date).toISOString(),
        })
        .eq("id", transaction.id);
      
      if (updateTransactionError) {
        console.error("📌 Error updating transaction with invoice details:", updateTransactionError);
        // Non-critical error, continue with response
      }
        
      // 9. Update invoice_items with Xendit invoice ID
      if (invoiceItem?.id) {
        const { error: updateItemError } = await supabase
          .from("invoice_items")
          .update({
            invoice_id: invoice.id,
          })
          .eq("id", invoiceItem.id);
          
        if (updateItemError) {
          console.error(`📌 Failed to update invoice item:`, updateItemError.code);
        }
        
        // Double-check that the invoice item was updated correctly
        const { data: updatedItem } = await supabase
          .from("invoice_items")
          .select("id, invoice_id")
          .eq("id", invoiceItem.id)
          .single();
      } else {
        console.log(`📌 No invoice item to update - bulk donation mode`);
      }
      
      // 10. Return success with invoice URL
      const response = {
        success: true,
        invoiceUrl: invoice.invoice_url,
        invoiceId: invoice.id,
        expiryDate: invoice.expiry_date,
      };
      
      console.log("📌 Payment invoice created successfully");
      
      return NextResponse.json(response);
    } catch (xenditError) {
      console.error("📌 Xendit API error occurred:", xenditError);
      // Try to extract more detailed error message from Xendit
      let errorDetails = "Unknown error";
      let statusCode = 500;
      let errorCode = "UNKNOWN_ERROR";
      
      if (xenditError instanceof Error) {
        errorDetails = xenditError.message;
        // Log the full error stack for debugging
        console.error("📌 Error details:", xenditError.name, xenditError.stack);
        
        // Check for specific Xendit error types
        if (xenditError.name === 'XenditError' && 'xenditErrorCode' in xenditError) {
          const xenditSpecificError = xenditError as any;
          errorCode = xenditSpecificError.xenditErrorCode || "XENDIT_ERROR";
          
          // Handle payment method errors specifically
          if (xenditSpecificError.xenditErrorCode === 'UNAVAILABLE_PAYMENT_METHOD_ERROR') {
            errorDetails = "Some payment methods are currently unavailable. This is likely a configuration issue with the payment gateway. Please try again later or contact support.";
            statusCode = 400;
          }
        }
      }
      
      // Ensure we always return a structured error response
      return NextResponse.json(
        { 
          success: false,
          error: "Failed to create invoice", 
          details: errorDetails,
          errorCode: errorCode
        },
        { status: statusCode }
      );
    }
    
  } catch (error) {
    console.error("📌 Unhandled error creating invoice:", error);
    return NextResponse.json(
      { 
        success: false,
        error: "Failed to create invoice", 
        details: error instanceof Error ? error.message : "Unknown error",
        errorCode: "SERVER_ERROR"
      },
      { status: 500 }
    );
  }
} 