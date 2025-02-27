import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from '@supabase/supabase-js'
import { XenditService } from "@/lib/xendit";

export async function POST(req: NextRequest) {
  try {
    // 1. Extract the webhook payload
    const payload = await req.json();
    
    // Log the full webhook payload for debugging
    console.log("Received Xendit webhook:", JSON.stringify(payload, null, 2));
    
    // Get the callback token for verification
    const callbackToken = req.headers.get("x-callback-token") || "";
    
    // Log all headers for debugging
    const headers = Object.fromEntries(req.headers.entries());
    console.log("Webhook headers:", headers);
    
    // 2. Create Supabase client with service role to bypass RLS and permission issues
    const supabase = createServiceClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Use the system user ID for any operations
    const systemUserId = "fa5060a6-3996-46ea-ae5f-bd3fed7e251a";
    
    // Store webhook in logs regardless of verification
    await supabase.from("webhook_logs").insert({
      webhook_id: payload.id || "unknown",
      event_type: payload.event || payload.status || "unknown",
      payload: payload,
      signature: callbackToken,
      ip_address: req.headers.get("x-forwarded-for") || req.headers.get("x-real-ip") || "unknown",
      status: "received",
      created_by: systemUserId,
    });
    
    // 3. Skip verification in development if bypassing is enabled
    let isValid = false;
    
    if (process.env.NODE_ENV !== 'production' && process.env.BYPASS_WEBHOOK_VERIFICATION === 'true') {
      console.warn('Bypassing webhook signature verification in development mode');
      isValid = true;
    } else {
      // Verify webhook signature
      const xenditService = new XenditService(
        process.env.XENDIT_SECRET_KEY || "",
        process.env.XENDIT_WEBHOOK_SECRET || "",
        process.env.XENDIT_CALLBACK_URL || "",
        process.env.XENDIT_SUCCESS_REDIRECT_URL || "",
        process.env.XENDIT_FAILURE_REDIRECT_URL || ""
      );
      
      isValid = xenditService.verifyWebhookSignature(payload, callbackToken);
    }
    
    if (!isValid) {
      console.error("Invalid webhook signature");
      
      // Update webhook log status
      await supabase
        .from("webhook_logs")
        .update({ status: "invalid_signature" })
        .eq("webhook_id", payload.id || "unknown");
        
      // Still return 200 to prevent Xendit from retrying
      return NextResponse.json({ status: "invalid_signature" }, { status: 200 });
    }
    
    // 4. Extract payment information
    // The payload structure depends on the event type
    const eventType = payload.event || payload.status || "";
    
    // Handle different event types
    if (eventType === "invoice.paid" || eventType === "PAID") {
      await handleInvoicePaid(payload, supabase, systemUserId);
    } else if (eventType === "invoice.expired" || eventType === "EXPIRED") {
      await handleInvoiceExpired(payload, supabase);
    } else {
      // Other event types - just log them
      await supabase
        .from("webhook_logs")
        .update({ status: "unsupported_event" })
        .eq("webhook_id", payload.id || "unknown");
    }
    
    // 5. Always return 200 OK to acknowledge receipt
    return NextResponse.json({ status: "success" }, { status: 200 });
    
  } catch (error) {
    console.error("Error processing webhook:", error);
    
    // Always return 200 OK to acknowledge receipt, even on errors
    // This prevents Xendit from retrying the webhook unnecessarily
    return NextResponse.json(
      { status: "error", message: error instanceof Error ? error.message : "Unknown error" },
      { status: 200 }
    );
  }
}

/**
 * Handles the invoice.paid event
 */
async function handleInvoicePaid(payload: any, supabase: any, systemUserId: string) {
  // Extract the invoice ID from the payload
  const invoiceId = payload.id;
  const externalId = payload.external_id;
  
  if (!invoiceId) {
    throw new Error("Missing invoice ID in webhook payload");
  }
  
  console.log(`Processing paid invoice: ${invoiceId}, external_id: ${externalId}`);
  
  // Update webhook log status
  await supabase
    .from("webhook_logs")
    .update({ status: "processing" })
    .eq("webhook_id", payload.id || "unknown");
  
  try {
    // 1. First, find the payment transaction record by invoice_id
    const { data: transaction, error: transactionError } = await supabase
      .from("payment_transactions")
      .select("id, status, reference_id, amount, payment_details")
      .eq("invoice_id", invoiceId)
      .single();
    
    if (transactionError || !transaction) {
      console.error(`Error finding transaction for invoice ${invoiceId}:`, transactionError);
      throw new Error(`Payment transaction not found for invoice ${invoiceId}`);
    }
    
    console.log(`Found transaction ${transaction.id} with status ${transaction.status}, reference_id: ${transaction.reference_id}`);
    
    // Only update if not already paid to prevent duplicate processing
    if (transaction.status !== "paid") {
      // 2. Update the payment transaction record
      const { error: updateError } = await supabase
        .from("payment_transactions")
        .update({
          status: "paid",
          payment_method: payload.payment_method || "unknown",
          payment_channel: payload.payment_channel || "unknown",
          payment_details: {
            ...transaction.payment_details,
            xenditResponse: payload || {},
          },
          paid_at: new Date().toISOString(),
        })
        .eq("invoice_id", invoiceId);
      
      if (updateError) {
        console.error(`Error updating transaction for invoice ${invoiceId}:`, updateError);
        throw new Error(`Failed to update payment transaction for invoice ${invoiceId}`);
      }
      
      console.log(`Updated transaction ${transaction.id} to status "paid"`);
      
      // DEBUG: Check all invoice items to see if any match our invoice_id
      const { data: allInvoiceItems, error: allItemsError } = await supabase
        .from("invoice_items")
        .select("id, invoice_id, missionary_id, donor_id")
        .order("created_at", { ascending: false })
        .limit(10);
        
      console.log(`DEBUG - Recent invoice items:`, JSON.stringify(allInvoiceItems || [], null, 2));
      
      // 3. Find associated invoice items by invoice_id
      let { data: invoiceItems, error: itemsError } = await supabase
        .from("invoice_items")
        .select("id, missionary_id, donor_id, amount")
        .eq("invoice_id", invoiceId);
      
      if (itemsError) {
        console.error(`Error finding invoice items for invoice ${invoiceId}:`, itemsError);
        throw new Error(`Failed to find invoice items for invoice ${invoiceId}`);
      }
      
      console.log(`Found ${invoiceItems?.length || 0} invoice items for invoice ${invoiceId}`);
      
      if (!invoiceItems || invoiceItems.length === 0) {
        console.error(`No invoice items found for invoice ${invoiceId}`);
        
        // As a last resort, try to create a donation record using payment_details from the transaction
        const paymentDetails = transaction.payment_details || {};
        if (paymentDetails.recipientId && paymentDetails.donorId) {
          console.log(`Attempting to create donation using payment_details: ${JSON.stringify(paymentDetails)}`);
          
          // Use direct SQL query to bypass materialized view refresh
          const { error: donationError } = await supabase.rpc(
            'insert_single_donation',
            {
              donor_id: paymentDetails.donorId,
              amount: transaction.amount,
              missionary_id: paymentDetails.recipientId,
              donation_date: new Date().toISOString(),
              source: 'online',
              status: 'completed',
              notes: "Created from payment_details as fallback (no invoice item found)"
            }
          );
          
          if (donationError) {
            console.error(`Error creating fallback donation record:`, donationError);
          } else {
            console.log(`Created fallback donation from payment_details using insert_single_donation function`);
          }
        }
      } else {
        // Process each invoice item and create a donation record
        for (const item of invoiceItems) {
          if (!item.missionary_id || !item.donor_id) {
            console.warn(`Skipping invoice item with missing data: ${JSON.stringify(item)}`);
            continue;
          }
          
          console.log(`Creating donation for invoice item (missionary: ${item.missionary_id}, donor: ${item.donor_id})`);
          
          // Extract donation details from transaction's payment_details
          const paymentDetails = transaction.payment_details || {};
          
          // Use direct SQL query to bypass materialized view refresh
          const { error: donationError } = await supabase.rpc(
            'insert_single_donation',
            {
              donor_id: item.donor_id,
              amount: item.amount || transaction.amount,
              missionary_id: item.missionary_id,
              donation_date: new Date().toISOString(),
              source: 'online',
              status: 'completed',
              notes: `Payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
            }
          );
          
          if (donationError) {
            console.error(`Error creating donation record:`, donationError);
          } else {
            console.log(`Created donation for missionary ${item.missionary_id} and donor ${item.donor_id} using insert_single_donation function`);
          }
        }
      }
    } else {
      console.log(`Transaction ${transaction.id} already marked as paid, skipping update`);
    }
    
    // 4. Update webhook log status
    await supabase
      .from("webhook_logs")
      .update({ status: "completed" })
      .eq("webhook_id", payload.id || "unknown");
    
    console.log(`Webhook processing completed for invoice ${invoiceId}`);
      
  } catch (error) {
    // Log the error but don't rethrow - we still want to return 200 OK
    console.error("Error processing invoice.paid webhook:", error);
    
    await supabase
      .from("webhook_logs")
      .update({ 
        status: "error",
        processing_errors: error instanceof Error ? error.message : "Unknown error"
      })
      .eq("webhook_id", payload.id || "unknown");
  }
}

/**
 * Handles the invoice.expired event
 */
async function handleInvoiceExpired(payload: any, supabase: any) {
  // Extract the invoice ID from the payload
  const invoiceId = payload.id || payload.data?.id;
  
  if (!invoiceId) {
    throw new Error("Missing invoice ID in webhook payload");
  }
  
  console.log(`Processing expired invoice: ${invoiceId}`);
  
  // Update webhook log status
  await supabase
    .from("webhook_logs")
    .update({ status: "processing" })
    .eq("webhook_id", payload.id || "unknown");
  
  try {
    // 1. First, find the payment transaction record by invoice_id
    const { data: transaction, error: transactionError } = await supabase
      .from("payment_transactions")
      .select("id, status, reference_id, payment_details")
      .eq("invoice_id", invoiceId)
      .single();
    
    if (transactionError || !transaction) {
      console.error(`Error finding transaction for invoice ${invoiceId}:`, transactionError);
      throw new Error(`Payment transaction not found for invoice ${invoiceId}`);
    }
    
    console.log(`Found transaction ${transaction.id} with status ${transaction.status}`);
    
    // Only update if not already expired to prevent duplicate processing
    if (transaction.status !== "expired") {
      // 2. Update the payment transaction record
      const { error: updateError } = await supabase
        .from("payment_transactions")
        .update({
          status: "expired",
          payment_details: {
            ...(transaction.payment_details || {}),
            expiryData: payload.data || payload || {},
          },
        })
        .eq("invoice_id", invoiceId);
      
      if (updateError) {
        console.error(`Error updating transaction for invoice ${invoiceId}:`, updateError);
        throw new Error(`Failed to update payment transaction for invoice ${invoiceId}`);
      }
      
      console.log(`Updated transaction ${transaction.id} to status "expired"`);
      
      // 3. Find invoice items associated with this invoice
      const { data: invoiceItems, error: itemsError } = await supabase
        .from("invoice_items")
        .select("id")
        .eq("invoice_id", invoiceId);
      
      if (itemsError) {
        console.error(`Error finding invoice items for invoice ${invoiceId}:`, itemsError);
      } else if (invoiceItems && invoiceItems.length > 0) {
        console.log(`Found ${invoiceItems.length} invoice items for expired invoice ${invoiceId}`);
        
        // We don't need to update the invoice items since there's no status field
        // Just log that we found them
      } else {
        console.log(`No invoice items found for expired invoice ${invoiceId}`);
      }
      
      // For expired invoices, we don't create any donor_donations records
      // since no payment was made
    } else {
      console.log(`Transaction ${transaction.id} already marked as expired, skipping update`);
    }
    
    // 4. Update webhook log status
    await supabase
      .from("webhook_logs")
      .update({ status: "completed" })
      .eq("webhook_id", payload.id || "unknown");
    
    console.log(`Webhook processing completed for invoice ${invoiceId}`);
      
  } catch (error) {
    // Log the error but don't rethrow - we still want to return 200 OK
    console.error("Error processing invoice.expired webhook:", error);
    
    await supabase
      .from("webhook_logs")
      .update({ 
        status: "error",
        processing_errors: error instanceof Error ? error.message : "Unknown error"
      })
      .eq("webhook_id", payload.id || "unknown");
  }
} 