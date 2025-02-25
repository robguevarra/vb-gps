import { NextResponse } from 'next/server'
import { createClient } from '@/utils/supabase/server'
import crypto from 'crypto'

const WEBHOOK_TOKEN = process.env.XENDIT_WEBHOOK_SECRET || 'DfHz2IsSz1ErauIztRvCpGEVw0a1I4KbwgrO69EmFJlFl24z'

interface XenditWebhookPayload {
  event: 'invoice.paid' | 'invoice.expired';
  invoice_id: string;
  payment_method?: string;
  payment_channel?: string;
  payment_id?: string;
}

function verifyWebhookSignature(payload: XenditWebhookPayload, signature: string) {
  const calculatedSignature = crypto
    .createHmac('sha256', WEBHOOK_TOKEN)
    .update(JSON.stringify(payload))
    .digest('hex')
  
  return calculatedSignature === signature
}

export async function POST(request: Request) {
  try {
    const signature = request.headers.get('x-callback-token')
    if (!signature) {
      return NextResponse.json({ error: 'No signature provided' }, { status: 401 })
    }

    const payload = await request.json() as XenditWebhookPayload
    
    // Verify webhook signature
    if (!verifyWebhookSignature(payload, signature)) {
      return NextResponse.json({ error: 'Invalid signature' }, { status: 401 })
    }

    const supabase = await createClient()
    
    // Handle different webhook events
    switch (payload.event) {
      case 'invoice.paid': {
        // Update all donations in the batch to completed
        const { data, error } = await supabase
          .from('donor_donations')
          .update({
            status: 'completed',
            payment_method: payload.payment_method,
            payment_channel: payload.payment_channel,
            payment_timestamp: new Date().toISOString(),
            xendit_payment_id: payload.payment_id
          })
          .eq('xendit_invoice_id', payload.invoice_id)
          .select()

        if (error) {
          throw error
        }

        return NextResponse.json({ success: true, updated: data })
      }

      case 'invoice.expired': {
        // Update donations to expired
        const { data, error } = await supabase
          .from('donor_donations')
          .update({
            status: 'expired'
          })
          .eq('xendit_invoice_id', payload.invoice_id)
          .select()

        if (error) {
          throw error
        }

        return NextResponse.json({ success: true, updated: data })
      }

      default:
        return NextResponse.json({ message: 'Unhandled event type' }, { status: 200 })
    }

  } catch (error: unknown) {
    console.error("Webhook error:", error)
    const errorMessage = error instanceof Error ? error.message : 'An unexpected error occurred'
    return NextResponse.json({ error: errorMessage }, { status: 500 })
  }
} 