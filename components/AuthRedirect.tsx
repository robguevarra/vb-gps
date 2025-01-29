'use client'

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { useSupabase } from '@/app/supabase-provider'

export default function AuthRedirect() {
  const { session } = useSupabase()
  const router = useRouter()

  useEffect(() => {
    if (!session) {
      router.push('/login')
      return
    }

    // Redirect based on role
    const role = session.user.user_metadata.role
    switch(role) {
      case 'missionary':
        router.push('/dashboard/missionary')
        break
      case 'campus_director':
        router.push('/dashboard/campus-director')
        break
      case 'lead_pastor':
        router.push('/dashboard/lead-pastor')
        break
      case 'finance_officer':
        router.push('/dashboard/finance')
        break
      case 'superadmin':
        router.push('/dashboard/superadmin')
        break
      default:
        router.push('/login')
    }
  }, [session, router])

  return <div>Redirecting...</div>
} 