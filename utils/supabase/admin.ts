/**
 * Admin Supabase Client
 * 
 * This module provides an admin-level Supabase client that bypasses RLS.
 * IMPORTANT: This client should ONLY be used in server-side code (server actions)
 * and never in client components.
 * 
 * Security considerations:
 * - Never import this in client components
 * - Only use for operations that require admin privileges
 * - Always validate user permissions before performing admin operations
 */

import { createClient as createSBClient } from '@supabase/supabase-js'

// Create an admin client specifically for bypassing RLS in server actions
export const createAdminClient = () => {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  
  if (!supabaseUrl || !supabaseServiceKey) {
    throw new Error('Missing Supabase environment variables')
  }
  
  // Create a client with explicit RLS bypass
  return createSBClient(supabaseUrl, supabaseServiceKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    },
    // Explicitly set to use service_role auth and bypass RLS
    global: {
      headers: {
        'x-supabase-auth-token': `service_role:${supabaseServiceKey}`
      }
    }
  })
}
