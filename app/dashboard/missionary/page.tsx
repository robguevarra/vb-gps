// app/dashboard/missionary/page.tsx
import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';
import DashboardCards from '@/components/DashboardCards';
import RecentDonations from '@/components/RecentDonations';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import ProfileSelector from '@/components/ProfileSelector';
import { LeaveRequestModal } from '@/components/LeaveRequestModal';
import { SurplusRequestModal } from '@/components/SurplusRequestModal';
import RealtimeSubscriptions from '@/components/RealtimeSubscriptions';
import { ApprovalTab } from '@/components/ApprovalTab';

export const dynamic = 'force-dynamic';

interface LeaveRequest {
  id: string;
  type: 'Sick Leave' | 'Vacation Leave';
  startDate: string;
  endDate: string;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

interface SurplusRequest {
  id: string;
  type: 'Surplus';
  amount: number;
  reason: string;
  status: string;
  date: string;
  requester?: { full_name: string } | null;
}

export default async function MissionaryDashboard(
  props: { searchParams: Promise<{ [key: string]: string | string[] | undefined }> }
) {
  const searchParams = await props.searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  console.log('Authenticated User:', user);

  const userIdParam = typeof searchParams.userId === 'string'
    ? searchParams.userId
    : Array.isArray(searchParams.userId)
      ? searchParams.userId[0]
      : undefined;
  console.log('Computed userIdParam:', userIdParam);
  console.log(
    'UserIdParam vs Current User:',
    `Param: ${userIdParam}`,
    `User: ${user?.id}`,
    `Is SuperAdmin: ${user?.email === 'robneil@gmail.com'}`
  );

  if (!user) {
    redirect('/login');
  }

  const isSuperAdmin = user.email === 'robneil@gmail.com';
  console.log('Is SuperAdmin:', isSuperAdmin);

  const { data: allMissionaries } = isSuperAdmin 
    ? await supabase
          .from('profiles')
          .select('*')
          .neq('role', 'superadmin')
    : { data: null };

  const { data: fetchedProfileData } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userIdParam || user.id)
    .single();

  const { data: churchData } = await supabase
    .from('local_churches')
    .select('name')
    .eq('id', fetchedProfileData?.local_church_id)
    .single();

  const profileData = fetchedProfileData || (isSuperAdmin ? {
    id: user.id,
    full_name: user.user_metadata?.full_name || user.email,
    role: 'superadmin',
    local_church_id: null,
    monthly_goal: 0,
    surplus_balance: 0
  } : null);

  const churchName = churchData?.name || (isSuperAdmin ? 'All Churches' : 'Unknown Church');

  if (!profileData) {
    redirect('/login');
  }
  console.log('Profile Data to use:', profileData);

  // -------------------------------
  // Fetch Donation Data
  // -------------------------------
  const { data: donationsData } = await supabase
    .from('donations')
    .select('id, amount, created_at, donor_name, notes')
    .eq('missionary_id', userIdParam || user.id)
    .order('created_at', { ascending: false });

  const { data: donorDonationsData } = await supabase
    .from('donor_donations')
    .select('id, amount, date, donors(name), notes')
    .eq('missionary_id', userIdParam || user.id)
    .order('date', { ascending: false });

  const formattedDonorDonations = donorDonationsData?.map(record => ({
    id: record.id,
    amount: record.amount,
    created_at: record.date,
    donor_name: Array.isArray(record.donors) ? ((record.donors as any)[0]?.name || "Unknown") : ((record.donors as any)?.name || "Unknown"),
    notes: record.notes || ""
  })) || [];

  const combinedDonations = [
    ...(donationsData || []),
    ...formattedDonorDonations
  ].sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime())
    .slice(0, 5);

  // -------------------------------
  // Fetch Request History Data for this missionary (static display)
  // -------------------------------
  const { data: leaveRequestsData } = await supabase
    .from('leave_requests')
    .select('*')
    .eq('requester_id', userIdParam || user.id)
    .order('created_at', { ascending: false });
  console.log('Leave Requests Data:', leaveRequestsData);

  const { data: surplusRequestsData } = await supabase
    .from('surplus_requests')
    .select('*')
    .eq('missionary_id', userIdParam || user.id)
    .order('created_at', { ascending: false });
  console.log('Surplus Requests Data:', surplusRequestsData);

  const currentDonations = combinedDonations?.reduce((acc, d) => acc + d.amount, 0) || 0;
  const pendingRequests = [
    ...(leaveRequestsData?.filter(r => r.status === 'pending') || []),
    ...(surplusRequestsData?.filter(r => r.status === 'pending') || [])
  ].length;
  console.log('Pending Requests Count:', pendingRequests);

  // Map for Request History (static display)
  const leaveRequests: LeaveRequest[] = leaveRequestsData?.map(r => {
    const status = r.lead_pastor_approval === 'override' ? 'approved' :
                   r.campus_director_approval === 'rejected' ? 'rejected' :
                   r.lead_pastor_approval === 'approved' ? 'approved' :
                   r.status;
    return {
      id: r.id.toString(),
      type: r.type === 'sick' ? 'Sick Leave' : 'Vacation Leave',
      startDate: r.start_date,
      endDate: r.end_date,
      reason: r.reason,
      status,
      date: new Date(r.created_at).toLocaleDateString(),
      requester: null,
    };
  }) || [];

  const surplusRequests: SurplusRequest[] = surplusRequestsData?.map(r => ({
    id: r.id,
    type: 'Surplus',
    amount: r.amount_requested,
    reason: r.reason,
    status: r.status,
    date: new Date(r.created_at).toLocaleDateString(),
    requester: null,
  })) || [];

  // -------------------------------
  // Approvals for Campus Directors (only pending and approved)
  // -------------------------------
  const isCampusDirector = profileData.role === 'campus_director';
  let pendingLeaveApprovals: LeaveRequest[] = [];
  let approvedLeaveApprovals: LeaveRequest[] = [];
  let pendingSurplusApprovals: SurplusRequest[] = [];
  let approvedSurplusApprovals: SurplusRequest[] = [];

  if (isCampusDirector) {
    const { data: subordinateProfiles } = await supabase
      .from('profiles')
      .select('id, full_name')
      .eq('campus_director_id', profileData.id);
    const subordinateIds = subordinateProfiles?.map(p => p.id) || [];

    // Pending leave approvals:
    const { data: pendingLeaveApprovalsData } = await supabase
      .from('leave_requests')
      .select(`
        *,
        requester:profiles(full_name)
      `)
      .in('requester_id', subordinateIds)
      .eq('campus_director_approval', 'none')
      .eq('status', 'pending')
      .order('created_at', { ascending: false });
    pendingLeaveApprovals = pendingLeaveApprovalsData?.map(r => {
      const status = r.lead_pastor_approval === 'override' ? 'approved' :
                     r.campus_director_approval === 'rejected' ? 'rejected' :
                     r.lead_pastor_approval === 'approved' ? 'approved' :
                     r.status;
      return {
        id: r.id.toString(),
        type: r.type === 'sick' ? 'Sick Leave' : 'Vacation Leave',
        startDate: r.start_date,
        endDate: r.end_date,
        reason: r.reason,
        status,
        date: new Date(r.created_at).toLocaleDateString(),
        requester: r.requester || null,
      };
    }) || [];

    // Approved leave requests:
    const { data: approvedLeaveApprovalsData } = await supabase
      .from('leave_requests')
      .select(`
        *,
        requester:profiles(full_name)
      `)
      .in('requester_id', subordinateIds)
      .eq('campus_director_approval', 'approved')
      .order('created_at', { ascending: false });
    approvedLeaveApprovals = approvedLeaveApprovalsData?.map(r => {
      const status = r.lead_pastor_approval === 'override' ? 'approved' :
                     r.campus_director_approval === 'rejected' ? 'rejected' :
                     r.lead_pastor_approval === 'approved' ? 'approved' :
                     r.status;
      return {
        id: r.id.toString(),
        type: r.type === 'sick' ? 'Sick Leave' : 'Vacation Leave',
        startDate: r.start_date,
        endDate: r.end_date,
        reason: r.reason,
        status,
        date: new Date(r.created_at).toLocaleDateString(),
        requester: r.requester || null,
      };
    }) || [];

    // Pending surplus approvals:
    const { data: pendingSurplusApprovalsData } = await supabase
      .from('surplus_requests')
      .select(`
        *,
        requester:profiles(full_name)
      `)
      .in('missionary_id', subordinateIds)
      .eq('campus_director_approval', 'none')
      .eq('status', 'pending')
      .order('created_at', { ascending: false });
    pendingSurplusApprovals = pendingSurplusApprovalsData?.map(r => ({
      id: r.id,
      type: 'Surplus',
      amount: r.amount_requested,
      reason: r.reason,
      status: r.status,
      date: new Date(r.created_at).toLocaleDateString(),
      requester: r.requester || null,
    })) || [];

    // Approved surplus approvals:
    const { data: approvedSurplusApprovalsData } = await supabase
      .from('surplus_requests')
      .select(`
        *,
        requester:profiles(full_name)
      `)
      .in('missionary_id', subordinateIds)
      .eq('campus_director_approval', 'approved')
      .order('created_at', { ascending: false });
    approvedSurplusApprovals = approvedSurplusApprovalsData?.map(r => ({
      id: r.id,
      type: 'Surplus',
      amount: r.amount_requested,
      reason: r.reason,
      status: r.status,
      date: new Date(r.created_at).toLocaleDateString(),
      requester: r.requester || null,
    })) || [];
  }

  console.log('[Dashboard] Modal IDs:', `Leave: ${userIdParam || user.id}`, `Surplus: ${userIdParam || user.id}`);

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900" key={userIdParam || user.id}>
      <RealtimeSubscriptions 
        tables={[
          { 
            name: 'leave_requests',
            filter: `requester_id=eq.${userIdParam || user.id}`,
            event: 'INSERT,UPDATE,DELETE'
          },
          {
            name: 'surplus_requests',
            filter: `missionary_id=eq.${userIdParam || user.id}`,
            event: 'INSERT,UPDATE,DELETE'
          },
          {
            name: 'donations',
            filter: `missionary_id=eq.${userIdParam || user.id}`,
            event: 'INSERT,UPDATE,DELETE'
          },
          {
            name: 'donor_donations',
            filter: `missionary_id=eq.${userIdParam || user.id}`,
            event: 'INSERT,UPDATE,DELETE'
          }
        ]}
      />
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <header className="mb-8">
          <h1 className="text-3xl font-semibold text-gray-900 dark:text-gray-100">
            {profileData.full_name || user.email}
          </h1>
          <div className="flex items-center gap-2 mt-1">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              {profileData.role.replace(/_/g, " ")}
              {profileData.role === "campus_director" && " (Director)"}
            </p>
            <span className="text-sm text-gray-400">•</span>
            <p className="text-sm text-gray-500 dark:text-gray-400">{churchName}</p>
          </div>
        </header>
        {isSuperAdmin && (
          <div className="mb-8">
            <ProfileSelector 
              missionaries={allMissionaries || []}
              userId={typeof userIdParam === "string" ? userIdParam : undefined}
            />
          </div>
        )}

        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-3 mb-8">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="history">Request History</TabsTrigger>
            {isCampusDirector && <TabsTrigger value="approvals">Approvals</TabsTrigger>}
          </TabsList>

          <TabsContent value="overview" className="space-y-8">
            {/* Request creation buttons */}
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
              donations={combinedDonations.map(d => ({
                id: d.id,
                donor_name: d.donor_name,
                amount: d.amount,
                date: new Date(d.created_at).toLocaleDateString(),
                notes: d.notes || ""
              }))}
              missionaryId={userIdParam || user.id}
            />
          </TabsContent>

          <TabsContent value="history" className="space-y-8">
            <div className="space-y-4">
              <h2 className="text-2xl font-semibold">Request History</h2>
              <div className="space-y-4">
                {([...leaveRequests, ...surplusRequests] as (LeaveRequest | SurplusRequest)[]).map((request) => (
                  <div key={`${request.type}-${request.id}`} className="p-4 bg-background rounded-lg border">
                    <div className="flex flex-col">
                      <p className="font-medium">{request.type} Request</p>
                      <p className="text-sm text-muted-foreground mt-1">{request.date}</p>
                      <p className="text-sm mt-2">
                        {request.type !== 'Surplus'
                          ? `Dates: ${(request as LeaveRequest).startDate} - ${(request as LeaveRequest).endDate}. Reason: ${request.reason}`
                          : `Requested Amount: ₱${(request as SurplusRequest).amount.toLocaleString()}. Reason: ${request.reason}`
                        }
                      </p>
                      <p className="text-sm text-muted-foreground mt-2">
                        Status: {request.status}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </TabsContent>

          {isCampusDirector && (
            <TabsContent value="approvals" className="space-y-8">
              <ApprovalTab
                pendingLeaveApprovals={pendingLeaveApprovals}
                approvedLeaveApprovals={approvedLeaveApprovals}
                pendingSurplusApprovals={pendingSurplusApprovals}
                approvedSurplusApprovals={approvedSurplusApprovals}
              />
            </TabsContent>
          )}
        </Tabs>
      </div>
    </div>
  );
}
