import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';

/**
 * GET /api/donors/search
 * 
 * Enhanced donor search API with pagination and optimized search capabilities.
 * Designed to handle large datasets (10,000+ donors) efficiently.
 * 
 * Query parameters:
 * - term: Search term (optional, min 2 characters)
 * - page: Page number (default: 1)
 * - pageSize: Items per page (default: 20, max: 100)
 * 
 * Returns:
 * - data: Array of donor objects
 * - pagination: Pagination metadata
 */
export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const searchTerm = searchParams.get('term') || '';
    const page = Math.max(1, parseInt(searchParams.get('page') || '1'));
    const pageSize = Math.min(100, Math.max(1, parseInt(searchParams.get('pageSize') || '20')));
    
    // Validate search term if provided
    if (searchTerm && searchTerm.length < 2) {
      return NextResponse.json(
        { error: 'Search term must be at least 2 characters' },
        { status: 400 }
      );
    }
    
    // Create Supabase client with admin privileges
    const supabaseAdmin = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    // Log request for debugging
    console.log(`Donor search request: term="${searchTerm}", page=${page}, pageSize=${pageSize}`);
    
    // Get total donor count for debugging (only on first page)
    if (page === 1) {
      const { count: totalDonors } = await supabaseAdmin
        .from('donors')
        .select('*', { count: 'exact', head: true });
        
      console.log(`Total donors in database: ${totalDonors || 'unknown'}`);
    }
    
    // Build query
    let query = supabaseAdmin
      .from('donors')
      .select('id, name, email, phone', { count: 'exact' });
    
    // Apply search filter if term provided
    if (searchTerm) {
      // Split search terms for more flexible matching
      const terms = searchTerm.toLowerCase().split(/\s+/).filter(term => term.length > 0);
      
      if (terms.length > 0) {
        // Create search conditions for each term
        const searchConditions = terms.map(term => {
          return `name.ilike.%${term}%,email.ilike.%${term}%`;
        }).join(',');
        
        console.log(`Search conditions: ${searchConditions}`);
        query = query.or(searchConditions);
      }
    }
    
    // Calculate pagination
    const from = (page - 1) * pageSize;
    const to = from + pageSize - 1;
    
    // Execute query with pagination
    const { data, error, count } = await query
      .order('name')
      .range(from, to);
    
    if (error) {
      console.error('Error searching donors:', error);
      return NextResponse.json(
        { error: error.message },
        { status: 500 }
      );
    }
    
    // Calculate pagination metadata
    const totalCount = count || 0;
    const totalPages = Math.ceil(totalCount / pageSize);
    const hasMore = from + pageSize < totalCount;
    
    // Log results for debugging
    console.log(`Search results: ${data?.length || 0} donors (page ${page}/${totalPages}, total: ${totalCount})`);
    
    // Return paginated results with metadata
    return NextResponse.json({
      data: data || [],
      pagination: {
        page,
        pageSize,
        totalCount,
        totalPages,
        hasMore
      }
    });
    
  } catch (err) {
    console.error('Unexpected error searching donors:', err);
    return NextResponse.json(
      { error: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
} 