import { NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

export async function POST(request: Request) {
  const secret = request.headers.get('x-xendit-callback-token')
  if (secret !== process.env.XENDIT_WEBHOOK_SECRET) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const payload = await request.json()
  try {
    // Example payload parsing - adjust based on Xendit's actual webhook format
    const donation = {
      missionary_id: payload.external_id, // Assuming you pass missionary ID as external_id
      amount: payload.amount,
      donor_name: payload.payer?.name || 'Anonymous',
      source: 'online',
      status: payload.status === 'PAID' ? 'completed' : 'failed'
    }

    const { data, error } = await supabase
      .from('donations')
      .insert(donation)
      .select()

    if (error) throw error

    return NextResponse.json({ success: true, data })
  } catch (error) {
    console.error('Webhook error:', error)
    return NextResponse.json(
      { error: 'Error processing webhook' },
      { status: 500 }
    )
  }
} 