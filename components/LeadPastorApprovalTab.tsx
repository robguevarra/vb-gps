//components/LeadPastorApprovalTab.tsx

"use client"

import { useState, useMemo } from "react"
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Filter, Calendar } from "lucide-react"
import { ApprovalTable } from "@/components/LeadPastorApprovalCard"
import { Wallet } from "lucide-react"
import { ApprovalRequest } from "@/types/approval"

const LeadPastorApprovalTab = ({
  pendingLeaveApprovals,
  pendingSurplusApprovals,
}: {
  pendingLeaveApprovals: ApprovalRequest[]
  pendingSurplusApprovals: ApprovalRequest[]
}) => {
  const [searchQuery, setSearchQuery] = useState('')
  const [activeRequestType, setActiveRequestType] = useState<'leave' | 'surplus'>('leave')
  
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

  return (
    <div className="lg:ml-0 pl-0 pr-0 pt-0">
      <div className="flex flex-col sm:flex-row justify-between gap-1 mb-4">
        <div className="flex gap-2">
          <Tabs value={activeRequestType} onValueChange={(v) => {
            setActiveRequestType(v as 'leave' | 'surplus')
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
            }}
          />
          <Button variant="outline" size="sm" className="h-7">
            <Filter className="h-3 w-3" />
          </Button>
        </div>
      </div>

      <ApprovalTable
        requests={filteredRequests}
        requestType={activeRequestType}
        approvalStatus="pending"
      />
    </div>
  )
}

export default LeadPastorApprovalTab

