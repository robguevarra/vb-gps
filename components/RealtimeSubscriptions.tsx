//components/RealtimeSubscriptions.tsx

'use client'

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/utils/supabase/client'

interface TableSubscription {
  name: string;
  filter: string;
  event: string;
}

interface RealtimeSubscriptionsProps {
  tables: TableSubscription[];
}

export default function RealtimeSubscriptions({ tables }: RealtimeSubscriptionsProps) {
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    const channel = supabase.channel('realtime-subscriptions');

    tables.forEach((table) => {
      channel.on(
        'postgres_changes',
        { event: table.event, schema: 'public', table: table.name, filter: table.filter },
        (payload: any) => {
          console.log(`Realtime update detected on table: ${table.name}`, payload);
          router.refresh();
        }
      );
    });

    channel.subscribe();

    return () => {
      channel.unsubscribe();
    };
  }, [router, supabase, tables]);

  return null;
} 