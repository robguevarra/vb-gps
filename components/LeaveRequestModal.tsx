// components/LeaveRequestModal.tsx
'use client';

import { memo, useMemo, useCallback, useState } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Loader2, Calendar, AlertCircle } from 'lucide-react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';
import { cn } from '@/lib/utils';

interface LeaveRequestModalProps {
  missionaryId?: string;
  validateMissionary?: boolean;
}

/**
 * Skeleton component for loading state
 */
function LeaveRequestModalSkeleton() {
  return (
    <div className="p-6 space-y-4 animate-pulse">
      <div className="space-y-3">
        <div className="h-4 w-24 bg-gray-200 rounded" />
        <div className="grid grid-cols-2 gap-3">
          {[...Array(2)].map((_, i) => (
            <div key={i} className="h-20 bg-gray-200 rounded" />
          ))}
        </div>
      </div>
      <div className="space-y-3">
        <div className="h-4 w-32 bg-gray-200 rounded" />
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          {[...Array(2)].map((_, i) => (
            <div key={i} className="space-y-2">
              <div className="h-3 w-16 bg-gray-200 rounded" />
              <div className="h-10 bg-gray-200 rounded" />
            </div>
          ))}
        </div>
      </div>
    </div>
  );
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
  );
});

/**
 * Leave type selection component
 */
const LeaveTypeSelector = memo(function LeaveTypeSelector({ 
  type, 
  onSelect 
}: { 
  type: 'sick' | 'vacation';
  onSelect: (type: 'sick' | 'vacation') => void;
}) {
  return (
    <div className="space-y-3">
      <Label className="text-sm font-medium">Leave Type</Label>
      <div className="grid grid-cols-2 gap-3">
        <Button 
          type="button"
          variant={type === 'sick' ? 'default' : 'outline'}
          className={cn(
            "h-auto py-3 justify-start transition-colors",
            type === 'sick' && "bg-[#00458d] hover:bg-[#003a79]"
          )}
          onClick={() => onSelect('sick')}
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
            "h-auto py-3 justify-start transition-colors",
            type === 'vacation' && "bg-[#00458d] hover:bg-[#003a79]"
          )}
          onClick={() => onSelect('vacation')}
        >
          <div className="flex flex-col items-start">
            <span>Vacation</span>
            <span className="text-xs opacity-70 mt-1">Time off work</span>
          </div>
        </Button>
      </div>
    </div>
  );
});

/**
 * Date range selection component
 */
const DateRangeSelector = memo(function DateRangeSelector({ 
  dates, 
  onDateChange 
}: { 
  dates: { from?: Date; to?: Date };
  onDateChange: (dates: { from?: Date; to?: Date }) => void;
}) {
  const handleFromChange = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    onDateChange({ ...dates, from: new Date(e.target.value) });
  }, [dates, onDateChange]);

  const handleToChange = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    onDateChange({ ...dates, to: new Date(e.target.value) });
  }, [dates, onDateChange]);

  return (
    <div className="space-y-3 mt-6">
      <Label className="text-sm font-medium">Date Range</Label>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <div className="space-y-2">
          <Label className="text-xs text-gray-500">Start Date</Label>
          <Input
            type="date"
            value={dates.from ? dates.from.toISOString().split('T')[0] : ''}
            onChange={handleFromChange}
            min={new Date().toISOString().split('T')[0]}
            className="border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
          />
        </div>
        <div className="space-y-2">
          <Label className="text-xs text-gray-500">End Date</Label>
          <Input
            type="date"
            value={dates.to ? dates.to.toISOString().split('T')[0] : ''}
            onChange={handleToChange}
            min={dates.from ? dates.from.toISOString().split('T')[0] : new Date().toISOString().split('T')[0]}
            className="border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
          />
        </div>
      </div>
    </div>
  );
});

/**
 * Reason input component
 */
const ReasonInput = memo(function ReasonInput({ 
  value, 
  onChange 
}: { 
  value: string;
  onChange: (value: string) => void;
}) {
  return (
    <div className="space-y-2">
      <Label className="text-sm font-medium">Reason for Leave</Label>
      <Textarea
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder="Please provide details about your leave request..."
        className="min-h-[120px] resize-none border-gray-300 focus:border-[#00458d] focus:ring-[#00458d]"
        required
      />
      <p className="text-xs text-gray-500 mt-1">
        This information will be shared with your approvers.
      </p>
    </div>
  );
});

/**
 * Main LeaveRequestModal component with optimized rendering
 */
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
  const handleOpenChange = useCallback((open: boolean) => {
    setOpen(open);
    if (!open) {
      setDates({});
      setReason('');
      setType('sick');
      setError(null);
      setFormStep(1);
    }
  }, []);

  const handleSubmit = useCallback(async (e: React.FormEvent) => {
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
  }, [dates, type, reason, missionaryId, supabase, router]);

  const nextStep = useCallback(() => {
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
  }, [formStep, dates]);

  const prevStep = useCallback(() => {
    setError(null);
    setFormStep(1);
  }, []);

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
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
          <div className="space-y-4">
            {formStep === 1 ? (
              <div className="space-y-4 transition-opacity duration-300">
                <LeaveTypeSelector type={type} onSelect={setType} />
                <DateRangeSelector dates={dates} onDateChange={setDates} />
              </div>
            ) : (
              <div className="space-y-4 transition-opacity duration-300">
                <ReasonInput value={reason} onChange={setReason} />
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
              >
                Next
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
  );
}
