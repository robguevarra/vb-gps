// components/LeaveRequestModal.tsx
'use client';

import { useState } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Loader2 } from 'lucide-react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

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
                value={dates.from ? dates.from.toISOString().split('T')[0] : ''}
                onChange={(e) => setDates(prev => ({ ...prev, from: new Date(e.target.value) }))}
                min={new Date().toISOString().split('T')[0]}
                required
              />
            </div>
            <div className="space-y-2 flex-1">
              <Label>End Date</Label>
              <Input
                type="date"
                value={dates.to ? dates.to.toISOString().split('T')[0] : ''}
                onChange={(e) => setDates(prev => ({ ...prev, to: new Date(e.target.value) }))}
                min={dates.from ? dates.from.toISOString().split('T')[0] : new Date().toISOString().split('T')[0]}
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
  );
}
