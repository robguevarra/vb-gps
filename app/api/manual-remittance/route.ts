import { NextResponse } from 'next/server';
import { createClient } from '@/utils/supabase/server';
import Xendit from 'xendit-node';

// Initialize Xendit
const xendit = new Xendit({
  secretKey: process.env.XENDIT_SECRET_KEY || 'xnd_development_HLD1jNIChyU5q0rjTNfOdgLYwHJihuiRNxS9v7K91ChPLjZSuuoHHPqVRMQiOB',
});
const invoiceClient = xendit.Invoice;

export async function POST(request: Request) {
  try {
    const payload = await request.json();
    const {
      donations, // Array of donation entries
      missionary_id,
      total_amount, // Total amount for the batch
      notes
    } = payload;

    // Validate payload
    if (!donations || !Array.isArray(donations) || donations.length === 0 || !missionary_id) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    // Create Supabase client
    const supabase = await createClient();

    // Get authenticated user
    const { data: { user: authUser }, error: authError } = await supabase.auth.getUser();
    if (authError || !authUser) {
      return NextResponse.json({ error: "Authentication required" }, { status: 401 });
    }

    // Generate a batch ID for this remittance
    const batch_id = crypto.randomUUID();

    // Create Xendit invoice for the total amount
    const external_id = `manual-remit-${batch_id}`;
    const invoice = await invoiceClient.createInvoice({
      data: {
        amount: total_amount,
        externalId: external_id,
        description: `Manual remittance batch ${batch_id}`,
        payerEmail: authUser.email,
        currency: "PHP",
        items: donations.map(d => ({
          name: `Donation from ${d.donor_name}`,
          quantity: 1,
          price: d.amount,
        }))
      }
    });

    // Prepare donation records
    const donationRecords = donations.map(donation => ({
      donor_id: donation.donor_id,
      missionary_id,
      amount: donation.amount,
      date: new Date().toISOString(),
      source: 'offline',
      status: 'pending',
      notes: donation.notes || notes,
      recorded_by: authUser.id,
      batch_id,
      xendit_invoice_id: invoice.id,
    }));

    // Insert all donation records
    const { data: insertedDonations, error: insertError } = await supabase
      .from('donor_donations')
      .insert(donationRecords)
      .select();

    if (insertError) {
      return NextResponse.json({ error: insertError.message }, { status: 500 });
    }

    return NextResponse.json({
      success: true,
      batch_id,
      invoice_url: invoice.invoiceUrl,
      donations: insertedDonations,
    });

  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'An unexpected error occurred';
    console.error("Manual remittance error:", error);
    return NextResponse.json({ error: errorMessage }, { status: 500 });
  }
} 