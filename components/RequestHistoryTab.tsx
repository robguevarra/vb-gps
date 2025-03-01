"use client"

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ScrollArea } from "@/components/ui/scroll-area"

interface RequestHistoryTabProps {
  pendingLeaveRequests: any[]
  approvedLeaveRequests: any[]
  pendingSurplusRequests: any[]
  approvedSurplusRequests: any[]
}

export function RequestHistoryTab({
  pendingLeaveRequests,
  approvedLeaveRequests,
  pendingSurplusRequests,
  approvedSurplusRequests,
}: RequestHistoryTabProps) {
  return (
    <Tabs defaultValue="pending" className="w-full">
      <TabsList className="grid w-full grid-cols-2">
        <TabsTrigger value="pending">Pending</TabsTrigger>
        <TabsTrigger value="approved">Approved</TabsTrigger>
      </TabsList>

      <TabsContent value="pending">
        <div className="grid gap-6 md:grid-cols-2">
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Leave Requests</h3>
            <ScrollArea className="h-[300px] pr-4">
              {pendingLeaveRequests.length > 0 ? (
                pendingLeaveRequests.map((request) => (
                  <RequestHistoryCard 
                    key={request.id} 
                    request={{
                      ...request,
                      type: request.type === 'sick' ? 'Sick Leave' : 'Vacation Leave',
                      date: new Date(request.created_at).toLocaleDateString(),
                      startDate: new Date(request.start_date).toLocaleDateString(),
                      endDate: new Date(request.end_date).toLocaleDateString(),
                      isLeave: true
                    }} 
                  />
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
                pendingSurplusRequests.map((request) => (
                  <RequestHistoryCard 
                    key={request.id} 
                    request={{
                      ...request,
                      type: 'Surplus',
                      date: new Date(request.created_at).toLocaleDateString(),
                      isLeave: false
                    }} 
                  />
                ))
              ) : (
                <p className="text-sm text-muted-foreground">No pending surplus requests</p>
              )}
            </ScrollArea>
          </div>
        </div>
      </TabsContent>

      <TabsContent value="approved">
        <div className="grid gap-6 md:grid-cols-2">
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Approved Leaves</h3>
            <ScrollArea className="h-[300px] pr-4">
              {approvedLeaveRequests.length > 0 ? (
                approvedLeaveRequests.map((request) => (
                  <RequestHistoryCard 
                    key={request.id} 
                    request={{
                      ...request,
                      type: request.type === 'sick' ? 'Sick Leave' : 'Vacation Leave',
                      date: new Date(request.created_at).toLocaleDateString(),
                      startDate: new Date(request.start_date).toLocaleDateString(),
                      endDate: new Date(request.end_date).toLocaleDateString(),
                      isLeave: true
                    }} 
                  />
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
                approvedSurplusRequests.map((request) => (
                  <RequestHistoryCard 
                    key={request.id} 
                    request={{
                      ...request,
                      type: 'Surplus',
                      date: new Date(request.created_at).toLocaleDateString(),
                      isLeave: false
                    }} 
                  />
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

function RequestHistoryCard({ request }: { request: any }) {
  return (
    <div className="p-4 mb-4 bg-background rounded-lg border">
      <div className="flex justify-between items-start">
        <div>
          <p className="font-medium">{request.type}</p>
          <p className="text-sm text-muted-foreground">
            {request.date}
          </p>
        </div>
        <span className={`text-sm ${
          request.status === 'approved' ? 'text-green-600' : 
          request.status === 'rejected' ? 'text-red-600' : 'text-yellow-600'
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
    </div>
  )
} 