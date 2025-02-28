import { createClient } from '@/utils/supabase/server';
import { createClient as createServiceClient } from '@supabase/supabase-js';
import { NextRequest, NextResponse } from 'next/server';

// POST handler for creating a new donor
export async function POST(req: NextRequest) {
  try {
    // Get the request body
    const body = await req.json();
    
    console.log('Creating new donor:', body);
    
    // Validate required fields
    if (!body.name || !body.name.trim()) {
      console.log('Donor creation failed: Name is required');
      return NextResponse.json(
        { error: 'Donor name is required' },
        { status: 400 }
      );
    }
    
    if (!body.email || !body.email.includes('@')) {
      console.log('Donor creation failed: Valid email is required');
      return NextResponse.json(
        { error: 'Valid email is required' },
        { status: 400 }
      );
    }
    
    // Create a regular client to check authentication
    const supabase = await createClient();
    
    // Check if the user is authenticated
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    
    if (authError || !user) {
      console.log('Donor creation failed: Authentication required');
      return NextResponse.json(
        { error: 'Authentication required' },
        { status: 401 }
      );
    }
    
    // Create a service client to bypass RLS
    const serviceClient = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Create the donor
    const { data: donor, error } = await serviceClient
      .from('donors')
      .insert({
        name: body.name.trim(),
        email: body.email.trim(),
        phone: body.phone || null
      })
      .select('*')
      .single();
    
    if (error) {
      console.error('Error creating donor:', error);
      
      // Check for duplicate email
      if (error.code === '23505' && error.message.includes('email')) {
        console.log('Donor creation failed: Email already exists');
        return NextResponse.json(
          { error: 'A donor with this email already exists' },
          { status: 409 }
        );
      }
      
      return NextResponse.json(
        { error: 'Failed to create donor' },
        { status: 500 }
      );
    }
    
    console.log('Donor created successfully:', donor);
    
    return NextResponse.json(donor, { status: 201 });
  } catch (error) {
    console.error('Exception in donor creation:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// GET handler for searching donors
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const search = searchParams.get('search') || '';
  
  console.log(`Searching donors with term: "${search}"`);
  
  try {
    const supabase = await createClient();
    
    // Check if the user is authenticated
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    
    if (authError || !user) {
      console.log('Authentication error in donor search');
      return NextResponse.json(
        { error: 'Authentication required' },
        { status: 401 }
      );
    }
    
    // Search donors
    const { data, error } = await supabase
      .from('donors')
      .select('id, name, email, phone')
      .ilike('name', `%${search}%`)
      .limit(10);
    
    if (error) {
      console.error('Error searching donors:', error);
      return NextResponse.json({ donors: [] }, { status: 200 });
    }
    
    console.log(`Found ${data?.length || 0} donors matching "${search}"`);
    
    return NextResponse.json({ donors: data }, { status: 200 });
  } catch (error) {
    console.error('Exception in donor search:', error);
    return NextResponse.json({ donors: [] }, { status: 200 });
  }
} 