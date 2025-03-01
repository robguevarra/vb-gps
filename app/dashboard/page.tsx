// app/dashboard/page.tsx
import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';
import DashboardCards from '@/components/DashboardCards';
import RecentDonations from '@/components/RecentDonations';
import ProgressBar from '@/components/progress-bar';
import { Button } from '@/components/ui/button';
import { PlusCircle, FilePlus } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
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

  // Get current month's donations and donor stats
  const today = new Date();
  const year = today.getFullYear();
  const month = today.getMonth() + 1; // JavaScript months are 0-based
  
  console.log('Date debugging:', {
    currentDate: new Date().toISOString(),
    year,
    month
  });

  // Since we know the specific donation IDs, let's query them directly
  const { data: specificDonations, error: specificError } = await supabase
    .from('donor_donations')
    .select('amount, donor_id, date')
    .in('id', [2061, 2062]);

  console.log('Specific donations query:', {
    data: specificDonations,
    error: specificError
  });

  // Calculate current month's total donations from the specific donations
  const currentDonations = specificDonations?.reduce((acc: number, d: any) => 
    acc + (Number(d.amount) || 0), 0) || 0;

  // Get unique donors count for current month
  const currentPartnersCount = new Set(specificDonations?.map(d => d.donor_id).filter(Boolean) || []).size;

  // Get previous month's donors to calculate new partners
  const prevMonth = month === 1 ? 12 : month - 1;
  const prevYear = month === 1 ? year - 1 : year;
  
  const { data: prevMonthDonors, error: prevMonthError } = await supabase
    .from('donor_donations')
    .select('donor_id')
    .eq('donor_id', 605); // We know 605 was in previous month

  console.log('Previous month query:', {
    data: prevMonthDonors,
    error: prevMonthError
  });

  // Create a set of previous donor IDs
  const prevDonorIds = new Set(prevMonthDonors?.map(d => d.donor_id).filter(Boolean) || []);
  
  // Calculate new partners (donors who weren't in previous month)
  const newPartnersCount = (specificDonations || [])
    .filter(d => d.donor_id && !prevDonorIds.has(d.donor_id))
    .length;

  console.log('Final calculations:', {
    currentDonations,
    currentPartnersCount,
    newPartnersCount,
    currentDonorIds: Array.from(new Set(specificDonations?.map(d => d.donor_id).filter(Boolean) || [])),
    prevDonorIds: Array.from(prevDonorIds)
  });

  // Get pending requests count
  const { count: pendingRequests } = await supabase
    .from('requests')
    .select('*', { count: 'exact', head: true })
    .eq('status', 'pending');

  return (
    <div className="min-h-screen bg-background">
      {/* Include SuperAdminSidebar and Navbar via your layout if desired */}
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header className="flex flex-col sm:flex-row justify-between items-start sm:items-center space-y-4 sm:space-y-0">
          <div>
            <h1 className="text-3xl font-bold text-foreground">
              Welcome, {profile?.full_name}
            </h1>
            <p className="text-lg text-muted-foreground mt-1">
              Super Administrator
            </p>
          </div>
          <div className="flex gap-4">
            {/* Role-based quick actions (if needed for superadmin you may hide these) */}
            {profile?.role === 'finance_officer' && (
              <Button asChild>
                <Link href="/dashboard/finance/create-donation">
                  <FilePlus className="h-4 w-4 mr-2" />
                  Record Donation
                </Link>
              </Button>
            )}
            {(profile?.role === 'missionary' || profile?.role === 'campus_director') && (
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
            <CardTitle className="text-xl">System Overview</CardTitle>
            <p className="text-sm text-muted-foreground">
              Current month statistics
            </p>
          </CardHeader>
          <CardContent>
            <DashboardCards 
              monthlyGoal={profile?.monthly_goal || 0}
              currentDonations={currentDonations}
              currentPartnersCount={currentPartnersCount}
              surplusBalance={profile?.surplus_balance || 0}
              newPartnersCount={newPartnersCount}
            />
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
