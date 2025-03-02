/**
 * Missionary Dashboard Page
 * 
 * This is the main dashboard for missionaries and campus directors. It provides:
 * - Overview of donations and partner statistics
 * - Leave and surplus request management
 * - Manual remittance recording
 * - Reports and analytics
 * - Approval workflows for campus directors
 * 
 * The dashboard is dynamic and adapts its features based on the user's role
 * (missionary or campus director) and permissions.
 * 
 * @page
 */

// Add revalidation period (5 minutes)
export const revalidate = 300;

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import { Sidebar } from "@/components/Sidebar";
import { getUserRole } from "@/utils/getUserRole";
import { ChurchReportsTab } from "@/components/ChurchReportsTab";
import { OverviewTab } from "@/components/missionary-dashboard/OverviewTab";
import { RequestHistoryTabWrapper } from "@/components/missionary-dashboard/RequestHistoryTab";
import { ApprovalsTabWrapper } from "@/components/missionary-dashboard/ApprovalsTab";
import { ManualRemittanceTabWrapper } from "@/components/missionary-dashboard/ManualRemittanceTab";
import { ReportsTabWrapper } from "@/components/missionary-dashboard/ReportsTab";
import { TooltipProvider } from "@/components/ui/tooltip";

export default async function MissionaryDashboard({
  searchParams,
}: {
  searchParams: { [key: string]: string | string[] | undefined };
}) {
  const currentTab = typeof searchParams.tab === "string" ? searchParams.tab : "overview";
  const userIdParam = Array.isArray(searchParams.userId)
    ? searchParams.userId[0]
    : typeof searchParams.userId === "string"
    ? searchParams.userId
    : undefined;

  // Initialize Supabase client and get current user
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Get user role and check superadmin status
  const userRole = await getUserRole(user.id);
  const isSuperAdmin = userRole === "superadmin";

  // Only fetch essential profile and church data
  const [profileResult, churchResult] = await Promise.all([
    supabase
      .from("profiles")
      .select("*")
      .eq("id", userIdParam || user.id)
      .single(),
    supabase
      .from("local_churches")
      .select("name")
  ]);

  // Extract data and handle errors
  const fetchedProfileData = profileResult.data;
  const churchData = churchResult.data?.[0];

  // Create default profile for superadmin if needed
  const profileData = fetchedProfileData || (isSuperAdmin
    ? {
        id: user.id,
        full_name: user.email,
        role: "superadmin",
        local_church_id: null,
        monthly_goal: 0,
        surplus_balance: 0,
      }
    : null);

  if (!profileData) {
    redirect("/login");
  }

  const churchName = churchData?.name || (isSuperAdmin ? "All Churches" : "Unknown Church");
  const isCampusDirector = profileData.role === "campus_director";

  return (
    <div className="relative min-h-screen bg-gray-50 dark:bg-gray-900" key={userIdParam || user.id}>
      {/* Pinned Sidebar on large screens */}
      <Sidebar isCampusDirector={isCampusDirector} />

      {/* Main Content Offset by Sidebar Width */}
      <div className="lg:ml-64 px-4 sm:px-6 lg:px-8 py-8">
        <header className="mb-8">
          <h1 className="text-3xl font-semibold text-gray-900 dark:text-gray-100">
            {profileData.full_name || user.email}
          </h1>
          <div className="flex items-center gap-2 mt-1">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              {profileData.role.replace(/_/g, " ")}
            </p>
            <span className="text-sm text-gray-400">•</span>
            <p className="text-sm text-gray-500 dark:text-gray-400">{churchName}</p>
          </div>
        </header>

        {/* Overview Tab */}
        {currentTab === "overview" && (
          <OverviewTab 
            missionaryId={userIdParam || user.id}
            profileData={profileData}
            isSuperAdmin={isSuperAdmin}
          />
        )}

        {/* Request History Tab */}
        {currentTab === "history" && (
          <RequestHistoryTabWrapper
            missionaryId={userIdParam || user.id}
          />
        )}

        {/* Approvals Tab (Campus Directors Only) */}
        {isCampusDirector && currentTab === "approvals" && (
          <ApprovalsTabWrapper
            campusDirectorId={profileData.id}
          />
        )}

        {/* Manual Remittance Tab */}
        {currentTab === "manual-remittance" && (
          <ManualRemittanceTabWrapper
            missionaryId={userIdParam || user.id}
          />
        )}

        {/* Reports Tab */}
        {currentTab === "reports" && (
          <ReportsTabWrapper
            missionaryId={userIdParam || user.id}
          />
        )}

        {/* Staff Reports Tab (Campus Directors Only) */}
        {currentTab === "staff-reports" && profileData.role === 'campus_director' && (
          <TooltipProvider>
            <ChurchReportsTab churchIds={[profileData.local_church_id]} />
          </TooltipProvider>
        )}
      </div>
    </div>
  );
}
