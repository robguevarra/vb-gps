// app/dashboard/missionary/page.tsx

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

export const dynamic = "force-dynamic";

interface LeaveRequest {
  id: string;
  type: "Sick Leave" | "Vacation Leave";
  startDate: string;
  endDate: string;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

interface SurplusRequest {
  id: string;
  type: "Surplus";
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
  const searchParams = await promiseSearchParams;
  const currentTab =
    typeof searchParams.tab === "string" ? searchParams.tab : "overview";
  const userIdParam =
    Array.isArray(searchParams.userId)
      ? searchParams.userId[0]
      : typeof searchParams.userId === "string"
      ? searchParams.userId
      : undefined;

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Retrieve the user's role from the user_roles table.
  const userRole = await getUserRole(user.id);
  const isSuperAdmin = userRole === "superadmin";

  // Fetch profile data (either using provided userId or the logged-in user's id).
  const { data: fetchedProfileData } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", userIdParam || user.id)
    .single();

  const profileData =
    fetchedProfileData ||
    (isSuperAdmin
      ? {
          id: user.id,
          full_name: user.email, // fallback if full name isn't provided
          role: "superadmin",
          local_church_id: null,
          monthly_goal: 0,
          surplus_balance: 0,
        }
      : null);

  if (!profileData) {
    redirect("/login");
  }

  const { data: churchData } = await supabase
    .from("local_churches")
    .select("name")
    .eq("id", profileData.local_church_id)
    .single();
  const churchName =
    churchData?.name || (isSuperAdmin ? "All Churches" : "Unknown Church");

  // -------------------------------
  // Fetch Donation Data
  // -------------------------------
  const { data: donationsData } = await supabase
    .from("donations")
    .select("id, amount, created_at, donor_name, notes")
    .eq("missionary_id", userIdParam || user.id)
    .order("created_at", { ascending: false });

  const { data: donorDonationsData } = await supabase
    .from("donor_donations")
    .select("id, amount, date, donors(name), notes")
    .eq("missionary_id", userIdParam || user.id)
    .order("date", { ascending: false });

  const formattedDonorDonations = donorDonationsData?.map((record) => ({
    id: record.id,
    amount: record.amount,
    created_at: record.date,
    donor_name: Array.isArray(record.donors)
      ? (record.donors as any)[0]?.name || "Unknown"
      : (record.donors as any)?.name || "Unknown",
    notes: record.notes || "",
  })) || [];

  const combinedDonations = [
    ...(donationsData || []),
    ...formattedDonorDonations,
  ]
    .sort(
      (a, b) =>
        new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
    )
    .slice(0, 5);

  // -------------------------------
  // Fetch Request History Data
  // -------------------------------
  const { data: leaveRequestsData } = await supabase
    .from("leave_requests")
    .select("*")
    .eq("requester_id", userIdParam || user.id)
    .order("created_at", { ascending: false });

  const leaveRequests =
    leaveRequestsData?.map((r) => ({
      id: r.id,
      type: "Leave",
      startDate: new Date(r.start_date).toLocaleDateString(),
      endDate: new Date(r.end_date).toLocaleDateString(),
      reason: r.reason,
      status: r.status,
      date: new Date(r.created_at).toLocaleDateString(),
    })) || [];

  const { data: surplusRequestsData } = await supabase
    .from("surplus_requests")
    .select("*")
    .eq("missionary_id", userIdParam || user.id)
    .order("created_at", { ascending: false });

  const surplusRequests =
    surplusRequestsData?.map((r) => ({
      id: r.id,
      type: "Surplus",
      amount: r.amount_requested,
      reason: r.reason,
      status: r.status,
      date: new Date(r.created_at).toLocaleDateString(),
    })) || [];

  const currentDonations =
    combinedDonations?.reduce((acc, d) => acc + d.amount, 0) || 0;
  const pendingRequests =
    [
      ...(leaveRequestsData?.filter((r) => r.status === "pending") || []),
      ...(surplusRequestsData?.filter((r) => r.status === "pending") || []),
    ].length;

  // -------------------------------
  // Approvals for Campus Directors (if applicable)
  // -------------------------------
  const isCampusDirector = profileData.role === "campus_director";
  let pendingLeaveApprovals: LeaveRequest[] = [];
  let approvedLeaveApprovals: LeaveRequest[] = [];
  let pendingSurplusApprovals: SurplusRequest[] = [];
  let approvedSurplusApprovals: SurplusRequest[] = [];

  if (isCampusDirector) {
    const { data: subordinateProfiles } = await supabase
      .from("profiles")
      .select("id, full_name")
      .eq("campus_director_id", profileData.id);
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
    pendingLeaveApprovals =
      pendingLeaveApprovalsData?.map((r) => {
        const status =
          r.lead_pastor_approval === "override"
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

    const { data: approvedLeaveApprovalsData } = await supabase
      .from("leave_requests")
      .select(`
        *,
        requester:profiles(full_name)
      `)
      .in("requester_id", subordinateIds)
      .eq("campus_director_approval", "approved")
      .order("created_at", { ascending: false });
    approvedLeaveApprovals =
      approvedLeaveApprovalsData?.map((r) => {
        const status =
          r.lead_pastor_approval === "override"
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

    const { data: pendingSurplusApprovalsData } = await supabase
      .from("surplus_requests")
      .select(`
        *,
        requester:profiles(full_name)
      `)
      .in("missionary_id", subordinateIds)
      .eq("campus_director_approval", "none")
      .eq("status", "pending")
      .order("created_at", { ascending: false });
    pendingSurplusApprovals =
      pendingSurplusApprovalsData?.map((r) => ({
        id: r.id,
        type: "Surplus",
        amount: r.amount_requested,
        reason: r.reason,
        status: r.status,
        date: new Date(r.created_at).toLocaleDateString(),
        requester: r.requester || null,
      })) || [];

    const { data: approvedSurplusApprovalsData } = await supabase
      .from("surplus_requests")
      .select(`
        *,
        requester:profiles(full_name)
      `)
      .in("missionary_id", subordinateIds)
      .eq("campus_director_approval", "approved")
      .order("created_at", { ascending: false });
    approvedSurplusApprovals =
      approvedSurplusApprovalsData?.map((r) => ({
        id: r.id,
        type: "Surplus",
        amount: r.amount_requested,
        reason: r.reason,
        status: r.status,
        date: new Date(r.created_at).toLocaleDateString(),
        requester: r.requester || null,
      })) || [];
  }

  // -------------------------------
  // Fetch Unique Donors for Manual Remittance
  // -------------------------------
  const { data: donorsData } = await supabase
    .from("donor_donations")
    .select("donors(id, name)")
    .eq("missionary_id", userIdParam || user.id);

  const uniqueDonors = Array.from(
    new Set(donorsData?.map((d) => JSON.stringify(d.donors)) || [])
  ).map((str) => JSON.parse(str));

  // -------------------------------
  // Fetch Data for Reports Tab
  // -------------------------------
  const THIRTEEN_MONTHS_AGO = new Date();
  THIRTEEN_MONTHS_AGO.setMonth(THIRTEEN_MONTHS_AGO.getMonth() - 13);

  const { data: last13MonthDonationsData, error: last13Error } = await supabase
    .from("donor_donations")
    .select("id, amount, date, donor_id, donors!inner(id, name)")
    .eq("missionary_id", userIdParam || user.id)
    .gte("date", THIRTEEN_MONTHS_AGO.toISOString())
    .order("date", { ascending: true });

  const { data: allTimeDonorsData, error: allTimeError } = await supabase
    .from("donor_donations")
    .select("donor_id, donors!inner(id, name), amount, date")
    .eq("missionary_id", userIdParam || user.id)
    .order("date", { ascending: true });

  if (last13Error) {
    console.error("Error fetching last 13 months data:", last13Error.message);
  }
  if (allTimeError) {
    console.error("Error fetching all-time donors:", allTimeError.message);
  }

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

        {currentTab === "overview" && (
          <div className="space-y-8">
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
            <DashboardCards
              monthlyGoal={profileData.monthly_goal || 0}
              currentDonations={currentDonations}
              pendingRequests={pendingRequests}
              surplusBalance={profileData.surplus_balance}
            />
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

        {currentTab === "history" && (
          <div className="space-y-8">
            <h2 className="text-2xl font-semibold">Request History</h2>
            <RequestHistoryTab
              pendingLeaveRequests={leaveRequests.filter((r) => r.status === "pending")}
              approvedLeaveRequests={leaveRequests.filter((r) => r.status === "approved")}
              pendingSurplusRequests={surplusRequests.filter((r) => r.status === "pending")}
              approvedSurplusRequests={surplusRequests.filter((r) => r.status === "approved")}
            />
          </div>
        )}

        {isCampusDirector && currentTab === "approvals" && (
          <div className="space-y-8">
            <ApprovalTab
              pendingLeaveApprovals={pendingLeaveApprovals}
              approvedLeaveApprovals={approvedLeaveApprovals}
              pendingSurplusApprovals={pendingSurplusApprovals}
              approvedSurplusApprovals={approvedSurplusApprovals}
            />
          </div>
        )}

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
                donors={uniqueDonors}
              />
            </aside>
          </div>
        )}

        {currentTab === "reports" && (
          <div className="space-y-8">
            <ReportsTab
              missionaryId={userIdParam || user.id}
              last13MonthDonations={last13MonthDonationsData || []}
              allTimeDonors={allTimeDonorsData || []}
            />
          </div>
        )}
      </div>
    </div>
  );
}
