//components/LeadPastorApprovalTab.tsx

"use client"

import { useState } from "react"
import { Tabs } from "@/components/ui/tabs"
import { TabsContent } from "@/components/ui/tabs"
import { TabsList } from "@/components/ui/tabs"
import { TabsTrigger } from "@/components/ui/tabs"
import { LeadPastorApprovalCard } from "./LeadPastorApprovalCard"

type ApprovalRequest = {
  id: string
  type: string
  startDate?: string
  endDate?: string
  amount?: number
  reason: string
  status: string
  date: string
  campusDirectorApproval: string
  campusDirectorNotes?: string
  leadPastorApproval: string
  leadPastorNotes?: string
  requester?: { full_name: string }
}

const LeadPastorApprovalTab = ({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
}: {
  pendingLeaveApprovals: ApprovalRequest[]
  approvedLeaveApprovals: ApprovalRequest[]
  pendingSurplusApprovals: ApprovalRequest[]
  approvedSurplusApprovals: ApprovalRequest[]
}) => {
  const [activeTab, setActiveTab] = useState<"pending" | "approved">("pending")

  const renderRequests = (requests: ApprovalRequest[], isApprovedTab: boolean) => (
    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
      {requests.map((request) => (
        <LeadPastorApprovalCard
          key={`${request.type}-${request.id}`}
          request={request}
          requestType={request.type.toLowerCase().includes("leave") ? "leave" : "surplus"}
          isApprovedTab={isApprovedTab}
        />
      ))}
    </div>
  )

  return (
    <Tabs value={activeTab} onValueChange={(value) => setActiveTab(value as "pending" | "approved")} className="w-full">
      <TabsList className="grid w-full grid-cols-2 mb-8">
        <TabsTrigger value="pending">Pending</TabsTrigger>
        <TabsTrigger value="approved">Approved</TabsTrigger>
      </TabsList>
      <TabsContent value="pending" className="space-y-8">
        {pendingLeaveApprovals.length > 0 && (
          <div>
            <h3 className="text-lg font-medium mb-4">Leave Requests</h3>
            {renderRequests(pendingLeaveApprovals, false)}
          </div>
        )}
        {pendingSurplusApprovals.length > 0 && (
          <div>
            <h3 className="text-lg font-medium mb-4">Surplus Requests</h3>
            {renderRequests(pendingSurplusApprovals, false)}
          </div>
        )}
        {pendingLeaveApprovals.length === 0 && pendingSurplusApprovals.length === 0 && (
          <p className="text-gray-500 dark:text-gray-400 text-center">No pending requests.</p>
        )}
      </TabsContent>
      <TabsContent value="approved" className="space-y-8">
        {approvedLeaveApprovals.length > 0 && (
          <div>
            <h3 className="text-lg font-medium mb-4">Leave Requests</h3>
            {renderRequests(approvedLeaveApprovals, true)}
          </div>
        )}
        {approvedSurplusApprovals.length > 0 && (
          <div>
            <h3 className="text-lg font-medium mb-4">Surplus Requests</h3>
            {renderRequests(approvedSurplusApprovals, true)}
          </div>
        )}
        {approvedLeaveApprovals.length === 0 && approvedSurplusApprovals.length === 0 && (
          <p className="text-gray-500 dark:text-gray-400 text-center">No approved requests.</p>
        )}
      </TabsContent>
    </Tabs>
  )
}

export default LeadPastorApprovalTab

