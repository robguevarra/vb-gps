'use client'

import { useState } from 'react'
import { createClient } from '@/utils/supabase/client'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'
import { Calendar } from '@/components/ui/calendar'
import { Textarea } from '@/components/ui/textarea'
import { DateRange } from 'react-day-picker'
import { Loader2 } from 'lucide-react'

export function LeaveRequestForm() {
  const supabase = createClient()
  const router = useRouter()
  const [dates, setDates] = useState<DateRange | undefined>(undefined)
  const [reason, setReason] = useState('')
  const [loading, setLoading] = useState(false)
  const [errorMessage, setErrorMessage] = useState<string | null>(null)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!dates?.from || !dates?.to) {
      setErrorMessage('Please select a valid date range.')
      return
    }

    setLoading(true)
    setErrorMessage(null)

    const { error } = await supabase.from('leave_requests').insert({
      start_date: dates.from.toISOString(),
      end_date: dates.to.toISOString(),
      reason,
      status: 'pending',
      campus_director_approval: 'none',
      lead_pastor_approval: 'none',
    })

    if (error) {
      setErrorMessage(error.message)
    } else {
      router.refresh()
      setDates(undefined)
      setReason('')
    }
    setLoading(false)
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4 mt-4">
      <div className="space-y-2">
        <Label>Leave Dates</Label>
        <Calendar
          mode="range"
          selected={dates}
          onSelect={(range) => setDates(range || undefined)}
          className="rounded-md border"
          disabled={{ before: new Date() }}
        />
      </div>

      <div className="space-y-2">
        <Label htmlFor="reason">Reason for Leave</Label>
        <Textarea
          id="reason"
          value={reason}
          onChange={(e) => setReason(e.target.value)}
          required
        />
      </div>

      {errorMessage && <div className="text-red-500">{errorMessage}</div>}

      <Button
        type="submit"
        disabled={loading || !dates?.from || !dates?.to}
        className="w-full"
      >
        {loading ? (
          <div className="flex items-center gap-2">
            <Loader2 className="h-4 w-4 animate-spin" />
            Submitting...
          </div>
        ) : (
          'Request Leave'
        )}
      </Button>
    </form>
  )
}
