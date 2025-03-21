'use client'

import { useState } from 'react'
import { createClient } from '@/utils/supabase/client'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'

export function RequestSurplusForm({ surplusBalance }: { surplusBalance: number }) {
  const supabase = createClient()
  const router = useRouter()

  const [amount, setAmount] = useState('')
  const [reason, setReason] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')

    if (!amount || isNaN(parseFloat(amount))) {
      setError('Please enter a valid amount')
      return
    }

    setLoading(true)

    try {
      // First, get the current user
      const { data: { user } } = await supabase.auth.getUser()
      
      if (!user) {
        throw new Error('User not authenticated')
      }
      
      // Get the user's role from profiles
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single()
        
      if (profileError) throw profileError
      
      const isCampusDirector = profileData.role === 'campus_director'
      
      // Create the surplus request with auto-approval for campus directors
      const { error: submitError } = await supabase.from('surplus_requests').insert({
        missionary_id: user.id,
        amount_requested: parseFloat(amount),
        reason,
        status: 'pending',
        campus_director_approval: isCampusDirector ? 'approved' : 'none',
        lead_pastor_approval: 'none'
      })

      if (submitError) {
        throw submitError
      }
      
      router.refresh()
      setAmount('')
      setReason('')
    } catch (err: any) {
      console.error('Error submitting surplus request:', err)
      setError(err.message || 'Failed to submit request')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4 mt-4">
      <div className="space-y-2">
        <Label htmlFor="amount">Amount</Label>
        <Input
          id="amount"
          type="number"
          min="0"
          max={surplusBalance}
          value={amount}
          onChange={(e) => setAmount(e.target.value)}
          required
        />
        <p className="text-sm text-muted-foreground">
          Available surplus: ₱{surplusBalance.toLocaleString()}
        </p>
      </div>
      
      <div className="space-y-2">
        <Label htmlFor="reason">Reason</Label>
        <Textarea
          id="reason"
          value={reason}
          onChange={(e) => setReason(e.target.value)}
          required
        />
      </div>

      {error && <p className="text-red-500">{error}</p>}

      <Button type="submit" disabled={loading} className="w-full">
        {loading ? 'Submitting...' : 'Request Surplus'}
      </Button>
    </form>
  )
}
