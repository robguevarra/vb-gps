import { createClient } from "@/utils/supabase/server";
import { Profile } from "@/types/reports";
import DashboardCards from "@/components/DashboardCards";
import RecentDonations from "@/components/RecentDonations";
import { LeaveRequestModal } from "@/components/LeaveRequestModal";
import { SurplusRequestModal } from "@/components/SurplusRequestModal";
import { Suspense } from "react";
import { LoadingSpinner } from "@/components/LoadingSpinner";
import { ErrorBoundary } from "@/components/ErrorBoundary";

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
 * Loading component for the overview tab
 */
function OverviewTabSkeleton() {
  return (
    <div className="space-y-8 animate-pulse">
      {/* Request Actions Skeleton */}
      <div className="flex gap-4">
        <div className="h-10 w-32 bg-gray-200 rounded-md" />
        <div className="h-10 w-32 bg-gray-200 rounded-md" />
      </div>

      {/* Dashboard Cards Skeleton */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {[...Array(4)].map((_, i) => (
          <div key={i} className="h-32 bg-gray-200 rounded-lg" />
        ))}
      </div>

      {/* Recent Donations Skeleton */}
      <div className="space-y-4">
        <div className="h-8 w-48 bg-gray-200 rounded-md" />
        <div className="space-y-2">
          {[...Array(5)].map((_, i) => (
            <div key={i} className="h-16 bg-gray-200 rounded-md" />
          ))}
        </div>
      </div>
    </div>
  );
}

/**
 * Error component for the overview tab
 */
function OverviewTabError({ error }: { error: Error }) {
  return (
    <div className="space-y-4 p-4 bg-red-50 dark:bg-red-900/20 rounded-lg">
      <h3 className="text-red-800 dark:text-red-200 font-medium">Error Loading Dashboard</h3>
      <p className="text-red-600 dark:text-red-300 text-sm">{error.message}</p>
    </div>
  );
}

/**
 * Separate data fetching function for better organization and reusability
 */
async function fetchOverviewData(missionaryId: string) {
  const supabase = await createClient();
  
  // Initialize date variables for time-based queries
  const today = new Date();
  const year = today.getFullYear();
  const month = today.getMonth() + 1;
  
  // Format dates for Postgres timestamp comparison
  const startOfMonth = `${year}-${month.toString().padStart(2, '0')}-01`;
  const endOfMonth = `${year}-${month.toString().padStart(2, '0')}-31`;
  
  // Fetch all data in parallel with proper error handling
  const [
    donationsResult,
    currentDonorsResult,
    previousDonorsResult,
    currentMonthDonationsResult
  ] = await Promise.all([
    // Recent donations
    supabase
      .from("donor_donations")
      .select("id, amount, date, donor_id, notes")
      .eq("missionary_id", missionaryId)
      .order("date", { ascending: false })
      .limit(5),
    // Current month donors
    supabase
      .from('donor_donations')
      .select('donor_id')
      .eq('missionary_id', missionaryId)
      .gte('date', startOfMonth)
      .lt('date', `${endOfMonth} 23:59:59.999`),
    // Previous donors
    supabase
      .from('donor_donations')
      .select('donor_id')
      .eq('missionary_id', missionaryId)
      .lt('date', startOfMonth),
    // Current month donations
    supabase
      .from('donor_donations')
      .select('amount, date')
      .eq('missionary_id', missionaryId)
      .gte('date', startOfMonth)
      .lt('date', `${endOfMonth} 23:59:59.999`)
  ]);

  // Handle potential errors
  if (donationsResult.error) throw new Error(donationsResult.error.message);
  if (currentDonorsResult.error) throw new Error(currentDonorsResult.error.message);
  if (previousDonorsResult.error) throw new Error(previousDonorsResult.error.message);
  if (currentMonthDonationsResult.error) throw new Error(currentMonthDonationsResult.error.message);

  // Get donor names for recent donations
  const donorNamesMap = new Map<number, string>();
  if (donationsResult.data && donationsResult.data.length > 0) {
    const donorIds = [...new Set(donationsResult.data.map(d => d.donor_id))];
    const donorsResult = await supabase
      .from("donors")
      .select("id, name")
      .in("id", donorIds);

    if (donorsResult.error) throw new Error(donorsResult.error.message);
    
    if (donorsResult.data) {
      donorsResult.data.forEach(donor => {
        donorNamesMap.set(donor.id, donor.name);
      });
    }
  }

  // Calculate dashboard stats
  const currentDonorIds = new Set(currentDonorsResult.data?.map(d => d.donor_id) || []);
  const previousDonorIds = new Set(previousDonorsResult.data?.map(d => d.donor_id) || []);
  const currentPartnersCount = currentDonorIds.size;
  const newPartnersCount = Array.from(currentDonorIds).filter(id => !previousDonorIds.has(id)).length;

  // Process donation data
  const recentDonations: Donation[] = donationsResult.data?.map(d => ({
    id: d.id,
    donor_name: donorNamesMap.get(d.donor_id) || `Donor #${d.donor_id}`,
    amount: Number(d.amount),
    date: new Date(d.date).toLocaleDateString(),
    notes: d.notes || "",
  })) || [];

  // Calculate current donations total
  const currentDonations = currentMonthDonationsResult.data?.reduce(
    (acc, d) => acc + Number(d.amount),
    0
  ) || 0;

  return {
    currentDonations,
    currentPartnersCount,
    newPartnersCount,
    recentDonations
  };
}

/**
 * OverviewTab component for the missionary dashboard.
 * 
 * This component implements several performance optimizations:
 * 1. Parallel data fetching with Promise.all
 * 2. Proper error handling and boundaries
 * 3. Loading states with skeletons
 * 4. Efficient data processing with Maps
 * 5. Type-safe data handling
 */
export async function OverviewTab({ missionaryId, profileData, isSuperAdmin }: OverviewTabProps) {
  // Fetch data with error handling
  let overviewData;
  try {
    overviewData = await fetchOverviewData(missionaryId);
  } catch (error) {
    console.error("Error fetching overview data:", error);
    return <OverviewTabError error={error as Error} />;
  }

  const { currentDonations, currentPartnersCount, newPartnersCount, recentDonations } = overviewData;

  return (
    <ErrorBoundary fallback={<OverviewTabError error={new Error("Something went wrong")} />}>
      <Suspense fallback={<OverviewTabSkeleton />}>
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
            isLoading={false}
          />

          {/* Recent Donations list */}
          <RecentDonations
            donations={recentDonations}
            missionaryId={missionaryId}
            isLoading={false}
          />
        </div>
      </Suspense>
    </ErrorBoundary>
  );
} 