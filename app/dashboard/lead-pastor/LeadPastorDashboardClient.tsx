"use client"

import LeadPastorApprovalTab from "@/components/LeadPastorApprovalTab"
import { ChurchReportsTab } from "@/components/ChurchReportsTab"
import { TooltipProvider } from "@/components/ui/tooltip"
import { ApprovedRequestsTab } from "@/components/ApprovedRequestsTab"
import { ApprovalRequest, LeaveApproval, SurplusApproval } from "@/types/approval"

type LeadPastorDashboardClientProps = {
  pendingLeaveApprovals: LeaveApproval[]
  approvedLeaveApprovals: LeaveApproval[]
  pendingSurplusApprovals: SurplusApproval[]
  approvedSurplusApprovals: SurplusApproval[]
  churchIds: number[]
  currentTab: string
}

export default function LeadPastorDashboardClient({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
  churchIds,
  currentTab,
}: LeadPastorDashboardClientProps) {
  return (
    <TooltipProvider>
      <div className="space-y-8">
        {currentTab === 'approvals' && (
          <LeadPastorApprovalTab
            pendingLeaveApprovals={pendingLeaveApprovals as ApprovalRequest[]}
            pendingSurplusApprovals={pendingSurplusApprovals as ApprovalRequest[]}
          />
        )}
        
        {currentTab === 'approved-requests' && (
          <ApprovedRequestsTab
            approvedLeave={approvedLeaveApprovals as ApprovalRequest[]}
            approvedSurplus={approvedSurplusApprovals as ApprovalRequest[]}
            currentPage={1}
            totalPages={1}
            onPageChange={() => {}}
            pageSize={10}
            onPageSizeChange={() => {}}
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
    </TooltipProvider>
  )
}

