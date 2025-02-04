'use client'

import { useState } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { DateRange } from 'react-day-picker'
import { Loader2 } from 'lucide-react'
import { createClient } from '@/utils/supabase/client'
import { useRouter } from 'next/navigation'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'

export function LeaveRequestModal() {
  const supabase = createClient()
  const router = useRouter()
  const [open, setOpen] = useState(false)
  const [dates, setDates] = useState<DateRange | undefined>(undefined)
  const [reason, setReason] = useState('')
  const [type, setType] = useState<'sick' | 'vacation'>('sick')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!dates?.from || !dates?.to) {
      setError('Please select valid dates')
      return
    }

    if (dates.to < dates.from) {
      setError('End date cannot be before start date')
      return
    }

    setLoading(true)
    setError(null)

    const { data: user } = await supabase.auth.getUser()

    const { error: submitError } = await supabase.from('leave_requests').insert({
      type,
      start_date: dates.from,
      end_date: dates.to,
      reason,
      status: 'pending',
      requester_id: user.user?.id
    })

    if (submitError) {
      setError(submitError.message)
    } else {
      router.refresh()
      setOpen(false)
      setTimeout(() => router.refresh(), 500)
    }
    setLoading(false)
  }

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="outline">Request Leave</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>New Leave Request</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label>Leave Type</Label>
            <Select value={type} onValueChange={(v: 'sick' | 'vacation') => setType(v)}>
              <SelectTrigger>
                <SelectValue placeholder="Select leave type" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="sick">Sick Leave</SelectItem>
                <SelectItem value="vacation">Vacation Leave</SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div className="flex gap-4">
            <div className="space-y-2 flex-1">
              <Label>Start Date</Label>
              <Input
                type="date"
                value={dates?.from?.toISOString().split('T')[0] || ''}
                onChange={(e) => setDates(prev => ({
                  from: new Date(e.target.value),
                  to: prev?.to
                }))}
                min={new Date().toISOString().split('T')[0]}
                required
              />
            </div>
            
            <div className="space-y-2 flex-1">
              <Label>End Date</Label>
              <Input
                type="date"
                value={dates?.to?.toISOString().split('T')[0] || ''}
                onChange={(e) => setDates(prev => ({
                  from: prev?.from,
                  to: new Date(e.target.value)
                }))}
                min={dates?.from?.toISOString().split('T')[0] || new Date().toISOString().split('T')[0]}
                required
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label>Reason</Label>
            <Textarea
              value={reason}
              onChange={(e) => setReason(e.target.value)}
              required
            />
          </div>

          {error && <p className="text-red-500 text-sm">{error}</p>}

          <Button type="submit" disabled={loading}>
            {loading ? <Loader2 className="animate-spin" /> : 'Submit Request'}
          </Button>
        </form>
      </DialogContent>
    </Dialog>
  )
} 