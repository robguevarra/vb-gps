// components/LeadPastorApprovalTab.tsx

'use client'

import { useState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Badge } from '@/components/ui/badge'
import { ScrollArea } from '@/components/ui/scroll-area'
import { motion } from 'framer-motion'
import { LeadPastorApprovalCard } from './LeadPastorApprovalCard'

interface LeaveApproval {
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

interface SurplusApproval {
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

interface LeadPastorApprovalTabProps {
  pendingLeaveApprovals: LeaveApproval[]
  approvedLeaveApprovals: LeaveApproval[]
  pendingSurplusApprovals: SurplusApproval[]
  approvedSurplusApprovals: SurplusApproval[]
}

export function LeadPastorApprovalTab({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
}: LeadPastorApprovalTabProps) {
  const [activeTab, setActiveTab] = useState('pending')
  const MotionCard = motion(Card)

  return (
    <div className="space-y-8">
      <h2 className="text-3xl font-bold text-foreground">Lead Pastor Approvals</h2>

      <Tabs defaultValue="pending" onValueChange={setActiveTab}>
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="pending">Pending</TabsTrigger>
          <TabsTrigger value="approved">Approved</TabsTrigger>
        </TabsList>

        {/* ----------------- PENDING TAB ---------------- */}
        <TabsContent value="pending">
          <div className="grid gap-6 md:grid-cols-2">
            {/* Pending Leaves */}
            <MotionCard
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
            >
              <CardHeader>
                <CardTitle className="flex items-center justify-between">
                  <span>Leave Requests</span>
                  <Badge variant="secondary">{pendingLeaveApprovals.length}</Badge>
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[400px] pr-4">
                  {pendingLeaveApprovals.length > 0 ? (
                    pendingLeaveApprovals.map((request) => (
                      <LeadPastorApprovalCard
                        key={`pending-leave-${request.id}`}
                        requestType="leave"
                        request={request}
                      />
                    ))
                  ) : (
                    <p className="text-muted-foreground">No pending leave requests.</p>
                  )}
                </ScrollArea>
              </CardContent>
            </MotionCard>

            {/* Pending Surplus */}
            <MotionCard
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3, delay: 0.1 }}
            >
              <CardHeader>
                <CardTitle className="flex items-center justify-between">
                  <span>Surplus Requests</span>
                  <Badge variant="secondary">{pendingSurplusApprovals.length}</Badge>
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[400px] pr-4">
                  {pendingSurplusApprovals.length > 0 ? (
                    pendingSurplusApprovals.map((request) => (
                      <LeadPastorApprovalCard
                        key={`pending-surplus-${request.id}`}
                        requestType="surplus"
                        request={request}
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

        {/* ----------------- APPROVED TAB ---------------- */}
        <TabsContent value="approved">
          <div className="grid gap-6 md:grid-cols-2">
            {/* Approved Leaves */}
            <MotionCard
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
            >
              <CardHeader>
                <CardTitle>Approved Leave Requests</CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[400px] pr-4">
                  {approvedLeaveApprovals.length > 0 ? (
                    approvedLeaveApprovals.map((request) => (
                      <div
                        key={`approved-leave-${request.id}`}
                        className="p-2 border-b last:border-none"
                      >
                        <h4 className="font-semibold">
                          {request.requester?.full_name || 'Unknown'}
                        </h4>
                        <p className="text-sm text-muted-foreground">
                          Dates: {request.startDate} - {request.endDate}
                        </p>
                        <p className="text-sm mt-1">Reason: {request.reason}</p>

                        {/* Show the notes if any */}
                        {request.campusDirectorNotes && (
                          <p className="text-xs italic mt-2">
                            CD Notes: {request.campusDirectorNotes}
                          </p>
                        )}
                        {request.leadPastorNotes && (
                          <p className="text-xs italic mt-1">
                            Pastor Notes: {request.leadPastorNotes}
                          </p>
                        )}

                        <Badge className="mt-2" variant="outline">
                          {request.status}
                        </Badge>
                      </div>
                    ))
                  ) : (
                    <p className="text-muted-foreground">No approved leave requests.</p>
                  )}
                </ScrollArea>
              </CardContent>
            </MotionCard>

            {/* Approved Surplus */}
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
                      <div
                        key={`approved-surplus-${request.id}`}
                        className="p-2 border-b last:border-none"
                      >
                        <h4 className="font-semibold">
                          {request.requester?.full_name || 'Unknown'}
                        </h4>
                        <p className="text-sm text-muted-foreground">
                          Amount: ₱{request.amount.toLocaleString()}
                        </p>
                        <p className="text-sm mt-1">Reason: {request.reason}</p>

                        {/* Show the notes if any */}
                        {request.campusDirectorNotes && (
                          <p className="text-xs italic mt-2">
                            CD Notes: {request.campusDirectorNotes}
                          </p>
                        )}
                        {request.leadPastorNotes && (
                          <p className="text-xs italic mt-1">
                            Pastor Notes: {request.leadPastorNotes}
                          </p>
                        )}

                        <Badge className="mt-2" variant="outline">
                          {request.status}
                        </Badge>
                      </div>
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
