// components/ApprovalActionModal.tsx
'use client';

import { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Loader2 } from 'lucide-react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';

interface ApprovalActionModalProps {
  requestId: number | string;
  requestType: 'leave' | 'surplus';
  currentStatus: string;
  filedBy: string;
  details: string; // e.g. "Dates: ... Reason: ..." or "Requested Amount: ... Reason: ..."
  onActionComplete: () => void;
}

export function ApprovalActionModal({
  requestId,
  requestType,
  currentStatus,
  filedBy,
  details,
  onActionComplete,
}: ApprovalActionModalProps) {
  const supabase = createClient();
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const [action, setAction] = useState<'approve' | 'reject' | ''>('');
  const [notes, setNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleConfirm = async () => {
    if (!action) {
      setError('Please choose an action.');
      return;
    }
    setLoading(true);
    setError('');

    const updateData: Record<string, any> = {
      campus_director_approval: action === 'approve' ? 'approved' : 'rejected',
    };
    if (notes) {
      updateData.campus_director_notes = notes;
    }

    const tableName = requestType === 'leave' ? 'leave_requests' : 'surplus_requests';

    const { error: updateError } = await supabase
      .from(tableName)
      .update(updateData)
      .eq('id', requestId);

    if (updateError) {
      setError(updateError.message);
    } else {
      onActionComplete();
      setOpen(false);
    }
    setLoading(false);
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="ghost" size="sm">View Details</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Approve/Reject Request</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <p><strong>Filed by:</strong> {filedBy}</p>
          <p><strong>Details:</strong> {details}</p>
          <div className="flex gap-4">
            <Button
              variant={action === 'approve' ? "default" : "outline"}
              onClick={() => setAction('approve')}
            >
              Approve
            </Button>
            <Button
              variant={action === 'reject' ? "default" : "outline"}
              onClick={() => setAction('reject')}
            >
              Reject
            </Button>
          </div>
          <div className="space-y-2">
            <Label>Optional Notes</Label>
            <Textarea
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
              placeholder="Add notes (optional)"
            />
          </div>
          {error && <p className="text-red-500 text-sm">{error}</p>}
          <Button onClick={handleConfirm} disabled={loading}>
            {loading ? <Loader2 className="animate-spin" /> : 'Confirm'}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
