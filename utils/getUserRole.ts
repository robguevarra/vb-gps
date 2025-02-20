// utils/getUserRole.ts
import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { cookies } from 'next/headers';

export const getUserRole = async (userId: string): Promise<string | null> => {
  // Await cookies() as required.
  const cookieStore = await cookies();
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    {
      cookies: {
        async get(name: string) {
          return cookieStore.get(name)?.value;
        },
        async set(name: string, value: string, options: CookieOptions) {
          cookieStore.set({ name, value, ...options });
        },
        async remove(name: string, options: CookieOptions) {
          cookieStore.set({ name, value: '', ...options });
        }
      }
    }
  );

  const { data, error } = await supabase
    .from('user_roles')
    .select('role')
    .eq('user_id', userId)
    .single();

  if (error) {
    console.error("Error fetching user role:", error.message);
    return null;
  }
  return data?.role || null;
};
