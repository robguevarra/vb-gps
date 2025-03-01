import { createClient } from "@/utils/supabase/server";
import { RequestHistoryTab } from "@/components/RequestHistoryTab";

interface RequestHistoryTabWrapperProps {
  missionaryId: string;
}

export async function RequestHistoryTabWrapper({ missionaryId }: RequestHistoryTabWrapperProps) {
  const supabase = await createClient();
  
  const [leaveRequestsResult, surplusRequestsResult] = await Promise.all([
    supabase
      .from("leave_requests")
      .select("*")
      .eq("requester_id", missionaryId)
      .order("created_at", { ascending: false }),
    supabase
      .from("surplus_requests")
      .select("*")
      .eq("missionary_id", missionaryId)
      .order("created_at", { ascending: false })
  ]);

  const leaveRequestsData = leaveRequestsResult.data || [];
  
  // Ensure surplus requests have the correct amount format
  const surplusRequestsData = (surplusRequestsResult.data || []).map(request => ({
    ...request,
    // Convert amount_requested to a number to ensure proper formatting
    amount_requested: parseFloat(request.amount_requested) || 0
  }));

  return (
    <div className="space-y-8">
      <h2 className="text-2xl font-semibold">Request History</h2>
      <RequestHistoryTab
        pendingLeaveRequests={leaveRequestsData?.filter((r) => r.status === "pending") || []}
        approvedLeaveRequests={leaveRequestsData?.filter((r) => r.status === "approved") || []}
        pendingSurplusRequests={surplusRequestsData?.filter((r) => r.status === "pending") || []}
        approvedSurplusRequests={surplusRequestsData?.filter((r) => r.status === "approved") || []}
      />
    </div>
  );
} 