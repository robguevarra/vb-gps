// components/ApprovalCard.tsx
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

interface ApprovalCardProps {
  requestId: number | string;
  requestType: 'leave' | 'surplus';
  currentStatus: string;
  filedBy: string;
  details: string;
}

export function ApprovalCard({
  requestId,
  requestType,
  currentStatus,
  filedBy,
  details,
}: ApprovalCardProps) {
  const supabase = createClient();
  const router = useRouter();
  const [modalOpen, setModalOpen] = useState(false);
  const [selectedAction, setSelectedAction] = useState<'approve' | 'reject' | ''>('');
  const [notes, setNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleOpenModal = (action: 'approve' | 'reject') => {
    setSelectedAction(action);
    setModalOpen(true);
  };

  const handleConfirm = async () => {
    if (!selectedAction) {
      setError('Please choose an action.');
      return;
    }
    setLoading(true);
    setError('');

    const updateData: Record<string, any> = {
      campus_director_approval: selectedAction === 'approve' ? 'approved' : 'rejected',
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
      setModalOpen(false);
      router.refresh();
    }
    setLoading(false);
  };

  return (
    <div className="p-4 bg-background rounded-lg border flex justify-between items-center">
      <div>
        <p className="font-medium">
          {requestType === 'leave' ? 'Leave Request' : 'Surplus Request'} by {filedBy}
          <span className={`ml-2 text-sm ${
            currentStatus === 'approved'
              ? 'text-green-600'
              : currentStatus === 'rejected'
              ? 'text-red-600'
              : 'text-yellow-600'
          }`}>
            ({currentStatus})
          </span>
        </p>
        <p className="text-sm text-muted-foreground">{details}</p>
      </div>
      <div className="flex gap-2">
        <Button variant="outline" size="sm" onClick={() => handleOpenModal('approve')}>
          Approve
        </Button>
        <Button variant="outline" size="sm" onClick={() => handleOpenModal('reject')}>
          Reject
        </Button>
      </div>

      {modalOpen && (
        <Dialog open={modalOpen} onOpenChange={setModalOpen}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>
                {selectedAction === 'approve' ? 'Approve' : 'Reject'} Request
              </DialogTitle>
            </DialogHeader>
            <div className="space-y-4">
              <p><strong>Filed by:</strong> {filedBy}</p>
              <p><strong>Details:</strong> {details}</p>
              <div className="space-y-2">
                <Label>Optional Notes</Label>
                <Textarea
                  value={notes}
                  onChange={(e) => setNotes(e.target.value)}
                  placeholder="Add notes (optional)"
                />
              </div>
              {error && <p className="text-red-500 text-sm">{error}</p>}
              <div className="flex gap-2">
                <Button onClick={handleConfirm} disabled={loading}>
                  {loading ? <Loader2 className="animate-spin" /> : 'Confirm'}
                </Button>
                <Button variant="ghost" onClick={() => setModalOpen(false)}>
                  Cancel
                </Button>
              </div>
            </div>
          </DialogContent>
        </Dialog>
      )}
    </div>
  );
}
