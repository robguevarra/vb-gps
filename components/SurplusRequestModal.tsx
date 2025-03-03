// components/SurplusRequestModal.tsx
'use client'

import { useState, useEffect } from 'react'
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
  useEffect(() => {
    if (!open) {
      setAmount('')
      setReason('')
      setError('')
      setFormStep(1)
    }
  }, [open])

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

  const nextStep = () => {
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
  }

  const prevStep = () => {
    setError('')
    setFormStep(1)
  }

  const formVariants = {
    hidden: { opacity: 0, x: 20 },
    visible: { opacity: 1, x: 0, transition: { duration: 0.3 } },
    exit: { opacity: 0, x: -20, transition: { duration: 0.2 } }
  }

  return (
    <Dialog open={open} onOpenChange={setOpen}>
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
          <AnimatePresence mode="wait">
            {formStep === 1 ? (
              <motion.div 
                key="step1"
                variants={formVariants}
                initial="hidden"
                animate="visible"
                exit="exit"
                className="space-y-4"
              >
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
                      onChange={(e) => setAmount(e.target.value)}
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
                    
                    {amount && !isNaN(parseFloat(amount)) && (
                      <motion.div 
                        initial={{ opacity: 0, height: 0 }}
                        animate={{ opacity: 1, height: 'auto' }}
                        className="mt-3 pt-3 border-t border-gray-200 dark:border-gray-700"
                      >
                        <div className="flex justify-between items-center">
                          <span className="text-sm text-gray-600 dark:text-gray-300">After Request</span>
                          <span className="text-md font-medium text-gray-700 dark:text-gray-300">
                            ₱{(surplusBalance - parseFloat(amount)).toLocaleString()}
                          </span>
                        </div>
                      </motion.div>
                    )}
                  </div>
                </div>
              </motion.div>
            ) : (
              <motion.div 
                key="step2"
                variants={formVariants}
                initial="hidden"
                animate="visible"
                exit="exit"
                className="space-y-4"
              >
                <div className="space-y-2">
                  <div className="flex justify-between items-center">
                    <Label className="text-sm font-medium">Request Amount</Label>
                    <span className="text-md font-semibold text-[#00458d] dark:text-[#4d8dce]">
                      ₱{parseFloat(amount).toLocaleString()}
                    </span>
                  </div>
                  
                  <Label className="text-sm font-medium mt-4 block">Reason for Request</Label>
                  <Textarea
                    value={reason}
                    onChange={(e) => setReason(e.target.value)}
                    placeholder="Please provide details about why you need these funds..."
                    className="min-h-[120px] resize-none border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
                    required
                  />
                  <p className="text-xs text-gray-500 mt-1">
                    This information will be shared with your approvers.
                  </p>
                </div>
              </motion.div>
            )}
          </AnimatePresence>

          {error && (
            <motion.div 
              initial={{ opacity: 0, y: 10 }} 
              animate={{ opacity: 1, y: 0 }}
              className="mt-4 p-3 bg-red-50 border border-red-200 rounded-md flex items-start gap-2"
            >
              <AlertCircle className="h-4 w-4 text-red-500 mt-0.5 flex-shrink-0" />
              <p className="text-red-600 text-sm">{error}</p>
            </motion.div>
          )}

          <DialogFooter className="flex flex-col sm:flex-row gap-2 mt-6 pt-4 border-t">
            {formStep === 1 ? (
              <Button 
                type="button" 
                onClick={nextStep}
                className="w-full sm:w-auto bg-[#00458d] hover:bg-[#003a79] flex items-center gap-1"
              >
                Continue
                <ArrowRight className="h-4 w-4 ml-1" />
              </Button>
            ) : (
              <div className="flex flex-col sm:flex-row w-full gap-2">
                <Button 
                  type="button" 
                  variant="outline" 
                  onClick={prevStep}
                  className="w-full sm:w-auto order-2 sm:order-1"
                >
                  Back
                </Button>
                <Button 
                  type="submit" 
                  disabled={loading}
                  className="w-full sm:w-auto bg-[#00458d] hover:bg-[#003a79] order-1 sm:order-2"
                >
                  {loading ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
                  Submit Request
                </Button>
              </div>
            )}
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
