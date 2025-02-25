//components/LeadPastorApprovalTab.tsx

"use client"

import { useState, useMemo } from "react"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ScrollArea } from "@/components/ui/scroll-area"
import { EmptyState } from "@/components/EmptyState"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Clock, CheckCircle, Filter, CalendarOff, WalletCards, Calendar } from "lucide-react"
import { Badge } from "@/components/ui/badge"
import { ApprovalTable } from "@/components/LeadPastorApprovalCard"
import { PaginationControls } from "@/components/PaginationControls"
import { Wallet } from "lucide-react"

type ApprovalStatus = 'approved' | 'pending' | 'rejected'

type ApprovalRequest = {
  id: string
  type: string
  startDate?: string
  endDate?: string
  amount?: number
  reason: string
  status: ApprovalStatus
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
  const [searchQuery, setSearchQuery] = useState('')
  const [activeRequestType, setActiveRequestType] = useState<'leave' | 'surplus'>('leave')
  const [currentPage, setCurrentPage] = useState(1)
  const [pageSize, setPageSize] = useState(10)
  
  const baseRequests = useMemo(() => {
    return activeRequestType === 'leave' ? 
      pendingLeaveApprovals : 
      pendingSurplusApprovals
  }, [activeRequestType, pendingLeaveApprovals, pendingSurplusApprovals])

  const filteredRequests = useMemo(() => {
    if (!searchQuery) return baseRequests
    
    const query = searchQuery.toLowerCase().trim()
    return baseRequests.filter(request => 
      request.requester?.full_name?.toLowerCase().includes(query) ||
      request.reason.toLowerCase().includes(query) ||
      request.campusDirectorNotes?.toLowerCase().includes(query)
    )
  }, [baseRequests, searchQuery])

  const totalPages = Math.ceil(filteredRequests.length / pageSize)
  const startIdx = (currentPage - 1) * pageSize
  const endIdx = startIdx + pageSize
  const paginatedRequests = filteredRequests.slice(startIdx, endIdx)

  return (
    <div className="lg:ml-0 pl-0 pr-0 pt-0">
      <div className="flex flex-col sm:flex-row justify-between gap-1 mb-4">
        <div className="flex gap-2">
          <Tabs value={activeRequestType} onValueChange={(v) => {
            setActiveRequestType(v as 'leave' | 'surplus')
            setCurrentPage(1)
          }}>
            <TabsList className="h-9">
              <TabsTrigger value="leave" className="flex gap-1 px-3 text-sm">
                <Calendar className="h-4 w-4" /> 
                Leaves
              </TabsTrigger>
              <TabsTrigger value="surplus" className="flex gap-1 px-3 text-sm">
                <Wallet className="h-4 w-4" /> 
                Surplus
              </TabsTrigger>
            </TabsList>
          </Tabs>
        </div>

        <div className="flex gap-1 items-center">
          <Input 
            placeholder="Search..." 
            className="max-w-[180px] h-7 text-xs"
            value={searchQuery}
            onChange={(e) => {
              setSearchQuery(e.target.value)
              setCurrentPage(1)
            }}
          />
          <Button variant="outline" size="sm" className="h-7">
            <Filter className="h-3 w-3" />
          </Button>
        </div>
      </div>

      <ApprovalTable
        requests={paginatedRequests}
        requestType={activeRequestType}
        approvalStatus="pending"
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
        pageSize={pageSize}
        onPageSizeChange={setPageSize}
        className="mt-2"
      />
    </div>
  )
}

function SectionHeader({ title, count }: { title: string; count: number }) {
  return (
    <div className="flex items-center gap-3">
      <h3 className="text-lg font-semibold">{title}</h3>
      <Badge variant="outline" className="px-2 py-1 text-sm">
        {count} requests
      </Badge>
    </div>
  )
}

interface RequestGridProps {
  requests: ApprovalRequest[];
  type: 'leave' | 'surplus';
  isApproved?: boolean;
}

function RequestGrid({ requests, type, isApproved = false }: RequestGridProps) {
  if (requests.length === 0) {
    return (
      <EmptyState
        icon={type === 'leave' ? <CalendarOff className="w-8 h-8" /> : <WalletCards className="w-8 h-8" />}
        title={`No ${isApproved ? 'approved' : 'pending'} ${type} requests`}
        description={`All ${type} requests will appear here when ${isApproved ? 'approved' : 'submitted'}`}
      />
    )
  }

  return (
    <ScrollArea className="h-[600px] rounded-md border">
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 p-4">
        {requests.map((request) => (
          <LeadPastorApprovalCard
            key={`${type}-${request.id}`}
            request={request}
            requestType={type}
            isApproved={isApproved}
          />
        ))}
      </div>
    </ScrollArea>
  )
}

export default LeadPastorApprovalTab

