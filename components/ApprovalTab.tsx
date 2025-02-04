// components/ApprovalTab.tsx
'use client';

import { useRouter } from 'next/navigation';
import { ApprovalActionModal } from './ApprovalActionModal';

interface LeaveApproval {
  id: string;
  type: 'Sick Leave' | 'Vacation Leave';
  startDate: string;
  endDate: string;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

interface SurplusApproval {
  id: string;
  type: 'Surplus';
  amount: number;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

interface ApprovalTabProps {
  leaveApprovals: LeaveApproval[];
  surplusApprovals: SurplusApproval[];
}

export function ApprovalTab({ leaveApprovals, surplusApprovals }: ApprovalTabProps) {
  const router = useRouter();

  const onActionComplete = () => {
    router.refresh();
  };

  return (
    <div className="space-y-8">
      <h2 className="text-2xl font-semibold">Approval Queue</h2>
      <div className="space-y-4">
        <h3 className="text-xl font-medium">Leave Requests to Approve</h3>
        {leaveApprovals.length > 0 ? leaveApprovals.map((request) => (
          <div key={`approval-leave-${request.id}`} className="p-4 bg-background rounded-lg border">
            <div className="flex justify-between items-start">
              <div>
                <p className="font-medium">
                  {request.type} Request by {request.requester?.full_name || 'Unknown'}
                  <span className={`ml-2 text-sm ${
                    request.status === 'approved'
                      ? 'text-green-600'
                      : request.status === 'rejected'
                      ? 'text-red-600'
                      : 'text-yellow-600'
                  }`}>
                    ({request.status})
                  </span>
                </p>
                <p className="text-sm text-muted-foreground mt-1">{request.date}</p>
              </div>
              <ApprovalActionModal
                requestId={request.id}
                requestType="leave"
                currentStatus={request.status}
                filedBy={request.requester?.full_name || 'Unknown'}
                details={`Dates: ${request.startDate} - ${request.endDate}. Reason: ${request.reason}`}
                onActionComplete={onActionComplete}
              />
            </div>
          </div>
        )) : <p>No leave requests pending approval.</p>}

        <h3 className="text-xl font-medium mt-8">Surplus Requests to Approve</h3>
        {surplusApprovals.length > 0 ? surplusApprovals.map((request) => (
          <div key={`approval-surplus-${request.id}`} className="p-4 bg-background rounded-lg border">
            <div className="flex justify-between items-start">
              <div>
                <p className="font-medium">
                  Surplus Request by {request.requester?.full_name || 'Unknown'}
                  <span className={`ml-2 text-sm ${
                    request.status === 'approved'
                      ? 'text-green-600'
                      : request.status === 'rejected'
                      ? 'text-red-600'
                      : 'text-yellow-600'
                  }`}>
                    ({request.status})
                  </span>
                </p>
                <p className="text-sm text-muted-foreground mt-1">{request.date}</p>
              </div>
              <ApprovalActionModal
                requestId={request.id}
                requestType="surplus"
                currentStatus={request.status}
                filedBy={request.requester?.full_name || 'Unknown'}
                details={`Requested Amount: ₱${request.amount.toLocaleString()}. Reason: ${request.reason}`}
                onActionComplete={onActionComplete}
              />
            </div>
          </div>
        )) : <p>No surplus requests pending approval.</p>}
      </div>
    </div>
  );
}
