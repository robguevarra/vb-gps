"use client"

import LeadPastorApprovalTab from "@/components/LeadPastorApprovalTab"
import { ChurchReportsTab } from "@/components/ChurchReportsTab"

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
  localChurchId?: number
  churchIds: number[]
  currentTab: string
}

export default function LeadPastorDashboardClient({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
  selectedLeadPastorName,
  localChurchId,
  churchIds,
  currentTab,
}: LeadPastorDashboardClientProps) {
  return (
    <div className="space-y-8">
      {currentTab === 'approvals' && (
        <LeadPastorApprovalTab
          pendingLeaveApprovals={pendingLeaveApprovals}
          approvedLeaveApprovals={approvedLeaveApprovals}
          pendingSurplusApprovals={pendingSurplusApprovals}
          approvedSurplusApprovals={approvedSurplusApprovals}
        />
      )}
      
      {currentTab === 'reports' && (
        <div className="space-y-6">
          {churchIds.length > 0 ? (
            <ChurchReportsTab churchIds={churchIds} />
          ) : (
            <div className="p-4 rounded-lg bg-destructive/10 text-destructive">
              No local churches assigned - cannot show staff reports
            </div>
          )}
        </div>
      )}
    </div>
  )
}

