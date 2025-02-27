import { NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// Create a Supabase client with admin privileges to bypass RLS
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

// Mock data for testing when database is not available
const mockTransactions = [
  {
    id: '123e4567-e89b-12d3-a456-426614174000',
    reference_id: 'donation_test1',
    invoice_id: 'mock_invoice_1',
    invoice_url: 'https://checkout-staging.xendit.co/web/123456',
    status: 'COMPLETED',
    amount: 1000,
    fee_amount: 25,
    payment_method: 'CREDIT_CARD',
    payment_channel: 'CREDIT_CARD',
    payer_email: 'test@example.com',
    payer_name: 'Test User',
    created_at: new Date().toISOString(),
    paid_at: new Date().toISOString(),
  },
  {
    id: '223e4567-e89b-12d3-a456-426614174001',
    reference_id: 'donation_test2',
    invoice_id: 'mock_invoice_2',
    invoice_url: 'https://checkout-staging.xendit.co/web/234567',
    status: 'PENDING',
    amount: 2000,
    payer_email: 'test2@example.com',
    payer_name: 'Test User 2',
    created_at: new Date().toISOString(),
  },
  {
    id: '323e4567-e89b-12d3-a456-426614174002',
    reference_id: 'donation_test3',
    invoice_id: 'mock_invoice_3',
    invoice_url: 'https://checkout-staging.xendit.co/web/345678',
    status: 'EXPIRED',
    amount: 3000,
    payer_email: 'test3@example.com',
    payer_name: 'Test User 3',
    created_at: new Date(Date.now() - 86400000).toISOString(), // 1 day ago
  },
];

/**
 * GET handler for fetching recent payment transactions
 * This endpoint returns a list of recent payment transactions for testing purposes
 */
export async function GET(req: Request) {
  try {
    // Get query parameters
    const url = new URL(req.url);
    const limit = parseInt(url.searchParams.get('limit') || '10', 10);
    const useMock = url.searchParams.get('mock') === 'true' || process.env.NODE_ENV !== 'production';
    
    // Use mock data for testing if requested or if in development mode
    if (useMock) {
      console.log('Using mock transaction data for testing');
      return NextResponse.json({
        success: true,
        transactions: mockTransactions.slice(0, limit),
      });
    }
    
    // Fetch recent transactions from the database
    // Using service role client to bypass RLS
    const { data: transactions, error } = await supabase
      .from('payment_transactions')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(limit);
    
    if (error) {
      console.error('Error fetching recent transactions:', error);
      return NextResponse.json(
        { error: 'Failed to fetch recent transactions' },
        { status: 500 }
      );
    }
    
    return NextResponse.json({
      success: true,
      transactions,
    });
  } catch (error) {
    console.error('Error fetching recent transactions:', error);
    return NextResponse.json(
      { error: 'Failed to fetch recent transactions' },
      { status: 500 }
    );
  }
} 