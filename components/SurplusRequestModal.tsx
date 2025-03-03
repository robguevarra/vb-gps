// components/SurplusRequestModal.tsx
'use client'

import { memo, useMemo, useCallback, useState, useEffect } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { createClient } from '@/utils/supabase/client'
import { useRouter } from 'next/navigation'
import { Loader2, Wallet, AlertCircle, ArrowRight } from 'lucide-react'
import { motion, AnimatePresence } from 'framer-motion'
import { cn } from '@/lib/utils'

interface SurplusRequestModalProps {
  surplusBalance: number
  missionaryId?: string
}

/**
 * Skeleton component for loading state
 */
function SurplusRequestModalSkeleton() {
  return (
    <div className="p-6 space-y-4 animate-pulse">
      <div className="space-y-3">
        <div className="h-4 w-32 bg-gray-200 rounded" />
        <div className="space-y-2">
          <div className="h-10 bg-gray-200 rounded" />
          <div className="h-20 bg-gray-200 rounded" />
        </div>
      </div>
      <div className="space-y-3">
        <div className="h-4 w-24 bg-gray-200 rounded" />
        <div className="h-32 bg-gray-200 rounded" />
      </div>
    </div>
  )
}

/**
 * Error component for displaying validation errors
 */
const ErrorMessage = memo(function ErrorMessage({ message }: { message: string }) {
  return (
    <div className="mt-4 p-3 bg-red-50 border border-red-200 rounded-md flex items-start gap-2">
      <AlertCircle className="h-4 w-4 text-red-500 mt-0.5 flex-shrink-0" />
      <p className="text-sm text-red-600">{message}</p>
    </div>
  )
})

/**
 * Amount input component with balance display
 */
const AmountInput = memo(function AmountInput({ 
  amount, 
  surplusBalance, 
  onChange 
}: { 
  amount: string;
  surplusBalance: number;
  onChange: (value: string) => void;
}) {
  const numericAmount = parseFloat(amount)
  const remainingBalance = surplusBalance - (isNaN(numericAmount) ? 0 : numericAmount)

  return (
    <div className="space-y-3">
      <Label className="text-sm font-medium">Request Amount</Label>
      <div className="relative">
        <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
          <span className="text-gray-500">₱</span>
        </div>
        <Input
          type="number"
          placeholder="0.00"
          value={amount}
          onChange={(e) => onChange(e.target.value)}
          className="pl-8 border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
          min="1"
          max={surplusBalance}
          step="0.01"
        />
      </div>
      
      <div className="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg border border-gray-200 dark:border-gray-700 mt-4">
        <div className="flex justify-between items-center">
          <span className="text-sm text-gray-600 dark:text-gray-300">Available Balance</span>
          <span className="text-lg font-semibold text-[#00458d] dark:text-[#4d8dce]">
            ₱{surplusBalance.toLocaleString()}
          </span>
        </div>
        
        {amount && !isNaN(numericAmount) && (
          <div className="mt-3 pt-3 border-t border-gray-200 dark:border-gray-700 transition-all duration-300">
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600 dark:text-gray-300">After Request</span>
              <span className="text-md font-medium text-gray-700 dark:text-gray-300">
                ₱{remainingBalance.toLocaleString()}
              </span>
            </div>
          </div>
        )}
      </div>
    </div>
  )
})

/**
 * Reason input component
 */
const ReasonInput = memo(function ReasonInput({ 
  value, 
  onChange,
  amount 
}: { 
  value: string;
  onChange: (value: string) => void;
  amount: string;
}) {
  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <Label className="text-sm font-medium">Request Amount</Label>
        <span className="text-md font-semibold text-[#00458d] dark:text-[#4d8dce]">
          ₱{parseFloat(amount).toLocaleString()}
        </span>
      </div>
      
      <div className="space-y-2">
        <Label className="text-sm font-medium">Reason for Request</Label>
        <Textarea
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder="Please provide details about why you need these funds..."
          className="min-h-[120px] resize-none border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
          required
        />
        <p className="text-xs text-gray-500 mt-1">
          This information will be shared with your approvers.
        </p>
      </div>
    </div>
  )
})

/**
 * Main SurplusRequestModal component with optimized rendering
 */
export function SurplusRequestModal({ surplusBalance, missionaryId }: SurplusRequestModalProps) {
  const supabase = createClient()
  const router = useRouter()
  const [open, setOpen] = useState(false)
  const [amount, setAmount] = useState('')
  const [reason, setReason] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [formStep, setFormStep] = useState(1)

  // Reset form when modal closes
  const handleOpenChange = useCallback((open: boolean) => {
    setOpen(open)
    if (!open) {
      setAmount('')
      setReason('')
      setError('')
      setFormStep(1)
    }
  }, [])

  const handleSubmit = useCallback(async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')

    const numericAmount = parseFloat(amount)
    if (isNaN(numericAmount) || numericAmount <= 0 || numericAmount > surplusBalance) {
      setError('Invalid amount')
      return
    }

    setLoading(true)

    try {
      // Retrieve the current authenticated user's id
      const { data: { user } } = await supabase.auth.getUser()
      
      if (!user) {
        throw new Error('User not authenticated')
      }

      // Use the passed-in missionaryId if provided, otherwise default to the current user
      const requesterId = missionaryId || user.id

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

      if (submitError) throw submitError

      setOpen(false)
      router.refresh()
    } catch (err: any) {
      console.error('Error submitting surplus request:', err)
      setError(err.message || 'Failed to submit request')
    } finally {
      setLoading(false)
    }
  }, [amount, reason, surplusBalance, missionaryId, supabase, router])

  const nextStep = useCallback(() => {
    const numericAmount = parseFloat(amount)
    if (isNaN(numericAmount) || numericAmount <= 0) {
      setError('Please enter a valid amount greater than 0')
      return
    }
    
    if (numericAmount > surplusBalance) {
      setError(`Amount cannot exceed your available surplus balance of ₱${surplusBalance.toLocaleString()}`)
      return
    }
    
    setError('')
    setFormStep(2)
  }, [amount, surplusBalance])

  const prevStep = useCallback(() => {
    setError('')
    setFormStep(1)
  }, [])

  const formVariants = {
    hidden: { opacity: 0, x: 20 },
    visible: { opacity: 1, x: 0, transition: { duration: 0.3 } },
    exit: { opacity: 0, x: -20, transition: { duration: 0.2 } }
  }

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <Button variant="outline" className="w-full sm:w-auto flex items-center gap-2">
          <Wallet className="h-4 w-4" />
          <span>Request Surplus</span>
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px] p-0 overflow-hidden">
        <DialogHeader className="p-6 pb-2 bg-gray-50 dark:bg-gray-900">
          <DialogTitle className="text-xl font-semibold text-gray-900 dark:text-gray-100">
            New Surplus Request
          </DialogTitle>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
            {formStep === 1 ? "Enter the amount you'd like to request" : "Provide reason for your request"}
          </p>
        </DialogHeader>
        
        <form onSubmit={handleSubmit} className="p-6 pt-4">
          <div className="space-y-4">
            {formStep === 1 ? (
              <div className="space-y-4 transition-opacity duration-300">
                <AmountInput 
                  amount={amount} 
                  surplusBalance={surplusBalance} 
                  onChange={setAmount} 
                />
              </div>
            ) : (
              <div className="space-y-4 transition-opacity duration-300">
                <ReasonInput 
                  value={reason} 
                  onChange={setReason} 
                  amount={amount}
                />
              </div>
            )}
          </div>

          {error && <ErrorMessage message={error} />}

          <div className="mt-6 flex justify-between">
            {formStep === 2 && (
              <Button
                type="button"
                variant="outline"
                onClick={prevStep}
                disabled={loading}
              >
                Back
              </Button>
            )}
            <div className="flex-1" />
            {formStep === 1 ? (
              <Button
                type="button"
                onClick={nextStep}
                disabled={loading}
                className="flex items-center gap-1"
              >
                Continue
                <ArrowRight className="h-4 w-4 ml-1" />
              </Button>
            ) : (
              <Button
                type="submit"
                disabled={loading}
                className="min-w-[100px]"
              >
                {loading ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Submitting...
                  </>
                ) : (
                  'Submit'
                )}
              </Button>
            )}
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
