// app/dashboard/missionary/page.tsx

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import DashboardCards from "@/components/DashboardCards";
import RecentDonations from "@/components/RecentDonations";
import { LeaveRequestModal } from "@/components/LeaveRequestModal";
import { SurplusRequestModal } from "@/components/SurplusRequestModal";
import { ApprovalTab } from "@/components/ApprovalTab";
import { RequestHistoryTab } from "@/components/RequestHistoryTab";
import { ManualRemittanceWizard } from "@/components/ManualRemittanceWizard";
import { ReportsTab } from "@/components/ReportsTab";
import { Sidebar } from "@/components/Sidebar";
import { getUserRole } from "@/utils/getUserRole";
import type { LeaveRequest as DBLeaveRequest, SurplusRequest as DBSurplusRequest } from "@/types";
import { ApprovalStatus, LeaveApproval, SurplusApproval } from "@/types/approval";
import { LeaveRequest as HistoryLeaveRequest, SurplusRequest as HistorySurplusRequest } from "@/types/request";

interface DonorDonation {
  id: number;
  amount: number;
  date: string;
  donor_id: number;
  donors: { id: number; name: string } | null;
}

interface BaseRequest {
  id: string;
  type: 'Leave' | 'Surplus';
  date: string;
  status: 'approved' | 'rejected' | 'pending';
  reason: string;
}

interface LeaveRequest extends BaseRequest {
  type: 'Leave';
  startDate: string;
  endDate: string;
}

interface SurplusRequest extends BaseRequest {
  type: 'Surplus';
  amount: number;
}

export const dynamic = "force-dynamic";

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
    .eq("id", user.id)
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
    .from('donor_donations')
    .select(`
      id,
      amount,
      date,
      donor_id,
      donors!inner(id, name)
    `)
    .eq('missionary_id', user.id)
    .order('date', { ascending: false });

  const rawDonations = (donationsData as unknown as DonorDonation[]) ?? [];

  // Transform donations for RecentDonations and MonthlyDonations components
  const transformedDonations = rawDonations.map((donation) => ({
    id: String(donation.id),
    donor_name: donation.donors?.name ?? "Unknown",
    amount: Number(donation.amount) || 0,
    date: donation.date
  }));

  const initialRecentDonations = transformedDonations.slice(0, 5);

  // -------------------------------
  // Fetch Partner Count Data
  // -------------------------------
  // Get UTC dates
  const now = new Date();
  const startOfCurrentMonth = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), 1))
    .toISOString().split('T')[0];
  const today = new Date().toISOString().split('T')[0];

  // Get all unique donors for this missionary (current month)
  const { data: currentDonors, error: currentError } = await supabase
    .from('donor_donations')
    .select('donor_id')
    .eq('missionary_id', user.id)
    .gte('date', startOfCurrentMonth)
    .lte('date', today)
    .not('donor_id', 'is', null);

  // Get all unique donors before current month
  const { data: previousDonors, error: previousError } = await supabase
    .from('donor_donations')
    .select('donor_id')
    .eq('missionary_id', user.id)
    .lt('date', startOfCurrentMonth)
    .not('donor_id', 'is', null);

  // Calculate counts manually
  const currentDonorIds = new Set(currentDonors?.map(d => d.donor_id) || []);
  const previousDonorIds = new Set(previousDonors?.map(d => d.donor_id) || []);

  // Current partners = unique donors this month
  const currentPartnersCount = currentDonorIds.size;

  // New partners = donors in current month not in previous months
  const newPartnersCount = Array.from(currentDonorIds).filter(
    id => !previousDonorIds.has(id)
  ).length;

  // Handle errors
  if (currentError || previousError) {
    console.error('Partner count errors:', { currentError, previousError });
    throw new Error('Failed to fetch partner counts');
  }

  // After fetching partner counts
  console.log('Current Partners Query:', {
    query: currentDonors,
    params: {
      missionary_id: user.id,
      start_date: startOfCurrentMonth,
      end_date: today
    }
  });

  console.log('New Partners Query:', {
    query: newPartnersCount,
    params: {
      missionary_id: user.id,
      start_date: startOfCurrentMonth,
      end_date: today,
      currentPartnersCount: currentPartnersCount,
      newPartnersCount: newPartnersCount
    }
  });

  // -------------------------------
  // Fetch Request History Data
  // -------------------------------
  const { data: leaveRequestsData } = await supabase
    .from('leave_requests')
    .select('*')
    .eq('requester_id', user.id);

  const { data: surplusRequestsData } = await supabase
    .from('surplus_requests')
    .select('*')
    .eq('requester_id', user.id);

  const leaveRequests = (leaveRequestsData ?? []) as DBLeaveRequest[];
  const surplusRequests = (surplusRequestsData ?? []) as DBSurplusRequest[];

  const initialPendingLeaveRequests = leaveRequests.filter(req => req.status === 'pending');
  const initialApprovedLeaveRequests = leaveRequests.filter(req => req.status === 'approved');
  const initialPendingSurplusRequests = surplusRequests.filter(req => req.status === 'pending');
  const initialApprovedSurplusRequests = surplusRequests.filter(req => req.status === 'approved');

  const currentDonations =
    rawDonations.reduce((acc, d) => acc + d.amount, 0) || 0;
  const pendingRequests =
    [
      ...(leaveRequestsData?.filter((r) => r.status === "pending") || []),
      ...(surplusRequestsData?.filter((r) => r.status === "pending") || []),
    ].length;

  // -------------------------------
  // Approvals for Campus Directors (if applicable)
  // -------------------------------
  const isCampusDirector = profileData.role === "campus_director";
  let pendingLeaveRequests: HistoryLeaveRequest[] = [];
  let approvedLeaveRequests: HistoryLeaveRequest[] = [];
  let pendingSurplusRequests: HistorySurplusRequest[] = [];
  let approvedSurplusRequests: HistorySurplusRequest[] = [];
  let pendingLeaveApprovals: LeaveApproval[] = [];
  let approvedLeaveApprovals: LeaveApproval[] = [];
  let pendingSurplusApprovals: SurplusApproval[] = [];
  let approvedSurplusApprovals: SurplusApproval[] = [];

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
      pendingLeaveApprovalsData?.map((r) => ({
        id: r.id.toString(),
        type: r.type === "vacation" ? "Vacation Leave" as const : "Sick Leave" as const,
        startDate: r.start_date,
        endDate: r.end_date,
        reason: r.reason,
        status: 'pending',
        date: r.created_at,
        requester: r.requester
      })) || [];

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
      approvedLeaveApprovalsData?.map((r) => ({
        id: r.id.toString(),
        type: r.type === "vacation" ? "Vacation Leave" as const : "Sick Leave" as const,
        startDate: r.start_date,
        endDate: r.end_date,
        reason: r.reason,
        status: 'approved',
        date: r.created_at,
        requester: r.requester
      })) || [];

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
        id: r.id.toString(),
        type: 'Surplus',
        amount: r.amount_requested,
        reason: r.reason,
        status: 'pending',
        date: r.created_at,
        requester: r.requester
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
        id: r.id.toString(),
        type: 'Surplus',
        amount: r.amount_requested,
        reason: r.reason,
        status: 'approved',
        date: r.created_at,
        requester: r.requester
      })) || [];

    // Transform and update the request lists
    if (pendingLeaveApprovals) {
      const transformedPendingLeave = pendingLeaveApprovals.map(approval => ({
        id: approval.id.toString(),
        type: approval.type === "vacation" ? "Vacation Leave" : "Sick Leave",
        startDate: approval.startDate,
        endDate: approval.endDate,
        reason: approval.reason,
        status: 'pending',
        date: approval.date,
        requester: approval.requester
      })) as LeaveApproval[];
      initialPendingLeaveRequests.push(...transformedPendingLeave);
    }

    if (approvedLeaveApprovals) {
      const transformedApprovedLeave = approvedLeaveApprovals.map(approval => ({
        id: approval.id.toString(),
        type: approval.type === "vacation" ? "Vacation Leave" : "Sick Leave",
        startDate: approval.startDate,
        endDate: approval.endDate,
        reason: approval.reason,
        status: 'pending',
        date: approval.date,
        requester: approval.requester
      })) as LeaveApproval[];
      initialApprovedLeaveRequests.push(...transformedApprovedLeave);
    }

    if (pendingSurplusApprovals) {
      const transformedPendingSurplus = pendingSurplusApprovals.map(approval => ({
        id: approval.id.toString(),
        type: "Surplus",
        amount: approval.amount,
        reason: approval.reason,
        status: 'pending',
        date: approval.date,
        requester: approval.requester
      })) as SurplusApproval[];
      initialPendingSurplusRequests.push(...transformedPendingSurplus);
    }

    if (approvedSurplusApprovals) {
      const transformedApprovedSurplus = approvedSurplusApprovals.map(approval => ({
        id: approval.id.toString(),
        type: "Surplus",
        amount: approval.amount,
        reason: approval.reason,
        status: 'pending',
        date: approval.date,
        requester: approval.requester
      })) as SurplusApproval[];
      initialApprovedSurplusRequests.push(...transformedApprovedSurplus);
    }
  }

  // -------------------------------
  // Fetch Unique Donors for Manual Remittance
  // -------------------------------
  const { data: donorsData } = await supabase
    .from("donor_donations")
    .select("donors(id, name)")
    .eq("missionary_id", user.id);

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
    .eq("missionary_id", user.id)
    .gte("date", THIRTEEN_MONTHS_AGO.toISOString())
    .order("date", { ascending: true });

  const { data: allTimeDonorsData, error: allTimeError } = await supabase
    .from("donor_donations")
    .select("donor_id, donors!inner(id, name), amount, date")
    .eq("missionary_id", user.id)
    .order("date", { ascending: true });

  if (last13Error) {
    console.error("Error fetching last 13 months data:", last13Error.message);
  }
  if (allTimeError) {
    console.error("Error fetching all-time donors:", allTimeError.message);
  }

  // Transform donations with proper type handling
  const recentDonations = transformedDonations.map((donation) => ({
    id: String(donation.id),
    donor_name: donation.donor_name,
    amount: Number(donation.amount) || 0,
    date: donation.date
  }));

  const monthlyDonations = transformedDonations.map((donation) => ({
    id: String(donation.id),
    donor_name: donation.donor_name,
    amount: Number(donation.amount) || 0,
    date: donation.date
  }));

  // Transform donors for ManualRemittanceWizard
  const partners = (allTimeDonorsData as unknown as DonorDonation[])?.map(record => ({
    id: String(record.donor_id),
    name: record.donors?.name || "Unknown"
  })) || [];

  // Transform leave requests if data exists and not a campus director
  if (!isCampusDirector) {
    const pendingLeaveData = (leaveRequestsData?.filter(request => request.status === "pending") || []) as DBLeaveRequest[];
    const approvedLeaveData = (leaveRequestsData?.filter(request => request.status === "approved") || []) as DBLeaveRequest[];
    const pendingSurplusData = (surplusRequestsData?.filter(request => request.status === "pending") || []) as DBSurplusRequest[];
    const approvedSurplusData = (surplusRequestsData?.filter(request => request.status === "approved") || []) as DBSurplusRequest[];

    // Transform for RequestHistoryTab
    pendingLeaveRequests = pendingLeaveData.map(request => ({
      id: String(request.id),
      type: 'Leave' as const,
      date: request.created_at,
      status: 'pending' as const,
      reason: request.reason || "",
      startDate: request.start_date,
      endDate: request.end_date
    })) as HistoryLeaveRequest[];

    approvedLeaveRequests = approvedLeaveData.map(request => ({
      id: String(request.id),
      type: 'Leave' as const,
      date: request.created_at,
      status: 'approved' as const,
      reason: request.reason || "",
      startDate: request.start_date,
      endDate: request.end_date
    })) as HistoryLeaveRequest[];

    pendingSurplusRequests = pendingSurplusData.map(request => ({
      id: String(request.id),
      type: 'Surplus' as const,
      date: request.created_at,
      status: 'pending' as const,
      reason: request.reason || "",
      amount: Number(request.amount_requested) || 0
    })) as HistorySurplusRequest[];

    approvedSurplusRequests = approvedSurplusData.map(request => ({
      id: String(request.id),
      type: 'Surplus' as const,
      date: request.created_at,
      status: 'approved' as const,
      reason: request.reason || "",
      amount: Number(request.amount_requested) || 0
    })) as HistorySurplusRequest[];

    // Transform for ApprovalTab
    pendingLeaveApprovals = pendingLeaveData.map(request => ({
      id: String(request.id),
      type: request.type === "sick" ? "Sick Leave" as const : "Vacation Leave" as const,
      startDate: request.start_date,
      endDate: request.end_date,
      reason: request.reason || "",
      status: request.status,
      date: request.created_at,
      requester: { full_name: request.requester_id }
    }));

    approvedLeaveApprovals = approvedLeaveData.map(request => ({
      id: String(request.id),
      type: request.type === "sick" ? "Sick Leave" as const : "Vacation Leave" as const,
      startDate: request.start_date,
      endDate: request.end_date,
      reason: request.reason || "",
      status: request.status,
      date: request.created_at,
      requester: { full_name: request.requester_id }
    }));

    pendingSurplusApprovals = pendingSurplusData.map(request => ({
      id: String(request.id),
      type: "Surplus" as const,
      amount: Number(request.amount_requested) || 0,
      reason: request.reason || "",
      status: request.status,
      date: request.created_at,
      requester: { full_name: request.missionary_id }
    }));

    approvedSurplusApprovals = approvedSurplusData.map(request => ({
      id: String(request.id),
      type: "Surplus" as const,
      amount: Number(request.amount_requested) || 0,
      reason: request.reason || "",
      status: request.status,
      date: request.created_at,
      requester: { full_name: request.missionary_id }
    }));
  }

  // Update the request counts
  const totalPendingRequests = pendingLeaveRequests.length + pendingSurplusRequests.length;
  const totalApprovedRequests = approvedLeaveRequests.length + approvedSurplusRequests.length;

  return (
    <div className="relative min-h-screen bg-gray-50 dark:bg-gray-900" key={user.id}>
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
                missionaryId={user.id}
                validateMissionary={isSuperAdmin}
              />
              <SurplusRequestModal
                surplusBalance={profileData.surplus_balance}
                missionaryId={user.id}
              />
            </div>
            <DashboardCards
              monthlyGoal={profileData.monthly_goal || 0}
              currentDonations={currentDonations}
              currentPartnersCount={currentPartnersCount}
              newPartnersCount={newPartnersCount}
              surplusBalance={profileData.surplus_balance}
            />
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <RecentDonations donations={recentDonations} missionaryId={user.id} />
            </div>
          </div>
        )}

        {currentTab === "history" && (
          <div className="space-y-8">
            <h2 className="text-2xl font-semibold">Request History</h2>
            <RequestHistoryTab
              pendingLeaveRequests={pendingLeaveRequests}
              approvedLeaveRequests={approvedLeaveRequests}
              pendingSurplusRequests={pendingSurplusRequests}
              approvedSurplusRequests={approvedSurplusRequests}
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
                missionaryId={user.id}
                partners={partners}
              />
            </aside>
          </div>
        )}

        {currentTab === "reports" && (
          <div className="space-y-8">
            <ReportsTab
              missionaryId={user.id}
              last13MonthDonations={rawDonations}
              allTimeDonors={rawDonations}
            />
          </div>
        )}

        {currentTab === "staff-reports" && profileData.role === 'campus_director' && (
          <div className="space-y-8">
            <ChurchReportsTab churchIds={[profileData.local_church_id]} />
          </div>
        )}
      </div>
    </div>
  );
}
