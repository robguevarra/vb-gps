// app/dashboard/lead-pastor/page.tsx

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import LeadPastorSelector from "@/components/LeadPastorSelector";
import LeadPastorDashboardClient from "./LeadPastorDashboardClient";
import { getUserRole } from "@/utils/getUserRole";
import { ChurchReportsTab } from "@/components/ChurchReportsTab";
import LeadPastorNavbar from "@/components/LeadPastorNavbar";

// Define the ApprovalStatus type to match the one in LeadPastorApprovalTab
type ApprovalStatus = 'approved' | 'pending' | 'rejected'

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

  // Fetch local churches.
  const { data: localChurches, error: churchError } = await supabase
    .from('local_churches')
    .select('id, name')
    .eq('lead_pastor_id', selectedLeadPastorId);

  // Get all staff (missionaries and campus directors) in the lead pastor's churches
  const { data: churchStaff } = await supabase
    .from('profiles')
    .select('id, role, full_name')
    .in('local_church_id', localChurches?.map(ch => ch.id) || []);

  // Get all staff IDs
  const allStaffIds = churchStaff?.map(staff => staff.id) || [];

  // Create a map of staff IDs to names for easier lookup
  const staffNames = Object.fromEntries(
    (churchStaff || []).map(staff => [staff.id, staff.full_name])
  );

  // Fetch pending leave requests for these staff members
  const { data: pendingLeaveApprovalsData } = await supabase
    .from("leave_requests")
    .select(`*`)
    .in("requester_id", allStaffIds) // Filter by all church staff
    .eq("status", "pending")
    .or(`campus_director_approval.eq.approved,campus_director_approval.eq.rejected`) // Show both approved and rejected by CD
    .order("created_at", { ascending: false });

  const { data: approvedLeaveApprovalsData } = await supabase
    .from("leave_requests")
    .select(`*`)
    .in("requester_id", allStaffIds) // Filter by all church staff
    .eq("status", "approved")
    .order("created_at", { ascending: false });

  // Fetch pending surplus requests for missionaries
  const { data: pendingSurplusMissionaryData } = await supabase
    .from("surplus_requests")
    .select(`*`)
    .in("missionary_id", allStaffIds) // Filter by all church staff
    .eq("status", "pending")
    .or(`campus_director_approval.eq.approved,campus_director_approval.eq.rejected`) // Show both approved and rejected by CD
    .order("created_at", { ascending: false });

  // Fetch pending surplus requests for campus directors
  const { data: pendingSurplusCDData } = await supabase
    .from("surplus_requests")
    .select(`*`)
    .in("requester_id", allStaffIds) // Filter by all church staff
    .eq("status", "pending")
    .or(`campus_director_approval.eq.approved,campus_director_approval.eq.rejected`) // Show both approved and rejected by CD
    .order("created_at", { ascending: false });

  // Combine the two sets of surplus requests
  const pendingSurplusApprovalsData = [
    ...(pendingSurplusMissionaryData || []),
    ...(pendingSurplusCDData || [])
  ];

  // Fetch approved surplus requests for missionaries
  const { data: approvedSurplusMissionaryData } = await supabase
    .from("surplus_requests")
    .select(`*`)
    .in("missionary_id", allStaffIds) // Filter by all church staff
    .eq("status", "approved")
    .order("created_at", { ascending: false });

  // Fetch approved surplus requests for campus directors
  const { data: approvedSurplusCDData } = await supabase
    .from("surplus_requests")
    .select(`*`)
    .in("requester_id", allStaffIds) // Filter by all church staff
    .eq("status", "approved")
    .order("created_at", { ascending: false });

  // Combine the two sets of surplus requests
  const approvedSurplusApprovalsData = [
    ...(approvedSurplusMissionaryData || []),
    ...(approvedSurplusCDData || [])
  ];

  // Define the types to match LeadPastorDashboardClient props
  type LeaveApproval = {
    id: string;
    type: "Vacation Leave" | "Sick Leave";
    startDate: string;
    endDate: string;
    reason: string;
    status: ApprovalStatus;
    date: string;
    campusDirectorApproval: string;
    campusDirectorNotes?: string;
    leadPastorApproval: string;
    leadPastorNotes?: string;
    requester?: { full_name: string };
  };

  type SurplusApproval = {
    id: string;
    type: "Surplus";
    amount: number;
    reason: string;
    status: ApprovalStatus;
    date: string;
    campusDirectorApproval: string;
    campusDirectorNotes?: string;
    leadPastorApproval: string;
    leadPastorNotes?: string;
    requester?: { full_name: string };
  };

  const transformLeave = (req: any): LeaveApproval => ({
    id: String(req.id),
    type: req.type === "vacation" ? "Vacation Leave" : "Sick Leave",
    startDate: req.start_date,
    endDate: req.end_date,
    reason: req.reason,
    status: req.status as ApprovalStatus,
    date: req.created_at,
    campusDirectorApproval: req.campus_director_approval,
    campusDirectorNotes: req.campus_director_notes,
    leadPastorApproval: req.lead_pastor_approval,
    leadPastorNotes: req.lead_pastor_notes,
    requester: {
      full_name: staffNames[req.requester_id] || "Unknown",
    },
  });

  const transformSurplus = (req: any): SurplusApproval => ({
    id: String(req.id),
    type: "Surplus",
    amount: req.amount_requested,
    reason: req.reason,
    status: req.status as ApprovalStatus,
    date: req.created_at,
    campusDirectorApproval: req.campus_director_approval,
    campusDirectorNotes: req.campus_director_notes,
    leadPastorApproval: req.lead_pastor_approval,
    leadPastorNotes: req.lead_pastor_notes,
    requester: {
      full_name: staffNames[req.missionary_id || req.requester_id] || "Unknown",
    },
  });

  const transformedPendingLeaveApprovals: LeaveApproval[] = (pendingLeaveApprovalsData || []).map(transformLeave);
  const transformedApprovedLeaveApprovals: LeaveApproval[] = (approvedLeaveApprovalsData || []).map(transformLeave);
  const transformedPendingSurplusApprovals: SurplusApproval[] = (pendingSurplusApprovalsData || []).map(transformSurplus);
  const transformedApprovedSurplusApprovals: SurplusApproval[] = (approvedSurplusApprovalsData || []).map(transformSurplus);

  const selectedLeadPastorName =
    leadPastors?.find((pastor) => pastor.id === selectedLeadPastorId)?.full_name || "Lead Pastor";

  const currentTab = typeof resolvedSearchParams.tab === 'string' ? resolvedSearchParams.tab : 'approvals';

  return (
    <div className="min-h-screen bg-background">
      <LeadPastorNavbar />
      
      <main className="lg:ml-64 pt-20 px-4 sm:px-6 pb-6 space-y-4 sm:space-y-6">
        <header className="space-y-2 bg-white dark:bg-gray-900 p-4 rounded-lg shadow-sm border">
          <h1 className="text-2xl sm:text-3xl font-bold text-[#00458d]">{selectedLeadPastorName}</h1>
          <div className="flex flex-wrap items-center gap-2 text-muted-foreground">
            <span className="text-sm sm:text-base">Assigned Churches:</span>
            <div className="flex flex-wrap gap-1.5">
              {localChurches?.length ? (
                localChurches.map((ch) => (
                  <span key={ch.id} className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200">
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
          <div className="bg-accent/50 p-4 rounded-lg shadow-sm border">
            <LeadPastorSelector leadPastors={leadPastors || []} userId={selectedLeadPastorId} />
          </div>
        )}

        <section className="space-y-4 sm:space-y-8">
          <LeadPastorDashboardClient
            pendingLeaveApprovals={transformedPendingLeaveApprovals}
            approvedLeaveApprovals={transformedApprovedLeaveApprovals}
            pendingSurplusApprovals={transformedPendingSurplusApprovals}
            approvedSurplusApprovals={transformedApprovedSurplusApprovals}
            churchIds={localChurches?.map(ch => ch.id) || []}
            currentTab={currentTab}
            selectedLeadPastorName={selectedLeadPastorName}
          />
        </section>
      </main>
    </div>
  );
}
