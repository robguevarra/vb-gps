// app/dashboard/lead-pastor/LeadPastorDashboardClient.tsx

'use client'

import { LeadPastorApprovalTab } from '@/components/LeadPastorApprovalTab'

type LeaveApproval = {
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

type SurplusApproval = {
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

interface LeadPastorDashboardClientProps {
  pendingLeaveApprovals: LeaveApproval[]
  approvedLeaveApprovals: LeaveApproval[]
  pendingSurplusApprovals: SurplusApproval[]
  approvedSurplusApprovals: SurplusApproval[]
}

export default function LeadPastorDashboardClient({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
}: LeadPastorDashboardClientProps) {
  return (
    <div>
      <LeadPastorApprovalTab
        pendingLeaveApprovals={pendingLeaveApprovals}
        approvedLeaveApprovals={approvedLeaveApprovals}
        pendingSurplusApprovals={pendingSurplusApprovals}
        approvedSurplusApprovals={approvedSurplusApprovals}
      />
    </div>
  )
}
