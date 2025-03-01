import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from '@supabase/supabase-js'
import { XenditService } from "@/lib/xendit";

export async function POST(req: NextRequest) {
  try {
    // 1. Extract the webhook payload
    const payload = await req.json();
    
    // Get the callback token for verification
    const callbackToken = req.headers.get("x-callback-token") || "";
    
    // Log all headers for debugging
    const headers = Object.fromEntries(req.headers.entries());
    
    // 2. Create Supabase client with service role to bypass RLS and permission issues
    const supabase = createServiceClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Use the system user ID for any operations
    const systemUserId = process.env.SYSTEM_USER_ID!;
    
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
    
    // 3. Verify webhook signature - always verify in all environments
    let isValid = false;
    
    // Verify webhook signature
    const xenditService = new XenditService(
      process.env.XENDIT_SECRET_KEY || "",
      process.env.XENDIT_WEBHOOK_SECRET || "",
      process.env.XENDIT_CALLBACK_URL || "",
      process.env.XENDIT_SUCCESS_REDIRECT_URL || "",
      process.env.XENDIT_FAILURE_REDIRECT_URL || ""
    );
    
    isValid = xenditService.verifyWebhookSignature(payload, callbackToken);
    
    if (!isValid) {
      // Update webhook log status
      await supabase
        .from("webhook_logs")
        .update({ 
          status: "invalid_signature",
          processing_errors: "Webhook signature verification failed"
        })
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
      throw new Error(`Payment transaction not found`);
    }
    
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
        throw new Error(`Failed to update payment transaction`);
      }
      
      // DEBUG: Check all invoice items to see if any match our invoice_id
      const { data: allInvoiceItems, error: allItemsError } = await supabase
        .from("invoice_items")
        .select("id, invoice_id, missionary_id, donor_id")
        .order("created_at", { ascending: false })
        .limit(10);
        
      // 3. Find associated invoice items by invoice_id
      let { data: invoiceItems, error: itemsError } = await supabase
        .from("invoice_items")
        .select("id, missionary_id, donor_id, amount")
        .eq("invoice_id", invoiceId);
      
      if (itemsError) {
        throw new Error(`Failed to find invoice items`);
      }
      
      if (!invoiceItems || invoiceItems.length === 0) {
        // As a last resort, try to create a donation record using payment_details from the transaction
        const paymentDetails = transaction.payment_details || {};
        
        // Check if this is a bulk donation
        if (paymentDetails.isBulkDonation && Array.isArray(paymentDetails.donors) && paymentDetails.donors.length > 0) {
          // Process each donor in the bulk donation
          for (const donor of paymentDetails.donors) {
            if (!donor.donorId || !donor.amount) {
              continue;
            }
            
            // Use direct SQL query to bypass materialized view refresh
            const { error: donationError } = await supabase.rpc(
              'insert_single_donation',
              {
                donor_id: donor.donorId,
                amount: donor.amount,
                missionary_id: paymentDetails.recipientId,
                donation_date: new Date().toISOString(),
                source: 'online',
                status: 'completed',
                notes: `Bulk payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
              }
            );
            
            if (donationError) {
            }
          }
        } else if (paymentDetails.recipientId && paymentDetails.donorId) {
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
              notes: "Created from payment_details as fallback"
            }
          );
          
          if (donationError) {
          }
        }
      } else {
        // Process each invoice item and create a donation record
        for (const item of invoiceItems) {
          if (!item.missionary_id || !item.donor_id) {
            continue;
          }
          
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
          }
        }
      }
    }
    
    // 4. Update webhook log status
    await supabase
      .from("webhook_logs")
      .update({ status: "completed" })
      .eq("webhook_id", payload.id || "unknown");
      
  } catch (error) {
    // Log the error but don't rethrow - we still want to return 200 OK
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
      throw new Error(`Payment transaction not found`);
    }
    
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
        throw new Error(`Failed to update payment transaction`);
      }
      
      // 3. Find invoice items associated with this invoice
      const { data: invoiceItems, error: itemsError } = await supabase
        .from("invoice_items")
        .select("id")
        .eq("invoice_id", invoiceId);
        
      if (itemsError) {
      } else if (invoiceItems && invoiceItems.length > 0) {
      } else {
      }
    }
    
    // 4. Update webhook log status
    await supabase
      .from("webhook_logs")
      .update({ status: "completed" })
      .eq("webhook_id", payload.id || "unknown");
      
  } catch (error) {
    // Log the error but don't rethrow - we still want to return 200 OK
    await supabase
      .from("webhook_logs")
      .update({ 
        status: "error",
        processing_errors: error instanceof Error ? error.message : "Unknown error"
      })
      .eq("webhook_id", payload.id || "unknown");
  }
} 