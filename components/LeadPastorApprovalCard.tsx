//components/LeadPastorApprovalCard.tsx

"use client"

import { useState, useMemo, useEffect } from "react"
import { createClient } from "@/utils/supabase/client"
import { useRouter } from "next/navigation"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback } from "@/components/ui/avatar"
import {Tooltip, TooltipContent, TooltipTrigger} from "@/components/ui/tooltip"
import { ChevronRight, Check, X, ArrowRightLeft, CalendarDays, FileText, User, Wallet, MoreVertical, CheckCircle2, XCircle, AlertCircle, Clock, Loader2 } from "lucide-react"
import { cn } from "@/lib/utils"
import { Progress } from "@/components/ui/progress"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu"
import { format } from "date-fns"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { PaginationControls } from "@/components/PaginationControls"
import { debounce } from "lodash"
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
  DialogTrigger,
} from "@/components/ui/dialog"
import { toast } from "@/hooks/use-toast"

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

const statusStyles = {
  approved: "bg-green-100 text-green-800",
  pending: "bg-yellow-100 text-yellow-800",
  rejected: "bg-red-100 text-red-800"
}

const ApprovalTableRow = ({ request, requestType, approvalStatus }: { request: ApprovalRequest, requestType: 'leave' | 'surplus', approvalStatus: 'pending' | 'approved' }) => {
  const [isExpanded, setIsExpanded] = useState(false)
  const [localNotes, setLocalNotes] = useState(request.leadPastorNotes || '')
  const router = useRouter()
  const supabase = createClient()
  const [isConfirming, setIsConfirming] = useState(false)
  const [pendingAction, setPendingAction] = useState<"approve" | "reject" | "override">()
  const [overrideType, setOverrideType] = useState<"approve" | "reject">("approve")
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [modalNotes, setModalNotes] = useState("")

  const handleStatusUpdate = async (newStatus: string, action: "approve" | "reject" | "override" = "approve") => {
    setIsSubmitting(true)
    try {
      const tableName = requestType === 'leave' ? 'leave_requests' : 'surplus_requests'
      
      // Always update the lead_pastor_approval field and status
      const updateData = {
        lead_pastor_approval: newStatus,
        // For both missionaries and campus directors, Lead Pastor has final say
        // so we can update the status directly
        status: newStatus === 'approved' ? 'approved' : 'rejected',
        // Include the notes from the modal
        lead_pastor_notes: modalNotes
      };
      
      const { error } = await supabase
        .from(tableName)
        .update(updateData)
        .eq('id', request.id)

      if (error) throw error

      // Customize toast message based on the action
      let toastMessage = "";
      if (action === "override") {
        const cdDecision = request.campusDirectorApproval === 'approved' ? 'approval' : 
                          request.campusDirectorApproval === 'rejected' ? 'rejection' : 'decision';
        const lpAction = newStatus === 'approved' ? 'approved' : 'rejected';
        
        toastMessage = `Request ${lpAction} (Campus Director ${cdDecision} overridden)`;
      } else {
        toastMessage = `Request ${newStatus === 'approved' ? 'approved' : 'rejected'} successfully`;
      }

      toast({
        title: "Success!",
        description: toastMessage,
        variant: "success"
      })
      
      // Update local notes state to match what was saved
      setLocalNotes(modalNotes)
      
      router.refresh()
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to update request status",
        variant: "destructive"
      })
    } finally {
      setIsSubmitting(false)
      setIsConfirming(false)
    }
  }

  const saveNotes = useMemo(() => {
    return debounce(async (notes: string) => {
      const { error } = await supabase
        .from(requestType === 'leave' ? 'leave_requests' : 'surplus_requests')
        .update({ lead_pastor_notes: notes })
        .eq('id', request.id)

      if (!error) {
        router.refresh()
      }
    }, 500)
  }, [request.id, requestType])

  const handleNotesChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    const newNotes = e.target.value
    setLocalNotes(newNotes)
    saveNotes(newNotes)
  }

  useEffect(() => {
    return () => saveNotes.cancel()
  }, [saveNotes])

  return (
    <>
      <TableRow 
        className="hover:bg-gray-50 cursor-pointer group"
        onClick={() => setIsExpanded(!isExpanded)}
      >
        <TableCell className="px-3 py-3">
          <div className="flex items-center gap-3">
            <Avatar className="h-9 w-9">
              <AvatarFallback className="bg-blue-100 text-blue-800">
                {request.requester?.full_name?.[0] || "U"}
              </AvatarFallback>
            </Avatar>
            <div className="flex-1">
              <p className="font-medium">{request.requester?.full_name || "Unknown"}</p>
              <p className="text-sm text-muted-foreground">
                {format(new Date(request.date), 'MMM dd, yyyy')}
              </p>
            </div>
            <ChevronRight className={cn(
              "w-4 h-4 text-muted-foreground transform transition-transform",
              isExpanded ? "rotate-90" : "rotate-0"
            )} />
          </div>
        </TableCell>

        <TableCell className="px-3 py-3">
          <div className="flex items-center gap-2">
            <Badge 
              variant={
                request.campusDirectorApproval === 'approved' 
                  ? 'default' 
                  : request.campusDirectorApproval === 'rejected'
                  ? 'destructive'
                  : 'outline'
              }
              className="capitalize"
            >
              {request.campusDirectorApproval || 'pending'}
            </Badge>
            {request.campusDirectorNotes && (
              <Tooltip>
                <TooltipTrigger>
                  <FileText className="w-4 h-4 text-muted-foreground" />
                </TooltipTrigger>
                <TooltipContent>
                  <p className="max-w-xs">{request.campusDirectorNotes}</p>
                </TooltipContent>
              </Tooltip>
            )}
          </div>
        </TableCell>

        <TableCell className="px-3 py-3">
          <div className="flex items-center gap-2">
            {requestType === 'leave' ? (
              <>
                <CalendarDays className="w-4 h-4 text-blue-600" />
                <span className="text-sm">
                  {format(new Date(request.startDate || new Date()), 'MMM dd')} - 
                  {format(new Date(request.endDate || new Date()), 'MMM dd')}
                </span>
              </>
            ) : (
              <>
                <Wallet className="w-4 h-4 text-green-600" />
                <span className="text-sm">₱{request.amount?.toLocaleString()}</span>
              </>
            )}
          </div>
        </TableCell>

        <TableCell className="px-3 py-3">
          <div className="flex gap-2 items-center">
            <span className="text-muted-foreground text-sm">Click for details</span>
            <div className="flex gap-2">
              {approvalStatus === 'pending' && (
                <>
                  <div className="flex gap-2">
                    {/* Only enable regular approve button if CD has approved or not acted yet */}
                    <Button 
                      variant="default" 
                      className={`${request.campusDirectorApproval === 'rejected' ? 'opacity-50 cursor-not-allowed' : 'bg-green-600 hover:bg-green-700'} text-white h-8`}
                      onClick={(e) => {
                        e.stopPropagation()
                        setPendingAction('approve')
                        setIsConfirming(true)
                      }}
                      disabled={request.campusDirectorApproval === 'rejected'}
                      title={request.campusDirectorApproval === 'rejected' ? "Cannot approve - Campus Director rejected this request" : ""}
                    >
                      <Check className="w-4 h-4 mr-1" />
                      Approve
                    </Button>

                    {/* Always allow reject button */}
                    <Button
                      variant="destructive"
                      size="sm"
                      onClick={(e) => {
                        e.stopPropagation()
                        setPendingAction('reject')
                        setIsConfirming(true)
                      }}
                      className="h-8"
                      title={request.campusDirectorApproval === 'rejected' ? "Confirm Campus Director's rejection" : "Reject this request"}
                    >
                      <X className="w-4 h-4 mr-1" />
                      Reject
                    </Button>
                  </div>

                  <div className={`border-l pl-2 ml-1 ${request.campusDirectorApproval === 'rejected' ? 'border-amber-500' : ''}`}>
                    <DropdownMenu>
                      <Tooltip>
                        <TooltipTrigger asChild>
                          <DropdownMenuTrigger asChild>
                            <Button
                              variant={request.campusDirectorApproval === 'rejected' ? 'default' : 'outline'}
                              size="sm"
                              className={`h-8 gap-1 ${request.campusDirectorApproval === 'rejected' ? 'bg-amber-600 hover:bg-amber-700 text-white animate-pulse' : 'border-dashed'}`}
                            >
                              <ArrowRightLeft className="w-4 h-4" />
                              <span>{request.campusDirectorApproval === 'rejected' ? 'Override Required' : 'Override'}</span>
                            </Button>
                          </DropdownMenuTrigger>
                        </TooltipTrigger>
                        <TooltipContent>
                          <p>{request.campusDirectorApproval === 'rejected' 
                            ? 'Campus Director rejected this request - you must use override to approve it' 
                            : 'Override campus director decision'}</p>
                        </TooltipContent>
                      </Tooltip>
                      <DropdownMenuContent>
                        <DropdownMenuItem
                          onClick={(e) => {
                            e.stopPropagation();
                            setPendingAction('override');
                            setOverrideType('approve');
                            setIsConfirming(true);
                          }}
                          className="flex items-center gap-2 cursor-pointer"
                        >
                          <CheckCircle2 className="w-4 h-4 text-green-600" />
                          <span>Approve (Override CD)</span>
                        </DropdownMenuItem>
                        <DropdownMenuItem
                          onClick={(e) => {
                            e.stopPropagation();
                            setPendingAction('override');
                            setOverrideType('reject');
                            setIsConfirming(true);
                          }}
                          className="flex items-center gap-2 cursor-pointer"
                        >
                          <XCircle className="w-4 h-4 text-red-600" />
                          <span>Reject (Override CD)</span>
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>
                </>
              )}

              <Dialog open={isConfirming} onOpenChange={(open) => {
                setIsConfirming(open);
                if (open) {
                  // Initialize modal notes with existing notes when opening
                  setModalNotes(localNotes);
                }
              }}>
                <DialogContent className="max-w-md">
                  <DialogHeader>
                    <DialogTitle>
                      {pendingAction === 'approve' ? 'Approve Request' : 
                       pendingAction === 'reject' ? 'Reject Request' : 
                       'Override Campus Director Decision'}
                    </DialogTitle>
                    <DialogDescription>
                      {pendingAction === 'override' ? (
                        <>
                          <span className={`font-medium ${overrideType === 'approve' ? 'text-amber-600' : 'text-red-600'}`}>
                            You are about to override a Campus Director's {request.campusDirectorApproval === 'rejected' ? 'rejection' : 'decision'} with {overrideType === 'approve' ? 'approval' : 'rejection'}.
                          </span>
                          {request.campusDirectorApproval === 'rejected' && overrideType === 'approve' && (
                            <p className="mt-2 text-sm">
                              Note: The Campus Director rejected this request. Your override will approve it despite their rejection.
                            </p>
                          )}
                        </>
                      ) : pendingAction === 'reject' && request.campusDirectorApproval === 'rejected' ? (
                        <span>
                          You are confirming the Campus Director's rejection of this request.
                        </span>
                      ) : (
                        <>Are you sure you want to {pendingAction} this request?</>
                      )}
                    </DialogDescription>
                  </DialogHeader>
                  
                  <div className="space-y-4 py-4">
                    <div className="space-y-2">
                      <h4 className="text-sm font-medium">Request Details</h4>
                      <div className="rounded-md bg-muted p-3">
                        <p className="text-sm">{request.reason}</p>
                      </div>
                    </div>
                    
                    <div className="space-y-2">
                      <h4 className="text-sm font-medium">Campus Director Status</h4>
                      <div className="rounded-md bg-muted p-3 flex items-center gap-2">
                        <Badge 
                          variant={
                            request.campusDirectorApproval === 'approved' 
                              ? 'default' 
                              : request.campusDirectorApproval === 'rejected'
                              ? 'destructive'
                              : 'outline'
                          }
                          className="capitalize"
                        >
                          {request.campusDirectorApproval || 'pending'}
                        </Badge>
                        <span className="text-sm text-muted-foreground">
                          {request.campusDirectorApproval === 'approved' 
                            ? 'Campus Director has approved this request' 
                            : request.campusDirectorApproval === 'rejected'
                            ? 'Campus Director has rejected this request'
                            : 'Campus Director has not reviewed this request yet'}
                        </span>
                      </div>
                    </div>
                    
                    {request.campusDirectorNotes && (
                      <div className="space-y-2">
                        <h4 className="text-sm font-medium">Campus Director Notes</h4>
                        <div className="rounded-md bg-muted p-3">
                          <p className="text-sm text-muted-foreground">{request.campusDirectorNotes}</p>
                        </div>
                      </div>
                    )}
                    
                    <div className="space-y-2">
                      <h4 className="text-sm font-medium">Your Notes</h4>
                      <textarea
                        className="w-full p-3 border rounded-md text-sm min-h-[100px]"
                        placeholder="Add your notes about this decision..."
                        value={modalNotes}
                        onChange={(e) => setModalNotes(e.target.value)}
                      />
                    </div>
                  </div>
                  
                  <DialogFooter>
                    <Button 
                      variant="outline" 
                      onClick={() => setIsConfirming(false)}
                      disabled={isSubmitting}
                    >
                      Cancel
                    </Button>
                    <Button
                      variant={pendingAction === 'reject' || (pendingAction === 'override' && overrideType === 'reject') ? 'destructive' : 'default'}
                      onClick={() => {
                        if (pendingAction === 'override') {
                          handleStatusUpdate(overrideType === 'approve' ? 'approved' : 'rejected', pendingAction);
                        } else {
                          handleStatusUpdate(pendingAction === 'approve' ? 'approved' : 'rejected', pendingAction);
                        }
                      }}
                      disabled={isSubmitting}
                    >
                      {isSubmitting ? (
                        <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                      ) : (
                        <>
                          {pendingAction === 'approve' && <Check className="w-4 h-4 mr-1" />}
                          {pendingAction === 'reject' && <X className="w-4 h-4 mr-1" />}
                          {pendingAction === 'override' && <ArrowRightLeft className="w-4 h-4 mr-1" />}
                          
                          {pendingAction === 'approve' && 'Approve Request'}
                          {pendingAction === 'reject' && 'Reject Request'}
                          {pendingAction === 'override' && overrideType === 'approve' && 'Override with Approval'}
                          {pendingAction === 'override' && overrideType === 'reject' && 'Override with Rejection'}
                        </>
                      )}
                    </Button>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </div>
          </div>
        </TableCell>
      </TableRow>

      {isExpanded && (
        <TableRow className="bg-blue-50">
          <TableCell colSpan={4} className="p-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <h4 className="text-sm font-medium mb-2">Request Details</h4>
                <p className="text-sm">{request.reason}</p>
                
                <div className="mt-4 flex items-center gap-2">
                  <h4 className="text-sm font-medium">Current Status:</h4>
                  <Badge 
                    variant={
                      request.status === 'approved' 
                        ? 'default' 
                        : request.status === 'rejected'
                        ? 'destructive'
                        : 'outline'
                    }
                    className="capitalize"
                  >
                    {request.status}
                  </Badge>
                </div>
              </div>
              
              <div>
                <h4 className="text-sm font-medium mb-2">Campus Director Notes</h4>
                <p className="text-sm text-muted-foreground">
                  {request.campusDirectorNotes || "No notes provided"}
                </p>
              </div>

              <div className="col-span-2">
                <h4 className="text-sm font-medium mb-2">Lead Pastor Notes</h4>
                <div className="bg-white p-3 rounded-md border text-sm min-h-[80px]">
                  {localNotes ? (
                    <p>{localNotes}</p>
                  ) : (
                    <p className="text-muted-foreground italic">No notes provided. Add notes when approving or rejecting.</p>
                  )}
                </div>
              </div>
            </div>
          </TableCell>
        </TableRow>
      )}
    </>
  )
}

export function ApprovalTable({
  requests,
  requestType,
  approvalStatus,
  currentPage,
  totalPages,
  onPageChange,
  pageSize,
  onPageSizeChange
}: {
  requests: ApprovalRequest[];
  requestType: 'leave' | 'surplus';
  approvalStatus: 'pending' | 'approved';
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
  pageSize: number;
  onPageSizeChange: (size: number) => void
}) {
  return (
    <div className="w-full">
      {/* Desktop view - Table */}
      <div className="hidden md:block">
        <Table>
          <TableHeader className="bg-gray-50 dark:bg-gray-800/50">
            <TableRow className="hover:bg-transparent">
              <TableHead className="px-4 py-3.5 text-sm font-medium text-gray-700 dark:text-gray-300">Missionary</TableHead>
              <TableHead className="px-4 py-3.5 text-sm font-medium text-gray-700 dark:text-gray-300">Campus Director</TableHead>
              <TableHead className="px-4 py-3.5 text-sm font-medium text-gray-700 dark:text-gray-300">Details</TableHead>
              <TableHead className="px-4 py-3.5 text-sm font-medium text-gray-700 dark:text-gray-300">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {requests.map((request) => (
              <ApprovalTableRow
                key={request.id}
                request={request}
                requestType={requestType}
                approvalStatus={approvalStatus}
              />
            ))}
          </TableBody>
        </Table>
      </div>
      
      {/* Mobile view - Cards */}
      <div className="md:hidden">
        {requests.map((request) => (
          <MobileApprovalCard
            key={request.id}
            request={request}
            requestType={requestType}
            approvalStatus={approvalStatus}
          />
        ))}
      </div>
      
      <PaginationControls
        className="px-4 py-3 border-t bg-gray-50 dark:bg-gray-800/50"
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={onPageChange}
        pageSize={pageSize}
        onPageSizeChange={onPageSizeChange}
      />
    </div>
  )
}

// Mobile-optimized card component for approvals
function MobileApprovalCard({ 
  request, 
  requestType, 
  approvalStatus 
}: { 
  request: ApprovalRequest, 
  requestType: 'leave' | 'surplus', 
  approvalStatus: 'pending' | 'approved' 
}) {
  const [isExpanded, setIsExpanded] = useState(false)
  const [localNotes, setLocalNotes] = useState(request.leadPastorNotes || '')
  const router = useRouter()
  const supabase = createClient()
  const [isConfirming, setIsConfirming] = useState(false)
  const [pendingAction, setPendingAction] = useState<"approve" | "reject" | "override">()
  const [overrideType, setOverrideType] = useState<"approve" | "reject">("approve")
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [modalNotes, setModalNotes] = useState("")

  // Reuse the same functions from ApprovalTableRow
  const handleStatusUpdate = async (newStatus: string, action: "approve" | "reject" | "override" = "approve") => {
    setIsSubmitting(true)
    try {
      const tableName = requestType === 'leave' ? 'leave_requests' : 'surplus_requests'
      
      // Always update the lead_pastor_approval field and status
      const updateData = {
        lead_pastor_approval: newStatus,
        // For both missionaries and campus directors, Lead Pastor has final say
        // so we can update the status directly
        status: newStatus === 'approved' ? 'approved' : 'rejected',
        // Include the notes from the modal
        lead_pastor_notes: modalNotes
      };
      
      const { error } = await supabase
        .from(tableName)
        .update(updateData)
        .eq('id', request.id)

      if (error) throw error

      // Customize toast message based on the action
      let toastMessage = "";
      if (action === "override") {
        const cdDecision = request.campusDirectorApproval === 'approved' ? 'approval' : 
                          request.campusDirectorApproval === 'rejected' ? 'rejection' : 'decision';
        const lpAction = newStatus === 'approved' ? 'approved' : 'rejected';
        
        toastMessage = `Request ${lpAction} (Campus Director ${cdDecision} overridden)`;
      } else {
        toastMessage = `Request ${newStatus === 'approved' ? 'approved' : 'rejected'} successfully`;
      }

      toast({
        title: "Success!",
        description: toastMessage,
        variant: "success"
      })
      
      // Update local notes state to match what was saved
      setLocalNotes(modalNotes)
      
      router.refresh()
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to update request status",
        variant: "destructive"
      })
    } finally {
      setIsSubmitting(false)
      setIsConfirming(false)
    }
  }

  const saveNotes = useMemo(() => {
    return debounce(async (notes: string) => {
      const { error } = await supabase
        .from(requestType === 'leave' ? 'leave_requests' : 'surplus_requests')
        .update({ lead_pastor_notes: notes })
        .eq('id', request.id)

      if (!error) {
        router.refresh()
      }
    }, 500)
  }, [request.id, requestType])

  const handleNotesChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    const newNotes = e.target.value
    setLocalNotes(newNotes)
    saveNotes(newNotes)
  }

  useEffect(() => {
    return () => saveNotes.cancel()
  }, [saveNotes])

  return (
    <div className="border-b last:border-b-0">
      <div 
        className="p-4 cursor-pointer"
        onClick={() => setIsExpanded(!isExpanded)}
      >
        <div className="flex items-center justify-between mb-3">
          <div className="flex items-center gap-2">
            <Avatar className="h-9 w-9">
              <AvatarFallback className="bg-blue-100 text-blue-800">
                {request.requester?.full_name?.[0] || "U"}
              </AvatarFallback>
            </Avatar>
            <div>
              <p className="font-medium text-sm">{request.requester?.full_name || "Unknown"}</p>
              <p className="text-xs text-muted-foreground">
                {format(new Date(request.date), 'MMM dd, yyyy')}
              </p>
            </div>
          </div>
          <ChevronRight className={cn(
            "w-5 h-5 text-muted-foreground transform transition-transform",
            isExpanded ? "rotate-90" : "rotate-0"
          )} />
        </div>
        
        <div className="grid grid-cols-2 gap-2 text-sm mb-3">
          <div>
            <p className="text-xs text-muted-foreground mb-1">Campus Director</p>
            <Badge 
              variant={
                request.campusDirectorApproval === 'approved' 
                  ? 'default' 
                  : request.campusDirectorApproval === 'rejected'
                  ? 'destructive'
                  : 'outline'
              }
              className="capitalize text-xs"
            >
              {request.campusDirectorApproval || 'pending'}
            </Badge>
          </div>
          
          <div>
            <p className="text-xs text-muted-foreground mb-1">Request Details</p>
            <div className="flex items-center gap-1">
              {requestType === 'leave' ? (
                <>
                  <CalendarDays className="w-3.5 h-3.5 text-blue-600" />
                  <span className="text-xs truncate">
                    {format(new Date(request.startDate || new Date()), 'MMM dd')} - 
                    {format(new Date(request.endDate || new Date()), 'MMM dd')}
                  </span>
                </>
              ) : (
                <>
                  <Wallet className="w-3.5 h-3.5 text-green-600" />
                  <span className="text-xs">₱{request.amount?.toLocaleString()}</span>
                </>
              )}
            </div>
          </div>
        </div>
        
        {!isExpanded && (
          <div className="flex gap-2 mt-3">
            {approvalStatus === 'pending' && (
              <>
                <Button 
                  variant="default" 
                  className={`${request.campusDirectorApproval === 'rejected' ? 'opacity-50 cursor-not-allowed' : 'bg-green-600 hover:bg-green-700'} text-white h-8 text-xs flex-1`}
                  onClick={(e) => {
                    e.stopPropagation()
                    setPendingAction('approve')
                    setIsConfirming(true)
                  }}
                  disabled={request.campusDirectorApproval === 'rejected'}
                  title={request.campusDirectorApproval === 'rejected' ? "Cannot approve - Campus Director rejected this request" : ""}
                >
                  <Check className="w-3.5 h-3.5 mr-1" />
                  Approve
                </Button>

                <Button
                  variant="destructive"
                  size="sm"
                  onClick={(e) => {
                    e.stopPropagation()
                    setPendingAction('reject')
                    setIsConfirming(true)
                  }}
                  className="h-8 text-xs flex-1"
                  title={request.campusDirectorApproval === 'rejected' ? "Confirm Campus Director's rejection" : "Reject this request"}
                >
                  <X className="w-3.5 h-3.5 mr-1" />
                  Reject
                </Button>
              </>
            )}
          </div>
        )}
      </div>
      
      {/* Expanded content */}
      {isExpanded && (
        <div className="px-4 pb-4 bg-blue-50/50 dark:bg-gray-800/20">
          <div className="space-y-3">
            <div>
              <h4 className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Reason</h4>
              <p className="text-sm">{request.reason}</p>
            </div>
            
            {request.campusDirectorNotes && (
              <div>
                <h4 className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Campus Director Notes</h4>
                <div className="bg-white dark:bg-gray-800 p-2 rounded-md border text-sm">
                  <p className="text-sm">{request.campusDirectorNotes}</p>
                </div>
              </div>
            )}
            
            <div>
              <h4 className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Your Notes</h4>
              <textarea
                className="w-full p-2 border rounded-md text-sm min-h-[80px] bg-white dark:bg-gray-800"
                placeholder="Add your notes about this decision..."
                value={localNotes}
                onChange={handleNotesChange}
              />
            </div>
            
            {approvalStatus === 'pending' && (
              <div className="flex gap-2 pt-2">
                <Button 
                  variant="default" 
                  className={`${request.campusDirectorApproval === 'rejected' ? 'opacity-50 cursor-not-allowed' : 'bg-green-600 hover:bg-green-700'} text-white h-9 text-xs flex-1`}
                  onClick={(e) => {
                    e.stopPropagation()
                    setPendingAction('approve')
                    setIsConfirming(true)
                  }}
                  disabled={request.campusDirectorApproval === 'rejected'}
                >
                  <Check className="w-3.5 h-3.5 mr-1" />
                  Approve
                </Button>

                <Button
                  variant="destructive"
                  size="sm"
                  onClick={(e) => {
                    e.stopPropagation()
                    setPendingAction('reject')
                    setIsConfirming(true)
                  }}
                  className="h-9 text-xs flex-1"
                >
                  <X className="w-3.5 h-3.5 mr-1" />
                  Reject
                </Button>
                
                {/* Override button if CD rejected */}
                {request.campusDirectorApproval === 'rejected' && (
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={(e) => {
                      e.stopPropagation()
                      setPendingAction('override')
                      setIsConfirming(true)
                    }}
                    className="h-9 text-xs flex-1"
                  >
                    <ArrowRightLeft className="w-3.5 h-3.5 mr-1" />
                    Override
                  </Button>
                )}
              </div>
            )}
          </div>
        </div>
      )}
      
      {/* Confirmation Dialog - Reuse the same dialog from ApprovalTableRow */}
      <Dialog open={isConfirming} onOpenChange={setIsConfirming}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>
              {pendingAction === 'approve' 
                ? 'Approve Request' 
                : pendingAction === 'reject'
                ? 'Reject Request'
                : 'Override Campus Director Decision'}
            </DialogTitle>
            <DialogDescription>
              {pendingAction === 'approve' 
                ? 'Are you sure you want to approve this request?' 
                : pendingAction === 'reject'
                ? 'Are you sure you want to reject this request?'
                : 'Are you sure you want to override the Campus Director\'s decision?'}
            </DialogDescription>
          </DialogHeader>
          
          <div className="space-y-4 py-2">
            <div className="space-y-2">
              <h4 className="text-sm font-medium">Request Details</h4>
              <div className="rounded-md bg-muted p-3">
                <p className="text-sm">{request.reason}</p>
                {requestType === 'leave' && (
                  <p className="text-sm mt-2">
                    <strong>Period:</strong> {format(new Date(request.startDate || new Date()), 'MMM dd, yyyy')} - {format(new Date(request.endDate || new Date()), 'MMM dd, yyyy')}
                  </p>
                )}
                {requestType === 'surplus' && (
                  <p className="text-sm mt-2">
                    <strong>Amount:</strong> ₱{request.amount?.toLocaleString()}
                  </p>
                )}
              </div>
            </div>
            
            {pendingAction === 'override' && (
              <div className="space-y-2">
                <h4 className="text-sm font-medium">Override Action</h4>
                <Select
                  value={overrideType}
                  onValueChange={(v) => setOverrideType(v as "approve" | "reject")}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select action" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="approve">Approve (Override Rejection)</SelectItem>
                    <SelectItem value="reject">Reject (Override Approval)</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            )}
            
            {request.campusDirectorNotes && (
              <div className="space-y-2">
                <h4 className="text-sm font-medium">Campus Director Notes</h4>
                <div className="rounded-md bg-muted p-3">
                  <p className="text-sm text-muted-foreground">{request.campusDirectorNotes}</p>
                </div>
              </div>
            )}
            
            <div className="space-y-2">
              <h4 className="text-sm font-medium">Your Notes</h4>
              <textarea
                className="w-full p-3 border rounded-md text-sm min-h-[100px]"
                placeholder="Add your notes about this decision..."
                value={modalNotes}
                onChange={(e) => setModalNotes(e.target.value)}
              />
            </div>
          </div>
          
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsConfirming(false)}>Cancel</Button>
            <Button 
              variant={pendingAction === 'reject' ? 'destructive' : 'default'}
              onClick={() => {
                if (pendingAction === 'override') {
                  handleStatusUpdate(overrideType, 'override')
                } else {
                  handleStatusUpdate(pendingAction === 'approve' ? 'approved' : 'rejected', pendingAction)
                }
              }}
              disabled={isSubmitting}
            >
              {isSubmitting ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Processing...
                </>
              ) : (
                pendingAction === 'approve' 
                  ? 'Approve' 
                  : pendingAction === 'reject'
                  ? 'Reject'
                  : `Override with ${overrideType === 'approve' ? 'Approval' : 'Rejection'}`
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}

