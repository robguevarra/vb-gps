import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { generateMockRequests } from '@/utils/mockData'

export default async function LeadPastorDashboard() {
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
            Lead Pastor Dashboard
          </h1>
          <p className="text-lg text-muted-foreground mt-1">
            Final approvals and church oversight
          </p>
        </header>

        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">Pending Final Approvals</h2>
          <div className="space-y-4">
            {pendingRequests.map((request) => (
              <div key={request.id} className="p-4 bg-card rounded-lg shadow">
                <div className="flex justify-between items-center">
                  <div>
                    <p className="font-medium">{request.type} Request</p>
                    <p className="text-sm text-muted-foreground">
                      From: {request.missionaryName} • Status: {request.status}
                    </p>
                  </div>
                  <div className="flex gap-2">
                    <Button variant="outline">Approve</Button>
                    <Button variant="destructive">Reject</Button>
                    <Button variant="secondary">Override</Button>
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