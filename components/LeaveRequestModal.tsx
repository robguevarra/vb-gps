// components/LeaveRequestModal.tsx
'use client';

import { useState, useEffect } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Loader2, Calendar, AlertCircle } from 'lucide-react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { motion, AnimatePresence } from 'framer-motion';
import { cn } from '@/lib/utils';

interface LeaveRequestModalProps {
  missionaryId?: string;
  validateMissionary?: boolean;
}

export function LeaveRequestModal({ missionaryId, validateMissionary }: LeaveRequestModalProps) {
  const supabase = createClient();
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const [dates, setDates] = useState<{ from?: Date; to?: Date }>({});
  const [reason, setReason] = useState('');
  const [type, setType] = useState<'sick' | 'vacation'>('sick');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [formStep, setFormStep] = useState(1);

  // Reset form when modal closes
  useEffect(() => {
    if (!open) {
      setDates({});
      setReason('');
      setType('sick');
      setError(null);
      setFormStep(1);
    }
  }, [open]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    
    if (!dates.from || !dates.to) {
      setError('Please select both start and end dates');
      return;
    }
    
    if (dates.to < dates.from) {
      setError('End date cannot be before start date');
      return;
    }
    
    setLoading(true);
    
    try {
      // First, get the user's role to check if they're a campus director
      const { data: { user } } = await supabase.auth.getUser();
      
      if (!user) {
        throw new Error('User not authenticated');
      }
      
      // Get the user's role from profiles
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('role')
        .eq('id', missionaryId || user.id)
        .single();
        
      if (profileError) throw profileError;
      
      const isCampusDirector = profileData.role === 'campus_director';
      
      // Create the leave request with auto-approval for campus directors
      const { error: insertError } = await supabase.from('leave_requests').insert({
        requester_id: missionaryId || user.id,
        type,
        start_date: dates.from.toISOString(),
        end_date: dates.to.toISOString(),
        reason,
        status: 'pending',
        campus_director_approval: isCampusDirector ? 'approved' : 'none',
        lead_pastor_approval: 'none'
      });
      
      if (insertError) throw insertError;
      
      setOpen(false);
      router.refresh();
    } catch (err: any) {
      console.error('Error submitting leave request:', err);
      setError(err.message || 'Failed to submit request');
    } finally {
      setLoading(false);
    }
  };

  const nextStep = () => {
    if (formStep === 1 && (!dates.from || !dates.to)) {
      setError('Please select both start and end dates');
      return;
    }
    
    if (dates.to && dates.from && dates.to < dates.from) {
      setError('End date cannot be before start date');
      return;
    }
    
    setError(null);
    setFormStep(2);
  };

  const prevStep = () => {
    setError(null);
    setFormStep(1);
  };

  const formVariants = {
    hidden: { opacity: 0, x: 20 },
    visible: { opacity: 1, x: 0, transition: { duration: 0.3 } },
    exit: { opacity: 0, x: -20, transition: { duration: 0.2 } }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="outline" className="w-full sm:w-auto flex items-center gap-2">
          <Calendar className="h-4 w-4" />
          <span>Request Leave</span>
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px] p-0 overflow-hidden">
        <DialogHeader className="p-6 pb-2 bg-gray-50 dark:bg-gray-900">
          <DialogTitle className="text-xl font-semibold text-gray-900 dark:text-gray-100">
            New Leave Request
          </DialogTitle>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
            {formStep === 1 ? "Select your leave dates" : "Provide reason for your leave"}
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
                  <Label className="text-sm font-medium">Leave Type</Label>
                  <div className="grid grid-cols-2 gap-3">
                    <Button 
                      type="button"
                      variant={type === 'sick' ? 'default' : 'outline'}
                      className={cn(
                        "h-auto py-3 justify-start",
                        type === 'sick' && "bg-[#00458d] hover:bg-[#003a79]"
                      )}
                      onClick={() => setType('sick')}
                    >
                      <div className="flex flex-col items-start">
                        <span>Sick Leave</span>
                        <span className="text-xs opacity-70 mt-1">For health reasons</span>
                      </div>
                    </Button>
                    <Button 
                      type="button"
                      variant={type === 'vacation' ? 'default' : 'outline'}
                      className={cn(
                        "h-auto py-3 justify-start",
                        type === 'vacation' && "bg-[#00458d] hover:bg-[#003a79]"
                      )}
                      onClick={() => setType('vacation')}
                    >
                      <div className="flex flex-col items-start">
                        <span>Vacation</span>
                        <span className="text-xs opacity-70 mt-1">Time off work</span>
                      </div>
                    </Button>
                  </div>
                </div>

                <div className="space-y-3 mt-6">
                  <Label className="text-sm font-medium">Date Range</Label>
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <div className="space-y-2">
                      <Label className="text-xs text-gray-500">Start Date</Label>
                      <Input
                        type="date"
                        value={dates.from ? dates.from.toISOString().split('T')[0] : ''}
                        onChange={(e) => setDates(prev => ({ ...prev, from: new Date(e.target.value) }))}
                        min={new Date().toISOString().split('T')[0]}
                        className="border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
                      />
                    </div>
                    <div className="space-y-2">
                      <Label className="text-xs text-gray-500">End Date</Label>
                      <Input
                        type="date"
                        value={dates.to ? dates.to.toISOString().split('T')[0] : ''}
                        onChange={(e) => setDates(prev => ({ ...prev, to: new Date(e.target.value) }))}
                        min={dates.from ? dates.from.toISOString().split('T')[0] : new Date().toISOString().split('T')[0]}
                        className="border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
                      />
                    </div>
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
                  <Label className="text-sm font-medium">Reason for Leave</Label>
                  <Textarea
                    value={reason}
                    onChange={(e) => setReason(e.target.value)}
                    placeholder="Please provide details about your leave request..."
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
                className="w-full sm:w-auto bg-[#00458d] hover:bg-[#003a79]"
              >
                Continue
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
  );
}
