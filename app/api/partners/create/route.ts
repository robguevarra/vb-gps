import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';

/**
 * POST /api/partners/create
 * 
 * Creates a new partner for a donor using the server-side Supabase client with admin privileges.
 * This bypasses RLS policies that prevent client-side partner creation.
 */
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { donorId, name, email, phone } = body;
    
    // Validate required fields
    if (!donorId) {
      return NextResponse.json(
        { error: 'Donor ID is required' },
        { status: 400 }
      );
    }
    
    if (!name) {
      return NextResponse.json(
        { error: 'Partner name is required' },
        { status: 400 }
      );
    }
    
    // Create a Supabase client with service role key
    const supabaseAdmin = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Check if donor exists
    const { data: donorExists, error: donorCheckError } = await supabaseAdmin
      .from('donors')
      .select('id')
      .eq('id', donorId)
      .single();
    
    if (donorCheckError || !donorExists) {
      return NextResponse.json(
        { error: 'Donor not found' },
        { status: 404 }
      );
    }
    
    // Insert the partner into the donors table
    const { data, error } = await supabaseAdmin
      .from('donors')
      .insert({
        name,
        email: email || null,
        phone: phone || null
      })
      .select('id, name, email, phone')
      .single();
    
    if (error) {
      console.error('Error creating partner:', error);
      return NextResponse.json(
        { error: error.message },
        { status: 500 }
      );
    }
    
    // Generate a unique ID for the partner in our client-side store
    const partnerId = `partner_${Date.now()}_${Math.random().toString(36).substring(2, 9)}`;
    
    // Create partner object with both database ID and client-side ID
    const partner = {
      id: partnerId,
      donorId,
      databaseId: data.id, // Store the actual database ID
      name: data.name,
      email: data.email || null,
      phone: data.phone || null
    };
    
    // Return the partner data
    return NextResponse.json(partner);
    
  } catch (err) {
    console.error('Unexpected error creating partner:', err);
    return NextResponse.json(
      { error: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
} 