import { createClient } from '@/utils/supabase/server';
import { NextResponse } from 'next/server';

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const search = searchParams.get('search') || "";

  const supabase = await createClient();
  const { data, error } = await supabase
    .from('donors')
    .select('id, name, email, phone')
    .ilike('name', `%${search}%`);

  if (error) {
    console.error('Error fetching donor suggestions:', error);
    return NextResponse.json({ donors: [] }, { status: 200 });
  }

  return NextResponse.json({ donors: data }, { status: 200 });
} 