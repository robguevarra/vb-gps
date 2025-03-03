"use client"

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ScrollArea } from "@/components/ui/scroll-area"
import { motion } from "framer-motion"
import { useReducedMotion } from "framer-motion"

interface RequestHistoryTabProps {
  pendingLeaveRequests: any[]
  approvedLeaveRequests: any[]
  pendingSurplusRequests: any[]
  approvedSurplusRequests: any[]
}

/**
 * RequestHistoryTab Component
 * 
 * Client component that displays leave and surplus requests with tabs for pending and approved requests.
 * Implements optimized animations and responsive design.
 */
export function RequestHistoryTab({
  pendingLeaveRequests,
  approvedLeaveRequests,
  pendingSurplusRequests,
  approvedSurplusRequests,
}: RequestHistoryTabProps) {
  // Check if user prefers reduced motion
  const shouldReduceMotion = useReducedMotion();

  // Animation variants for list items
  const listItemVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 10 },
    visible: (i: number) => ({
      opacity: 1,
      y: 0,
      transition: {
        delay: shouldReduceMotion ? 0 : i * 0.05,
        duration: 0.3,
        ease: "easeOut"
      }
    })
  };

  return (
    <Tabs defaultValue="pending" className="w-full">
      <TabsList className="grid w-full grid-cols-2">
        <TabsTrigger value="pending" className="transition-all duration-200 hover:bg-muted/80 data-[state=active]:scale-[1.02]">Pending</TabsTrigger>
        <TabsTrigger value="approved" className="transition-all duration-200 hover:bg-muted/80 data-[state=active]:scale-[1.02]">Approved</TabsTrigger>
      </TabsList>

      <TabsContent value="pending" className="mt-6 focus-visible:outline-none focus-visible:ring-0">
        <div className="grid gap-6 md:grid-cols-2">
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Leave Requests</h3>
            <ScrollArea className="h-[300px] pr-4">
              {pendingLeaveRequests.length > 0 ? (
                pendingLeaveRequests.map((request, index) => (
                  <motion.div
                    key={request.id}
                    custom={index}
                    initial="hidden"
                    animate="visible"
                    variants={listItemVariants}
                  >
                    <RequestHistoryCard 
                      request={{
                        ...request,
                        type: request.type === 'sick' ? 'Sick Leave' : 'Vacation Leave',
                        date: new Date(request.created_at).toLocaleDateString(),
                        startDate: new Date(request.start_date).toLocaleDateString(),
                        endDate: new Date(request.end_date).toLocaleDateString(),
                        isLeave: true
                      }} 
                    />
                  </motion.div>
                ))
              ) : (
                <p className="text-sm text-muted-foreground">No pending leave requests</p>
              )}
            </ScrollArea>
          </div>
          
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Surplus Requests</h3>
            <ScrollArea className="h-[300px] pr-4">
              {pendingSurplusRequests.length > 0 ? (
                pendingSurplusRequests.map((request, index) => (
                  <motion.div
                    key={request.id}
                    custom={index}
                    initial="hidden"
                    animate="visible"
                    variants={listItemVariants}
                  >
                    <RequestHistoryCard 
                      request={{
                        ...request,
                        type: 'Surplus',
                        date: new Date(request.created_at).toLocaleDateString(),
                        isLeave: false
                      }} 
                    />
                  </motion.div>
                ))
              ) : (
                <p className="text-sm text-muted-foreground">No pending surplus requests</p>
              )}
            </ScrollArea>
          </div>
        </div>
      </TabsContent>

      <TabsContent value="approved" className="mt-6 focus-visible:outline-none focus-visible:ring-0">
        <div className="grid gap-6 md:grid-cols-2">
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Approved Leaves</h3>
            <ScrollArea className="h-[300px] pr-4">
              {approvedLeaveRequests.length > 0 ? (
                approvedLeaveRequests.map((request, index) => (
                  <motion.div
                    key={request.id}
                    custom={index}
                    initial="hidden"
                    animate="visible"
                    variants={listItemVariants}
                  >
                    <RequestHistoryCard 
                      request={{
                        ...request,
                        type: request.type === 'sick' ? 'Sick Leave' : 'Vacation Leave',
                        date: new Date(request.created_at).toLocaleDateString(),
                        startDate: new Date(request.start_date).toLocaleDateString(),
                        endDate: new Date(request.end_date).toLocaleDateString(),
                        isLeave: true
                      }} 
                    />
                  </motion.div>
                ))
              ) : (
                <p className="text-sm text-muted-foreground">No approved leave requests</p>
              )}
            </ScrollArea>
          </div>
          
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Approved Surplus</h3>
            <ScrollArea className="h-[300px] pr-4">
              {approvedSurplusRequests.length > 0 ? (
                approvedSurplusRequests.map((request, index) => (
                  <motion.div
                    key={request.id}
                    custom={index}
                    initial="hidden"
                    animate="visible"
                    variants={listItemVariants}
                  >
                    <RequestHistoryCard 
                      request={{
                        ...request,
                        type: 'Surplus',
                        date: new Date(request.created_at).toLocaleDateString(),
                        isLeave: false
                      }} 
                    />
                  </motion.div>
                ))
              ) : (
                <p className="text-sm text-muted-foreground">No approved surplus requests</p>
              )}
            </ScrollArea>
          </div>
        </div>
      </TabsContent>
    </Tabs>
  )
}

/**
 * RequestHistoryCard Component
 * 
 * Displays a single request card with appropriate styling based on request type and status.
 * Implements hover animations for better user feedback.
 */
function RequestHistoryCard({ request }: { request: any }) {
  return (
    <motion.div 
      className="p-4 mb-4 bg-background rounded-lg border"
      whileHover={{ 
        scale: 1.02,
        boxShadow: "0 4px 12px rgba(0,0,0,0.05)",
        transition: { duration: 0.2 }
      }}
      transition={{ duration: 0.2 }}
    >
      <div className="flex justify-between items-start">
        <div>
          <p className="font-medium">{request.type}</p>
          <p className="text-sm text-muted-foreground">
            {request.date}
          </p>
        </div>
        <span className={`text-sm px-2 py-1 rounded-full ${
          request.status === 'approved' ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' : 
          request.status === 'rejected' ? 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400' : 
          'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400'
        }`}>
          {request.status}
        </span>
      </div>
      
      {/* Display different details based on request type */}
      {request.isLeave ? (
        <p className="mt-2 text-sm">
          Dates: {request.startDate} - {request.endDate}
        </p>
      ) : (
        <p className="mt-2 text-sm">
          Amount: ₱{Number(request.amount_requested || 0).toLocaleString()}
        </p>
      )}
      
      <p className="text-sm text-muted-foreground mt-1">Reason: {request.reason}</p>
    </motion.div>
  )
} 