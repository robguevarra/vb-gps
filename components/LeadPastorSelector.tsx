// components/LeadPastorSelector.tsx

'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

export default function LeadPastorSelector({
  leadPastors,
  userId: initialUserId,
}: {
  leadPastors: any[];
  userId?: string;
}) {
  const router = useRouter();
  // For debugging, log the props
  console.log('[LeadPastorSelector] Received leadPastors:', leadPastors);
  console.log('[LeadPastorSelector] Received userId (initialUserId):', initialUserId);

  const [selected, setSelected] = useState(initialUserId || 'clear');

  useEffect(() => {
    console.log('[LeadPastorSelector] useEffect triggered, setting selected to:', initialUserId || 'clear');
    setSelected(initialUserId || 'clear');
  }, [initialUserId]);

  const handleValueChange = (value: string) => {
    console.log('[LeadPastorSelector] handleValueChange -> New value:', value);
    setSelected(value);

    const newParams = new URLSearchParams(window.location.search);
    // Add a timestamp parameter to force refresh if needed.
    newParams.set('_t', Date.now().toString());

    if (value === 'clear') {
      console.log('[LeadPastorSelector] Clearing userId param from query string...');
      newParams.delete('userId');
    } else {
      console.log('[LeadPastorSelector] Setting userId param to:', value);
      newParams.set('userId', value);
    }

    const newUrl = `${window.location.pathname}?${newParams.toString()}`;
    console.log('[LeadPastorSelector] Pushing to router with URL:', newUrl);

    router.push(newUrl, { scroll: false });
  };

  return (
    <Select value={selected} onValueChange={handleValueChange}>
      <SelectTrigger className="w-[300px]">
        <SelectValue placeholder="Select lead pastor" />
      </SelectTrigger>
      <SelectContent>
        <SelectItem value="clear">View as myself</SelectItem>
        {leadPastors.map((leadPastor) => (
          <SelectItem key={leadPastor.id} value={leadPastor.id}>
            {leadPastor.full_name} (Lead Pastor)
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
  );
}
