"use client"

import LeadPastorApprovalTab from "@/components/LeadPastorApprovalTab"

type LeaveApproval = {
  id: string
  type: "Vacation Leave" | "Sick Leave"
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
  type: "Surplus"
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

type LeadPastorDashboardClientProps = {
  pendingLeaveApprovals: LeaveApproval[]
  approvedLeaveApprovals: LeaveApproval[]
  pendingSurplusApprovals: SurplusApproval[]
  approvedSurplusApprovals: SurplusApproval[]
  selectedLeadPastorName: string
}

export default function LeadPastorDashboardClient({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
  selectedLeadPastorName,
}: LeadPastorDashboardClientProps) {
  return (
    <div className="space-y-8">
      <LeadPastorApprovalTab
        pendingLeaveApprovals={pendingLeaveApprovals}
        approvedLeaveApprovals={approvedLeaveApprovals}
        pendingSurplusApprovals={pendingSurplusApprovals}
        approvedSurplusApprovals={approvedSurplusApprovals}
      />
    </div>
  )
}

