import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { cookies } from 'next/headers';

export const createClient = async () => {
  const cookieStore = await cookies();

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    {
      cookies: {
        async get(name: string) {
          return (await cookieStore).get(name)?.value;
        },
        async set(name: string, value: string, options: CookieOptions) {
          // Set a 24-hour expiration for all auth cookies
          const cookieOptions = {
            ...options,
            maxAge: 60 * 60 * 24, // 24 hours in seconds
            expires: new Date(Date.now() + 1000 * 60 * 60 * 24), // 24 hours from now
          };
          
          ;(await cookieStore).set({ name, value, ...cookieOptions });
        },
        async remove(name: string, options: CookieOptions) {
          ;(await cookieStore).set({ name, value: '', ...options });
        }
      },
      // Enable RLS bypass with service role
      auth: {
        autoRefreshToken: true, // Enable token refresh
        persistSession: true,   // Enable session persistence
        detectSessionInUrl: false
      }
    }
  );
};
