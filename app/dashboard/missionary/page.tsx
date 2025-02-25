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

// Force dynamic rendering to ensure fresh data on every request
export const dynamic = "force-dynamic";

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import DashboardCards from "@/components/DashboardCards";
import RecentDonations from "@/components/RecentDonations";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import ProfileSelector from "@/components/ProfileSelector";
import { LeaveRequestModal } from "@/components/LeaveRequestModal";
import { SurplusRequestModal } from "@/components/SurplusRequestModal";
import RealtimeSubscriptions from "@/components/RealtimeSubscriptions";
import { ApprovalTab } from "@/components/ApprovalTab";
import { RequestHistoryTab } from "@/components/RequestHistoryTab";
import { ManualRemittanceWizard } from "@/components/ManualRemittanceWizard";
import { ReportsTab } from "@/components/ReportsTab";
import { Sidebar } from "@/components/Sidebar";
import { getUserRole } from "@/utils/getUserRole";
import { ChurchReportsTab } from "@/components/ChurchReportsTab";

interface SearchParams {
  tab?: string;
  userId?: string;
}

interface LeaveRequest {
  id: string;
  type: string;
  startDate: string;
  endDate: string;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

interface SurplusRequest {
  id: string;
  amount: number;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

export default async function MissionaryDashboard({
  searchParams: promiseSearchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) {
  // Resolve search parameters
  const searchParams = await promiseSearchParams;
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

  // Fetch profile data for the current user or selected user
  const { data: fetchedProfileData } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", userIdParam || user.id)
    .single();

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

  // Fetch church data
  const { data: churchData } = await supabase
    .from("local_churches")
    .select("name")
    .eq("id", profileData.local_church_id)
    .single();
  const churchName = churchData?.name || (isSuperAdmin ? "All Churches" : "Unknown Church");

  // -------------------------------
  // Fetch Request Data
  // -------------------------------
  const { data: leaveRequestsData } = await supabase
    .from("leave_requests")
    .select("*")
    .eq("requester_id", userIdParam || user.id)
    .order("created_at", { ascending: false });

  const { data: surplusRequestsData } = await supabase
    .from("surplus_requests")
    .select("*")
    .eq("missionary_id", userIdParam || user.id)
    .order("created_at", { ascending: false });

  // -------------------------------
  // Fetch Donation Data
  // -------------------------------
  // Get donations from both tables and combine them
  const { data: donationsData } = await supabase
    .from("donations")
    .select("id, amount, created_at, donor_name, notes")
    .eq("missionary_id", userIdParam || user.id)
    .order("created_at", { ascending: false });

  const { data: donorDonationsData } = await supabase
    .from("donor_donations")
    .select("id, amount, date, donor_id, donors!inner(id, name), notes")
    .eq("missionary_id", userIdParam || user.id)
    .order("date", { ascending: false });

  // Format donor donations to match regular donations structure
  const formattedDonorDonations = donorDonationsData?.map((record) => ({
    id: record.id,
    amount: record.amount,
    created_at: record.date,
    donor_name: record.donors ? (record.donors as any).name : "Unknown",
    notes: record.notes || "",
  })) || [];

  // Combine and sort all donations
  const combinedDonations = [
    ...(donationsData || []),
    ...formattedDonorDonations,
  ]
    .sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime())
    .slice(0, 5);

  // -------------------------------
  // Fetch Partner Count Data
  // -------------------------------
  // Get UTC dates for current month
  const now = new Date();
  const startOfCurrentMonth = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), 1))
    .toISOString().split('T')[0];
  const today = new Date().toISOString().split('T')[0];

  // Get current month donors
  const { data: currentDonors, error: currentError } = await supabase
    .from('donor_donations')
    .select('donor_id')
    .eq('missionary_id', userIdParam || user.id)
    .gte('date', startOfCurrentMonth)
    .lte('date', today)
    .not('donor_id', 'is', null);

  // Get previous donors
  const { data: previousDonors, error: previousError } = await supabase
    .from('donor_donations')
    .select('donor_id')
    .eq('missionary_id', userIdParam || user.id)
    .lt('date', startOfCurrentMonth)
    .not('donor_id', 'is', null);

  // Calculate partner counts
  const currentDonorIds = new Set(currentDonors?.map(d => d.donor_id) || []);
  const previousDonorIds = new Set(previousDonors?.map(d => d.donor_id) || []);
  const currentPartnersCount = currentDonorIds.size;
  const newPartnersCount = Array.from(currentDonorIds).filter(id => !previousDonorIds.has(id)).length;

  // Calculate totals
  const currentDonations = combinedDonations?.reduce((acc, d) => acc + d.amount, 0) || 0;
  const pendingRequests = [
    ...(leaveRequestsData?.filter((r) => r.status === "pending") || []),
    ...(surplusRequestsData?.filter((r) => r.status === "pending") || []),
  ].length;

  // -------------------------------
  // Fetch Approval Data for Campus Directors
  // -------------------------------
  const isCampusDirector = profileData.role === "campus_director";
  let pendingLeaveApprovals: LeaveRequest[] = [];
  let approvedLeaveApprovals: LeaveRequest[] = [];
  let pendingSurplusApprovals: SurplusRequest[] = [];
  let approvedSurplusApprovals: SurplusRequest[] = [];

  if (isCampusDirector) {
    // Get subordinate profiles
    const { data: subordinateProfiles } = await supabase
      .from("profiles")
      .select("id, full_name")
      .eq("campus_director_id", profileData.id);
    const subordinateIds = subordinateProfiles?.map((p) => p.id) || [];

    // Get pending leave approvals
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

    // Format leave approvals
    pendingLeaveApprovals = pendingLeaveApprovalsData?.map((r) => {
      const status = r.lead_pastor_approval === "override"
        ? "approved"
        : r.campus_director_approval === "rejected"
        ? "rejected"
        : r.lead_pastor_approval === "approved"
        ? "approved"
        : r.status;
      return {
        id: r.id.toString(),
        type: r.type === "sick" ? "Sick Leave" : "Vacation Leave",
        startDate: r.start_date,
        endDate: r.end_date,
        reason: r.reason,
        status,
        date: new Date(r.created_at).toLocaleDateString(),
        requester: r.requester || null,
      };
    }) || [];

    // Similar data fetching for surplus approvals...
  }

  // Get unique donors for manual remittance
  const { data: uniqueDonors } = await supabase
    .from("donors")
    .select("id, name")
    .order("name", { ascending: true });

  // Get last 13 months donations data for reports
  const { data: last13MonthDonationsData } = await supabase
    .from("donor_donations")
    .select("id, amount, date, donor_id, donors(id, name)")
    .eq("missionary_id", userIdParam || user.id)
    .gte("date", new Date(new Date().setMonth(new Date().getMonth() - 13)).toISOString())
    .order("date", { ascending: false });

  // Get all-time donors data for reports
  const { data: allTimeDonorsData } = await supabase
    .from("donor_donations")
    .select("donor_id, amount, date, donors(id, name)")
    .eq("missionary_id", userIdParam || user.id)
    .order("date", { ascending: false });

  return (
    <div className="relative min-h-screen bg-gray-50 dark:bg-gray-900" key={userIdParam || user.id}>
      {/* Pinned Sidebar on large screens */}
      <Sidebar isCampusDirector={profileData.role === "campus_director"} />

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
          <div className="space-y-8">
            {/* Request Actions */}
            <div className="flex gap-4">
              <LeaveRequestModal
                missionaryId={userIdParam || user.id}
                validateMissionary={isSuperAdmin}
              />
              <SurplusRequestModal
                surplusBalance={profileData.surplus_balance}
                missionaryId={userIdParam}
              />
            </div>

            {/* Dashboard Cards */}
            <DashboardCards
              monthlyGoal={profileData.monthly_goal || 0}
              currentDonations={currentDonations}
              currentPartnersCount={currentPartnersCount}
              newPartnersCount={newPartnersCount}
              surplusBalance={profileData.surplus_balance}
            />

            {/* Recent Donations */}
            <RecentDonations
              donations={combinedDonations.map((d) => ({
                id: d.id,
                donor_name: d.donor_name,
                amount: d.amount,
                date: new Date(d.created_at).toLocaleDateString(),
                notes: d.notes || "",
              }))}
              missionaryId={userIdParam || user.id}
            />
          </div>
        )}

        {/* Request History Tab */}
        {currentTab === "history" && (
          <div className="space-y-8">
            <h2 className="text-2xl font-semibold">Request History</h2>
            <RequestHistoryTab
              pendingLeaveRequests={leaveRequestsData?.filter((r) => r.status === "pending") || []}
              approvedLeaveRequests={leaveRequestsData?.filter((r) => r.status === "approved") || []}
              pendingSurplusRequests={surplusRequestsData?.filter((r) => r.status === "pending") || []}
              approvedSurplusRequests={surplusRequestsData?.filter((r) => r.status === "approved") || []}
            />
          </div>
        )}

        {/* Approvals Tab (Campus Directors Only) */}
        {isCampusDirector && currentTab === "approvals" && (
          <div className="space-y-8">
            <ApprovalTab
              pendingLeaveApprovals={pendingLeaveApprovals.map(r => ({
                ...r,
                type: r.type as "Sick Leave" | "Vacation Leave"
              }))}
              approvedLeaveApprovals={approvedLeaveApprovals.map(r => ({
                ...r,
                type: r.type as "Sick Leave" | "Vacation Leave"
              }))}
              pendingSurplusApprovals={pendingSurplusApprovals.map(r => ({
                ...r,
                type: "Surplus" as const
              }))}
              approvedSurplusApprovals={approvedSurplusApprovals.map(r => ({
                ...r,
                type: "Surplus" as const
              }))}
            />
          </div>
        )}

        {/* Manual Remittance Tab */}
        {currentTab === "manual-remittance" && (
          <div className="flex flex-col gap-6 md:flex-row">
            <div className="flex-1 space-y-4">
              <h2 className="text-2xl font-semibold">Manual Remittance</h2>
              <p className="text-muted-foreground text-sm">
                Here you can record offline donations. Enter the total amount, add donors, and submit.
              </p>
              <div className="bg-white p-4 rounded-md shadow dark:bg-gray-800">
                <h3 className="text-lg font-medium">Remittance Instructions</h3>
                <p className="text-sm mt-2 text-muted-foreground">
                  1. Fill out the total amount received.<br />
                  2. Add each donor entry and the amount they contributed.<br />
                  3. Click Submit to record these donations.
                </p>
              </div>
            </div>
            <aside className="w-full md:w-96 lg:w-[30rem] bg-white dark:bg-gray-800 rounded-md shadow p-4">
              <ManualRemittanceWizard
                missionaryId={userIdParam || user.id}
              />
            </aside>
          </div>
        )}

        {/* Reports Tab */}
        {currentTab === "reports" && (
          <div className="space-y-8">
            <ReportsTab
              missionaryId={userIdParam || user.id}
              last13MonthDonations={last13MonthDonationsData?.map(d => ({
                id: Number(d.id),
                amount: Number(d.amount),
                date: String(d.date),
                donor_id: Number(d.donor_id),
                donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
                  id: Number(d.donors.id),
                  name: String(d.donors.name)
                } : null
              })) || []}
              allTimeDonors={allTimeDonorsData?.map(d => ({
                donor_id: Number(d.donor_id),
                amount: Number(d.amount),
                date: String(d.date),
                donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
                  id: Number(d.donors.id),
                  name: String(d.donors.name)
                } : null
              })) || []}
            />
          </div>
        )}

        {/* Staff Reports Tab (Campus Directors Only) */}
        {currentTab === "staff-reports" && profileData.role === 'campus_director' && (
          <div className="space-y-8">
            <ChurchReportsTab churchIds={[profileData.local_church_id]} />
          </div>
        )}
      </div>
    </div>
  );
}
