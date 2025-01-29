import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import { generateMockDonations, mockProfile } from '@/utils/mockData'
import DashboardCards from '@/components/dashboard-cards'
import RecentDonations from '@/components/recent-donations'
import { Button } from '@/components/ui/button'
import { CalendarDays, WalletCards } from 'lucide-react'
import Link from 'next/link'
import { generateMockLeaveRequests, generateMockSurplusRequests } from '@/utils/mockData'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'

export default async function MissionaryDashboard() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Mock data
  const mockDonations = generateMockDonations(5)
  const currentDonations = mockDonations.reduce((acc, d) => acc + d.amount, 0)
  const pendingRequests = 2
  const leaveRequests = generateMockLeaveRequests(3)
  const surplusRequests = generateMockSurplusRequests(2)

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header className="space-y-2">
          <h1 className="text-3xl font-bold text-foreground">
            {mockProfile.full_name}
          </h1>
          <div className="flex items-center gap-4 text-muted-foreground">
            <p className="bg-accent px-3 py-1 rounded-full text-sm">
              {mockProfile.role.replace(/_/g, ' ')}
              {mockProfile.role === 'campus_director' && ' (Director)'}
            </p>
            <p className="text-sm">•</p>
            <p className="text-sm">{mockProfile.local_churches?.name}</p>
          </div>
        </header>

        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-3 lg:w-1/2">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="requests">New Requests</TabsTrigger>
            <TabsTrigger value="history">Request History</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-8">
            <DashboardCards
              monthlyGoal={mockProfile.monthly_goal}
              currentDonations={currentDonations}
              pendingRequests={pendingRequests}
              surplusBalance={mockProfile.surplus_balance}
            />
            <RecentDonations donations={mockDonations} />
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
                      max={mockProfile.surplus_balance}
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
                {[...leaveRequests, ...surplusRequests].map((request) => (
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
                        Dates: {request.startDate} - {request.endDate}
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