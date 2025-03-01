"use client"

import LeadPastorApprovalTab from "@/components/LeadPastorApprovalTab"
import { ChurchReportsTab } from "@/components/ChurchReportsTab"
import { TooltipProvider } from "@/components/ui/tooltip"
import { ApprovedRequestsTab } from "@/components/ApprovedRequestsTab"

// Define the ApprovalStatus type to match the one in LeadPastorApprovalTab
type ApprovalStatus = 'approved' | 'pending' | 'rejected'

// Update LeaveApproval to use ApprovalStatus
type LeaveApproval = {
  id: string
  type: "Vacation Leave" | "Sick Leave"
  startDate: string
  endDate: string
  reason: string
  status: ApprovalStatus
  date: string
  campusDirectorApproval: string
  campusDirectorNotes?: string
  leadPastorApproval: string
  leadPastorNotes?: string
  requester?: { full_name: string }
}

// Update SurplusApproval to use ApprovalStatus
type SurplusApproval = {
  id: string
  type: "Surplus"
  amount: number
  reason: string
  status: ApprovalStatus
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
    <TooltipProvider>
      <div className="space-y-4 sm:space-y-8">
        {currentTab === 'approvals' && (
          <LeadPastorApprovalTab
            pendingLeaveApprovals={pendingLeaveApprovals}
            approvedLeaveApprovals={approvedLeaveApprovals}
            pendingSurplusApprovals={pendingSurplusApprovals}
            approvedSurplusApprovals={approvedSurplusApprovals}
          />
        )}
        
        {currentTab === 'approved-requests' && (
          <ApprovedRequestsTab
            approvedLeave={approvedLeaveApprovals}
            approvedSurplus={approvedSurplusApprovals}
            currentPage={1}
            totalPages={1}
            onPageChange={() => {}}
            pageSize={10}
            onPageSizeChange={() => {}}
          />
        )}
        
        {currentTab === 'reports' && (
          <div className="space-y-4 sm:space-y-6">
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
    </TooltipProvider>
  )
}

