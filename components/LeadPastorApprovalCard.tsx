//components/LeadPastorApprovalCard.tsx

"use client"

import { useState, useMemo, useEffect } from "react"
import { createClient } from "@/utils/supabase/client"
import { useRouter } from "next/navigation"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback } from "@/components/ui/avatar"
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip"
import { ChevronRight, Check, X, ArrowRightLeft, CalendarDays, FileText, Wallet, Loader2 } from "lucide-react"
import { cn } from "@/lib/utils"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { format } from "date-fns"
import { debounce } from "lodash"
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog"
import { toast } from "@/hooks/use-toast"
import { ApprovalRequest } from "@/types/approval"

const ApprovalTableRow = ({ request, requestType, approvalStatus }: { request: ApprovalRequest, requestType: 'leave' | 'surplus', approvalStatus: 'pending' | 'approved' }) => {
  const [isExpanded, setIsExpanded] = useState(false)
  const [localNotes, setLocalNotes] = useState(request.leadPastorNotes || '')
  const router = useRouter()
  const supabase = createClient()
  const [isConfirming, setIsConfirming] = useState(false)
  const [pendingAction, setPendingAction] = useState<"approve" | "reject" | "override">()
  const [isSubmitting, setIsSubmitting] = useState(false)

  const handleStatusUpdate = async (newStatus: string) => {
    setIsSubmitting(true)
    try {
      const tableName = requestType === 'leave' ? 'leave_requests' : 'surplus_requests'
      const { error: updateError } = await supabase
        .from(tableName)
        .update({ 
          lead_pastor_approval: newStatus,
          status: newStatus === 'approved' ? 'approved' : 'rejected'
        })
        .eq('id', request.id)

      if (updateError) {
        toast({
          title: "Error",
          description: updateError.message || "Failed to update request status",
          variant: "destructive"
        })
        return
      }

      toast({
        title: "Success!",
        description: `Request ${newStatus === 'approved' ? 'approved' : 'rejected'} successfully`,
        variant: "success"
      })
      router.refresh()
    } catch (error: unknown) {
      const errorMessage = error instanceof Error ? error.message : "An unexpected error occurred"
      toast({
        title: "Error",
        description: errorMessage,
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
  }, [request.id, requestType, router, supabase])

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
              variant={request.campusDirectorApproval === 'approved' ? 'default' : 'destructive'}
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
                  <Button 
                    variant="default" 
                    className="bg-green-600 hover:bg-green-700 text-white h-8"
                    onClick={(e) => {
                      e.stopPropagation()
                      setPendingAction('approve')
                      setIsConfirming(true)
                    }}
                  >
                    <Check className="w-4 h-4 mr-1" />
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
                    className="h-8"
                  >
                    <X className="w-4 h-4 mr-1" />
                    Reject
                  </Button>

                  <Tooltip>
                    <TooltipTrigger asChild>
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={(e) => {
                          e.stopPropagation()
                          setPendingAction('override')
                          setIsConfirming(true)
                        }}
                        className="h-8 gap-1"
                      >
                        <ArrowRightLeft className="w-4 h-4" />
                        <span>OVERRIDE</span>
                      </Button>
                    </TooltipTrigger>
                    <TooltipContent>
                      <p>Override campus director decision</p>
                    </TooltipContent>
                  </Tooltip>
                </>
              )}

              <Dialog open={isConfirming} onOpenChange={setIsConfirming}>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle>Confirm Action</DialogTitle>
                    <DialogDescription>
                      Are you sure you want to {pendingAction} this request?
                    </DialogDescription>
                  </DialogHeader>
                  <DialogFooter>
                    <Button
                      variant="outline"
                      onClick={() => setIsConfirming(false)}
                    >
                      Cancel
                    </Button>
                    <Button
                      variant={pendingAction === 'approve' ? 'default' : 'destructive'}
                      onClick={() => handleStatusUpdate(pendingAction === 'approve' ? 'approved' : 'rejected')}
                      disabled={isSubmitting}
                    >
                      {isSubmitting && <Loader2 className="w-4 h-4 mr-2 animate-spin" />}
                      {pendingAction === 'approve' ? 'Approve' : 'Reject'}
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
              </div>
              
              <div>
                <h4 className="text-sm font-medium mb-2">Campus Director Notes</h4>
                <p className="text-sm text-muted-foreground">
                  {request.campusDirectorNotes || "No notes provided"}
                </p>
              </div>

              <div className="col-span-2">
                <h4 className="text-sm font-medium mb-2">Lead Pastor Notes</h4>
                <textarea
                  className="w-full p-2 border rounded-md text-sm"
                  placeholder="Add your notes..."
                  value={localNotes}
                  onChange={handleNotesChange}
                />
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
  approvalStatus
}: {
  requests: ApprovalRequest[];
  requestType: 'leave' | 'surplus';
  approvalStatus: 'pending' | 'approved';
}) {
  return (
    <div className="space-y-4">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Requester</TableHead>
            <TableHead>Campus Director</TableHead>
            <TableHead>Details</TableHead>
            <TableHead>Actions</TableHead>
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
  )
}

