import { createClient } from "@/utils/supabase/server";
import { ApprovalTab } from "@/components/ApprovalTab";

interface ApprovalsTabWrapperProps {
  campusDirectorId: string;
}

// Define interfaces to match the expected types in ApprovalTab
interface LeaveApproval {
  id: string;
  type: "Sick Leave" | "Vacation Leave";
  startDate: string;
  endDate: string;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

interface SurplusApproval {
  id: string;
  type: "Surplus";
  amount_requested: number;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

export async function ApprovalsTabWrapper({ campusDirectorId }: ApprovalsTabWrapperProps) {
  const supabase = await createClient();

  // First, get the campus director's profile to get their local_church_id
  const { data: campusDirectorProfile } = await supabase
    .from("profiles")
    .select("local_church_id")
    .eq("id", campusDirectorId)
    .single();

  if (!campusDirectorProfile?.local_church_id) {
    return (
      <div className="space-y-8">
        <p className="text-red-500">Error: Could not determine your church. Please contact support.</p>
      </div>
    );
  }

  // Get all missionaries from the same local church
  const { data: subordinateProfiles } = await supabase
    .from("profiles")
    .select("id, full_name")
    .eq("local_church_id", campusDirectorProfile.local_church_id)
    .eq("role", "missionary");
  
  if (!subordinateProfiles || subordinateProfiles.length === 0) {
    return (
      <div className="space-y-8">
        <h2 className="text-2xl font-semibold">Approvals</h2>
        <p>No missionaries found in your church.</p>
      </div>
    );
  }

  const subordinateIds = subordinateProfiles.map((p) => p.id);
  
  // Create a map of missionary IDs to names for easier lookup
  const missionaryNames = Object.fromEntries(
    subordinateProfiles.map(profile => [profile.id, profile.full_name])
  );

  // Fetch pending leave requests
  const { data: pendingLeaveApprovalsData, error: pendingLeaveError } = await supabase
    .from("leave_requests")
    .select(`
      id,
      type,
      start_date,
      end_date,
      reason,
      status,
      created_at,
      requester_id,
      campus_director_approval
    `)
    .in("requester_id", subordinateIds)
    .eq("status", "pending")
    .eq("campus_director_approval", "none");
    
  // Fetch approved leave requests
  const { data: approvedLeaveApprovalsData, error: approvedLeaveError } = await supabase
    .from("leave_requests")
    .select(`
      id,
      type,
      start_date,
      end_date,
      reason,
      status,
      created_at,
      requester_id,
      campus_director_approval
    `)
    .in("requester_id", subordinateIds)
    .eq("campus_director_approval", "approved");
    
  // Fetch pending surplus requests
  const { data: pendingSurplusApprovalsData, error: pendingSurplusError } = await supabase
    .from("surplus_requests")
    .select(`
      id,
      amount_requested,
      reason,
      status,
      created_at,
      missionary_id,
      campus_director_approval
    `)
    .in("missionary_id", subordinateIds)
    .eq("status", "pending")
    .eq("campus_director_approval", "none");
    
  // Fetch approved surplus requests
  const { data: approvedSurplusApprovalsData, error: approvedSurplusError } = await supabase
    .from("surplus_requests")
    .select(`
      id,
      amount_requested,
      reason,
      status,
      created_at,
      missionary_id,
      campus_director_approval
    `)
    .in("missionary_id", subordinateIds)
    .eq("campus_director_approval", "approved");

  // Format leave approvals with proper typing
  const pendingLeaveApprovals: LeaveApproval[] = (pendingLeaveApprovalsData || []).map((r) => {
    return {
      id: r.id.toString(),
      type: r.type === "sick" ? "Sick Leave" : "Vacation Leave",
      startDate: new Date(r.start_date).toLocaleDateString(),
      endDate: new Date(r.end_date).toLocaleDateString(),
      reason: r.reason || "",
      status: r.status || "pending",
      date: new Date(r.created_at).toLocaleDateString(),
      requester: { full_name: missionaryNames[r.requester_id] || "Unknown" }
    };
  });

  // Only include requests that have been approved by the campus director
  const approvedLeaveApprovals: LeaveApproval[] = (approvedLeaveApprovalsData || [])
    .filter(r => r.campus_director_approval === "approved")
    .map((r) => {
      return {
        id: r.id.toString(),
        type: r.type === "sick" ? "Sick Leave" : "Vacation Leave",
        startDate: new Date(r.start_date).toLocaleDateString(),
        endDate: new Date(r.end_date).toLocaleDateString(),
        reason: r.reason || "",
        status: r.status || "approved",
        date: new Date(r.created_at).toLocaleDateString(),
        requester: { full_name: missionaryNames[r.requester_id] || "Unknown" }
      };
    });

  // Format surplus approvals with proper typing
  const pendingSurplusApprovals: SurplusApproval[] = (pendingSurplusApprovalsData || []).map((r) => {
    return {
      id: r.id.toString(),
      type: "Surplus",
      amount_requested: parseFloat(r.amount_requested) || 0,
      reason: r.reason || "",
      status: r.status || "pending",
      date: new Date(r.created_at).toLocaleDateString(),
      requester: { full_name: missionaryNames[r.missionary_id] || "Unknown" }
    };
  });

  // Only include requests that have been approved by the campus director
  const approvedSurplusApprovals: SurplusApproval[] = (approvedSurplusApprovalsData || [])
    .filter(r => r.campus_director_approval === "approved")
    .map((r) => {
      return {
        id: r.id.toString(),
        type: "Surplus",
        amount_requested: parseFloat(r.amount_requested) || 0,
        reason: r.reason || "",
        status: r.status || "approved",
        date: new Date(r.created_at).toLocaleDateString(),
        requester: { full_name: missionaryNames[r.missionary_id] || "Unknown" }
      };
    });

  return (
    <div className="space-y-8">
      <h2 className="text-2xl font-semibold">Approvals</h2>
      <ApprovalTab
        pendingLeaveApprovals={pendingLeaveApprovals}
        approvedLeaveApprovals={approvedLeaveApprovals}
        pendingSurplusApprovals={pendingSurplusApprovals}
        approvedSurplusApprovals={approvedSurplusApprovals}
      />
    </div>
  );
} 