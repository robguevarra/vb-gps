// components/ApprovalTab.tsx
'use client';

import { ApprovalCard } from './ApprovalCard';

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
  return (
    <div className="space-y-8">
      <h2 className="text-2xl font-semibold">Approval Queue</h2>
      <div className="space-y-4">
        <h3 className="text-xl font-medium">Leave Requests to Approve</h3>
        {leaveApprovals.length > 0 ? leaveApprovals.map((request) => (
          <ApprovalCard
            key={`approval-leave-${request.id}`}
            requestId={request.id}
            requestType="leave"
            currentStatus={request.status}
            filedBy={request.requester?.full_name || 'Unknown'}
            details={`Dates: ${request.startDate} - ${request.endDate}. Reason: ${request.reason}`}
          />
        )) : <p>No leave requests pending approval.</p>}

        <h3 className="text-xl font-medium mt-8">Surplus Requests to Approve</h3>
        {surplusApprovals.length > 0 ? surplusApprovals.map((request) => (
          <ApprovalCard
            key={`approval-surplus-${request.id}`}
            requestId={request.id}
            requestType="surplus"
            currentStatus={request.status}
            filedBy={request.requester?.full_name || 'Unknown'}
            details={`Requested Amount: ₱${request.amount.toLocaleString()}. Reason: ${request.reason}`}
          />
        )) : <p>No surplus requests pending approval.</p>}
      </div>
    </div>
  );
}
