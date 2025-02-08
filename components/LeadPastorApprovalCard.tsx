//components/LeadPastorApprovalCard.tsx

"use client"

import { useState } from "react"
import { createClient } from "@/utils/supabase/client"
import { useRouter } from "next/navigation"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"

import { Card, CardContent, CardFooter, CardHeader } from "@/components/ui/card"
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Calendar, DollarSign } from "lucide-react"

type ApprovalRequest = {
  id: string
  type: string
  startDate?: string
  endDate?: string
  amount?: number
  reason: string
  status: string
  date: string
  campusDirectorApproval: string
  campusDirectorNotes?: string
  leadPastorApproval: string
  leadPastorNotes?: string
  requester?: { full_name: string }
}

const LeadPastorApprovalCard = ({
  request,
  requestType,
  isApprovedTab,
}: {
  request: ApprovalRequest
  requestType: "leave" | "surplus"
  isApprovedTab: boolean
}) => {
  const [isOpen, setIsOpen] = useState(false)
  const [modalType, setModalType] = useState("")
  const [notes, setNotes] = useState("")
  const router = useRouter()
  const supabase = createClient()

  const handleOpenModal = (action: string) => {
    setModalType(action)
    setNotes("")
    setIsOpen(true)
  }

  const handleCloseModal = () => {
    setIsOpen(false)
    setNotes("")
  }

  const handleConfirm = async () => {
    try {
      const tableName = requestType === "leave" ? "leave_requests" : "surplus_requests"
      const updateData = {
        lead_pastor_approval: modalType,
        lead_pastor_notes: notes,
        status: modalType.includes("approved") ? "approved" : "rejected",
      }

      const { error } = await supabase.from(tableName).update(updateData).eq("id", request.id)

      if (error) throw error

      handleCloseModal()
      router.refresh()
    } catch (error) {
      console.error("Error updating request status:", error)
    }
  }

  const getDetails = () => {
    if (requestType === "leave") {
      return `${request.startDate} - ${request.endDate}`
    } else {
      return `₱${request.amount?.toLocaleString()}`
    }
  }

  return (
    <Card className="overflow-hidden">
      <CardHeader className="pb-2">
        <div className="flex justify-between items-center">
          <span className="font-medium text-sm">{request.requester?.full_name || "Unknown"}</span>
          <Badge variant={request.status === "approved" ? "success" : "secondary"} className="text-xs">
            {request.status}
          </Badge>
        </div>
      </CardHeader>
      <CardContent className="pb-2">
        <div className="flex items-center text-sm text-gray-600 dark:text-gray-300 mb-2">
          {requestType === "leave" ? <Calendar className="w-4 h-4 mr-2" /> : <DollarSign className="w-4 h-4 mr-2" />}
          {getDetails()}
        </div>
        <p className="text-xs text-gray-500 dark:text-gray-400 mb-2">{request.reason}</p>
        {!isApprovedTab && (
          <>
            <div className="flex items-center gap-2 mb-2">
              <span className="text-xs font-semibold text-gray-500 dark:text-gray-400">Campus Director:</span>
              <Badge
                variant={
                  request.campusDirectorApproval === "approved"
                    ? "success"
                    : request.campusDirectorApproval === "rejected"
                      ? "destructive"
                      : "secondary"
                }
                className="text-xs"
              >
                {request.campusDirectorApproval === "approved"
                  ? "Approved"
                  : request.campusDirectorApproval === "rejected"
                    ? "Rejected"
                    : "Pending"}
              </Badge>
            </div>
            {request.campusDirectorNotes && (
              <div className="bg-gray-100 dark:bg-gray-700 p-2 rounded-md mb-2">
                <p className="text-xs text-gray-600 dark:text-gray-300">
                  <span className="font-semibold">Campus Director Notes:</span> {request.campusDirectorNotes}
                </p>
              </div>
            )}
          </>
        )}
      </CardContent>
      {!isApprovedTab && (
        <CardFooter className="pt-2 flex justify-between">
          <Button
            variant="outline"
            size="sm"
            onClick={() => handleOpenModal("approved")}
            className="bg-green-50 text-green-600 border-green-200 hover:bg-green-100 hover:text-green-700"
          >
            Approve
          </Button>
          <Button
            variant="outline"
            size="sm"
            onClick={() => handleOpenModal("rejected")}
            className="bg-red-50 text-red-600 border-red-200 hover:bg-red-100 hover:text-red-700"
          >
            Reject
          </Button>
          <Button
            variant="secondary"
            size="sm"
            onClick={() => handleOpenModal("override-approved")}
            className="bg-blue-50 text-blue-600 border-blue-200 hover:bg-blue-100 hover:text-blue-700"
          >
            Override
          </Button>
        </CardFooter>
      )}

      <Dialog open={isOpen} onOpenChange={setIsOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              {modalType === "approved"
                ? "Approve Request"
                : modalType === "rejected"
                  ? "Reject Request"
                  : "Override Approval"}
            </DialogTitle>
          </DialogHeader>
          <Label htmlFor="notes">Notes (Optional):</Label>
          <Textarea
            id="notes"
            placeholder="Enter your notes here..."
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
          />
          <div className="flex justify-end mt-4 gap-2">
            <Button variant="secondary" onClick={handleCloseModal}>
              Cancel
            </Button>
            <Button onClick={handleConfirm}>
              {modalType === "approved" ? "Approve" : modalType === "rejected" ? "Reject" : "Override"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </Card>
  )
}

export { LeadPastorApprovalCard }

