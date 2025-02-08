import { createClient } from "@/utils/supabase/server"
import { redirect } from "next/navigation"
import LeadPastorSelector from "@/components/LeadPastorSelector"
import LeadPastorDashboardClient from "./LeadPastorDashboardClient"

export default async function LeadPastorDashboard({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>
}) {
  const resolvedSearchParams = await searchParams
  const supabase = await createClient()

  // Auth check
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) {
    redirect("/login")
  }

  // Determine selected lead pastor ID
  const selectedLeadPastorId =
    typeof resolvedSearchParams.userId === "string"
      ? resolvedSearchParams.userId
      : Array.isArray(resolvedSearchParams.userId)
        ? resolvedSearchParams.userId[0]
        : user.id

  // Fetch lead pastors for the dropdown
  const { data: leadPastors, error: leadPastorsError } = await supabase
    .from("profiles")
    .select("id, full_name, role")
    .eq("role", "lead_pastor")

  if (leadPastorsError) {
    console.error("Error fetching lead pastors", leadPastorsError)
  }

  // Fetch local church name
  const { data: localChurch } = await supabase
    .from("local_churches")
    .select("name")
    .eq("lead_pastor_id", selectedLeadPastorId)
    .single()

  // Fetch pending and approved leave requests
  const { data: pendingLeaveApprovals, error: pendingLeaveError } = await supabase
    .from("leave_requests")
    .select(`
      id, type, start_date, end_date, reason, status, created_at,
      campus_director_approval, campus_director_notes, lead_pastor_approval,
      requester:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq("status", "pending")
    .eq("lead_pastor_approval", "none")
    .neq("campus_director_approval", "none")
    .eq("requester.local_churches.lead_pastor_id", selectedLeadPastorId)
    .order("created_at", { ascending: false })

  const { data: approvedLeaveApprovals, error: approvedLeaveError } = await supabase
    .from("leave_requests")
    .select(`
      id, type, start_date, end_date, reason, status, created_at,
      campus_director_approval, campus_director_notes, lead_pastor_approval,
      requester:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq("status", "approved")
    .in("lead_pastor_approval", ["approved", "override-approved"])
    .eq("requester.local_churches.lead_pastor_id", selectedLeadPastorId)
    .order("created_at", { ascending: false })

  // Fetch pending and approved surplus requests
  const { data: pendingSurplusApprovals, error: pendingSurplusError } = await supabase
    .from("surplus_requests")
    .select(`
      id, amount_requested, reason, status, created_at,
      campus_director_approval, campus_director_notes, lead_pastor_approval,
      missionary:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq("status", "pending")
    .eq("lead_pastor_approval", "none")
    .neq("campus_director_approval", "none")
    .eq("missionary.local_churches.lead_pastor_id", selectedLeadPastorId)
    .order("created_at", { ascending: false })

  const { data: approvedSurplusApprovals, error: approvedSurplusError } = await supabase
    .from("surplus_requests")
    .select(`
      id, amount_requested, reason, status, created_at,
      campus_director_approval, campus_director_notes, lead_pastor_approval,
      missionary:profiles!inner(full_name, local_churches!fk_local_church!inner(lead_pastor_id))
    `)
    .eq("status", "approved")
    .in("lead_pastor_approval", ["approved", "override-approved"])
    .eq("missionary.local_churches.lead_pastor_id", selectedLeadPastorId)
    .order("created_at", { ascending: false })

  // Transform data
  const transformLeave = (req: any) => ({
    id: String(req.id),
    type: req.type === "vacation" ? "Vacation Leave" : "Sick Leave",
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
      full_name: req.requester?.full_name || "Unknown",
    },
  })

  const transformSurplus = (req: any) => ({
    id: String(req.id),
    type: "Surplus" as const,
    amount: req.amount_requested,
    reason: req.reason,
    status: req.status,
    date: req.created_at,
    campusDirectorApproval: req.campus_director_approval,
    campusDirectorNotes: req.campus_director_notes,
    leadPastorApproval: req.lead_pastor_approval,
    leadPastorNotes: req.lead_pastor_notes,
    requester: {
      full_name: req.missionary?.full_name || "Unknown",
    },
  })

  const transformedPendingLeaveApprovals = (pendingLeaveApprovals || []).map(transformLeave)
  const transformedApprovedLeaveApprovals = (approvedLeaveApprovals || []).map(transformLeave)
  const transformedPendingSurplusApprovals = (pendingSurplusApprovals || []).map(transformSurplus)
  const transformedApprovedSurplusApprovals = (approvedSurplusApprovals || []).map(transformSurplus)

  const selectedLeadPastorName =
    leadPastors?.find((pastor) => pastor.id === selectedLeadPastorId)?.full_name || "Lead Pastor"

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <header className="mb-8">
          <h1 className="text-3xl font-semibold text-gray-900 dark:text-gray-100">{selectedLeadPastorName}</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
            {localChurch?.name || "No local church assigned"}
          </p>
        </header>

        <div className="mb-8">
          <LeadPastorSelector leadPastors={leadPastors || []} userId={selectedLeadPastorId} />
        </div>

        <LeadPastorDashboardClient
          pendingLeaveApprovals={transformedPendingLeaveApprovals}
          approvedLeaveApprovals={transformedApprovedLeaveApprovals}
          selectedLeadPastorName={selectedLeadPastorName}
          pendingSurplusApprovals={transformedPendingSurplusApprovals}
          approvedSurplusApprovals={transformedApprovedSurplusApprovals}
        />
      </div>
    </div>
  )
}

