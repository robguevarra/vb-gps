// components/LeadPastorApprovalCard.tsx

'use client'

import { useState } from 'react'
import { createClient } from '@/utils/supabase/client'
import { useRouter } from 'next/navigation'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Loader2 } from 'lucide-react'

interface LeaveRequestData {
  id: string
  type: 'Vacation Leave' | 'Sick Leave'
  startDate: string
  endDate: string
  reason: string
  status: string
  date: string
  campusDirectorApproval: string
  campusDirectorNotes?: string
  leadPastorApproval: string
  leadPastorNotes?: string
  requester?: { full_name: string }
}

interface SurplusRequestData {
  id: string
  type: 'Surplus'
  amount: number
  reason: string
  status: string
  date: string
  campusDirectorApproval: string
  campusDirectorNotes?: string
  leadPastorApproval: string
  leadPastorNotes?: string
  requester?: { full_name: string }
}

type RequestData = LeaveRequestData | SurplusRequestData

interface LeadPastorApprovalCardProps {
  request: RequestData
  requestType: 'leave' | 'surplus'
}

type LeadPastorAction =
  | 'approved'
  | 'rejected'
  | 'override-approved'
  | 'override-rejected'

export function LeadPastorApprovalCard({
  request,
  requestType,
}: LeadPastorApprovalCardProps) {
  const supabase = createClient()
  const router = useRouter()

  const [modalOpen, setModalOpen] = useState(false)
  const [selectedAction, setSelectedAction] = useState<LeadPastorAction | ''>('')
  const [notes, setNotes] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  // We do 2 normal buttons: Approve, Reject
  // 1 Override button that triggers a sub-choice for override-approved or override-rejected
  const handleOpenModal = (action: LeadPastorAction) => {
    setSelectedAction(action)
    setNotes('')
    setModalOpen(true)
  }

  const handleConfirm = async () => {
    if (!selectedAction) {
      setError('No action chosen.')
      return
    }
    setLoading(true)
    setError('')

    const tableName = requestType === 'leave' ? 'leave_requests' : 'surplus_requests'

    // Build update data
    const updateData: Record<string, any> = {
      lead_pastor_notes: notes,
    }

    // If it's 'approved' or 'rejected' -> standard
    // If it's 'override-approved' or 'override-rejected' -> special
    updateData.lead_pastor_approval = selectedAction

    if (selectedAction === 'approved' || selectedAction === 'override-approved') {
      updateData.status = 'approved'
    } else {
      // 'rejected' or 'override-rejected'
      updateData.status = 'rejected'
    }

    const { error: updateError } = await supabase
      .from(tableName)
      .update(updateData)
      .eq('id', request.id)

    if (updateError) {
      setError(updateError.message)
    } else {
      setModalOpen(false)
      router.refresh()
    }
    setLoading(false)
  }

  // Helper function for details
  const getDetails = () => {
    if (requestType === 'leave') {
      const leaveRequest = request as LeaveRequestData;
      return `Dates: ${leaveRequest.startDate} - ${leaveRequest.endDate}. Reason: ${leaveRequest.reason}`;
    } else {
      const surplusRequest = request as SurplusRequestData;
      return `Requested Amount: ₱${surplusRequest.amount.toLocaleString()}. Reason: ${surplusRequest.reason}`;
    }
  };

  const details = getDetails();

  return (
    <div className="p-4 bg-background rounded-lg border flex flex-col gap-4 mb-4">
      <div>
        <div className="font-semibold">
          {request.requester?.full_name || 'Unknown'}
          <Badge variant="outline" className="ml-2 inline-block">
            {request.status}
          </Badge>
        </div>
        <p className="text-sm mt-1 text-muted-foreground">{details}</p>

        <div className="mt-2">
          <span className="text-xs font-semibold">Campus Director:</span>
          {request.campusDirectorApproval === 'approved' && (
            <Badge variant="success" className="ml-1 text-xs inline-block">
              Approved
            </Badge>
          )}
          {request.campusDirectorApproval === 'rejected' && (
            <Badge variant="destructive" className="ml-1 text-xs inline-block">
              Rejected
            </Badge>
          )}
          {request.campusDirectorApproval === 'none' && (
            <Badge variant="secondary" className="ml-1 text-xs inline-block">
              Pending
            </Badge>
          )}
        </div>

        {request.leadPastorNotes && (
          <p className="text-xs italic mt-1">
            Your Notes: {request.leadPastorNotes}
          </p>
        )}
        {request.campusDirectorNotes && (
          <div className="mt-2 p-2 rounded-md bg-gray-100 border">
            <p className="text-xs font-semibold">Campus Director Notes:</p>
            <p className="text-xs">{request.campusDirectorNotes}</p>
          </div>
        )}

      </div>

      {/* The action buttons */}
        <div className="flex gap-2 flex-wrap">
          {/* Normal Approve/Reject */}
          <Button
            variant="outline"
            size="sm"
            onClick={() => handleOpenModal('approved')}
          >
            Approve
          </Button>
          <Button
            variant="outline"
            size="sm"
            onClick={() => handleOpenModal('rejected')}
          >
            Reject
          </Button>
        <Button variant="secondary" size="sm" onClick={() => handleOpenModal('override-approved')}>
          Override
        </Button>
      </div>

      {/* The modal: if user picks override, we let them choose override-approved or override-rejected inside the modal */}
      {modalOpen && (
        <Dialog open={modalOpen} onOpenChange={setModalOpen}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Confirm Action</DialogTitle>
            </DialogHeader>
            <div className="space-y-4">
              <p className="text-sm">
                <strong>Request by:</strong> {request.requester?.full_name}
              </p>
              <p className="text-sm text-muted-foreground">{details}</p>

              {request.campusDirectorNotes && (
                <div className="mt-2 p-2 rounded-md bg-gray-100 border">
                  <p className="text-xs font-semibold">Campus Director Notes:</p>
                  <p className="text-xs">{request.campusDirectorNotes}</p>
                </div>
              )}

              {/* If user clicked 'override-approved', let's show a mini toggle: 
                  Approve or Reject override? 
                  In a real UI, you might do a radio or select. 
                  Here's a minimal approach:
              */}
              {selectedAction.startsWith('override') && (
                <div className="space-y-2">
                  <Label>Override Action</Label>
                  <div className="flex gap-2">
                    <Button
                      variant={selectedAction === 'override-approved' ? 'default' : 'outline'}
                      onClick={() => setSelectedAction('override-approved')}
                    >
                      Approve
                    </Button>
                    <Button
                      variant={selectedAction === 'override-rejected' ? 'default' : 'outline'}
                      onClick={() => setSelectedAction('override-rejected')}
                    >
                      Reject
                    </Button>
                  </div>
                </div>
              )}

              <div className="space-y-2">
                <Label>Lead Pastor Notes</Label>
                <Textarea
                  value={notes}
                  onChange={(e) => setNotes(e.target.value)}
                  placeholder="Add any final notes..."
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
  )
}
