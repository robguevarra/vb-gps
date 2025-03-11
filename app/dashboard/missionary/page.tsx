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
 * - Added client-side tab prefetching for instant tab switching
 * - Removed duplicate navigation (tabs) to simplify UI
 * - Implemented caching for the Overview tab to prevent unnecessary reloads
 * 
 * @page
 */

// Add revalidation period (5 minutes)
export const revalidate = 300;

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import { getUserRole } from "@/utils/getUserRole";
import { ChurchReportsTab } from "@/components/ChurchReportsTab";
import OverviewTab from "@/components/missionary-dashboard/OverviewTab";
import { OverviewTabWrapper } from "@/components/missionary-dashboard/OverviewTabWrapper";
import { RequestHistoryTabWrapper } from "@/components/missionary-dashboard/RequestHistoryTab";
import { ApprovalsTabWrapper } from "@/components/missionary-dashboard/ApprovalsTab";
import { ManualRemittanceTabWrapper } from "@/components/missionary-dashboard/ManualRemittanceTab";
import { ReportsTabWrapper } from "@/components/missionary-dashboard/ReportsTab";
import { TooltipProvider } from "@/components/ui/tooltip";
import { PageTransition } from "@/components/PageTransition";
import { DashboardTabWrapper } from "@/components/DashboardTabWrapper";
import { AnimatedHeader } from "@/components/AnimatedHeader";
import { Suspense } from "react";
import { DashboardTabSkeleton } from "@/components/missionary-dashboard/DashboardTabSkeleton";
import { DashboardShell } from "@/components/missionary-dashboard/DashboardShell";
import { BackgroundTabPreloader } from "@/components/missionary-dashboard/BackgroundTabPreloader";

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
  
  // Check if this is a refresh request (used for the Overview tab)
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
        surplus_balance: 0,
      }
    : null);

  if (!profileData) {
    redirect("/login");
  }

  const churchName = churchData?.name || (isSuperAdmin ? "All Churches" : "Unknown Church");
  const isCampusDirector = profileData.role === "campus_director";
  
  // Check if user should have access to campus director tabs
  const hasAccessToCampusDirectorTabs = isCampusDirector || isSuperAdmin;

  // Get tab title and subtitle for the current tab
  const getTabInfo = () => {
    switch(currentTab) {
      case "overview":
        return {
          title: "Dashboard Overview",
          subtitle: "View your key metrics and performance indicators"
        };
      case "history":
        return {
          title: "Request History",
          subtitle: "Track and manage your past requests"
        };
      case "approvals":
        return {
          title: "Pending Approvals",
          subtitle: "Review and manage approval requests"
        };
      case "manual-remittance":
        return {
          title: "Manual Remittance",
          subtitle: "Record donations received outside the system"
        };
      case "reports":
        return {
          title: "My Reports",
          subtitle: "View detailed reports and analytics"
        };
      case "staff-reports":
        return {
          title: "Staff Performance",
          subtitle: "Monitor your team's performance metrics"
        };
      default:
        return {
          title: "Dashboard",
          subtitle: "Welcome to your missionary dashboard"
        };
    }
  };

  // Define available tabs for background preloading
  const availableTabs = [
    { id: "overview", label: "Overview" },
    { id: "history", label: "Request History" },
    { id: "manual-remittance", label: "Manual Remittance" },
    { id: "reports", label: "My Reports" },
  ];

  // Add campus director tabs if user has access
  if (hasAccessToCampusDirectorTabs) {
    availableTabs.push(
      { id: "approvals", label: "Approvals" },
      { id: "staff-reports", label: "Staff Reports" }
    );
  }

  // Determine which tab content to render with Suspense boundaries
  const renderTabContent = () => {
    switch(currentTab) {
      case "overview":
        return (
          <Suspense fallback={<DashboardTabSkeleton type="overview" />}>
            <>
              {/* Add the refresh button for the Overview tab */}
              <OverviewTabWrapper 
                missionaryId={userIdParam || user.id}
              />
              
              {/* The actual Overview tab content */}
              <OverviewTab 
                missionaryId={userIdParam || user.id}
                key={isRefreshRequest ? `refresh-${params.refresh}` : 'overview'}
              />
            </>
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

  const { title, subtitle } = getTabInfo();

  return (
    <DashboardShell
      fullName={profileData.full_name || user.email}
      role={profileData.role.replace(/_/g, " ")}
      churchName={churchName}
      title={title}
      subtitle={subtitle}
      userId={userIdParam || user.id}
    >
      {/* Background preloader for other tabs */}
      <BackgroundTabPreloader 
        missionaryId={userIdParam || user.id} 
        availableTabs={availableTabs.map(tab => tab.id)}
      />

      {/* Tab content with page transitions */}
      <PageTransition mode="elastic">
        <DashboardTabWrapper>
          {renderTabContent()}
        </DashboardTabWrapper>
      </PageTransition>
    </DashboardShell>
  );
}
