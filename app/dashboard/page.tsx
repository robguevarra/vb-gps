// app/dashboard/page.tsx
import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';
import DashboardCards from '@/components/DashboardCards';
import RecentDonations from '@/components/RecentDonations';
import ProgressBar from '@/components/progress-bar';
import { Button } from '@/components/ui/button';
import { PlusCircle, FilePlus } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { generateMockDonations, mockProfile } from '@/utils/mockData';
import Link from 'next/link';

export default async function SuperAdminDashboard() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/login');
  }

  // Get profile data
  const { data: profile } = await supabase
    .from('profiles')
    .select('role, full_name, local_church_id, monthly_goal, surplus_balance')
    .eq('id', user.id)
    .single();

  // Role-based immediate redirection
  if (profile?.role) {
    switch (profile.role.toLowerCase()) {
      case 'finance_officer':
        redirect('/dashboard/finance');
      case 'lead_pastor':
        redirect('/dashboard/lead-pastor');
      case 'missionary':
      case 'campus_director':
        redirect('/dashboard/missionary');
      case 'superadmin':
        break; // Superadmin stays here
      default:
        redirect('/login');
    }
  }

  // For demo purposes (mock data)
  const userProfile = {
    ...mockProfile,
    role: 'superadmin',
    local_church: 'All Churches'
  };

  const mockDonations = generateMockDonations(5);
  const pendingRequests = 2; // Mock pending requests count
  const currentDonations = mockDonations.reduce((acc, d) => acc + d.amount, 0);

  return (
    <div className="min-h-screen bg-background">
      {/* Include SuperAdminSidebar and Navbar via your layout if desired */}
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header className="flex flex-col sm:flex-row justify-between items-start sm:items-center space-y-4 sm:space-y-0">
          <div>
            <h1 className="text-3xl font-bold text-foreground">
              Welcome, {userProfile.full_name}
            </h1>
            <p className="text-lg text-muted-foreground mt-1">
              {userProfile.local_church} ({userProfile.role.replace(/_/g, ' ')})
            </p>
          </div>
          <div className="flex gap-4">
            {/* Role-based quick actions (if needed for superadmin you may hide these) */}
            {userProfile.role === 'finance_officer' && (
              <Button asChild>
                <Link href="/dashboard/finance/create-donation">
                  <FilePlus className="h-4 w-4 mr-2" />
                  Record Donation
                </Link>
              </Button>
            )}
            {(userProfile.role === 'missionary' || userProfile.role === 'campus_director') && (
              <Button variant="outline" asChild>
                <Link href="/dashboard/requests/new">
                  <PlusCircle className="h-4 w-4 mr-2" />
                  New Request
                </Link>
              </Button>
            )}
          </div>
        </header>

        {/* Dashboard Selection Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <Card className="hover:bg-accent transition-colors">
            <Link href="/dashboard/missionary">
              <CardHeader>
                <CardTitle className="text-lg">Missionary Dashboard</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">
                  Track donations, manage requests, and view surplus.
                </p>
              </CardContent>
            </Link>
          </Card>

          <Card className="hover:bg-accent transition-colors">
            <Link href="/dashboard/finance">
              <CardHeader>
                <CardTitle className="text-lg">Finance Dashboard</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">
                  Record offline donations and manage financial records.
                </p>
              </CardContent>
            </Link>
          </Card>

          <Card className="hover:bg-accent transition-colors">
            <Link href="/dashboard/lead-pastor">
              <CardHeader>
                <CardTitle className="text-lg">Lead Pastor</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">
                  Final approvals and church oversight.
                </p>
              </CardContent>
            </Link>
          </Card>

          <Card className="hover:bg-accent transition-colors">
            <Link href="/dashboard/superadmin">
              <CardHeader>
                <CardTitle className="text-lg">Superadmin</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">
                  System configuration and reporting.
                </p>
              </CardContent>
            </Link>
          </Card>
        </div>

        {/* Current Role Demo Section */}
        <Card>
          <CardHeader>
            <CardTitle className="text-xl">Current Role Preview</CardTitle>
            <p className="text-sm text-muted-foreground">
              Showing mock data for: {userProfile.role}
            </p>
          </CardHeader>
          <CardContent>
            <DashboardCards 
              monthlyGoal={userProfile.monthly_goal}
              currentDonations={currentDonations}
              pendingRequests={pendingRequests}
              surplusBalance={userProfile.surplus_balance}
            />
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
