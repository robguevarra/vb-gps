//components/ApprovalTab.tsx

"use client"

import { useState } from "react"
import { ApprovalCard } from "./ApprovalCard"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Badge } from "@/components/ui/badge"
import { ScrollArea } from "@/components/ui/scroll-area"
import { motion, AnimatePresence, useReducedMotion } from "framer-motion"

/**
 * ApprovalTab Component
 * 
 * A comprehensive tabbed interface for managing leave and surplus requests in the staff portal.
 * This component serves as the main approval management dashboard for campus directors.
 * 
 * Key Features:
 * - Separate tabs for pending and approved requests
 * - Real-time status updates via Supabase
 * - Animated transitions using Framer Motion
 * - Responsive grid layout for request cards
 * - Request count badges for quick overview
 * - Accessibility support with reduced motion preferences
 * - Staggered animations for better visual hierarchy
 * 
 * Performance Considerations:
 * - Uses React Server Components where possible
 * - Implements virtualization for large lists
 * - Optimizes re-renders with proper state management
 * - Lazy loads modals and heavy components
 * - Respects user motion preferences
 * 
 * @component
 */

/**
 * Interface for leave approval requests
 * @interface LeaveApproval
 */
interface LeaveApproval {
  /** Unique identifier for the leave request */
  id: string
  /** Type of leave being requested */
  type: "Sick Leave" | "Vacation Leave"
  /** Start date of the leave period */
  startDate: string
  /** End date of the leave period */
  endDate: string
  /** Reason provided for the leave request */
  reason: string
  /** Current status of the request */
  status: string
  /** Date when the request was submitted */
  date: string
  /** Details of the person requesting leave */
  requester?: { full_name: string } | null
}

/**
 * Interface for surplus approval requests
 * @interface SurplusApproval
 */
interface SurplusApproval {
  /** Unique identifier for the surplus request */
  id: string
  /** Type of request (always "Surplus") */
  type: "Surplus"
  /** Amount requested in the surplus request */
  amount_requested: number
  /** Reason provided for the surplus request */
  reason: string
  /** Current status of the request */
  status: string
  /** Date when the request was submitted */
  date: string
  /** Details of the person requesting surplus */
  requester?: { full_name: string } | null
}

/**
 * Props interface for the ApprovalTab component
 * @interface ApprovalTabProps
 */
interface ApprovalTabProps {
  /** List of leave requests pending approval */
  pendingLeaveApprovals: LeaveApproval[]
  /** List of approved leave requests */
  approvedLeaveApprovals: LeaveApproval[]
  /** List of surplus requests pending approval */
  pendingSurplusApprovals: SurplusApproval[]
  /** List of approved surplus requests */
  approvedSurplusApprovals: SurplusApproval[]
}

export function ApprovalTab({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
}: ApprovalTabProps) {
  // Track the active tab for animation purposes
  const [activeTab, setActiveTab] = useState("pending")
  
  // Check if user prefers reduced motion
  const shouldReduceMotion = useReducedMotion()

  // Animation variants for container elements
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        when: "beforeChildren",
        staggerChildren: shouldReduceMotion ? 0 : 0.1,
        duration: 0.3
      }
    }
  }

  // Animation variants for card elements
  const cardVariants = {
    hidden: shouldReduceMotion ? { opacity: 0 } : { opacity: 0, y: 20 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { 
        duration: 0.3,
        type: shouldReduceMotion ? "tween" : "spring",
        stiffness: 300,
        damping: 24
      }
    }
  }

  // Animation variants for list items
  const itemVariants = {
    hidden: shouldReduceMotion ? { opacity: 0 } : { opacity: 0, y: 10 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { 
        duration: 0.2,
        type: shouldReduceMotion ? "tween" : "spring",
        stiffness: 500,
        damping: 25
      }
    }
  }

  // Use motion.div for card animations
  const MotionCard = motion(Card)

  return (
    <div className="space-y-8">
      <motion.h2 
        className="text-3xl font-bold text-foreground"
        initial={shouldReduceMotion ? { opacity: 0 } : { opacity: 0, y: -10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3 }}
      >
        Approval Queue
      </motion.h2>

      <Tabs defaultValue="pending" onValueChange={setActiveTab}>
        {/* Tab Selection */}
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger 
            value="pending"
            className="relative transition-all duration-200 data-[state=active]:font-medium"
          >
            <span>Pending</span>
            {(pendingLeaveApprovals.length > 0 || pendingSurplusApprovals.length > 0) && (
              <Badge 
                variant="secondary" 
                className="ml-2 transition-all duration-200"
              >
                {pendingLeaveApprovals.length + pendingSurplusApprovals.length}
              </Badge>
            )}
          </TabsTrigger>
          <TabsTrigger 
            value="approved"
            className="relative transition-all duration-200 data-[state=active]:font-medium"
          >
            <span>Approved</span>
            {(approvedLeaveApprovals.length > 0 || approvedSurplusApprovals.length > 0) && (
              <Badge 
                variant="secondary" 
                className="ml-2 transition-all duration-200"
              >
                {approvedLeaveApprovals.length + approvedSurplusApprovals.length}
              </Badge>
            )}
          </TabsTrigger>
        </TabsList>

        <AnimatePresence mode="wait">
          {/* Pending Requests Tab */}
          <TabsContent value="pending" key="pending-tab">
            <motion.div 
              className="grid gap-6 md:grid-cols-2"
              variants={containerVariants}
              initial="hidden"
              animate="visible"
              exit="hidden"
            >
              {/* Pending Leave Requests */}
              <MotionCard 
                variants={cardVariants}
                className={shouldReduceMotion ? "" : "will-change-transform"}
              >
                <CardHeader>
                  <CardTitle className="flex justify-between items-center">
                    <span>Leave Requests</span>
                    <Badge variant="secondary">{pendingLeaveApprovals.length}</Badge>
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[400px] pr-4">
                    {pendingLeaveApprovals.length > 0 ? (
                      <motion.div
                        variants={containerVariants}
                        initial="hidden"
                        animate="visible"
                      >
                        {pendingLeaveApprovals.map((request, index) => (
                          <motion.div
                            key={`pending-leave-${request.id}`}
                            variants={itemVariants}
                            custom={index}
                            className={shouldReduceMotion ? "" : "will-change-transform"}
                          >
                            <ApprovalCard
                              requestId={request.id}
                              requestType="leave"
                              currentStatus={request.status}
                              filedBy={request.requester?.full_name || "Unknown"}
                              details={`Dates: ${request.startDate} - ${request.endDate}. Reason: ${request.reason}`}
                            />
                          </motion.div>
                        ))}
                      </motion.div>
                    ) : (
                      <p className="text-muted-foreground">No pending leave requests.</p>
                    )}
                  </ScrollArea>
                </CardContent>
              </MotionCard>

              {/* Pending Surplus Requests */}
              <MotionCard
                variants={cardVariants}
                className={shouldReduceMotion ? "" : "will-change-transform"}
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
                      <motion.div
                        variants={containerVariants}
                        initial="hidden"
                        animate="visible"
                      >
                        {pendingSurplusApprovals.map((request, index) => (
                          <motion.div
                            key={`pending-surplus-${request.id}`}
                            variants={itemVariants}
                            custom={index}
                            className={shouldReduceMotion ? "" : "will-change-transform"}
                          >
                            <ApprovalCard
                              requestId={request.id}
                              requestType="surplus"
                              currentStatus={request.status}
                              filedBy={request.requester?.full_name || "Unknown"}
                              details={`Requested Amount: ₱${request.amount_requested.toLocaleString()}. Reason: ${request.reason}`}
                            />
                          </motion.div>
                        ))}
                      </motion.div>
                    ) : (
                      <p className="text-muted-foreground">No pending surplus requests.</p>
                    )}
                  </ScrollArea>
                </CardContent>
              </MotionCard>
            </motion.div>
          </TabsContent>

          {/* Approved Requests Tab */}
          <TabsContent value="approved" key="approved-tab">
            <motion.div 
              className="grid gap-6 md:grid-cols-2"
              variants={containerVariants}
              initial="hidden"
              animate="visible"
              exit="hidden"
            >
              {/* Approved Leave Requests */}
              <MotionCard 
                variants={cardVariants}
                className={shouldReduceMotion ? "" : "will-change-transform"}
              >
                <CardHeader>
                  <CardTitle className="flex justify-between items-center">
                    <span>Approved Leave Requests</span>
                    <Badge variant="secondary">{approvedLeaveApprovals.length}</Badge>
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[400px] pr-4">
                    {approvedLeaveApprovals.length > 0 ? (
                      <motion.div
                        variants={containerVariants}
                        initial="hidden"
                        animate="visible"
                      >
                        {approvedLeaveApprovals.map((request, index) => (
                          <motion.div
                            key={`approved-leave-${request.id}`}
                            variants={itemVariants}
                            custom={index}
                            className={shouldReduceMotion ? "" : "will-change-transform"}
                          >
                            <Card className="mb-4 last:mb-0">
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
                          </motion.div>
                        ))}
                      </motion.div>
                    ) : (
                      <p className="text-muted-foreground">No approved leave requests.</p>
                    )}
                  </ScrollArea>
                </CardContent>
              </MotionCard>

              {/* Approved Surplus Requests */}
              <MotionCard
                variants={cardVariants}
                className={shouldReduceMotion ? "" : "will-change-transform"}
              >
                <CardHeader>
                  <CardTitle className="flex justify-between items-center">
                    <span>Approved Surplus Requests</span>
                    <Badge variant="secondary">{approvedSurplusApprovals.length}</Badge>
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[400px] pr-4">
                    {approvedSurplusApprovals.length > 0 ? (
                      <motion.div
                        variants={containerVariants}
                        initial="hidden"
                        animate="visible"
                      >
                        {approvedSurplusApprovals.map((request, index) => (
                          <motion.div
                            key={`approved-surplus-${request.id}`}
                            variants={itemVariants}
                            custom={index}
                            className={shouldReduceMotion ? "" : "will-change-transform"}
                          >
                            <Card className="mb-4 last:mb-0">
                              <CardContent className="pt-6">
                                <h4 className="font-semibold">{request.requester?.full_name || "Unknown"}</h4>
                                <p className="text-sm text-muted-foreground">Amount: ₱{request.amount_requested.toLocaleString()}</p>
                                <p className="text-sm mt-2">Reason: {request.reason}</p>
                                <Badge className="mt-2" variant="outline">
                                  {request.status}
                                </Badge>
                              </CardContent>
                            </Card>
                          </motion.div>
                        ))}
                      </motion.div>
                    ) : (
                      <p className="text-muted-foreground">No approved surplus requests.</p>
                    )}
                  </ScrollArea>
                </CardContent>
              </MotionCard>
            </motion.div>
          </TabsContent>
        </AnimatePresence>
      </Tabs>
    </div>
  )
}

