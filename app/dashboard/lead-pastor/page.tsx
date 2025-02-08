// app/dashboard/lead-pastor/page.tsx

import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { LeadPastorApprovalCard } from '@/components/LeadPastorApprovalCard'
import LeadPastorSelector from '@/components/LeadPastorSelector'
import LeadPastorDashboardClient from './LeadPastorDashboardClient'

export default async function LeadPastorDashboard({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>
}) {
  const resolvedSearchParams = await searchParams
  const supabase = await createClient()

  // 1) Auth check
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) {
    redirect('/login')
  }

  // 2) Determine selected lead pastor ID
  const selectedLeadPastorId =
    typeof resolvedSearchParams.userId === 'string'
      ? resolvedSearchParams.userId
      : Array.isArray(resolvedSearchParams.userId)
      ? resolvedSearchParams.userId[0]
      : user.id

  // 3) (Optional) fetch lead pastors for the dropdown
  const { data: leadPastors, error: leadPastorsError } = await supabase
    .from('profiles')
    .select('id, full_name, role')
    .eq('role', 'lead_pastor')

  if (leadPastorsError) {
    console.error('Error fetching lead pastors', leadPastorsError)
  }

  // 4) Optionally fetch local church name
  const { data: localChurch } = await supabase
    .from('local_churches')
    .select('name')
    .eq('lead_pastor_id', selectedLeadPastorId)
    .single()

  // ------------------- Pending Leaves -------------------
  const { data: leaveRequests, error: leaveError } = await supabase
    .from('leave_requests')
    .select(`
      id,
      type,
      start_date,
      end_date,
      reason,
      status,
      created_at,
      campus_director_approval,
      lead_pastor_approval,
      requester:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq('status', 'pending')
    .eq('lead_pastor_approval', 'none')
    .neq('campus_director_approval', 'none')
    .eq('requester.local_churches.lead_pastor_id', selectedLeadPastorId)
    .order('created_at', { ascending: false })

  if (leaveError) {
    console.error('Error fetching pending leave requests', leaveError)
  }

  // ------------------- Approved Leaves -------------------
  // We treat 'override-approved' as also "approved"
  const { data: approvedLeaveRows, error: approvedLeaveError } = await supabase
    .from('leave_requests')
    .select(`
      id,
      type,
      start_date,
      end_date,
      reason,
      status,
      created_at,
      campus_director_approval,
      lead_pastor_approval,
      requester:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq('status', 'approved')
    .in('lead_pastor_approval', ['approved', 'override-approved'])
    .eq('requester.local_churches.lead_pastor_id', selectedLeadPastorId)
    .order('created_at', { ascending: false })

    if (approvedLeaveError) {
        console.error('Error fetching approved leave requests', approvedLeaveError);
    }

  // ------------------- Pending Surplus -------------------
  const { data: surplusRequests, error: surplusError } = await supabase
    .from('surplus_requests')
    .select(`
      id,
      amount_requested,
      reason,
      status,
      created_at,
      campus_director_approval,
      lead_pastor_approval,
      missionary:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq('status', 'pending')
    .eq('lead_pastor_approval', 'none')
    .neq('campus_director_approval', 'none')
    .eq('missionary.local_churches.lead_pastor_id', selectedLeadPastorId)
    .order('created_at', { ascending: false })

  if (surplusError) {
    console.error('Error fetching pending surplus requests', surplusError)
  }

  // ------------------- Approved Surplus -------------------
  const { data: approvedSurplusRows, error: approvedSurplusError } = await supabase
    .from('surplus_requests')
    .select(`
      id,
      amount_requested,
      reason,
      status,
      created_at,
      campus_director_approval,
      lead_pastor_approval,
      missionary:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq('status', 'approved')
    .in('lead_pastor_approval', ['approved', 'override-approved'])
    .eq('missionary.local_churches.lead_pastor_id', selectedLeadPastorId)
    .order('created_at', { ascending: false })

    if (approvedSurplusError) {
        console.error('Error fetching approved surplus requests', approvedSurplusError);
    }

  // 5) Transform each row into a simpler shape if needed
  function transformLeave(req: any) {
    return {
      id: String(req.id),
      type: req.type === 'vacation' ? 'Vacation Leave' : 'Sick Leave',
      startDate: req.start_date,
      endDate: req.end_date,
      reason: req.reason,
      status: req.status,
      date: req.created_at,
      campusDirectorApproval: req.campus_director_approval,
      campusDirectorNotes: req.campus_director_notes,
      leadPastorApproval: req.lead_pastor_approval,
      leadPastorNotes: req.lead_pastor_notes,
      requester: {
        full_name: req.requester?.full_name || 'Unknown',
      },
    }
  }

  function transformSurplus(req: any) {
    return {
      id: String(req.id),
      type: 'Surplus' as const,
      amount: req.amount_requested,
      reason: req.reason,
      status: req.status,
      date: req.created_at,
      campusDirectorApproval: req.campus_director_approval,
      campusDirectorNotes: req.campus_director_notes,
      leadPastorApproval: req.lead_pastor_approval,
      leadPastorNotes: req.lead_pastor_notes,
      requester: {
        full_name: req.missionary?.full_name || 'Unknown',
      },
    }
  }

  const pendingLeaveApprovals = (leaveRequests || []).map(transformLeave)
  const approvedLeaveApprovals = (approvedLeaveRows || []).map(transformLeave)
  const pendingSurplusApprovals = (surplusRequests || []).map(transformSurplus)
  const approvedSurplusApprovals = (approvedSurplusRows || []).map(transformSurplus)

  // 6) Render
  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header>
          <h1 className="text-3xl font-bold text-foreground">
            Lead Pastor Dashboard
          </h1>
          <p className="text-lg text-muted-foreground mt-1">
            {localChurch?.name ?? 'No local church assigned'}
          </p>
        </header>

        {/* Lead Pastor Selector */}
        <div className="mb-4">
          <LeadPastorSelector
            leadPastors={leadPastors || []}
            userId={selectedLeadPastorId}
          />
        </div>

        {/* Pass data to a client component, e.g. LeadPastorDashboardClient */}
        <LeadPastorDashboardClient
          pendingLeaveApprovals={pendingLeaveApprovals}
          approvedLeaveApprovals={approvedLeaveApprovals}
          pendingSurplusApprovals={pendingSurplusApprovals}
          approvedSurplusApprovals={approvedSurplusApprovals}
        />
      </div>
    </div>
  )
}
