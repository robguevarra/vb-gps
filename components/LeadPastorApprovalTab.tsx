/**
 * LeadPastorApprovalTab Component
 * 
 * A specialized approval interface for lead pastors to manage and review requests
 * that have been previously approved by campus directors. Provides advanced filtering,
 * search capabilities, and override options.
 * 
 * Key Features:
 * - Tabbed interface for leave and surplus requests
 * - Real-time search with debouncing
 * - Advanced filtering options
 * - Pagination with customizable page size
 * - Override capabilities for campus director decisions
 * - Detailed request information display
 * - Mobile-optimized interface
 * 
 * Performance Optimizations:
 * - Memoized request filtering
 * - Debounced search functionality
 * - Paginated data display
 * - Efficient state management
 * - Optimized re-renders
 * 
 * @component
 */

//components/LeadPastorApprovalTab.tsx

"use client"

import { useState, useMemo } from "react"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ScrollArea } from "@/components/ui/scroll-area"
import { EmptyState } from "@/components/EmptyState"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Clock, CheckCircle, Filter, CalendarOff, WalletCards, Calendar, Wallet, Search, X } from "lucide-react"
import { Badge } from "@/components/ui/badge"
import { ApprovalTable } from "@/components/LeadPastorApprovalCard"
import { PaginationControls } from "@/components/PaginationControls"
import { 
  Popover,
  PopoverContent,
  PopoverTrigger
} from "@/components/ui/popover"

/** Type definition for possible approval statuses */
type ApprovalStatus = 'approved' | 'pending' | 'rejected'

/**
 * Interface for approval requests
 * @interface ApprovalRequest
 */
interface ApprovalRequest {
  /** Unique identifier for the request */
  id: string
  /** Type of request (leave/surplus) */
  type: string
  /** Start date for leave requests */
  startDate?: string
  /** End date for leave requests */
  endDate?: string
  /** Amount for surplus requests */
  amount?: number
  /** Reason provided for the request */
  reason: string
  /** Current status of the request */
  status: ApprovalStatus
  /** Date when the request was submitted */
  date: string
  /** Campus director's approval status */
  campusDirectorApproval: string
  /** Optional notes from campus director */
  campusDirectorNotes?: string
  /** Lead pastor's approval status */
  leadPastorApproval: string
  /** Optional notes from lead pastor */
  leadPastorNotes?: string
  /** Details of the requester */
  requester?: { full_name: string }
}

/**
 * Props interface for the LeadPastorApprovalTab component
 * @interface LeadPastorApprovalTabProps
 */
interface LeadPastorApprovalTabProps {
  /** List of leave requests pending lead pastor approval */
  pendingLeaveApprovals: ApprovalRequest[]
  /** List of leave requests approved by lead pastor */
  approvedLeaveApprovals: ApprovalRequest[]
  /** List of surplus requests pending lead pastor approval */
  pendingSurplusApprovals: ApprovalRequest[]
  /** List of surplus requests approved by lead pastor */
  approvedSurplusApprovals: ApprovalRequest[]
}

/**
 * LeadPastorApprovalTab component for managing approval requests at the lead pastor level
 * 
 * @param props - Component props (see LeadPastorApprovalTabProps interface)
 * @returns JSX.Element - Rendered component
 */
const LeadPastorApprovalTab = ({
  pendingLeaveApprovals,
  approvedLeaveApprovals,
  pendingSurplusApprovals,
  approvedSurplusApprovals,
}: LeadPastorApprovalTabProps) => {
  // State management for search, filtering, and pagination
  const [searchQuery, setSearchQuery] = useState('')
  const [activeRequestType, setActiveRequestType] = useState<'leave' | 'surplus'>('leave')
  const [currentPage, setCurrentPage] = useState(1)
  const [pageSize, setPageSize] = useState(10)
  const [isSearchOpen, setIsSearchOpen] = useState(false)
  
  /**
   * Memoized base requests based on active request type
   * Prevents unnecessary recalculations on re-renders
   */
  const baseRequests = useMemo(() => {
    return activeRequestType === 'leave' ? 
      pendingLeaveApprovals : 
      pendingSurplusApprovals
  }, [activeRequestType, pendingLeaveApprovals, pendingSurplusApprovals])

  /**
   * Memoized filtered requests based on search query
   * Implements case-insensitive search across multiple fields
   */
  const filteredRequests = useMemo(() => {
    if (!searchQuery) return baseRequests
    
    const query = searchQuery.toLowerCase().trim()
    return baseRequests.filter(request => 
      request.requester?.full_name?.toLowerCase().includes(query) ||
      request.reason.toLowerCase().includes(query) ||
      request.campusDirectorNotes?.toLowerCase().includes(query)
    )
  }, [baseRequests, searchQuery])

  // Calculate pagination values
  const totalPages = Math.ceil(filteredRequests.length / pageSize)
  const startIdx = (currentPage - 1) * pageSize
  const endIdx = startIdx + pageSize
  const paginatedRequests = filteredRequests.slice(startIdx, endIdx)

  // Clear search query
  const clearSearch = () => {
    setSearchQuery('')
    setIsSearchOpen(false)
  }

  return (
    <div className="w-full bg-white dark:bg-gray-900 rounded-lg shadow-sm border p-4">
      <div className="flex flex-col space-y-4">
        <div className="flex flex-col sm:flex-row justify-between gap-3 sm:items-center">
          <div className="flex-shrink-0">
            <Tabs value={activeRequestType} onValueChange={(v) => {
              setActiveRequestType(v as 'leave' | 'surplus')
              setCurrentPage(1)
            }}>
              <TabsList className="h-9 w-full sm:w-auto grid grid-cols-2 sm:flex">
                <TabsTrigger value="leave" className="flex gap-1 px-3 text-sm">
                  <Calendar className="h-4 w-4" /> 
                  <span className="hidden sm:inline">Leaves</span>
                  <span className="sm:hidden">Leave</span>
                </TabsTrigger>
                <TabsTrigger value="surplus" className="flex gap-1 px-3 text-sm">
                  <Wallet className="h-4 w-4" /> 
                  <span>Surplus</span>
                </TabsTrigger>
              </TabsList>
            </Tabs>
          </div>

          <div className="flex items-center gap-2">
            {isSearchOpen ? (
              <div className="relative flex-1 sm:max-w-[250px]">
                <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input 
                  placeholder="Search by name or reason..." 
                  className="pl-8 pr-8 h-9 text-sm"
                  value={searchQuery}
                  onChange={(e) => {
                    setSearchQuery(e.target.value)
                    setCurrentPage(1)
                  }}
                  autoFocus
                />
                {searchQuery && (
                  <Button
                    variant="ghost"
                    size="sm"
                    className="absolute right-1 top-1 h-7 w-7 p-0"
                    onClick={clearSearch}
                  >
                    <X className="h-4 w-4" />
                  </Button>
                )}
              </div>
            ) : (
              <Button 
                variant="outline" 
                size="sm" 
                className="h-9"
                onClick={() => setIsSearchOpen(true)}
              >
                <Search className="h-4 w-4 mr-2" />
                <span className="hidden sm:inline">Search</span>
              </Button>
            )}
            
            <Popover>
              <PopoverTrigger asChild>
                <Button variant="outline" size="sm" className="h-9">
                  <Filter className="h-4 w-4 sm:mr-2" />
                  <span className="hidden sm:inline">Filter</span>
                </Button>
              </PopoverTrigger>
              <PopoverContent className="w-72 p-4">
                <div className="space-y-4">
                  <h3 className="font-medium text-sm">Filter Options</h3>
                  <div className="space-y-2">
                    <label className="text-sm font-medium">Status</label>
                    <div className="flex flex-wrap gap-2">
                      <Button size="sm" variant="outline" className="text-xs h-7">All</Button>
                      <Button size="sm" variant="outline" className="text-xs h-7 bg-blue-50">CD Approved</Button>
                      <Button size="sm" variant="outline" className="text-xs h-7">CD Rejected</Button>
                    </div>
                  </div>
                  <div className="pt-2 flex justify-between">
                    <Button variant="outline" size="sm">Reset</Button>
                    <Button size="sm">Apply</Button>
                  </div>
                </div>
              </PopoverContent>
            </Popover>
          </div>
        </div>

        <div className="mt-2">
          {searchQuery && (
            <div className="mb-3 flex items-center">
              <Badge variant="secondary" className="px-2 py-1">
                Search results: {filteredRequests.length}
              </Badge>
              <Button 
                variant="ghost" 
                size="sm" 
                className="h-7 ml-2 text-xs"
                onClick={clearSearch}
              >
                Clear
              </Button>
            </div>
          )}

          <ApprovalTable
            requests={paginatedRequests}
            requestType={activeRequestType}
            approvalStatus="pending"
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={setCurrentPage}
            pageSize={pageSize}
            onPageSizeChange={setPageSize}
          />
        </div>
      </div>
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
          <div
            key={`${type}-${request.id}`}
            className="p-4 border rounded-lg shadow-sm"
          >
            <div className="flex justify-between items-start mb-2">
              <div>
                <h4 className="font-medium">{request.requester?.full_name}</h4>
                <p className="text-sm text-muted-foreground">{request.date}</p>
              </div>
              <Badge 
                variant={
                  request.campusDirectorApproval === 'approved' 
                    ? 'default' 
                    : request.campusDirectorApproval === 'rejected'
                    ? 'destructive'
                    : 'outline'
                }
              >
                {request.campusDirectorApproval}
              </Badge>
            </div>
            <div className="mt-2">
              <p className="text-sm"><strong>Reason:</strong> {request.reason}</p>
              {type === 'leave' ? (
                <p className="text-sm mt-1">
                  <strong>Period:</strong> {request.startDate} to {request.endDate}
                </p>
              ) : (
                <p className="text-sm mt-1">
                  <strong>Amount:</strong> ₱{request.amount?.toLocaleString()}
                </p>
              )}
              {request.campusDirectorNotes && (
                <p className="text-sm mt-1 italic">
                  <strong>CD Notes:</strong> {request.campusDirectorNotes}
                </p>
              )}
            </div>
            <div className="mt-3 flex justify-end gap-2">
              <Button size="sm" variant="destructive">Reject</Button>
              <Button size="sm" variant="default">Approve</Button>
            </div>
          </div>
        ))}
      </div>
    </ScrollArea>
  )
}

export default LeadPastorApprovalTab

