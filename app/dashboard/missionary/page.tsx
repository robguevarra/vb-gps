import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import DashboardCards from '@/components/dashboard-cards'
import RecentDonations from '@/components/recent-donations'
import { Button } from '@/components/ui/button'
import { CalendarDays, WalletCards } from 'lucide-react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import ProfileSelector from '@/components/ProfileSelector'

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

export default async function MissionaryDashboard({
  searchParams,
}: {
  searchParams: { [key: string]: string | string[] | undefined }
}) {
  // First await other async operations
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  // Then access searchParams after awaits
  const userIdParam = typeof searchParams.userId === 'string' 
    ? searchParams.userId 
    : Array.isArray(searchParams.userId)
      ? searchParams.userId[0]
      : undefined

  if (!user) {
    redirect('/login')
  }

  // Check for superadmin
  const isSuperAdmin = user.email === 'robneil@gmail.com'

  // Fetch all missionaries if superadmin
  const { data: allMissionaries } = isSuperAdmin 
    ? await supabase
        .from('profiles')
        .select('id, full_name, role')
        .neq('role', 'super_admin') // Exclude other superadmins
    : { data: null }

  // Fetch profile data (either selected or current user)
  const { data: profileData } = await supabase
    .from('profiles')
    .select('*, local_churches(name)')
    .eq('id', userIdParam || user.id)
    .single()

  // Fetch donations
  const { data: donationsData } = await supabase
    .from('donations')
    .select('amount, created_at')
    .eq('user_id', userIdParam || user.id)
    .order('created_at', { ascending: false })
    .limit(5)

  // Fetch leave requests
  const { data: leaveRequestsData } = await supabase
    .from('leave_requests')
    .select('*')
    .eq('user_id', userIdParam || user.id)
    .order('created_at', { ascending: false })

  // Fetch surplus requests
  const { data: surplusRequestsData } = await supabase
    .from('surplus_requests')
    .select('*')
    .eq('user_id', userIdParam || user.id)
    .order('created_at', { ascending: false })

  if (!profileData) {
    redirect('/login')
  }

  // Process data
  const currentDonations = donationsData?.reduce((acc, d) => acc + d.amount, 0) || 0
  const pendingRequests = [
    ...(leaveRequestsData?.filter(r => r.status === 'pending') || []),
    ...(surplusRequestsData?.filter(r => r.status === 'pending') || [])
  ].length

  // Transform requests
  const leaveRequests = leaveRequestsData?.map(r => ({
    id: r.id,
    type: 'Leave' as const,
    startDate: r.start_date,
    endDate: r.end_date,
    reason: r.reason,
    status: r.status,
    date: new Date(r.created_at).toLocaleDateString()
  })) || []

  const surplusRequests = surplusRequestsData?.map(r => ({
    id: r.id,
    type: 'Surplus' as const,
    amount: r.amount,
    reason: r.reason,
    status: r.status,
    date: new Date(r.created_at).toLocaleDateString()
  })) || []

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
              <p className="text-sm">{profileData.local_churches?.name}</p>
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
            <RecentDonations donations={donationsData?.map(d => ({
              id: d.created_at,
              amount: d.amount,
              date: new Date(d.created_at).toLocaleDateString(),
              donor: 'Donor' // Update if you have donor names
            })) || []} />
          </TabsContent>

          <TabsContent value="requests">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
              {/* Surplus Request Card */}
              <div className="p-6 bg-card rounded-lg shadow">
                <h2 className="text-xl font-semibold flex items-center gap-2 mb-4">
                  <WalletCards className="h-5 w-5" />
                  Surplus Request
                </h2>
                <form className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium mb-1">
                      Request Amount
                    </label>
                    <input
                      type="number"
                      max={profileData.surplus_balance}
                      className="w-full p-2 border rounded"
                      placeholder="Enter amount"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium mb-1">
                      Reason
                    </label>
                    <textarea
                      className="w-full p-2 border rounded h-24"
                      placeholder="Describe the need for this surplus"
                    />
                  </div>
                  <Button type="submit" className="w-full">
                    Submit Request
                  </Button>
                </form>
              </div>

              {/* Leave Request Card */}
              <div className="p-6 bg-card rounded-lg shadow">
                <h2 className="text-xl font-semibold flex items-center gap-2 mb-4">
                  <CalendarDays className="h-5 w-5" />
                  Leave Request
                </h2>
                <form className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium mb-1">
                        Start Date
                      </label>
                      <input
                        type="date"
                        className="w-full p-2 border rounded"
                      />
                    </div>
                    <div>
                      <label className="block text-sm font-medium mb-1">
                        End Date
                      </label>
                      <input
                        type="date"
                        className="w-full p-2 border rounded"
                      />
                    </div>
                  </div>
                  <div>
                    <label className="block text-sm font-medium mb-1">
                      Reason
                    </label>
                    <textarea
                      className="w-full p-2 border rounded h-24"
                      placeholder="Reason for leave"
                    />
                  </div>
                  <Button type="submit" className="w-full">
                    Submit Leave Request
                  </Button>
                </form>
              </div>
            </div>
          </TabsContent>

          <TabsContent value="history">
            <div className="space-y-4">
              <h2 className="text-2xl font-semibold">Recent Applications</h2>
              <div className="space-y-4">
                {([...leaveRequests, ...surplusRequests] as (LeaveRequest | SurplusRequest)[]).map((request) => (
                  <div key={request.id} className="p-4 bg-background rounded-lg border">
                    <div className="flex justify-between items-start">
                      <div>
                        <p className="font-medium">
                          {request.type} Request
                          <span className={`ml-2 text-sm ${
                            request.status === 'approved' ? 'text-green-600' :
                            request.status === 'rejected' ? 'text-red-600' : 'text-yellow-600'
                          }`}>
                            ({request.status})
                          </span>
                        </p>
                        <p className="text-sm text-muted-foreground mt-1">
                          {request.date}
                        </p>
                      </div>
                      <Button variant="ghost" size="sm">
                        View Details
                      </Button>
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
  )
}