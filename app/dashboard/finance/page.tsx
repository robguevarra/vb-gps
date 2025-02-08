//app/dashboard/finance/page.tsx

export const dynamic = 'force-dynamic'; // Ensures fresh data on every request

import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';
import DonationModal from '../../../components/DonationModal';
import RecentTransactionsTable from '@/components/RecentTransactionsTable';
// REMOVED: import RealtimeSubscriptions from '@/components/RealtimeSubscriptions';

export default async function FinanceDashboard() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/login');
  }


  // Updated query: include donors(name, email, phone)
  const { data: donorDonationsData, error } = await supabase
    .from('donor_donations')
    .select('id, amount, date, notes, donors(name, email, phone)')
    .eq('source', 'offline')
    .order('date', { ascending: false });

  if (error) {
    console.error("[FinanceDashboard] Error fetching donations:", error.message);
  } 

  const formattedDonations = donorDonationsData?.map((d: any) => ({
    id: d.id,
    donor_name: Array.isArray(d.donors)
      ? (d.donors[0]?.name || "Unknown")
      : (d.donors?.name || "Unknown"),
    donor_email: Array.isArray(d.donors)
      ? (d.donors[0]?.email || "N/A")
      : (d.donors?.email || "N/A"),
    donor_phone: Array.isArray(d.donors)
      ? (d.donors[0]?.phone || "N/A")
      : (d.donors?.phone || "N/A"),
    amount: d.amount,
    date: d.date,
    notes: d.notes || ""
  })) || [];

  // Fetch missionary profiles for DonationModal.
  const { data: missionaryProfiles, error: missionError } = await supabase
    .from('profiles')
    .select('id, full_name, role')
    .eq('role', 'missionary');

  if (missionError) {
    console.error("[FinanceDashboard] Error fetching missionary profiles:", missionError.message);
  } 

  return (
    <div className="min-h-screen bg-background">
      {/*
        REMOVED RealtimeSubscriptions:
          <RealtimeSubscriptions
            tables={[
              { name: 'donor_donations', filter: 'source=eq.offline', event: 'INSERT' },
              { name: 'donations', filter: `missionary_id=eq.${user.id}`, event: 'INSERT' }
            ]}
          />
      */}
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold text-foreground">Finance Dashboard</h1>
            <p className="text-lg text-muted-foreground mt-1">Manage manual donation entries</p>
          </div>
          <DonationModal missionaries={missionaryProfiles || []} />
        </header>
        <div className="p-6 bg-card rounded-lg shadow">
          <h2 className="text-2xl font-semibold mb-4">Recent Transactions</h2>
          <RecentTransactionsTable donations={formattedDonations} />
        </div>
      </div>
    </div>
  );
}
