import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import DashboardCards from '@/components/DashboardCards'
import RecentDonations from '@/components/RecentDonations'
import { CalendarDays, WalletCards } from 'lucide-react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import ProfileSelector from '@/components/ProfileSelector'
import { RequestSurplusForm } from '@/components/RequestSurplusForm'
import { LeaveRequestForm } from '@/components/LeaveRequestForm'

export const dynamic = 'force-dynamic'

interface LeaveRequest {
  id: string;
  type: 'Leave';
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

export default async function MissionaryDashboard(
  props: {
    searchParams: Promise<{ [key: string]: string | string[] | undefined }>
  }
) {
  const searchParams = await props.searchParams;
  console.log('SearchParams:', searchParams);

  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  console.log('Authenticated User:', user);

  const userIdParam = typeof searchParams.userId === 'string'
    ? searchParams.userId
    : Array.isArray(searchParams.userId)
      ? searchParams.userId[0]
      : undefined;
  console.log('Computed userIdParam:', userIdParam);

  if (!user) {
    redirect('/login');
  }

  const isSuperAdmin = user.email === 'robneil@gmail.com';
  console.log('Is SuperAdmin:', isSuperAdmin);

  // Fetch all missionaries if superadmin
  const { data: allMissionaries } = isSuperAdmin 
    ? await supabase
        .from('profiles')
        .select('id, full_name, role')
        .neq('role', 'superadmin')
    : { data: null };
  console.log('All Missionaries:', allMissionaries);

  // Updated: Use join alias syntax to fetch the local church name.
  const { data: fetchedProfileData } = await supabase
    .from('profiles')
    // Using an alias: join local_church table on local_church_id, select its name
    .select('*')
    .eq('id', userIdParam || user.id)
    .single();
  console.log('Fetched Profile Data:', fetchedProfileData);

  const profileData = fetchedProfileData || (isSuperAdmin ? {
    id: user.id,
    full_name: user.email,
    role: 'superadmin',
    // Provide a default object if no local church exists
    local_church: { name: 'N/A' },
    monthly_goal: 0,
    surplus_balance: 0
  } : null);

  if (!profileData) {
    redirect('/login');
  }
  console.log('Profile Data to use:', profileData);

  // Fetch donations using the correct column name "missionary_id"
const { data: donationsData } = await supabase
.from('donations')
.select('amount, created_at')
.eq('missionary_id', userIdParam || user.id)
.order('created_at', { ascending: false })
.limit(5);
console.log('Donations Data:', donationsData);

// Fetch leave requests using the correct column name "requester_id"
const { data: leaveRequestsData } = await supabase
.from('leave_requests')
.select('*')
.eq('requester_id', userIdParam || user.id)
.order('created_at', { ascending: false });
console.log('Leave Requests Data:', leaveRequestsData);

// Fetch surplus requests using the correct column name "missionary_id"
const { data: surplusRequestsData } = await supabase
.from('surplus_requests')
.select('*')
.eq('missionary_id', userIdParam || user.id)
.order('created_at', { ascending: false });
console.log('Surplus Requests Data:', surplusRequestsData);

  const currentDonations = donationsData?.reduce((acc, d) => acc + d.amount, 0) || 0;
  const pendingRequests = [
    ...(leaveRequestsData?.filter(r => r.status === 'pending') || []),
    ...(surplusRequestsData?.filter(r => r.status === 'pending') || [])
  ].length;
  console.log('Current Donations:', currentDonations);
  console.log('Pending Requests Count:', pendingRequests);

  const leaveRequests: LeaveRequest[] = leaveRequestsData?.map(r => ({
    id: r.id,
    type: 'Leave',
    startDate: r.start_date,
    endDate: r.end_date,
    reason: r.reason,
    status: r.status,
    date: new Date(r.created_at).toLocaleDateString()
  })) || [];
  console.log('Processed Leave Requests:', leaveRequests);

  const surplusRequests: SurplusRequest[] = surplusRequestsData?.map(r => ({
    id: r.id,
    type: 'Surplus',
    amount: r.amount_requested,
    reason: r.reason,
    status: r.status,
    date: new Date(r.created_at).toLocaleDateString()
  })) || [];
  console.log('Processed Surplus Requests:', surplusRequests);

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <div className="flex justify-between items-start">
          <header className="space-y-2">
            <h1 className="text-3xl font-bold text-foreground">
              {profileData.full_name}
            </h1>
            <div className="flex items-center gap-4 text-muted-foreground">
              <p className="bg-accent px-3 py-1 rounded-full text-sm">
                {profileData.role.replace(/_/g, ' ')}
                {profileData.role === 'campus_director' && ' (Director)'}
              </p>
              <p className="text-sm">•</p>
              {/* Update here: use the joined local church field */}
              <p className="text-sm">{profileData.local_church?.name}</p>
            </div>
          </header>
          
          {isSuperAdmin && (
            <ProfileSelector 
              missionaries={allMissionaries || []}
              userId={typeof userIdParam === 'string' ? userIdParam : undefined}
            />
          )}
        </div>

        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-3 lg:w-1/2">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="requests">New Requests</TabsTrigger>
            <TabsTrigger value="history">Request History</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-8">
            <DashboardCards
              monthlyGoal={profileData.monthly_goal}
              currentDonations={currentDonations}
              pendingRequests={pendingRequests}
              surplusBalance={profileData.surplus_balance}
            />
            <RecentDonations
              donations={
                donationsData?.map(d => ({
                  id: d.created_at,
                  amount: d.amount,
                  date: new Date(d.created_at).toLocaleDateString(),
                  donor: 'Donor'
                })) || []
              }
            />
          </TabsContent>

          <TabsContent value="requests">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
              <div className="p-6 bg-card rounded-lg shadow">
                <h2 className="text-xl font-semibold flex items-center gap-2 mb-4">
                  <WalletCards className="h-5 w-5" />
                  Surplus Request
                </h2>
                <RequestSurplusForm surplusBalance={profileData.surplus_balance} />
              </div>

              <div className="p-6 bg-card rounded-lg shadow">
                <h2 className="text-xl font-semibold flex items-center gap-2 mb-4">
                  <CalendarDays className="h-5 w-5" />
                  Leave Request
                </h2>
                <LeaveRequestForm />
              </div>
            </div>
          </TabsContent>

          <TabsContent value="history">
            <div className="space-y-4">
              <h2 className="text-2xl font-semibold">Recent Applications</h2>
              <div className="space-y-4">
                {([...leaveRequests, ...surplusRequests] as (LeaveRequest | SurplusRequest)[]).map(
                  (request) => (
                    <div key={request.id} className="p-4 bg-background rounded-lg border">
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
                  )
                )}
              </div>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
