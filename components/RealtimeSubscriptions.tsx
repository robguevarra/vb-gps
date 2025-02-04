'use client'

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/utils/supabase/client'

export default function RealtimeSubscriptions() {
  const router = useRouter()
  const supabase = createClient()

  useEffect(() => {
    const channel = supabase
      .channel('requests')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'leave_requests' }, () => router.refresh())
      .on('postgres_changes', { event: '*', schema: 'public', table: 'surplus_requests' }, () => router.refresh())
      .subscribe()

    return () => {
      channel.unsubscribe()
    }
  }, [router, supabase])

  return null
} 