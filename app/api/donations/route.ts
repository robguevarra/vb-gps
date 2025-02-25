/**
 * Donation Logging API Endpoint
 *
 * This API endpoint handles the logging of donation records for both online and offline donations.
 * It is designed to be re-usable across our application for any donation logging, including manual
 * donations recorded via the Finance Dashboard as well as online donations recorded by missionaries.
 *
 * How it works:
 * 1. The endpoint accepts a JSON payload with donation details such as:
 *    - donor_name, donor_email, donor_phone, amount, date, missionary_id, notes, and an optional "source" field.
 *    If "source" is not provided, it defaults to "offline".
 * 2. It validates that the required fields (donor_name, amount, date, missionary_id) are present.
 * 3. It creates a server-side Supabase client and retrieves the authenticated user using supabase.auth.getUser().
 *    This ensures the donation is attributed to the current authenticated user.
 * 4. The endpoint checks if a donor with the given donor_name exists.
 *    - If the donor exists, it updates their email/phone if provided and different.
 *    - If the donor does not exist, it creates a new donor record.
 * 5. The donation record is built with the 'recorded_by' field explicitly set to the authenticated user's ID.
 * 6. The donation record is inserted into the donor_donations table.
 *
 * Note: The 'recorded_by' field is enforced via Row-Level Security (RLS) policies (with proper UUID casting)
 * to ensure that only authorized users can log donations. Ensure that your RLS policies are set up accordingly.
 *
 * This endpoint can be re-used for all donation logging scenarios.
 */

import { createClient } from '@/utils/supabase/server';
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  try {
    // Parse the incoming payload
    const payload = await request.json();
    const {
      donor_name,
      donor_email,
      donor_phone,
      amount,
      date,
      missionary_id,
      notes,
      source, // optional field: can be 'online' or 'offline'
    } = payload;
    console.log("[API] Received payload:", payload);

    // Validate required fields
    if (!donor_name || !amount || !date || !missionary_id) {
      console.error("[API] Missing required fields");
      return NextResponse.json({ error: "Missing required fields" }, { status: 400 });
    }

    // Create a server-side Supabase client
    const supabase = await createClient();
    console.log("[API] Supabase client created.");

    // Get the authenticated user from the request
    const {
      data: { user: authUser },
      error: authError,
    } = await supabase.auth.getUser();
    if (authError || !authUser) {
      console.error("[API] Authentication error:", authError?.message || "No authenticated user");
      return NextResponse.json({ error: "Authentication required" }, { status: 401 });
    }
    console.log("[API] Authenticated user:", authUser);

    // Override any client-provided recorded_by with the authenticated user's id.
    const recorded_by = authUser.id;

    // Check if donor exists by donor_name
    const { data: existingDonor } = await supabase
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
        console.error(
          "[API] Error creating new donor:",
          newDonorError ? newDonorError.message : "No donor returned"
        );
        return NextResponse.json({ error: newDonorError ? newDonorError.message : 'Failed to create donor' }, { status: 500 });
      }
      donorId = newDonor.id;
      console.log("[API] Created new donor with id:", donorId);
    }

    // Build the donation record with the authenticated user's ID for recorded_by.
    const donationRecord = {
      donor_id: donorId,
      missionary_id,
      amount,
      date,
      source: source || 'offline',
      status: 'completed',
      notes: notes || "",
      recorded_by, // Force recorded_by to the authenticated user's ID
    };

    console.log("[API] Inserting donation record:", donationRecord);

    // Insert donation record into donor_donations table
    const { data: donation, error: donationError } = await supabase
      .from('donor_donations')
      .insert([donationRecord])
      .select();

    if (donationError) {
      console.error("[API] Donation insert error:", donationError.message);
      return NextResponse.json({ error: donationError.message }, { status: 500 });
    }

    console.log("[API] Donation inserted successfully:", donation);
    return NextResponse.json({ donation }, { status: 200 });
  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'An unexpected error occurred';
    console.error("[API] Unexpected error:", errorMessage);
    return NextResponse.json({ error: errorMessage }, { status: 500 });
  }
}
