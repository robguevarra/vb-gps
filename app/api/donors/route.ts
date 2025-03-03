import { createClient } from '@/utils/supabase/server';
import { createClient as createServiceClient } from '@supabase/supabase-js';
import { NextRequest, NextResponse } from 'next/server';

// POST handler for creating a new donor
export async function POST(req: NextRequest) {
  try {
    // Get the request body
    const body = await req.json();
    
    // Keep this log as it's useful for debugging donor creation issues
    console.log('Creating new donor request received');
    
    // Validate required fields
    if (!body.name || !body.name.trim()) {
      // Keep this log as it's useful for debugging validation issues
      console.log('Donor creation failed: Name is required');
      return NextResponse.json(
        { error: 'Donor name is required' },
        { status: 400 }
      );
    }
    
    if (!body.email || !body.email.includes('@')) {
      // Keep this log as it's useful for debugging validation issues
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
      // Keep this log as it's useful for debugging authentication issues
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
      // Keep error logs for debugging
      console.error('Error creating donor:', error);
      
      // Check for duplicate email
      if (error.code === '23505' && error.message.includes('email')) {
        // Keep this log as it's useful for debugging duplicate email issues
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
    
    // Keep this log as it's useful for tracking successful donor creation
    console.log('Donor created successfully with ID:', donor.id);
    
    return NextResponse.json(donor, { status: 201 });
  } catch (error) {
    // Keep error logs for debugging
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
  // Get the limit parameter from the URL, default to 1000
  const limit = parseInt(searchParams.get('limit') || '1000', 10);
  // Get the offset parameter for pagination
  const offset = parseInt(searchParams.get('offset') || '0', 10);
  // Get sort parameter, default to created_at desc
  const sortBy = searchParams.get('sort') || 'created_at';
  const sortOrder = searchParams.get('order') || 'desc';
  
  // Remove excessive log
  
  try {
    const supabase = await createClient();
    
    // Check if the user is authenticated
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    
    if (authError || !user) {
      // Keep this log as it's useful for debugging authentication issues
      console.log('Authentication error in donor search');
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
    
    // Build the query with pagination and sorting
    let query = serviceClient
      .from('donors')
      .select('id, name, email, phone', { count: 'exact' });
    
    // Add search filter if provided
    if (search) {
      query = query.ilike('name', `%${search}%`);
    }
    
    // Add pagination
    query = query
      .order(sortBy, { ascending: sortOrder === 'asc' })
      .range(offset, offset + limit - 1);
    
    // Execute the query
    const { data, error, count } = await query;
    
    if (error) {
      // Keep error logs for debugging
      console.error('Error searching donors:', error);
      return NextResponse.json({ donors: [], total: 0 }, { status: 200 });
    }
    
    // Return the results with pagination metadata
    return NextResponse.json({ 
      donors: data || [], 
      total: count || 0,
      hasMore: data && data.length === limit,
      page: Math.floor(offset / limit) + 1,
      pageSize: limit,
      offset
    });
  } catch (error) {
    // Keep error logs for debugging
    console.error('Exception in donor search:', error);
    return NextResponse.json({ donors: [], total: 0 }, { status: 200 });
  }
} 