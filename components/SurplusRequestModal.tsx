// components/SurplusRequestModal.tsx
'use client'

import { useState } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { createClient } from '@/utils/supabase/client'
import { useRouter } from 'next/navigation'
import { Loader2 } from 'lucide-react'

interface SurplusRequestModalProps {
  surplusBalance: number
  missionaryId?: string
}

export function SurplusRequestModal({ surplusBalance, missionaryId }: SurplusRequestModalProps) {
  const supabase = createClient()
  const router = useRouter()
  const [open, setOpen] = useState(false)
  const [amount, setAmount] = useState('')
  const [reason, setReason] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')

    const numericAmount = parseFloat(amount)
    if (isNaN(numericAmount) || numericAmount <= 0 || numericAmount > surplusBalance) {
      setError('Invalid amount')
      return
    }

    setLoading(true)

    // Retrieve the current authenticated user's id
    const { data: authData } = await supabase.auth.getUser()
    const currentUserId = authData.user?.id

    // Use the passed-in missionaryId if provided, otherwise default to the current user
    const requesterId = missionaryId || currentUserId

    // Insert with valid statuses
    const { error: submitError } = await supabase.from('surplus_requests').insert({
      amount_requested: numericAmount,
      reason,
      status: 'pending',
      missionary_id: requesterId,
      // valid campus director
      campus_director_approval: 'none',
      // valid lead pastor
      lead_pastor_approval: 'none'
    })

    if (submitError) {
      setError(submitError.message)
    } else {
      router.refresh()
      setOpen(false)
      setAmount('')
      setReason('')
    }
    setLoading(false)
  }

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="outline">Request Surplus</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>New Surplus Request</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label>Amount</Label>
            <Input
              placeholder="0.00"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              prefix="₱"
              min="1"
              max={surplusBalance}
              required
            />
            <p className="text-sm text-muted-foreground">
              Available surplus: ₱{surplusBalance.toLocaleString()}
            </p>
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
