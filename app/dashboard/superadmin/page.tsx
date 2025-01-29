import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import { generateMockChurches, generateMockUsers } from '@/utils/mockData'

export default async function SuperadminDashboard() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Mock data
  const mockChurches = generateMockChurches(5)
  const mockUsers = generateMockUsers(5)

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header>
          <h1 className="text-3xl font-bold text-foreground">
            Superadmin Dashboard
          </h1>
          <p className="text-lg text-muted-foreground mt-1">
            System configuration and management
          </p>
        </header>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div className="space-y-6">
            <h2 className="text-2xl font-semibold">Local Churches</h2>
            <div className="space-y-4">
              {mockChurches.map((church) => (
                <div key={church.id} className="p-4 bg-card rounded-lg shadow">
                  <p className="font-medium">{church.name}</p>
                  <p className="text-sm text-muted-foreground">
                    Members: {church.memberCount}
                  </p>
                </div>
              ))}
            </div>
          </div>

          <div className="space-y-6">
            <h2 className="text-2xl font-semibold">User Accounts</h2>
            <div className="space-y-4">
              {mockUsers.map((user) => (
                <div key={user.id} className="p-4 bg-card rounded-lg shadow">
                  <p className="font-medium">{user.full_name}</p>
                  <p className="text-sm text-muted-foreground">
                    Role: {user.role}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
} 