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
import { Clock, CheckCircle, Filter, CalendarOff, WalletCards, Calendar, Wallet, Search, X, AlertCircle } from "lucide-react"
import { Badge } from "@/components/ui/badge"
import { ApprovalTable } from "@/components/LeadPastorApprovalCard"
import { PaginationControls } from "@/components/PaginationControls"
import { 
  Popover,
  PopoverContent,
  PopoverTrigger
} from "@/components/ui/popover"
import { motion, AnimatePresence } from "framer-motion"

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
    <div className="w-full bg-white dark:bg-gray-900 rounded-lg shadow-sm border overflow-hidden">
      {/* Header section with improved mobile layout */}
      <div className="p-4 sm:p-5 border-b bg-gradient-to-r from-blue-50 to-white dark:from-gray-800 dark:to-gray-900">
        <h2 className="text-xl font-semibold text-[#00458d] dark:text-white mb-1">Approval Requests</h2>
        <p className="text-sm text-gray-500 dark:text-gray-400">Review and manage approval requests from your team</p>
      </div>

      <div className="p-4 sm:p-5 space-y-4">
        {/* Tabs and controls with improved responsive layout */}
        <div className="flex flex-col sm:flex-row justify-between gap-3 sm:items-center">
          <div className="flex-shrink-0">
            <Tabs 
              value={activeRequestType} 
              onValueChange={(v) => {
                setActiveRequestType(v as 'leave' | 'surplus')
                setCurrentPage(1)
              }}
              className="w-full sm:w-auto"
            >
              <TabsList className="h-10 w-full sm:w-auto grid grid-cols-2 sm:flex bg-blue-50 dark:bg-gray-800 p-1">
                <TabsTrigger 
                  value="leave" 
                  className="flex gap-1.5 px-3 py-2 text-sm data-[state=active]:bg-white dark:data-[state=active]:bg-gray-700 data-[state=active]:text-[#00458d] dark:data-[state=active]:text-white rounded-md transition-all"
                >
                  <Calendar className="h-4 w-4" /> 
                  <span>Leave Requests</span>
                </TabsTrigger>
                <TabsTrigger 
                  value="surplus" 
                  className="flex gap-1.5 px-3 py-2 text-sm data-[state=active]:bg-white dark:data-[state=active]:bg-gray-700 data-[state=active]:text-[#00458d] dark:data-[state=active]:text-white rounded-md transition-all"
                >
                  <Wallet className="h-4 w-4" /> 
                  <span>Surplus Requests</span>
                </TabsTrigger>
              </TabsList>
            </Tabs>
          </div>

          <div className="flex items-center gap-2 mt-3 sm:mt-0">
            <AnimatePresence mode="wait">
              {isSearchOpen ? (
                <motion.div 
                  className="relative flex-1 w-full sm:w-auto sm:min-w-[250px]"
                  initial={{ opacity: 0, width: 0 }}
                  animate={{ opacity: 1, width: "100%" }}
                  exit={{ opacity: 0, width: 0 }}
                  transition={{ duration: 0.2 }}
                >
                  <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                  <Input 
                    placeholder="Search by name or reason..." 
                    className="pl-9 pr-9 h-10 text-sm w-full border-blue-100 dark:border-gray-700 focus-visible:ring-blue-400"
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
                      className="absolute right-1 top-1/2 transform -translate-y-1/2 h-8 w-8 p-0"
                      onClick={clearSearch}
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  )}
                </motion.div>
              ) : (
                <motion.div
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  exit={{ opacity: 0 }}
                >
                  <Button 
                    variant="outline" 
                    size="sm" 
                    className="h-10 border-blue-100 dark:border-gray-700 hover:bg-blue-50 dark:hover:bg-gray-800"
                    onClick={() => setIsSearchOpen(true)}
                  >
                    <Search className="h-4 w-4 mr-2" />
                    <span>Search</span>
                  </Button>
                </motion.div>
              )}
            </AnimatePresence>
            
            <Popover>
              <PopoverTrigger asChild>
                <Button 
                  variant="outline" 
                  size="sm" 
                  className="h-10 border-blue-100 dark:border-gray-700 hover:bg-blue-50 dark:hover:bg-gray-800"
                >
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
                      <Button size="sm" variant="outline" className="text-xs h-8">All</Button>
                      <Button size="sm" variant="outline" className="text-xs h-8 bg-blue-50">CD Approved</Button>
                      <Button size="sm" variant="outline" className="text-xs h-8">CD Rejected</Button>
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

        {/* Request count summary */}
        <div className="flex flex-wrap gap-3 items-center">
          <Badge variant="outline" className="px-2.5 py-1 bg-blue-50 dark:bg-gray-800 text-blue-700 dark:text-blue-300 border-blue-200 dark:border-gray-700">
            <Clock className="h-3.5 w-3.5 mr-1.5" />
            Pending: {filteredRequests.length}
          </Badge>
          
          {searchQuery && (
            <Badge variant="outline" className="px-2.5 py-1 bg-amber-50 dark:bg-amber-900/20 text-amber-700 dark:text-amber-300 border-amber-200 dark:border-amber-900/30">
              <Search className="h-3.5 w-3.5 mr-1.5" />
              Search results: {filteredRequests.length}
              <Button 
                variant="ghost" 
                size="sm" 
                className="h-5 ml-1.5 text-xs p-0"
                onClick={clearSearch}
              >
                <X className="h-3.5 w-3.5" />
              </Button>
            </Badge>
          )}
        </div>

        {/* Empty state with improved styling */}
        {filteredRequests.length === 0 && (
          <div className="bg-gray-50 dark:bg-gray-800/50 rounded-lg p-8 text-center my-6">
            <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-blue-100 dark:bg-blue-900/30">
              <AlertCircle className="h-6 w-6 text-blue-600 dark:text-blue-400" />
            </div>
            <h3 className="mt-4 text-base font-medium text-gray-900 dark:text-gray-100">No requests found</h3>
            <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">
              {searchQuery 
                ? "No results match your search criteria. Try a different search term." 
                : `There are no pending ${activeRequestType} requests to review at this time.`}
            </p>
            {searchQuery && (
              <Button 
                variant="outline" 
                size="sm" 
                className="mt-4"
                onClick={clearSearch}
              >
                Clear search
              </Button>
            )}
          </div>
        )}

        {/* Table with improved styling */}
        {filteredRequests.length > 0 && (
          <div className="mt-2 overflow-hidden rounded-lg border border-gray-200 dark:border-gray-800">
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
        )}
      </div>
    </div>
  )
}

function SectionHeader({ title, count }: { title: string; count: number }) {
  return (
    <div className="flex items-center justify-between mb-3">
      <h3 className="text-lg font-medium">{title}</h3>
      <Badge variant="secondary">{count}</Badge>
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
      <div className="text-center py-8">
        <p className="text-muted-foreground">No {type} requests found</p>
      </div>
    )
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      {requests.map((request) => (
        <div key={request.id} className="border rounded-lg p-4 hover:shadow-md transition-shadow">
          <div className="flex justify-between items-start mb-2">
            <div>
              <h4 className="font-medium">{request.requester?.full_name}</h4>
              <p className="text-sm text-muted-foreground">{request.date}</p>
            </div>
            <Badge className={statusStyles[request.status]}>{request.status}</Badge>
          </div>
          <p className="text-sm mb-3 line-clamp-2">{request.reason}</p>
          <div className="flex justify-between items-center">
            <div className="flex items-center gap-1">
              {type === 'leave' ? (
                <CalendarOff className="h-4 w-4 text-blue-500" />
              ) : (
                <WalletCards className="h-4 w-4 text-green-500" />
              )}
              <span className="text-xs">
                {type === 'leave' 
                  ? `${request.startDate} - ${request.endDate}` 
                  : `₱${request.amount}`}
              </span>
            </div>
            <Button variant="ghost" size="sm" className="h-7 text-xs">View</Button>
          </div>
        </div>
      ))}
    </div>
  )
}

export default LeadPastorApprovalTab

