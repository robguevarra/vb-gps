//utils/supabase/client.ts

import { createBrowserClient } from '@supabase/ssr'

export const createClient = () =>
  createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      // Configure client-side auth settings
      auth: {
        autoRefreshToken: true,
        persistSession: true,
        flowType: 'pkce'
      },
      // Set cookie options
      cookieOptions: {
        maxAge: 60 * 60 * 24, // 24 hours in seconds
        sameSite: 'lax',
        secure: process.env.NODE_ENV === 'production'
      }
    }
  )