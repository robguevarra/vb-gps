import { createClient } from "@/utils/supabase/server";
import { ApprovalTab } from "@/components/ApprovalTab";

interface ApprovalsTabWrapperProps {
  campusDirectorId: string;
}

export async function ApprovalsTabWrapper({ campusDirectorId }: ApprovalsTabWrapperProps) {
  const supabase = await createClient();

  // Get subordinate profiles
  const { data: subordinateProfiles } = await supabase
    .from("profiles")
    .select("id, full_name")
    .eq("campus_director_id", campusDirectorId);
  
  const subordinateIds = subordinateProfiles?.map((p) => p.id) || [];

  const { data: pendingLeaveApprovalsData } = await supabase
    .from("leave_requests")
    .select(`
      *,
      requester:profiles(full_name)
    `)
    .in("requester_id", subordinateIds)
    .eq("campus_director_approval", "none")
    .eq("status", "pending")
    .order("created_at", { ascending: false });

  // Format approvals
  const pendingLeaveApprovals = pendingLeaveApprovalsData?.map((r) => ({
    id: r.id.toString(),
    type: r.type === "sick" ? "Sick Leave" : "Vacation Leave",
    startDate: r.start_date,
    endDate: r.end_date,
    reason: r.reason,
    status: r.status,
    date: new Date(r.created_at).toLocaleDateString(),
    requester: r.requester || null,
  })) || [];

  return (
    <div className="space-y-8">
      <ApprovalTab
        pendingLeaveApprovals={pendingLeaveApprovals}
        approvedLeaveApprovals={[]}
        pendingSurplusApprovals={[]}
        approvedSurplusApprovals={[]}
      />
    </div>
  );
} 