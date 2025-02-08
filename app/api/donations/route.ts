import { createClient } from '@/utils/supabase/server';
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  try {
    const payload = await request.json();
    const { donor_name, donor_email, donor_phone, amount, date, missionary_id, notes } = payload;
    console.log("[API] Received payload:", payload);

    if (!donor_name || !amount || !date || !missionary_id) {
      console.error("[API] Missing required fields");
      return NextResponse.json({ error: "Missing required fields" }, { status: 400 });
    }

    const supabase = await createClient();
    console.log("[API] Supabase client created.");

    // Check if donor exists
    const { data: existingDonor, error: donorError } = await supabase
      .from('donors')
      .select('id, email, phone')
      .eq('name', donor_name)
      .maybeSingle();

    let donorId;
    if (existingDonor && existingDonor.id) {
      donorId = existingDonor.id;
      console.log("[API] Found existing donor with id:", donorId);
      // Update donor info if provided and different
      if (
        (donor_email && donor_email !== existingDonor.email) ||
        (donor_phone && donor_phone !== existingDonor.phone)
      ) {
        const { error: updateError } = await supabase
          .from('donors')
          .update({ email: donor_email, phone: donor_phone })
          .eq('id', donorId);
        if (updateError) {
          console.error("[API] Failed to update donor info:", updateError.message);
        } else {
          console.log("[API] Updated donor info for donor id:", donorId);
        }
      }
    } else {
      // Insert new donor with email and phone if provided
      const { data: newDonor, error: newDonorError } = await supabase
        .from('donors')
        .insert([{ name: donor_name, email: donor_email || null, phone: donor_phone || null }])
        .select('id')
        .maybeSingle();
      if (newDonorError || !newDonor) {
        console.error("[API] Error creating new donor:", newDonorError ? newDonorError.message : "No donor returned");
        return NextResponse.json({ error: newDonorError ? newDonorError.message : 'Failed to create donor' }, { status: 500 });
      }
      donorId = newDonor.id;
      console.log("[API] Created new donor with id:", donorId);
    }

    // Insert donation record into donor_donations table
    const { data: donation, error: donationError } = await supabase
      .from('donor_donations')
      .insert([
        {
          donor_id: donorId,
          missionary_id,
          amount,
          date,
          source: 'offline',
          status: 'completed',
          notes: notes || ""
        }
      ])
      .select();

    if (donationError) {
      console.error("[API] Donation insert error:", donationError.message);
      return NextResponse.json({ error: donationError.message }, { status: 500 });
    }

    console.log("[API] Donation inserted successfully:", donation);
    return NextResponse.json({ donation }, { status: 200 });
  } catch (error: any) {
    console.error("[API] Unexpected error:", error.message);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
