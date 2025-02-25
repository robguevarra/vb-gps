export type ApprovalStatus = 'approved' | 'pending' | 'rejected'

export type ApprovalRequest = {
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

export type LeaveApproval = ApprovalRequest & {
  type: "Vacation Leave" | "Sick Leave"
  startDate: string
  endDate: string
}

export type SurplusApproval = ApprovalRequest & {
  type: "Surplus"
  amount: number
} 