import { NextRequest, NextResponse } from "next/server";
import { createClient as createServiceClient } from '@supabase/supabase-js';

/**
 * Test endpoint for Xendit webhooks
 * For receiving test webhooks without signature verification
 * DO NOT USE IN PRODUCTION
 */
export async function POST(req: NextRequest) {
  try {
    // Only allow in development mode
    if (process.env.NODE_ENV === 'production') {
      return NextResponse.json({ error: "Test endpoint not available in production" }, { status: 404 });
    }

    // 1. Extract the webhook payload
    const payload = await req.json();
    
    // Log the full webhook payload for debugging
    console.log("Received test webhook payload:", JSON.stringify(payload, null, 2));

    // Get headers for debugging
    const headers = Object.fromEntries(req.headers.entries());
    console.log("Webhook headers:", headers);
    
    // 2. Create Supabase client with service role 
    const supabase = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Use the system user ID for any operations
    const systemUserId = "fa5060a6-3996-46ea-ae5f-bd3fed7e251a";
    
    // Store webhook in logs for analysis
    await supabase.from("webhook_logs").insert({
      webhook_id: payload.id || "test-webhook",
      event_type: payload.status || "TEST",
      payload: payload,
      signature: req.headers.get("x-callback-token") || "test-signature",
      ip_address: req.headers.get("x-forwarded-for") || req.headers.get("x-real-ip") || "unknown",
      status: "received_test",
      created_by: systemUserId,
    });
    
    // Process a test payment if this is a PAID status
    if (payload.status === "PAID" && payload.external_id) {
      const invoiceId = payload.id;
      console.log(`Test webhook: Processing payment for invoice ${invoiceId}`);
      
      // Find the payment transaction by external_id
      const { data: transaction } = await supabase
        .from("payment_transactions")
        .select("id")
        .eq("invoice_id", invoiceId)
        .maybeSingle();
        
      if (transaction) {
        // Update payment transaction to paid
        await supabase
          .from("payment_transactions")
          .update({
            status: "paid",
            payment_method: payload.payment_method || "TEST",
            payment_channel: payload.payment_channel || "TEST",
            payment_details: payload,
            paid_at: new Date().toISOString(),
          })
          .eq("id", transaction.id);
          
        console.log(`Test webhook: Updated transaction ${transaction.id} to paid`);
      } else {
        console.log(`Test webhook: No matching transaction found for ${invoiceId}`);
      }
    }
    
    // Return success with payload summary
    return NextResponse.json({
      status: "test_success", 
      message: "Webhook received for testing",
      payloadSummary: {
        id: payload.id,
        status: payload.status,
        amount: payload.amount,
        external_id: payload.external_id
      }
    }, { status: 200 });
    
  } catch (error) {
    console.error("Error processing test webhook:", error);
    
    return NextResponse.json({
      status: "test_error", 
      message: error instanceof Error ? error.message : "Unknown error"
    }, { status: 200 });
  }
} 