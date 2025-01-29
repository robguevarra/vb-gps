import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { FilePlus } from 'lucide-react'
import Link from 'next/link'
import { generateMockDonations } from '@/utils/mockData'

export default async function FinanceDashboard() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Mock data for finance dashboard
  const mockDonations = generateMockDonations(10)
  const monthlyTotal = mockDonations.reduce((acc, d) => acc + d.amount, 0)

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold text-foreground">
              Finance Dashboard
            </h1>
            <p className="text-lg text-muted-foreground mt-1">
              Manage donations and financial records
            </p>
          </div>
          <Button asChild>
            <Link href="/dashboard/finance/create-donation">
              <FilePlus className="h-4 w-4 mr-2" />
              Record Donation
            </Link>
          </Button>
        </header>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div className="space-y-6">
            <div className="p-6 bg-card rounded-lg shadow">
              <h2 className="text-2xl font-semibold mb-4">Monthly Summary</h2>
              <div className="space-y-2">
                <p className="text-foreground">
                  Total Donations: ${monthlyTotal.toLocaleString()}
                </p>
                <p className="text-muted-foreground">
                  Last updated: {new Date().toLocaleDateString()}
                </p>
              </div>
            </div>
          </div>

          <div className="p-6 bg-card rounded-lg shadow">
            <h2 className="text-2xl font-semibold mb-4">Recent Transactions</h2>
            <div className="space-y-4">
              {mockDonations.map((donation) => (
                <div key={donation.id} className="flex justify-between items-center p-3 bg-background rounded">
                  <div>
                    <p className="font-medium">{donation.donor_name}</p>
                    <p className="text-sm text-muted-foreground">
                      {new Date(donation.date).toLocaleDateString()}
                    </p>
                  </div>
                  <p className="font-semibold">
                    ${donation.amount.toLocaleString()}
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