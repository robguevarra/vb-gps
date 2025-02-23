import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { generateMockRequests } from '@/utils/mockData'

export default async function CampusDirectorDashboard() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Mock data
  const pendingRequests = generateMockRequests(5)

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header>
          <h1 className="text-3xl font-bold text-foreground">
            Campus Director Dashboard
          </h1>
          <p className="text-lg text-muted-foreground mt-1">
            Manage missionary requests and approvals
          </p>
        </header>

        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">Pending Approvals</h2>
          <div className="space-y-4">
            {pendingRequests.map((request) => (
              <div key={request.id} className="p-4 bg-card rounded-lg shadow">
                <div className="flex justify-between items-center">
                  <div>
                    <p className="font-medium">{request.type} Request</p>
                    <p className="text-sm text-muted-foreground">
                      From: {request.missionaryName}
                    </p>
                  </div>
                  <div className="flex gap-2">
                    <Button variant="outline">Approve</Button>
                    <Button variant="destructive">Reject</Button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
} 