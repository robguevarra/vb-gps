import { createClient } from "@/utils/supabase/server";
import { RequestHistoryTab } from "@/components/RequestHistoryTab";
import { Suspense } from "react";
import { Skeleton } from "@/components/ui/skeleton";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";

interface RequestHistoryTabWrapperProps {
  missionaryId: string;
}

/**
 * RequestHistoryTabWrapper Component
 * 
 * Server component that fetches leave and surplus request data for the missionary dashboard.
 * Implements optimized data fetching with parallel queries and proper error handling.
 * 
 * @param missionaryId - The ID of the missionary to fetch data for
 */
export async function RequestHistoryTabWrapper({ missionaryId }: RequestHistoryTabWrapperProps) {
  const supabase = await createClient();
  
  // Fetch request data in parallel for better performance
  // Using Promise.all to prevent waterfall requests
  const [leaveRequestsResult, surplusRequestsResult] = await Promise.all([
    supabase
      .from("leave_requests")
      .select("*")
      .eq("requester_id", missionaryId)
      .order("created_at", { ascending: false })
      .throwOnError(),
    supabase
      .from("surplus_requests")
      .select("*")
      .eq("missionary_id", missionaryId)
      .order("created_at", { ascending: false })
      .throwOnError()
  ]).catch(error => {
    console.error("Error fetching request data:", error);
    // Return empty results in case of error
    return [{ data: [] }, { data: [] }];
  });

  // Process and type-check the data before passing to client component
  const leaveRequestsData = leaveRequestsResult.data || [];
  
  // Ensure surplus requests have the correct amount format
  const surplusRequestsData = (surplusRequestsResult.data || []).map(request => ({
    ...request,
    // Convert amount_requested to a number to ensure proper formatting
    amount_requested: parseFloat(request.amount_requested) || 0
  }));

  // Pre-filter the data on the server to reduce client-side processing
  const pendingLeaveRequests = leaveRequestsData.filter((r) => r.status === "pending");
  const approvedLeaveRequests = leaveRequestsData.filter((r) => r.status === "approved");
  const pendingSurplusRequests = surplusRequestsData.filter((r) => r.status === "pending");
  const approvedSurplusRequests = surplusRequestsData.filter((r) => r.status === "approved");

  return (
    <ErrorBoundaryProvider componentName="Request History Tab">
      <div className="space-y-8">
        <Suspense fallback={<RequestHistoryTabSkeleton />}>
          <RequestHistoryTab
            pendingLeaveRequests={pendingLeaveRequests}
            approvedLeaveRequests={approvedLeaveRequests}
            pendingSurplusRequests={pendingSurplusRequests}
            approvedSurplusRequests={approvedSurplusRequests}
          />
        </Suspense>
      </div>
    </ErrorBoundaryProvider>
  );
}

/**
 * Skeleton loader for the RequestHistoryTab
 * Displays while the data is being fetched
 */
function RequestHistoryTabSkeleton() {
  return (
    <div className="space-y-6">
      <div className="h-10 bg-muted rounded-md w-[200px] mb-4" />
      <div className="grid gap-6 md:grid-cols-2">
        <div className="space-y-4">
          <Skeleton className="h-6 w-[150px]" />
          <div className="space-y-4">
            <Skeleton className="h-[100px] w-full rounded-lg" />
            <Skeleton className="h-[100px] w-full rounded-lg" />
          </div>
        </div>
        <div className="space-y-4">
          <Skeleton className="h-6 w-[150px]" />
          <div className="space-y-4">
            <Skeleton className="h-[100px] w-full rounded-lg" />
            <Skeleton className="h-[100px] w-full rounded-lg" />
          </div>
        </div>
      </div>
    </div>
  );
} 