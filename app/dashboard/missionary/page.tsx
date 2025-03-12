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
 * Optimization improvements:
 * - Implemented component streaming with Suspense boundaries
 * - Prioritized UI shell and static content to load first
 * - Isolated data-fetching components to prevent blocking the entire page
 * - Added skeleton loaders for better perceived performance
 * - Used progressive enhancement for a better user experience
 * - Added client-side tab switching for instant feedback
 * - Persistent sidebar for consistent navigation experience
 * 
 * @page
 */

// Add revalidation period (5 minutes)
export const revalidate = 300;

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import { getUserRole } from "@/utils/getUserRole";
import { ChurchReportsTab } from "@/components/ChurchReportsTab";
import OverviewTab from "@/components/missionary-dashboard/OverviewTabPage";
import { RequestHistoryTabWrapper } from "@/components/missionary-dashboard/RequestHistoryTab";
import { ApprovalsTabWrapper } from "@/components/missionary-dashboard/ApprovalsTab";
import { ManualRemittanceTabWrapper } from "@/components/missionary-dashboard/ManualRemittanceTab";
import { ReportsTabWrapper } from "@/components/missionary-dashboard/ReportsTab";
import { TooltipProvider } from "@/components/ui/tooltip";
import { Suspense } from "react";
import { DashboardTabSkeleton } from "@/components/missionary-dashboard/DashboardTabSkeleton";
import { ClientDashboardLayout } from "@/components/missionary-dashboard/ClientDashboardLayout";

export default async function MissionaryDashboard({
  searchParams,
}: {
  searchParams: { [key: string]: string | string[] | undefined };
}) {
  // Await searchParams before accessing its properties
  const params = await searchParams;
  const currentTab = typeof params.tab === "string" ? params.tab : "overview";
  const userIdParam = Array.isArray(params.userId)
    ? params.userId[0]
    : typeof params.userId === "string"
    ? params.userId
    : undefined;
  
  // Check if this is a refresh request
  const isRefreshRequest = params.refresh !== undefined;

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
      }
    : null);

  // If no profile data and not superadmin, redirect to profile creation
  if (!profileData) {
    redirect("/profile/create");
  }

  // Get church name
  const churchName = profileData.local_church_id && churchData
    ? churchData.name
    : "No Church Assigned";

  // Check if user has access to campus director tabs
  const hasAccessToCampusDirectorTabs = 
    profileData.role === "campus_director" || 
    profileData.role === "superadmin" || 
    isSuperAdmin;

  // Define available tabs based on user role
  const availableTabs = [
    { id: "overview", label: "Overview" },
    { id: "history", label: "Request History" },
    { id: "manual-remittance", label: "Manual Remittance" },
    { id: "reports", label: "Reports" },
  ];

  // Add campus director tabs if user has access
  if (hasAccessToCampusDirectorTabs) {
    availableTabs.push(
      { id: "approvals", label: "Approvals" },
      { id: "staff-reports", label: "Staff Reports" }
    );
  }

  // Generate the tab content based on the current tab
  const getTabContent = () => {
    switch(currentTab) {
      case "overview":
        return (
          <Suspense fallback={<DashboardTabSkeleton type="overview" />}>
            <OverviewTab 
              missionaryId={userIdParam || user.id}
              key={isRefreshRequest ? `refresh-${params.refresh}` : 'overview'}
            />
          </Suspense>
        );
      case "history":
        return (
          <Suspense fallback={<DashboardTabSkeleton type="history" />}>
            <RequestHistoryTabWrapper
              missionaryId={userIdParam || user.id}
            />
          </Suspense>
        );
      case "approvals":
        // Only render approvals tab for campus directors and superadmins
        if (hasAccessToCampusDirectorTabs) {
          return (
            <Suspense fallback={<DashboardTabSkeleton type="approvals" />}>
              <ApprovalsTabWrapper
                campusDirectorId={profileData.id}
              />
            </Suspense>
          );
        }
        // If not authorized, default to overview
        return (
          <Suspense fallback={<DashboardTabSkeleton type="overview" />}>
            <OverviewTab 
              missionaryId={userIdParam || user.id}
            />
          </Suspense>
        );
      case "manual-remittance":
        return (
          <Suspense fallback={<DashboardTabSkeleton type="manual-remittance" />}>
            <ManualRemittanceTabWrapper
              missionaryId={userIdParam || user.id}
            />
          </Suspense>
        );
      case "reports":
        return (
          <Suspense fallback={<DashboardTabSkeleton type="reports" />}>
            <ReportsTabWrapper
              missionaryId={userIdParam || user.id}
            />
          </Suspense>
        );
      case "staff-reports":
        // Only render staff reports tab for campus directors and superadmins
        if (hasAccessToCampusDirectorTabs) {
          return (
            <Suspense fallback={<DashboardTabSkeleton type="staff-reports" />}>
              <TooltipProvider>
                <ChurchReportsTab churchIds={[profileData.local_church_id]} />
              </TooltipProvider>
            </Suspense>
          );
        }
        // If not authorized, default to overview
        return (
          <Suspense fallback={<DashboardTabSkeleton type="overview" />}>
            <OverviewTab 
              missionaryId={userIdParam || user.id}
            />
          </Suspense>
        );
      default:
        // Default to overview if tab is not recognized
        return (
          <Suspense fallback={<DashboardTabSkeleton type="overview" />}>
            <OverviewTab 
              missionaryId={userIdParam || user.id}
            />
          </Suspense>
        );
    }
  };

  // Render the client-side dashboard layout with the initial tab content
  return (
    <ClientDashboardLayout
      initialContent={getTabContent()}
      currentTab={currentTab}
      missionaryId={userIdParam || user.id}
      availableTabs={availableTabs}
      userRole={profileData.role}
      churchName={churchName}
    />
  );
}
