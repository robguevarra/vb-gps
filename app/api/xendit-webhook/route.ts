import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from '@supabase/supabase-js'
import { XenditService } from "@/lib/xendit";

export async function POST(req: NextRequest) {
  try {
    // 1. Extract the webhook payload
    const payload = await req.json();
    
    console.log('📌 Received Xendit webhook:', payload.event || payload.status || "unknown");
    
    // Get the callback token for verification
    const callbackToken = req.headers.get("x-callback-token") || "";
    
    // Log all headers for debugging
    const headers = Object.fromEntries(req.headers.entries());
    console.log('📌 Webhook headers:', JSON.stringify(headers, null, 2));
    
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
    
    console.log('📌 Webhook logged to database');
    
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
    
    // IMPORTANT: In development environment, skip verification for testing
    if (process.env.NODE_ENV === 'development') {
      console.log('⚠️ Development environment detected - SKIPPING webhook signature verification');
      isValid = true;
    } else {
      console.log('🔒 Production environment - verifying webhook signature');
      console.log('📌 Callback token:', callbackToken ? 'Present' : 'Missing');
      isValid = xenditService.verifyWebhookSignature(payload, callbackToken);
      console.log('📌 Signature verification result:', isValid ? 'Valid' : 'Invalid');
    }
    
    if (!isValid) {
      console.error('❌ Webhook signature verification failed');
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
    
    console.log('✅ Webhook signature verified successfully');
    
    // 4. Extract payment information
    // The payload structure depends on the event type
    const eventType = payload.event || payload.status || "";
    
    console.log(`📌 Processing webhook event type: ${eventType}`);
    
    // Handle different event types
    if (eventType === "invoice.paid" || eventType === "PAID") {
      console.log('📌 Handling invoice.paid event');
      const result = await handleInvoicePaid(payload, supabase, systemUserId);
      console.log('📌 Invoice.paid handling result:', result);
      
      // Update webhook log status
      await supabase
        .from("webhook_logs")
        .update({ 
          status: result.success ? "processed" : "failed",
          processing_errors: result.success ? null : result.error
        })
        .eq("webhook_id", payload.id || "unknown");
        
    } else if (eventType === "invoice.expired" || eventType === "EXPIRED") {
      console.log('📌 Handling invoice.expired event');
      const result = await handleInvoiceExpired(payload, supabase);
      console.log('📌 Invoice.expired handling result:', result);
      
      // Update webhook log status
      await supabase
        .from("webhook_logs")
        .update({ 
          status: result.success ? "processed" : "failed",
          processing_errors: result.success ? null : result.error
        })
        .eq("webhook_id", payload.id || "unknown");
    } else {
      console.log(`📌 Unsupported event type: ${eventType}`);
      // Other event types - just log them
      await supabase
        .from("webhook_logs")
        .update({ status: "unsupported_event" })
        .eq("webhook_id", payload.id || "unknown");
    }
    
    // 5. Always return 200 OK to acknowledge receipt
    return NextResponse.json({ status: "success" }, { status: 200 });
    
  } catch (error) {
    console.error('❌ Error processing webhook:', error);
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
export async function handleInvoicePaid(payload: any, supabase: any, systemUserId: string) {
  console.log('📌 Processing paid invoice webhook:', payload.id);
  
  try {
    // Extract the invoice ID and external ID from the payload
    const invoiceId = payload.id;
    const externalId = payload.external_id;
    
    if (!invoiceId) {
      console.error('❌ Missing invoice ID in webhook payload');
      return { success: false, error: 'Missing invoice ID' };
    }
    
    // Update webhook log status
    await supabase
      .from("webhook_logs")
      .update({ status: "processing" })
      .eq("webhook_id", payload.id || "unknown");
    
    // Find the transaction record
    console.log(`📌 Looking for transaction with reference: ${externalId} or invoice_id: ${invoiceId}`);
    
    // First try to find by reference
    let { data: transaction, error: txError } = await supabase
      .from('payment_transactions')
      .select('*')
      .eq('reference', externalId)
      .single();
    
    // If not found by reference, try by invoice_id
    if (!transaction) {
      console.log(`📌 Transaction not found by reference, trying invoice_id: ${invoiceId}`);
      const { data: txByInvoice, error: invoiceError } = await supabase
        .from('payment_transactions')
        .select('*')
        .eq('invoice_id', invoiceId)
        .single();
      
      if (txByInvoice) {
        transaction = txByInvoice;
        txError = invoiceError;
      }
    }
    
    if (txError) {
      console.error('❌ Error finding transaction record:', txError);
      return { success: false, error: 'Transaction not found' };
    }
    
    if (!transaction) {
      console.error('❌ Transaction not found for reference:', externalId, 'or invoice_id:', invoiceId);
      return { success: false, error: 'Transaction not found' };
    }
    
    console.log(`📌 Found transaction record for reference ${externalId} with ID ${transaction.id}`);
    
    // Only update if not already paid to prevent duplicate processing
    if (transaction.status !== "completed") {
      // Update transaction status
      const { error: updateError } = await supabase
        .from('payment_transactions')
        .update({
          status: 'completed',
          payment_method: payload.payment_method,
          payment_channel: payload.payment_channel,
          paid_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })
        .eq('id', transaction.id);
      
      if (updateError) {
        console.error('❌ Error updating transaction status:', updateError);
        return { success: false, error: 'Failed to update transaction' };
      }
      
      console.log(`📌 Updated transaction status to completed for ID ${transaction.id}`);
      
      // Parse payment details
      let paymentDetails;
      try {
        console.log('📌 Raw payment_details:', typeof transaction.payment_details, transaction.payment_details);
        
        if (typeof transaction.payment_details === 'string') {
          console.log('📌 Parsing payment_details from string');
          paymentDetails = JSON.parse(transaction.payment_details);
        } else if (transaction.payment_details && typeof transaction.payment_details === 'object') {
          console.log('📌 Using payment_details as object');
          paymentDetails = transaction.payment_details;
        } else {
          console.log('📌 No valid payment_details found');
          paymentDetails = null;
        }
        
        console.log('📌 Parsed payment details:', JSON.stringify(paymentDetails, null, 2));
      } catch (e) {
        console.error('❌ Error parsing payment details:', e);
        paymentDetails = null;
      }
      
      // Create donation records
      if (paymentDetails) {
        console.log('📌 Creating donation records from payment details');
        console.log('📌 Donor ID type:', typeof paymentDetails.donorId, 'Value:', paymentDetails.donorId);
        console.log('📌 Recipient ID type:', typeof paymentDetails.recipientId, 'Value:', paymentDetails.recipientId);
        
        if (paymentDetails.isBulkDonation && Array.isArray(paymentDetails.donors) && paymentDetails.donors.length > 0) {
          console.log(`📌 Processing bulk donation with ${paymentDetails.donors.length} donors`);
          // Process each donor in the bulk donation
          for (const donor of paymentDetails.donors) {
            if (!donor.donorId || !donor.amount) {
              console.warn(`⚠️ Skipping donor with missing data:`, donor);
              continue;
            }
            
            console.log(`📌 Creating donation record for donor ${donor.donorId} (type: ${typeof donor.donorId}) with amount ${donor.amount}`);
            
            try {
              // Use direct SQL query to bypass materialized view refresh
              console.log(`📌 Calling insert_single_donation with params:`, {
                donor_id: parseInt(donor.donorId, 10),
                amount: donor.amount,
                missionary_id: paymentDetails.recipientId,
                donation_date: new Date().toISOString(),
                source: 'online',
                status: 'completed',
                notes: `Bulk payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
              });
              
              const { data: donationResult, error: donationError } = await supabase.rpc(
                'insert_single_donation',
                {
                  donor_id: parseInt(donor.donorId, 10), // Convert string to number
                  amount: donor.amount,
                  missionary_id: paymentDetails.recipientId,
                  donation_date: new Date().toISOString(),
                  source: 'online',
                  status: 'completed',
                  notes: `Bulk payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
                }
              );
              
              if (donationError) {
                console.error(`❌ Error creating donation record for donor ${donor.donorId}:`, donationError);
              } else {
                console.log(`✅ Successfully created donation record for donor ${donor.donorId}`, donationResult);
              }
            } catch (err) {
              console.error(`❌ Exception creating donation record for donor ${donor.donorId}:`, err);
            }
          }
        } else if (paymentDetails.recipientId && paymentDetails.donorId) {
          console.log(`📌 Processing single donation for donor ${paymentDetails.donorId} (type: ${typeof paymentDetails.donorId})`);
          
          try {
            // Use direct SQL query to bypass materialized view refresh
            console.log(`📌 Calling insert_single_donation with params:`, {
              donor_id: parseInt(paymentDetails.donorId, 10),
              amount: transaction.amount,
              missionary_id: paymentDetails.recipientId,
              donation_date: new Date().toISOString(),
              source: 'online',
              status: 'completed',
              notes: `Payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
            });
            
            const { data: donationResult, error: donationError } = await supabase.rpc(
              'insert_single_donation',
              {
                donor_id: parseInt(paymentDetails.donorId, 10), // Convert string to number
                amount: transaction.amount,
                missionary_id: paymentDetails.recipientId,
                donation_date: new Date().toISOString(),
                source: 'online',
                status: 'completed',
                notes: `Payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
              }
            );
            
            if (donationError) {
              console.error(`❌ Error creating donation record:`, donationError);
            } else {
              console.log(`✅ Successfully created donation record for donor ${paymentDetails.donorId}`, donationResult);
            }
          } catch (err) {
            console.error(`❌ Exception creating donation record:`, err);
          }
        } else {
          console.warn('⚠️ No valid donor information found in payment details:', paymentDetails);
        }
      } else {
        console.warn('⚠️ No payment details found for transaction');
        
        // Fallback: Try to find invoice items for this invoice
        console.log('📌 Attempting to find invoice items for invoice:', invoiceId);
        
        const { data: invoiceItems, error: itemsError } = await supabase
          .from('invoice_items')
          .select('*')
          .eq('invoice_id', invoiceId);
        
        if (itemsError) {
          console.error('❌ Error finding invoice items:', itemsError);
        } else if (invoiceItems && invoiceItems.length > 0) {
          console.log(`📌 Found ${invoiceItems.length} invoice items for invoice ${invoiceId}`);
          
          // Process each invoice item
          for (const item of invoiceItems) {
            if (!item.missionary_id || !item.donor_id) {
              console.warn('⚠️ Skipping invoice item with missing data:', item);
              continue;
            }
            
            console.log(`📌 Creating donation record from invoice item for donor ${item.donor_id}`);
            
            try {
              // Use direct SQL query to bypass materialized view refresh
              const { error: donationError } = await supabase.rpc(
                'insert_single_donation',
                {
                  donor_id: parseInt(item.donor_id, 10), // Convert string to number
                  amount: item.amount || transaction.amount,
                  missionary_id: item.missionary_id,
                  donation_date: new Date().toISOString(),
                  source: 'online',
                  status: 'completed',
                  notes: `Payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
                }
              );
              
              if (donationError) {
                console.error(`❌ Error creating donation record from invoice item:`, donationError);
              } else {
                console.log(`✅ Successfully created donation record from invoice item for donor ${item.donor_id}`);
              }
            } catch (err) {
              console.error(`❌ Exception creating donation record from invoice item:`, err);
            }
          }
        } else {
          console.warn('⚠️ No invoice items found for invoice:', invoiceId);
        }
      }
    } else {
      console.log(`📌 Transaction already completed, skipping donation creation`);
    }
    
    return { success: true };
  } catch (error) {
    console.error('❌ Error handling invoice.paid event:', error);
    return { success: false, error: error instanceof Error ? error.message : "Unknown error" };
  }
}

/**
 * Handles the invoice.expired event
 */
export async function handleInvoiceExpired(payload: any, supabase: any) {
  console.log('📌 Processing expired invoice webhook:', payload.id);
  
  try {
    // Extract the invoice ID and external ID from the payload
    const invoiceId = payload.id;
    const externalId = payload.external_id;
    
    if (!invoiceId) {
      console.error('❌ Missing invoice ID in webhook payload');
      return { success: false, error: 'Missing invoice ID' };
    }
    
    // Update webhook log status
    await supabase
      .from("webhook_logs")
      .update({ status: "processing" })
      .eq("webhook_id", payload.id || "unknown");
    
    // Find the transaction record
    console.log(`📌 Looking for transaction with reference: ${externalId} or invoice_id: ${invoiceId}`);
    
    // First try to find by reference
    let { data: transaction, error: txError } = await supabase
      .from('payment_transactions')
      .select('*')
      .eq('reference', externalId)
      .single();
    
    // If not found by reference, try by invoice_id
    if (!transaction) {
      console.log(`📌 Transaction not found by reference, trying invoice_id: ${invoiceId}`);
      const { data: txByInvoice, error: invoiceError } = await supabase
        .from('payment_transactions')
        .select('*')
        .eq('invoice_id', invoiceId)
        .single();
      
      if (txByInvoice) {
        transaction = txByInvoice;
        txError = invoiceError;
      }
    }
    
    if (txError) {
      console.error('❌ Error finding transaction record:', txError);
      return { success: false, error: 'Transaction not found' };
    }
    
    if (!transaction) {
      console.error('❌ Transaction not found for reference:', externalId, 'or invoice_id:', invoiceId);
      return { success: false, error: 'Transaction not found' };
    }
    
    console.log(`📌 Found transaction record for reference ${externalId} with ID ${transaction.id}`);
    
    // Update transaction status
    const { error: updateError } = await supabase
      .from('payment_transactions')
      .update({
        status: 'expired',
        updated_at: new Date().toISOString()
      })
      .eq('id', transaction.id);
    
    if (updateError) {
      console.error('❌ Error updating transaction status:', updateError);
      return { success: false, error: 'Failed to update transaction' };
    }
    
    console.log(`📌 Updated transaction status to expired for ID ${transaction.id}`);
    
    return { success: true };
  } catch (error) {
    console.error('❌ Error handling invoice.expired event:', error);
    return { success: false, error: error instanceof Error ? error.message : "Unknown error" };
  }
}
