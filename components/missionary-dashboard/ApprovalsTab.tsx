import { createClient } from "@/utils/supabase/server";
import { ApprovalTab } from "@/components/ApprovalTab";
import { Suspense } from "react";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Alert, AlertTitle, AlertDescription } from "@/components/ui/alert";
import { AlertCircle } from "lucide-react";

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

/**
 * ApprovalsTabWrapper Component
 * 
 * Server component that fetches approval data for the missionary dashboard.
 * Implements optimized data fetching with parallel queries and proper error handling.
 * 
 * @param campusDirectorId - The ID of the campus director to fetch data for
 */
export async function ApprovalsTabWrapper({ campusDirectorId }: ApprovalsTabWrapperProps) {
  const supabase = await createClient();

  try {
    // First, get the campus director's profile to get their local_church_id
    const { data: campusDirectorProfile, error: profileError } = await supabase
      .from("profiles")
      .select("local_church_id")
      .eq("id", campusDirectorId)
      .single();

    if (profileError || !campusDirectorProfile?.local_church_id) {
      return (
        <div className="space-y-8">
          <h2 className="text-2xl font-semibold">Approvals</h2>
          <div className="p-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-md">
            <p className="text-red-600 dark:text-red-400">Error: Could not determine your church. Please contact support.</p>
          </div>
        </div>
      );
    }

    // Get all missionaries from the same local church
    const { data: subordinateProfiles, error: subordinatesError } = await supabase
      .from("profiles")
      .select("id, full_name")
      .eq("local_church_id", campusDirectorProfile.local_church_id)
      .eq("role", "missionary");
    
    if (subordinatesError || !subordinateProfiles || subordinateProfiles.length === 0) {
      return (
        <div className="space-y-8">
          <h2 className="text-2xl font-semibold">Approvals</h2>
          <div className="p-4 bg-muted rounded-md">
            <p className="text-muted-foreground">No missionaries found in your church.</p>
          </div>
        </div>
      );
    }

    const subordinateIds = subordinateProfiles.map((p) => p.id);
    
    // Create a map of missionary IDs to names for efficient lookup
    const missionaryNames = Object.fromEntries(
      subordinateProfiles.map(profile => [profile.id, profile.full_name])
    );

    // Fetch all approval data in parallel for better performance
    const [
      pendingLeaveApprovalsResult, 
      approvedLeaveApprovalsResult, 
      pendingSurplusApprovalsResult, 
      approvedSurplusApprovalsResult
    ] = await Promise.all([
      // Fetch pending leave requests
      supabase
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
        .eq("campus_director_approval", "none")
        .throwOnError(),
        
      // Fetch approved leave requests
      supabase
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
        .eq("campus_director_approval", "approved")
        .throwOnError(),
        
      // Fetch pending surplus requests
      supabase
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
        .eq("campus_director_approval", "none")
        .throwOnError(),
        
      // Fetch approved surplus requests
      supabase
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
        .eq("campus_director_approval", "approved")
        .throwOnError()
    ]).catch(error => {
      console.error("Error fetching approval data:", error);
      // Return empty results in case of error
      return [{ data: [] }, { data: [] }, { data: [] }, { data: [] }];
    });

    // Format leave approvals with proper typing
    const pendingLeaveApprovals: LeaveApproval[] = (pendingLeaveApprovalsResult.data || []).map((r) => {
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
    const approvedLeaveApprovals: LeaveApproval[] = (approvedLeaveApprovalsResult.data || [])
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
    const pendingSurplusApprovals: SurplusApproval[] = (pendingSurplusApprovalsResult.data || []).map((r) => {
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
    const approvedSurplusApprovals: SurplusApproval[] = (approvedSurplusApprovalsResult.data || [])
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

    // Custom fallback UI for approvals tab errors
    const approvalsTabErrorFallback = (
      <Alert variant="destructive" className="my-4">
        <AlertCircle className="h-4 w-4" />
        <AlertTitle>Approvals Tab Error</AlertTitle>
        <AlertDescription>
          <p className="mb-2">There was an error loading the approvals tab.</p>
          <p className="mb-2">Please try refreshing the page or contact support if the issue persists.</p>
        </AlertDescription>
      </Alert>
    );

    return (
      <ErrorBoundary fallback={approvalsTabErrorFallback}>
        <div className="space-y-8">
          <h2 className="text-2xl font-semibold">Approvals</h2>
          <Suspense fallback={<ApprovalsTabSkeleton />}>
            <ApprovalTab
              pendingLeaveApprovals={pendingLeaveApprovals}
              approvedLeaveApprovals={approvedLeaveApprovals}
              pendingSurplusApprovals={pendingSurplusApprovals}
              approvedSurplusApprovals={approvedSurplusApprovals}
            />
          </Suspense>
        </div>
      </ErrorBoundary>
    );
  } catch (error) {
    console.error("Unexpected error in ApprovalsTabWrapper:", error);
    return (
      <div className="space-y-8">
        <h2 className="text-2xl font-semibold">Approvals</h2>
        <div className="p-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-md">
          <p className="text-red-600 dark:text-red-400">An unexpected error occurred. Please try again later.</p>
        </div>
      </div>
    );
  }
}

/**
 * Skeleton loader for the ApprovalsTab
 * Displays while the data is being fetched
 */
function ApprovalsTabSkeleton() {
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