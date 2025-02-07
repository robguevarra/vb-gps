//components/ApprovalTab.tsx

"use client"

import { useState } from "react"
import { ApprovalCard } from "./ApprovalCard"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Badge } from "@/components/ui/badge"
import { ScrollArea } from "@/components/ui/scroll-area"
import { motion } from "framer-motion"

interface LeaveApproval {
  id: string
  type: "Sick Leave" | "Vacation Leave"
  startDate: string
  endDate: string
  reason: string
  status: string
  date: string
  requester?: { full_name: string } | null
}

interface SurplusApproval {
  id: string
  type: "Surplus"
  amount: number
  reason: string
  status: string
  date: string
  requester?: { full_name: string } | null
}

interface ApprovalTabProps {
  pendingLeaveApprovals: LeaveApproval[]
  approvedLeaveApprovals: LeaveApproval[]
  pendingSurplusApprovals: SurplusApproval[]
  approvedSurplusApprovals: SurplusApproval[]
}

export function ApprovalTab({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
}: ApprovalTabProps) {
  const [activeTab, setActiveTab] = useState("pending")

  const MotionCard = motion(Card)

  return (
    <div className="space-y-8">
      <h2 className="text-3xl font-bold text-foreground">Approval Queue</h2>

      <Tabs defaultValue="pending" onValueChange={setActiveTab}>
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="pending">Pending</TabsTrigger>
          <TabsTrigger value="approved">Approved</TabsTrigger>
        </TabsList>
        <TabsContent value="pending">
          <div className="grid gap-6 md:grid-cols-2">
            <MotionCard initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.3 }}>
              <CardHeader>
                <CardTitle className="flex justify-between items-center">
                  <span>Leave Requests</span>
                  <Badge variant="secondary">{pendingLeaveApprovals.length}</Badge>
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[400px] pr-4">
                  {pendingLeaveApprovals.length > 0 ? (
                    pendingLeaveApprovals.map((request) => (
                      <ApprovalCard
                        key={`pending-leave-${request.id}`}
                        requestId={request.id}
                        requestType="leave"
                        currentStatus={request.status}
                        filedBy={request.requester?.full_name || "Unknown"}
                        details={`Dates: ${request.startDate} - ${request.endDate}. Reason: ${request.reason}`}
                      />
                    ))
                  ) : (
                    <p className="text-muted-foreground">No pending leave requests.</p>
                  )}
                </ScrollArea>
              </CardContent>
            </MotionCard>

            <MotionCard
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3, delay: 0.1 }}
            >
              <CardHeader>
                <CardTitle className="flex justify-between items-center">
                  <span>Surplus Requests</span>
                  <Badge variant="secondary">{pendingSurplusApprovals.length}</Badge>
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[400px] pr-4">
                  {pendingSurplusApprovals.length > 0 ? (
                    pendingSurplusApprovals.map((request) => (
                      <ApprovalCard
                        key={`pending-surplus-${request.id}`}
                        requestId={request.id}
                        requestType="surplus"
                        currentStatus={request.status}
                        filedBy={request.requester?.full_name || "Unknown"}
                        details={`Requested Amount: ₱${request.amount.toLocaleString()}. Reason: ${request.reason}`}
                      />
                    ))
                  ) : (
                    <p className="text-muted-foreground">No pending surplus requests.</p>
                  )}
                </ScrollArea>
              </CardContent>
            </MotionCard>
          </div>
        </TabsContent>
        <TabsContent value="approved">
          <div className="grid gap-6 md:grid-cols-2">
            <MotionCard initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.3 }}>
              <CardHeader>
                <CardTitle>Approved Leave Requests</CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[400px] pr-4">
                  {approvedLeaveApprovals.length > 0 ? (
                    approvedLeaveApprovals.map((request) => (
                      <Card key={`approved-leave-${request.id}`} className="mb-4 last:mb-0">
                        <CardContent className="pt-6">
                          <h4 className="font-semibold">{request.requester?.full_name || "Unknown"}</h4>
                          <p className="text-sm text-muted-foreground">
                            Dates: {request.startDate} - {request.endDate}
                          </p>
                          <p className="text-sm mt-2">Reason: {request.reason}</p>
                          <Badge className="mt-2" variant="outline">
                            {request.status}
                          </Badge>
                        </CardContent>
                      </Card>
                    ))
                  ) : (
                    <p className="text-muted-foreground">No approved leave requests.</p>
                  )}
                </ScrollArea>
              </CardContent>
            </MotionCard>

            <MotionCard
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3, delay: 0.1 }}
            >
              <CardHeader>
                <CardTitle>Approved Surplus Requests</CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[400px] pr-4">
                  {approvedSurplusApprovals.length > 0 ? (
                    approvedSurplusApprovals.map((request) => (
                      <Card key={`approved-surplus-${request.id}`} className="mb-4 last:mb-0">
                        <CardContent className="pt-6">
                          <h4 className="font-semibold">{request.requester?.full_name || "Unknown"}</h4>
                          <p className="text-sm text-muted-foreground">Amount: ₱{request.amount.toLocaleString()}</p>
                          <p className="text-sm mt-2">Reason: {request.reason}</p>
                          <Badge className="mt-2" variant="outline">
                            {request.status}
                          </Badge>
                        </CardContent>
                      </Card>
                    ))
                  ) : (
                    <p className="text-muted-foreground">No approved surplus requests.</p>
                  )}
                </ScrollArea>
              </CardContent>
            </MotionCard>
          </div>
        </TabsContent>
      </Tabs>
    </div>
  )
}

