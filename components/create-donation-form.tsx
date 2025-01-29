'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/utils/supabase/client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { format } from 'date-fns'

export function CreateDonationForm({ 
  missionaries,
  localChurchId
}: { 
  missionaries: Array<{ id: string, full_name: string }>
  localChurchId: string 
}) {
  const supabase = createClient()
  const router = useRouter()
  const [donation, setDonation] = useState({
    missionary_id: '',
    donor_name: '',
    amount: '',
    date: format(new Date(), 'yyyy-MM-dd')
  })
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')

    const { error: dbError } = await supabase.from('donations').insert({
      missionary_id: donation.missionary_id,
      donor_name: donation.donor_name || null,
      amount: parseFloat(donation.amount),
      date: new Date(donation.date).toISOString(),
      source: 'offline',
      status: 'completed',
      local_church_id: localChurchId,
      created_by: (await supabase.auth.getUser()).data.user?.id
    })

    if (dbError) {
      setError(dbError.message)
    } else {
      router.refresh()
      setDonation({
        missionary_id: '',
        donor_name: '',
        amount: '',
        date: format(new Date(), 'yyyy-MM-dd')
      })
    }
    setLoading(false)
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div className="space-y-2">
        <Label>Missionary</Label>
        <Select
          value={donation.missionary_id}
          onValueChange={(value) => setDonation({ ...donation, missionary_id: value })}
          required
        >
          <SelectTrigger>
            <SelectValue placeholder="Select missionary" />
          </SelectTrigger>
          <SelectContent>
            {missionaries.map((missionary) => (
              <SelectItem key={missionary.id} value={missionary.id}>
                {missionary.full_name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      <div className="space-y-2">
        <Label htmlFor="amount">Amount</Label>
        <Input
          id="amount"
          type="number"
          value={donation.amount}
          onChange={(e) => setDonation({ ...donation, amount: e.target.value })}
          required
        />
      </div>

      <div className="space-y-2">
        <Label htmlFor="date">Donation Date</Label>
        <Input
          id="date"
          type="date"
          value={donation.date}
          onChange={(e) => setDonation({ ...donation, date: e.target.value })}
          required
        />
      </div>

      <div className="space-y-2">
        <Label htmlFor="donor">Donor Name (Optional)</Label>
        <Input
          id="donor"
          value={donation.donor_name}
          onChange={(e) => setDonation({ ...donation, donor_name: e.target.value })}
        />
      </div>

      {error && <p className="text-sm text-destructive">{error}</p>}
      <Button type="submit" className="w-full" disabled={loading}>
        {loading ? 'Saving...' : 'Record Donation'}
      </Button>
    </form>
  )
} 