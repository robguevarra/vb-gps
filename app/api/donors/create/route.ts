import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';

/**
 * POST /api/donors/create
 * 
 * Creates a new donor using the server-side Supabase client with admin privileges.
 * This bypasses RLS policies that prevent client-side donor creation.
 */
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { name, email, phone } = body;
    
    // Validate required fields
    if (!name) {
      return NextResponse.json(
        { error: 'Donor name is required' },
        { status: 400 }
      );
    }
    
    // Create a Supabase client with service role key
    const supabaseAdmin = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Insert the new donor
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
      console.error('Error creating donor:', error);
      return NextResponse.json(
        { error: error.message },
        { status: 500 }
      );
    }
    
    return NextResponse.json(data);
    
  } catch (err) {
    console.error('Unexpected error creating donor:', err);
    return NextResponse.json(
      { error: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
} 