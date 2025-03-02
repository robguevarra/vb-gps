"use client"

import LeadPastorApprovalTab from "@/components/LeadPastorApprovalTab"
import { ChurchReportsTab } from "@/components/ChurchReportsTab"
import { TooltipProvider } from "@/components/ui/tooltip"
import { ApprovedRequestsTab } from "@/components/ApprovedRequestsTab"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { useRouter, usePathname } from "next/navigation"
import { CheckCircle, FileText, BarChart3 } from "lucide-react"

// Define the ApprovalStatus type to match the one in LeadPastorApprovalTab
type ApprovalStatus = 'approved' | 'pending' | 'rejected'

// Define the LeaveApproval type
type LeaveApproval = {
  id: string
  type: string
  startDate: string
  endDate: string
  reason: string
  status: ApprovalStatus
  date: string
  campusDirectorApproval: string
  campusDirectorNotes?: string
  leadPastorApproval: string
  leadPastorNotes?: string
  requester: {
    full_name: string
  }
}

// Define the SurplusApproval type
type SurplusApproval = {
  id: string
  type: string
  amount: number
  reason: string
  status: ApprovalStatus
  date: string
  campusDirectorApproval: string
  campusDirectorNotes?: string
  leadPastorApproval: string
  leadPastorNotes?: string
  requester: {
    full_name: string
  }
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
  const router = useRouter()
  const pathname = usePathname()

  const handleTabChange = (value: string) => {
    router.push(`${pathname}?tab=${value}`)
  }

  return (
    <TooltipProvider>
      <div className="space-y-4 sm:space-y-6">
        <Tabs value={currentTab} onValueChange={handleTabChange} className="w-full">
          <TabsList className="w-full sm:w-auto grid grid-cols-3 h-11 bg-blue-50 dark:bg-gray-800 p-1 rounded-lg mb-4">
            <TabsTrigger 
              value="approvals" 
              className="flex gap-1.5 px-3 py-2 text-sm data-[state=active]:bg-white dark:data-[state=active]:bg-gray-700 data-[state=active]:text-[#00458d] dark:data-[state=active]:text-white rounded-md transition-all"
            >
              <FileText className="h-4 w-4" />
              <span className="hidden sm:inline">Pending Approvals</span>
              <span className="sm:hidden">Pending</span>
            </TabsTrigger>
            <TabsTrigger 
              value="approved-requests" 
              className="flex gap-1.5 px-3 py-2 text-sm data-[state=active]:bg-white dark:data-[state=active]:bg-gray-700 data-[state=active]:text-[#00458d] dark:data-[state=active]:text-white rounded-md transition-all"
            >
              <CheckCircle className="h-4 w-4" />
              <span className="hidden sm:inline">Approved Requests</span>
              <span className="sm:hidden">Approved</span>
            </TabsTrigger>
            <TabsTrigger 
              value="reports" 
              className="flex gap-1.5 px-3 py-2 text-sm data-[state=active]:bg-white dark:data-[state=active]:bg-gray-700 data-[state=active]:text-[#00458d] dark:data-[state=active]:text-white rounded-md transition-all"
            >
              <BarChart3 className="h-4 w-4" />
              <span className="hidden sm:inline">Church Reports</span>
              <span className="sm:hidden">Reports</span>
            </TabsTrigger>
          </TabsList>

          <TabsContent value="approvals" className="mt-0">
            <LeadPastorApprovalTab
              pendingLeaveApprovals={pendingLeaveApprovals}
              approvedLeaveApprovals={approvedLeaveApprovals}
              pendingSurplusApprovals={pendingSurplusApprovals}
              approvedSurplusApprovals={approvedSurplusApprovals}
            />
          </TabsContent>
          
          <TabsContent value="approved-requests" className="mt-0">
            <ApprovedRequestsTab
              approvedLeave={approvedLeaveApprovals}
              approvedSurplus={approvedSurplusApprovals}
              currentPage={1}
              totalPages={1}
              onPageChange={() => {}}
              pageSize={10}
              onPageSizeChange={() => {}}
            />
          </TabsContent>
          
          <TabsContent value="reports" className="mt-0">
            <div className="space-y-4 sm:space-y-6">
              {churchIds.length > 0 ? (
                <ChurchReportsTab churchIds={churchIds} />
              ) : (
                <div className="p-6 rounded-lg bg-destructive/10 text-destructive border border-destructive/20">
                  <h3 className="text-lg font-medium mb-2">No Churches Assigned</h3>
                  <p>No local churches are currently assigned to this lead pastor. Church reports cannot be displayed.</p>
                </div>
              )}
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </TooltipProvider>
  )
}

