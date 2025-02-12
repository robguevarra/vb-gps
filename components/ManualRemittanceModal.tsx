"use client"

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { createClient } from '@/utils/supabase/client'
import { Plus, Trash } from 'lucide-react'

interface ManualRemittanceModalProps {
  missionaryId: string
  donors: Array<{ id: string; name: string }>
}

export function ManualRemittanceModal({ missionaryId, donors }: ManualRemittanceModalProps) {
  const supabase = createClient()
  const [totalAmount, setTotalAmount] = useState('')
  const [donorEntries, setDonorEntries] = useState([{ donorId: '', amount: '', isNew: false, newName: '' }])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  const handleAddDonorEntry = () => {
    setDonorEntries([...donorEntries, { donorId: '', amount: '', isNew: false, newName: '' }])
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')

    try {
      // Validate total amount
      const total = parseFloat(totalAmount)
      if (isNaN(total) || total <= 0) {
        throw new Error('Please enter a valid total amount')
      }

      // Validate donor entries
      const entries = await Promise.all(donorEntries.map(async (entry) => {
        const amount = parseFloat(entry.amount)
        if (isNaN(amount) || amount <= 0) {
          throw new Error('All donation amounts must be valid numbers')
        }

        let donorId = entry.donorId
        if (entry.isNew) {
          // Create new donor
          const { data: newDonor, error: donorError } = await supabase
            .from('donors')
            .insert({ name: entry.newName })
            .select()
            .single()

          if (donorError) throw donorError
          donorId = newDonor.id
        }

        return { donor_id: donorId, amount }
      }))

      // Check sum of entries matches total
      const sum = entries.reduce((acc, curr) => acc + curr.amount, 0)
      if (Math.abs(sum - total) > 0.01) {
        throw new Error('Sum of individual donations must match total amount')
      }

      // Create donor donations
      const { error: donationError } = await supabase
        .from('donor_donations')
        .insert(entries.map(entry => ({
          donor_id: entry.donor_id,
          missionary_id: missionaryId,
          amount: entry.amount,
          date: new Date().toISOString(),
          source: 'offline',
          status: 'completed'
        })))

      if (donationError) throw donationError

      // Reset form on success
      setTotalAmount('')
      setDonorEntries([{ donorId: '', amount: '', isNew: false, newName: '' }])
      alert('Remittance submitted successfully!')

    } catch (err) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-semibold">Manual Remittance</h2>
      
      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="space-y-2">
          <Label>Total Amount</Label>
          <Input
            type="number"
            value={totalAmount}
            onChange={(e) => setTotalAmount(e.target.value)}
            placeholder="Enter total amount"
            required
          />
        </div>

        <div className="space-y-4">
          {donorEntries.map((entry, index) => (
            <div key={index} className="flex gap-4 items-end">
              <div className="flex-1 space-y-2">
                <Label>Donor {index + 1}</Label>
                {entry.isNew ? (
                  <Input
                    value={entry.newName}
                    onChange={(e) => {
                      const newEntries = [...donorEntries]
                      newEntries[index].newName = e.target.value
                      setDonorEntries(newEntries)
                    }}
                    placeholder="New donor name"
                    required
                  />
                ) : (
                  <select
                    value={entry.donorId}
                    onChange={(e) => {
                      const newEntries = [...donorEntries]
                      newEntries[index].donorId = e.target.value
                      setDonorEntries(newEntries)
                    }}
                    className="w-full p-2 rounded border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-800"
                    required
                  >
                    <option value="">Select donor</option>
                    {donors.map(donor => (
                      <option key={donor.id} value={donor.id}>{donor.name}</option>
                    ))}
                  </select>
                )}
              </div>

              <div className="flex-1 space-y-2">
                <Label>Amount</Label>
                <Input
                  type="number"
                  value={entry.amount}
                  onChange={(e) => {
                    const newEntries = [...donorEntries]
                    newEntries[index].amount = e.target.value
                    setDonorEntries(newEntries)
                  }}
                  placeholder="Amount"
                  required
                />
              </div>

              <div className="flex gap-2">
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => {
                    const newEntries = [...donorEntries]
                    newEntries[index].isNew = !newEntries[index].isNew
                    newEntries[index].donorId = ''
                    newEntries[index].newName = ''
                    setDonorEntries(newEntries)
                  }}
                >
                  {entry.isNew ? 'Existing' : 'New'}
                </Button>

                {index > 0 && (
                  <Button
                    type="button"
                    variant="destructive"
                    size="sm"
                    onClick={() => {
                      const newEntries = donorEntries.filter((_, i) => i !== index)
                      setDonorEntries(newEntries)
                    }}
                  >
                    <Trash className="h-4 w-4" />
                  </Button>
                )}
              </div>
            </div>
          ))}
        </div>

        <div className="flex gap-4">
          <Button
            type="button"
            variant="outline"
            onClick={handleAddDonorEntry}
          >
            <Plus className="mr-2 h-4 w-4" /> Add Donor
          </Button>

          <Button type="submit" disabled={loading}>
            {loading ? 'Submitting...' : 'Submit Remittance'}
          </Button>
        </div>

        {error && <p className="text-red-500 text-sm">{error}</p>}
      </form>
    </div>
  )
} 