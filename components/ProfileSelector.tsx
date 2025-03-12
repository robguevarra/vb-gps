'use client'

import { useState, useEffect, Suspense } from 'react'
import { useRouter, useSearchParams, usePathname } from 'next/navigation'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { cn } from '@/lib/utils'

interface ProfileSelectorProps {
  missionaries: any[]
  userId?: string
  className?: string
  onClose?: () => void
}

/**
 * SelectorContent Component
 * 
 * This component handles the actual selection logic and URL updates.
 * It's separated to properly handle the useSearchParams hook which needs
 * to be wrapped in a Suspense boundary.
 */
function SelectorContent({
  missionaries,
  initialUserId,
  className,
  onClose
}: {
  missionaries: any[]
  initialUserId?: string
  className?: string
  onClose?: () => void
}) {
  const router = useRouter()
  const pathname = usePathname()
  const searchParams = useSearchParams()
  const [selected, setSelected] = useState(initialUserId || 'clear')

  useEffect(() => {
    setSelected(initialUserId || 'clear')
  }, [initialUserId])

  const handleValueChange = (value: string) => {
    setSelected(value)

    const newParams = new URLSearchParams(searchParams?.toString() || "")
    // Add a timestamp parameter to force refresh if needed.
    newParams.set('_t', Date.now().toString())

    if (value === 'clear') {
      newParams.delete('userId')
    } else {
      newParams.set('userId', value)
    }

    router.push(`${pathname}?${newParams.toString()}`, {
      scroll: false,
    })
    
    // Call onClose if provided
    if (onClose) {
      onClose()
    }
  }

  return (
    <div className={className}>
      <Select value={selected} onValueChange={handleValueChange}>
        <SelectTrigger className="w-[200px]">
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
    </div>
  )
}

export default function ProfileSelector(props: ProfileSelectorProps) {
  return (
    <Suspense fallback={
      <div className={props.className}>
        <Select disabled value={props.userId || "clear"}>
          <SelectTrigger className="w-[200px]">
            <SelectValue placeholder="Loading..." />
          </SelectTrigger>
        </Select>
      </div>
    }>
      <SelectorContent {...props} initialUserId={props.userId} />
    </Suspense>
  )
}
