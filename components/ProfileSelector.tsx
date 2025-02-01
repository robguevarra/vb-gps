'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'

export default function ProfileSelector({
  missionaries,
  userId: initialUserId,
}: {
  missionaries: any[]
  userId?: string
}) {
  const router = useRouter()
  const [selected, setSelected] = useState(initialUserId || 'clear')

  useEffect(() => {
    setSelected(initialUserId || 'clear')
  }, [initialUserId])

  const handleValueChange = (value: string) => {
    setSelected(value)

    const newParams = new URLSearchParams(window.location.search)
    // Add a timestamp parameter to force refresh if needed.
    newParams.set('_t', Date.now().toString())

    if (value === 'clear') {
      newParams.delete('userId')
    } else {
      newParams.set('userId', value)
    }

    router.push(`${window.location.pathname}?${newParams.toString()}`, {
      scroll: false,
    })
  }

  return (
    <Select value={selected} onValueChange={handleValueChange}>
      <SelectTrigger className="w-[300px]">
        <SelectValue placeholder="Select missionary" />
      </SelectTrigger>
      <SelectContent>
        <SelectItem value="clear">View as myself</SelectItem>
        {missionaries.map((missionary) => (
          <SelectItem key={missionary.id} value={missionary.id}>
            {missionary.full_name} ({missionary.role.replace(/_/g, ' ')})
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
  )
}
