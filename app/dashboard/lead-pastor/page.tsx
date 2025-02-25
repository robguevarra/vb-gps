// app/dashboard/lead-pastor/page.tsx

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import LeadPastorSelector from "@/components/LeadPastorSelector";
import LeadPastorDashboardClient from "./LeadPastorDashboardClient";
import { getUserRole } from "@/utils/getUserRole";
import { LeadPastorSidebar } from "@/components/LeadPastorSidebar";
import { LeaveApproval, SurplusApproval } from "@/types/approval";

interface RawLeaveRequest {
  id: number;
  type: "vacation" | "sick";
  start_date: string;
  end_date: string;
  reason: string;
  status: string;
  created_at: string;
  campus_director_approval: string;
  campus_director_notes?: string;
  lead_pastor_approval: string;
  lead_pastor_notes?: string;
  requester?: {
    full_name: string;
  };
}

interface RawSurplusRequest {
  id: number;
  amount_requested: number;
  reason: string;
  status: string;
  created_at: string;
  campus_director_approval: string;
  campus_director_notes?: string;
  lead_pastor_approval: string;
  lead_pastor_notes?: string;
  requester?: {
    full_name: string;
  };
}

export default async function LeadPastorDashboard({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) {
  const resolvedSearchParams = await searchParams;
  const supabase = await createClient();

  // Auth check
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    redirect("/login");
  }

  // Retrieve user's role from user_roles.
  const userRole = await getUserRole(user.id);

  // Determine selected lead pastor ID.
  const selectedLeadPastorId =
    typeof resolvedSearchParams.userId === "string"
      ? resolvedSearchParams.userId
      : Array.isArray(resolvedSearchParams.userId)
      ? resolvedSearchParams.userId[0]
      : user.id;

  // Fetch lead pastors for the dropdown.
  const { data: leadPastors, error: leadPastorsError } = await supabase
    .from("profiles")
    .select("id, full_name, role")
    .eq("role", "lead_pastor");

  if (leadPastorsError) {
    console.error("Error fetching lead pastors", leadPastorsError);
  }

  // Fetch local churches.
  const { data: localChurches, error: churchError } = await supabase
    .from('local_churches')
    .select('id, name')
    .eq('lead_pastor_id', selectedLeadPastorId);

  if (churchError) {
    console.error('Local churches fetch error:', churchError);
  }

  // Get missionaries in the lead pastor's churches
  const { data: churchMissionaries } = await supabase
    .from('profiles')
    .select('id')
    .in('local_church_id', localChurches?.map(ch => ch.id) || []);

  // Fetch pending leave requests for these missionaries
  const { data: pendingLeaveApprovalsData } = await supabase
    .from("leave_requests")
    .select(`
      *,
      requester:profiles(full_name)
    `)
    .in("requester_id", churchMissionaries?.map(m => m.id) || []) // Filter by church missionaries
    .eq("status", "pending")
    .order("created_at", { ascending: false });

  const { data: approvedLeaveApprovalsData } = await supabase
    .from("leave_requests")
    .select(`
      *,
      requester:profiles(full_name)
    `)
    .in("requester_id", churchMissionaries?.map(m => m.id) || []) // Filter by church missionaries
    .eq("status", "approved")
    .order("created_at", { ascending: false });

  // Fetch pending surplus requests for these missionaries
  const { data: pendingSurplusApprovalsData } = await supabase
    .from("surplus_requests")
    .select(`
      *,
      requester:profiles(full_name)
    `)
    .in("missionary_id", churchMissionaries?.map(m => m.id) || []) // Filter by church missionaries
    .eq("status", "pending")
    .order("created_at", { ascending: false });

  const { data: approvedSurplusApprovalsData } = await supabase
    .from("surplus_requests")
    .select(`
      *,
      requester:profiles(full_name)
    `)
    .in("missionary_id", churchMissionaries?.map(m => m.id) || []) // Filter by church missionaries
    .eq("status", "approved")
    .order("created_at", { ascending: false });

  const transformLeave = (req: RawLeaveRequest): LeaveApproval => ({
    id: String(req.id),
    type: req.type === "vacation" ? "Vacation Leave" : "Sick Leave",
    startDate: req.start_date,
    endDate: req.end_date,
    reason: req.reason,
    status: req.status as LeaveApproval['status'],
    date: req.created_at,
    campusDirectorApproval: req.campus_director_approval,
    campusDirectorNotes: req.campus_director_notes,
    leadPastorApproval: req.lead_pastor_approval,
    leadPastorNotes: req.lead_pastor_notes,
    requester: {
      full_name: req.requester?.full_name || "Unknown",
    },
  });

  const transformSurplus = (req: RawSurplusRequest): SurplusApproval => ({
    id: String(req.id),
    type: "Surplus",
    amount: req.amount_requested,
    reason: req.reason,
    status: req.status as SurplusApproval['status'],
    date: req.created_at,
    campusDirectorApproval: req.campus_director_approval,
    campusDirectorNotes: req.campus_director_notes,
    leadPastorApproval: req.lead_pastor_approval,
    leadPastorNotes: req.lead_pastor_notes,
    requester: {
      full_name: req.requester?.full_name || "Unknown",
    },
  });

  const transformedPendingLeaveApprovals = (pendingLeaveApprovalsData || []).map(transformLeave);
  const transformedApprovedLeaveApprovals = (approvedLeaveApprovalsData || []).map(transformLeave);
  const transformedPendingSurplusApprovals = (pendingSurplusApprovalsData || []).map(transformSurplus);
  const transformedApprovedSurplusApprovals = (approvedSurplusApprovalsData || []).map(transformSurplus);

  const selectedLeadPastorName =
    leadPastors?.find((pastor) => pastor.id === selectedLeadPastorId)?.full_name || "Lead Pastor";

  const currentTab = typeof resolvedSearchParams.tab === 'string' ? resolvedSearchParams.tab : 'approvals';

  return (
    <div className="min-h-screen bg-background">
      <LeadPastorSidebar />
      
      <main className="lg:ml-64 p-6 space-y-6">
        <header className="space-y-1">
          <h1 className="text-3xl font-bold">{selectedLeadPastorName}</h1>
          <div className="flex items-center gap-2 text-muted-foreground">
            <span>Assigned Churches:</span>
            <div className="flex gap-1.5">
              {localChurches?.length ? (
                localChurches.map((ch) => (
                  <span key={ch.id} className="badge badge-outline">
                    {ch.name}
                  </span>
                ))
              ) : (
                <span className="text-sm italic">No churches assigned</span>
              )}
            </div>
          </div>
        </header>

        {userRole === 'superadmin' && (
          <div className="bg-accent/50 p-4 rounded-lg">
            <LeadPastorSelector leadPastors={leadPastors || []} userId={selectedLeadPastorId} />
          </div>
        )}

        <section className="space-y-8">
          <LeadPastorDashboardClient
            pendingLeaveApprovals={transformedPendingLeaveApprovals}
            approvedLeaveApprovals={transformedApprovedLeaveApprovals}
            pendingSurplusApprovals={transformedPendingSurplusApprovals}
            approvedSurplusApprovals={transformedApprovedSurplusApprovals}
            churchIds={localChurches?.map(ch => ch.id) || []}
            currentTab={currentTab}
          />
        </section>
      </main>
    </div>
  );
}
