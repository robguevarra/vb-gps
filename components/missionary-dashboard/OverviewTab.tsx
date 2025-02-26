import { createClient } from "@/utils/supabase/client";
import { Profile } from "@/types/reports";
import DashboardCards from "@/components/DashboardCards";
import RecentDonations from "@/components/RecentDonations";
import { LeaveRequestModal } from "@/components/LeaveRequestModal";
import { SurplusRequestModal } from "@/components/SurplusRequestModal";

// Define the donation interface to match RecentDonations component requirements
interface Donation {
  id: string | number;
  donor_name: string;
  amount: number;
  date: string;
  notes?: string;
}

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
  
  // Fetch donation data without join since we're having join issues
  const donationsResult = await supabase
    .from("donor_donations")
    .select("id, amount, date, donor_id, notes")
    .eq("missionary_id", missionaryId)
    .order("date", { ascending: false })
    .limit(5);
  
  // Get donor names separately to avoid join issues
  // Using a Map instead of a plain object to avoid TypeScript issues
  const donorNamesMap = new Map<number, string>();
  
  if (donationsResult.data && donationsResult.data.length > 0) {
    // Extract unique donor IDs
    const donorIds = [...new Set(donationsResult.data.map(d => d.donor_id))];
    
    // Fetch donor details separately
    const donorsResult = await supabase
      .from("donors")
      .select("id, name")
      .in("id", donorIds);
    
    // Create a map of donor_id to donor name
    if (donorsResult.data) {
      donorsResult.data.forEach(donor => {
        donorNamesMap.set(donor.id, donor.name);
      });
    }
  }
  
  // Get current and previous donors with proper error handling
  const [currentDonorsResult, previousDonorsResult, currentMonthDonationsResult] = await Promise.all([
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
      .from('donor_donations')
      .select('amount')
      .eq('missionary_id', missionaryId)
      .gte('date', startOfCurrentMonth.toISOString())
      .lte('date', today)
  ]);

  // Calculate stats with null checks
  const currentDonorIds = new Set(currentDonorsResult?.data?.map(d => d.donor_id) || []);
  const previousDonorIds = new Set(previousDonorsResult?.data?.map(d => d.donor_id) || []);
  const currentPartnersCount = currentDonorIds.size;
  const newPartnersCount = Array.from(currentDonorIds).filter(id => !previousDonorIds.has(id)).length;

  // Process donation data by matching with donor names from our separate query
  const recentDonations: Donation[] = donationsResult.data?.map(d => {
    // Get donor name from our Map, or use a fallback
    const donorName = donorNamesMap.get(d.donor_id) || `Donor #${d.donor_id}`;
    
    return {
      id: d.id,
      donor_name: donorName,
      amount: Number(d.amount),
      date: new Date(d.date).toLocaleDateString(),
      notes: d.notes || "",
    };
  }) || [];

  // Calculate current donations from all donations in the current month
  const currentDonations = currentMonthDonationsResult?.data?.reduce((acc, d) => acc + Number(d.amount), 0) || 0;

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