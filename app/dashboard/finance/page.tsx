// app/dashboard/finance/page.tsx
export const dynamic = 'force-dynamic'; // Ensures fresh data on every request

import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';
import DonationModal from '../../../components/DonationModal';
import RecentTransactionsTable from '@/components/RecentTransactionsTable';
import { getUserRole } from '@/utils/getUserRole';

export default async function FinanceDashboard() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/login');
  }

  // Securely fetch the user's role from the user_roles table.
  const financeRole = await getUserRole(user.id);
  if (financeRole !== 'finance_officer') {
    // Not authorized for finance dashboard.
    redirect('/login');
  }

  // Fetch the finance officer's profile to determine their local_church_id.
  const { data: financeProfile, error: profileError } = await supabase
    .from('profiles')
    .select('local_church_id')
    .eq('id', user.id)
    .single();

  if (profileError) {
    console.error("[FinanceDashboard] Error fetching finance profile:", profileError.message);
    // Optionally, handle this error (e.g., redirect or show an error message)
  }

  // Use the finance officer's local_church_id to filter missionary profiles.
  const { data: missionaryProfiles, error: missionError } = await supabase
    .from('profiles')
    .select('id, full_name, role')
    .or('role.eq.missionary,role.eq.campus_director')
    .eq('local_church_id', financeProfile?.local_church_id);  // filtering by local church

  if (missionError) {
    console.error("[FinanceDashboard] Error fetching missionary profiles:", missionError.message);
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

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold text-foreground">Finance Dashboard</h1>
            <p className="text-lg text-muted-foreground mt-1">Manage manual donation entries</p>
          </div>
          {/* Pass the filtered missionaryProfiles to the DonationModal */}
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
