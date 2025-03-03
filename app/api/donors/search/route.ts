import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';

/**
 * GET /api/donors/search?term=searchTerm
 * 
 * Searches for donors by name or email using the server-side Supabase client with admin privileges.
 * This bypasses RLS policies that might prevent client-side donor search.
 */
export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const searchTerm = searchParams.get('term');
    
    // Validate search term
    if (!searchTerm || searchTerm.length < 2) {
      return NextResponse.json(
        { error: 'Search term must be at least 2 characters' },
        { status: 400 }
      );
    }
    
    // Create a Supabase client with service role key
    const supabaseAdmin = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Search for donors by name or email
    const { data, error } = await supabaseAdmin
      .from('donors')
      .select('id, name, email, phone')
      .or(`name.ilike.%${searchTerm}%,email.ilike.%${searchTerm}%`)
      .limit(20);
    
    if (error) {
      console.error('Error searching donors:', error);
      return NextResponse.json(
        { error: error.message },
        { status: 500 }
      );
    }
    
    // Log the search results for debugging
    console.log(`Search for "${searchTerm}" found ${data?.length || 0} results`);
    
    return NextResponse.json(data || []);
    
  } catch (err) {
    console.error('Unexpected error searching donors:', err);
    return NextResponse.json(
      { error: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
} 