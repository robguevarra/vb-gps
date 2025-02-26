import { createClient } from "@/utils/supabase/server";
import { Profile } from "@/types/reports";
import DashboardCards from "@/components/DashboardCards";
import RecentDonations from "@/components/RecentDonations";
import { LeaveRequestModal } from "@/components/LeaveRequestModal";
import { SurplusRequestModal } from "@/components/SurplusRequestModal";

/**
 * Interface defining the structure of donation data needed for the RecentDonations component.
 * This ensures type safety when passing donation data to the component.
 */
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

/**
 * OverviewTab component for the missionary dashboard.
 * 
 * IMPORTANT IMPLEMENTATION NOTES:
 * 
 * 1. FOREIGN KEY RELATIONSHIP ISSUE:
 *    We originally tried to use Supabase joins (donors!inner) to fetch donor information 
 *    alongside donations, but encountered errors. This appeared to be due to a 
 *    foreign key relationship issue where donor_id values in the donor_donations table 
 *    might not have matching records in the donors table.
 * 
 * 2. TWO-STEP QUERY APPROACH:
 *    Our solution uses a two-step query approach:
 *    - First, fetch donations without attempting joins
 *    - Then, separately fetch donor information for the donation donor_ids
 *    - Finally, manually link the data in JavaScript
 * 
 * 3. FALLBACK MECHANISM:
 *    We implemented a fallback mechanism to show "Donor #[id]" when a donor record
 *    cannot be found, ensuring the UI doesn't break even with incomplete donor data.
 * 
 * 4. ROW LEVEL SECURITY (RLS):
 *    Using the server-side Supabase client with service role key to bypass RLS
 *    restrictions. This ensures data is always accessible regardless of RLS settings.
 *    - For client-side components that need this data, we fetch it server-side and pass it as props
 * 
 * This approach is more resilient than direct joins, especially when database 
 * relationships might not be perfectly maintained.
 */
export async function OverviewTab({ missionaryId, profileData, isSuperAdmin }: OverviewTabProps) {
  const supabase = await createClient();
  
  // Initialize date variables for time-based queries
  const today = new Date().toISOString().split('T')[0];
  const startOfCurrentMonth = new Date();
  startOfCurrentMonth.setDate(1);
  startOfCurrentMonth.setHours(0, 0, 0, 0);
  
  // STEP 1: Fetch recent donations WITHOUT joining to the donors table
  // This avoids foreign key relationship issues that can occur with direct joins
  const donationsResult = await supabase
    .from("donor_donations")
    .select("id, amount, date, donor_id, notes")
    .eq("missionary_id", missionaryId)
    .order("date", { ascending: false })
    .limit(5);
  
  // STEP 2: Get donor names separately to work around join issues
  // Using a Map for type safety and efficient lookups
  const donorNamesMap = new Map<number, string>();
  
  if (donationsResult.data && donationsResult.data.length > 0) {
    // Extract unique donor IDs to minimize database queries
    const donorIds = [...new Set(donationsResult.data.map(d => d.donor_id))];
    
    // Fetch donor details in a separate query
    const donorsResult = await supabase
      .from("donors")
      .select("id, name")
      .in("id", donorIds);
    
    // Create a map of donor_id to donor name for efficient lookups
    if (donorsResult.data) {
      donorsResult.data.forEach(donor => {
        donorNamesMap.set(donor.id, donor.name);
      });
    }
  }
  
  // STEP 3: Fetch data for dashboard stats (current month donors, previous donors, donation amounts)
  const [currentDonorsResult, previousDonorsResult, currentMonthDonationsResult] = await Promise.all([
    // Current month donors (for "Active Partners" count)
    supabase
      .from('donor_donations')
      .select('donor_id')
      .eq('missionary_id', missionaryId)
      .gte('date', startOfCurrentMonth.toISOString())
      .lte('date', today),
    // Previous donors (for calculating "New Partners")
    supabase
      .from('donor_donations')
      .select('donor_id')
      .eq('missionary_id', missionaryId)
      .lt('date', startOfCurrentMonth.toISOString()),
    // Current month donation amounts (for "Current Donations" total)
    supabase
      .from('donor_donations')
      .select('amount')
      .eq('missionary_id', missionaryId)
      .gte('date', startOfCurrentMonth.toISOString())
      .lte('date', today)
  ]);

  // Calculate dashboard stats
  const currentDonorIds = new Set(currentDonorsResult?.data?.map(d => d.donor_id) || []);
  const previousDonorIds = new Set(previousDonorsResult?.data?.map(d => d.donor_id) || []);
  const currentPartnersCount = currentDonorIds.size;
  const newPartnersCount = Array.from(currentDonorIds).filter(id => !previousDonorIds.has(id)).length;

  // STEP 4: Process donation data by matching with donor names from our separate query
  // This manually creates the joined data that would normally come from a database join
  const recentDonations: Donation[] = donationsResult.data?.map(d => {
    // Get donor name from our Map, or use a fallback if not found
    // This ensures the UI doesn't break even with missing donor records
    const donorName = donorNamesMap.get(d.donor_id) || `Donor #${d.donor_id}`;
    
    return {
      id: d.id,
      donor_name: donorName,
      amount: Number(d.amount),
      date: new Date(d.date).toLocaleDateString(),
      notes: d.notes || "",
    };
  }) || [];

  // Calculate current donations total from all current month donations
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

      {/* Dashboard Cards showing key metrics */}
      <DashboardCards
        monthlyGoal={profileData.monthly_goal || 0}
        currentDonations={currentDonations}
        currentPartnersCount={currentPartnersCount}
        newPartnersCount={newPartnersCount}
        surplusBalance={profileData.surplus_balance}
      />

      {/* Recent Donations list */}
      <RecentDonations
        donations={recentDonations}
        missionaryId={missionaryId}
      />
    </div>
  );
} 