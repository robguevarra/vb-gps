export interface Donation {
  id: string
  amount: number
  date: string
  missionary_id: string
  donor_name?: string
  source: string
  status: 'pending' | 'approved' | 'rejected'
  local_church_id: string
  created_by: string
  created_at: string
}

export interface SurplusRequest {
  id: string
  amount_requested: number
  reason: string
  status: 'pending' | 'approved' | 'rejected'
  missionary_id: string
  campus_director_approval: 'none' | 'approved' | 'rejected' | 'override'
  lead_pastor_approval: 'none' | 'approved' | 'rejected' | 'override'
  local_church_id: string
  created_at: string
}

export interface LeaveRequest {
  id: string
  start_date: string
  end_date: string
  reason: string
  status: 'pending' | 'approved' | 'rejected'
  requester_id: string
  campus_director_approval: 'none' | 'approved' | 'rejected' | 'override'
  lead_pastor_approval: 'none' | 'approved' | 'rejected' | 'override'
  local_church_id: string
  created_at: string
}

export interface Profile {
  id: string
  full_name: string
  role: 'missionary' | 'finance_officer' | 'campus_director' | 'lead_pastor' | 'superadmin'
  monthly_goal: number
  surplus_balance: number
  local_church_id: number | null
  campus_director_id?: string
  created_at: string
}

export interface LocalChurch {
  id: string
  name: string
  created_at: string
}

export interface ApprovalAction {
  id: string
  type: 'surplus' | 'leave'
  decision: 'approved' | 'rejected' | 'override'
  decided_by: string
  decided_at: string
}

export interface Donor {
  id: number
  name: string
  email: string
  phone: string
}

export interface DonorDonation {
  id: number
  missionary_id: string
  donor_id: number | null
  date: string
  amount: number
  source: string
  status: string
  notes: string | null
  donors?: Donor | null
} 