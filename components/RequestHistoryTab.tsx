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
              {pendingLeaveRequests.map((request) => (
                <RequestHistoryCard key={request.id} request={request} />
              ))}
            </ScrollArea>
          </div>
          
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Surplus Requests</h3>
            <ScrollArea className="h-[300px] pr-4">
              {pendingSurplusRequests.map((request) => (
                <RequestHistoryCard key={request.id} request={request} />
              ))}
            </ScrollArea>
          </div>
        </div>
      </TabsContent>

      <TabsContent value="approved">
        <div className="grid gap-6 md:grid-cols-2">
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Approved Leaves</h3>
            <ScrollArea className="h-[300px] pr-4">
              {approvedLeaveRequests.map((request) => (
                <RequestHistoryCard key={request.id} request={request} />
              ))}
            </ScrollArea>
          </div>
          
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Approved Surplus</h3>
            <ScrollArea className="h-[300px] pr-4">
              {approvedSurplusRequests.map((request) => (
                <RequestHistoryCard key={request.id} request={request} />
              ))}
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
          <p className="font-medium">{request.type} Request</p>
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
      <p className="mt-2 text-sm">
        {request.type === 'Leave' 
          ? `Dates: ${request.startDate} - ${request.endDate}`
          : `Amount: ₱${request.amount.toLocaleString()}`
        }
      </p>
      <p className="text-sm text-muted-foreground mt-1">Reason: {request.reason}</p>
    </div>
  )
} 