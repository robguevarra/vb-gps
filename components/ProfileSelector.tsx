'use client'

import { useRouter } from 'next/navigation'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'

export default function ProfileSelector({ missionaries, userId }: { missionaries: any[], userId?: string }) {
  const router = useRouter()

  return (
    <Select
      value={userId || 'clear'}
      onValueChange={(value) => {
        if (value === 'clear') {
          router.push('/dashboard/missionary')
        } else {
          router.push(`/dashboard/missionary?userId=${value}`)
        }
      }}
    >
      <SelectTrigger className="w-[300px]">
        <SelectValue placeholder="Select missionary" />
      </SelectTrigger>
      <SelectContent>
        <SelectItem value="clear">View as myself</SelectItem>
        {missionaries?.map((missionary) => (
          <SelectItem key={missionary.id} value={missionary.id}>
            {missionary.full_name} ({missionary.role.replace(/_/g, ' ')})
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
  )
} 