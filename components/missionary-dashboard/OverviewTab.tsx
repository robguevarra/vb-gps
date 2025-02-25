import { createClient } from "@/utils/supabase/client";
import { Profile } from "@/types/reports";
import DashboardCards from "@/components/DashboardCards";
import RecentDonations from "@/components/RecentDonations";
import { LeaveRequestModal } from "@/components/LeaveRequestModal";
import { SurplusRequestModal } from "@/components/SurplusRequestModal";

interface OverviewTabProps {
  missionaryId: string;
  profileData: Profile;
  isSuperAdmin: boolean;
}

export async function OverviewTab({ missionaryId, profileData, isSuperAdmin }: OverviewTabProps) {
  const supabase = createClient();
  
  // Initialize date variables
  const today = new Date().toISOString().split('T')[0];
  const startOfCurrentMonth = new Date();
  startOfCurrentMonth.setDate(1);
  startOfCurrentMonth.setHours(0, 0, 0, 0);
  
  // Fetch only the data needed for overview
  const [currentDonorsResult, previousDonorsResult, donationsResult] = await Promise.all([
    supabase
      .from('donor_donations')
      .select('donor_id')
      .eq('missionary_id', missionaryId)
      .gte('date', startOfCurrentMonth.toISOString())
      .lte('date', today),
    supabase
      .from('donor_donations')
      .select('donor_id')
      .eq('missionary_id', missionaryId)
      .lt('date', startOfCurrentMonth.toISOString()),
    supabase
      .from("donor_donations")
      .select("id, amount, date, donor_id, donors!inner(id, name), notes")
      .eq("missionary_id", missionaryId)
      .order("date", { ascending: false })
      .limit(5)
  ]);

  // Calculate stats
  const currentDonorIds = new Set(currentDonorsResult.data?.map(d => d.donor_id) || []);
  const previousDonorIds = new Set(previousDonorsResult.data?.map(d => d.donor_id) || []);
  const currentPartnersCount = currentDonorIds.size;
  const newPartnersCount = Array.from(currentDonorIds).filter(id => !previousDonorIds.has(id)).length;

  const recentDonations = donationsResult.data?.map(d => ({
    id: d.id,
    donor_name: d.donors?.name || "Unknown",
    amount: d.amount,
    date: new Date(d.date).toLocaleDateString(),
    notes: d.notes || "",
  })) || [];

  const currentDonations = recentDonations.reduce((acc, d) => acc + d.amount, 0);

  return (
    <div className="space-y-8">
      {/* Request Actions */}
      <div className="flex gap-4">
        <LeaveRequestModal
          missionaryId={missionaryId}
          validateMissionary={isSuperAdmin}
        />
        <SurplusRequestModal
          surplusBalance={profileData.surplus_balance}
          missionaryId={missionaryId}
        />
      </div>

      {/* Dashboard Cards */}
      <DashboardCards
        monthlyGoal={profileData.monthly_goal || 0}
        currentDonations={currentDonations}
        currentPartnersCount={currentPartnersCount}
        newPartnersCount={newPartnersCount}
        surplusBalance={profileData.surplus_balance}
      />

      {/* Recent Donations */}
      <RecentDonations
        donations={recentDonations}
        missionaryId={missionaryId}
      />
    </div>
  );
} 