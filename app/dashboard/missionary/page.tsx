// app/dashboard/missionary/page.tsx
import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';
import DashboardCards from '@/components/DashboardCards';
import RecentDonations from '@/components/RecentDonations';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import ProfileSelector from '@/components/ProfileSelector';
import { RequestSurplusForm } from '@/components/RequestSurplusForm';
import { LeaveRequestForm } from '@/components/LeaveRequestForm';
import { LeaveRequestModal } from '@/components/LeaveRequestModal';
import { SurplusRequestModal } from '@/components/SurplusRequestModal';
import RealtimeSubscriptions from '@/components/RealtimeSubscriptions';

export const dynamic = 'force-dynamic';

interface LeaveRequest {
  id: string;
  type: 'Sick Leave' | 'Vacation Leave';
  startDate: string;
  endDate: string;
  reason: string;
  status: string;
  date: string;
}

interface SurplusRequest {
  id: string;
  type: 'Surplus';
  amount: number;
  reason: string;
  status: string;
  date: string;
}

export default async function MissionaryDashboard(props: { searchParams: Promise<{ [key: string]: string | string[] | undefined }> }) {
  // Await search parameters (App Router passes them as a Promise)
  const searchParams = await props.searchParams;

  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  console.log('Authenticated User:', user);

  // Compute the userIdParam from searchParams, if provided
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
    `Is SuperAdmin: ${user.email === 'robneil@gmail.com'}`
  );

  if (!user) {
    redirect('/login');
  }

  const isSuperAdmin = user.email === 'robneil@gmail.com';
  console.log('Is SuperAdmin:', isSuperAdmin);

  // Fetch all profiles for the ProfileSelector if superadmin is logged in.
  const { data: allMissionaries } = isSuperAdmin 
    ? await supabase
        .from('profiles')
        .select('*')
        .neq('role', 'superadmin')
    : { data: null };

  // Fetch profile data using either the provided userIdParam or the authenticated user's id.
  const { data: fetchedProfileData } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userIdParam || user.id)
    .single();

  // Query for church name
  const { data: churchData } = await supabase
    .from('local_churches')
    .select('name')
    .eq('id', fetchedProfileData?.local_church_id)
    .single();

  // Fallback profile if necessary
  const profileData = fetchedProfileData || (isSuperAdmin ? {
    id: user.id,
    full_name: user.user_metadata?.full_name || user.email,
    role: 'superadmin',
    local_church_id: null,
    monthly_goal: 0,
    surplus_balance: 0
  } : null);

  // Determine church name
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
    .select('id, amount, created_at, donor_name')
    .eq('missionary_id', userIdParam || user.id)
    .order('created_at', { ascending: false });

  const { data: donorDonationsData } = await supabase
    .from('donor_donations')
    .select('id, amount, date, donors(name)')
    .eq('missionary_id', userIdParam || user.id)
    .order('date', { ascending: false });

  const formattedDonorDonations = donorDonationsData?.map(record => ({
    id: record.id,
    amount: record.amount,
    created_at: record.date,
    donor_name: record.donors?.name || 'Unknown'
  })) || [];

  const combinedDonations = [
    ...(donationsData || []),
    ...formattedDonorDonations
  ].sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime())
    .slice(0, 5);

  // -------------------------------
  // Fetch Leave Requests Data
  // -------------------------------
  const { data: leaveRequestsData } = await supabase
    .from('leave_requests')
    .select('*')
    .eq('requester_id', userIdParam || user.id)
    .order('created_at', { ascending: false });
  console.log('Leave Requests Data:', leaveRequestsData);

  // -------------------------------
  // Fetch Surplus Requests Data
  // -------------------------------
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
      date: new Date(r.created_at).toLocaleDateString()
    };
  }) || [];

  const surplusRequests: SurplusRequest[] = surplusRequestsData?.map(r => ({
    id: r.id,
    type: 'Surplus',
    amount: r.amount_requested,
    reason: r.reason,
    status: r.status,
    date: new Date(r.created_at).toLocaleDateString()
  })) || [];

  console.log(
    '[Dashboard] Modal IDs:',
    `Leave: ${userIdParam || user.id}`,
    `Surplus: ${userIdParam || user.id}`
  );

  return (
    <div className="min-h-screen bg-background" key={userIdParam || user.id}>
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
          }
        ]}
      />
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <div className="flex justify-between items-start">
          <header className="space-y-2">
            <h1 className="text-3xl font-bold text-foreground">
              {profileData.full_name || user.email}
            </h1>
            <div className="flex items-center gap-4 text-muted-foreground">
              <p className="bg-accent px-3 py-1 rounded-full text-sm">
                {profileData.role.replace(/_/g, ' ')}
                {profileData.role === 'campus_director' && ' (Director)'}
              </p>
              <p className="text-sm">•</p>
              <p className="text-sm">{churchName}</p>
            </div>
          </header>
          
          {isSuperAdmin && (
            <ProfileSelector 
              missionaries={allMissionaries || []}
              userId={typeof userIdParam === 'string' ? userIdParam : undefined}
              required
            />
          )}
        </div>

        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-2 lg:w-1/2">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="history">Request History</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-8">
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
                date: new Date(d.created_at).toLocaleDateString()
              }))}
            />
          </TabsContent>

          <TabsContent value="history" className="space-y-8">
            <div className="flex gap-4">
              <LeaveRequestModal 
                missionaryId={userIdParam || user.id}
                validateMissionary={isSuperAdmin}
              />
              <SurplusRequestModal 
                surplusBalance={profileData.surplus_balance}
                missionaryId={userIdParam}
                validateMissionary={isSuperAdmin}
              />
            </div>

            <div className="space-y-4">
              <h2 className="text-2xl font-semibold">Request History</h2>
              <div className="space-y-4">
                {([...leaveRequests, ...surplusRequests] as (LeaveRequest | SurplusRequest)[]).map((request) => (
                  <div key={`${request.type}-${request.id}`} className="p-4 bg-background rounded-lg border">
                    <div className="flex justify-between items-start">
                      <div>
                        <p className="font-medium">
                          {request.type} Request
                          <span className={`ml-2 text-sm ${
                            request.status === 'approved'
                              ? 'text-green-600'
                              : request.status === 'rejected'
                              ? 'text-red-600'
                              : 'text-yellow-600'
                          }`}>
                            ({request.status})
                          </span>
                        </p>
                        <p className="text-sm text-muted-foreground mt-1">
                          {request.date}
                        </p>
                      </div>
                      <button className="btn-ghost btn-sm btn">View Details</button>
                    </div>
                    {request.type === 'Leave' && (
                      <p className="text-sm mt-2">
                        Dates: {(request as LeaveRequest).startDate} - {(request as LeaveRequest).endDate}
                      </p>
                    )}
                    <p className="text-sm text-muted-foreground mt-2">
                      {request.reason}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
