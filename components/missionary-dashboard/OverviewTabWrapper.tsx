/**
 * OverviewTabWrapper Component
 * 
 * Server component that fetches data for the missionary dashboard overview tab.
 * Implements optimized data fetching with parallel queries and proper error handling.
 * 
 * Key Features:
 * - Server-side data fetching for better performance
 * - Parallel data fetching to prevent waterfall requests
 * - Proper error handling and fallback states
 * - Suspense boundaries for progressive loading
 * - Type-safe data processing before passing to client components
 * 
 * @component
 */

import { createClient } from "@/utils/supabase/server";
import OverviewTab from "./OverviewTab";
import { Suspense } from "react";
import { Skeleton } from "@/components/ui/skeleton";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";
import { Card } from "@/components/ui/card";

interface OverviewTabWrapperProps {
  missionaryId: string;
}

// Define types for database responses
interface StatsData {
  missionary_id: string;
  monthly_goal: number;
  current_donations: number;
  active_partners_count: number;
  surplus_balance: number;
  new_partners_count: number;
}

interface SurplusData {
  balance: string;
}

interface DonorData {
  id: number | string;
  name: string;
}

interface DonationData {
  id: number | string;
  amount: number | string;
  date: string;
  donor_id: number | string;
  donors?: DonorData | null;
}

/**
 * Skeleton loader for the OverviewTab
 * Displays while the data is being fetched
 */
function OverviewTabSkeleton() {
  return (
    <div className="space-y-8">
      <Skeleton className="h-10 w-[200px]" />
      
      {/* Action Buttons Skeleton */}
      <div className="flex flex-col sm:flex-row gap-4 justify-between">
        <Skeleton className="h-10 w-40" />
        <Skeleton className="h-10 w-40" />
      </div>
      
      {/* Dashboard Cards Skeleton */}
      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        {[...Array(5)].map((_, i) => (
          <div key={i} className="p-6 space-y-4 border rounded-lg bg-card">
            <div className="flex items-center justify-between">
              <Skeleton className="h-10 w-10 rounded-full" />
              <Skeleton className="h-6 w-16" />
            </div>
            <div className="space-y-2">
              <Skeleton className="h-4 w-24" />
              <Skeleton className="h-8 w-32" />
            </div>
            <Skeleton className="h-2 w-full mt-4" />
          </div>
        ))}
      </div>
      
      {/* Recent Donations Skeleton */}
      <Card className="p-6">
        <div className="flex justify-between items-center mb-6">
          <Skeleton className="h-7 w-48" />
          <Skeleton className="h-9 w-32" />
        </div>
        <div className="space-y-4">
          {[...Array(5)].map((_, i) => (
            <div key={i} className="flex items-center justify-between py-2">
              <div className="flex items-center gap-3">
                <Skeleton className="h-10 w-10 rounded-full" />
                <div>
                  <Skeleton className="h-4 w-32 mb-2" />
                  <Skeleton className="h-3 w-24" />
                </div>
              </div>
              <Skeleton className="h-6 w-20" />
            </div>
          ))}
        </div>
      </Card>
    </div>
  );
}

export async function OverviewTabWrapper({ missionaryId }: OverviewTabWrapperProps) {
  const supabase = await createClient();

  // Initialize default values for results
  let statsData: Partial<StatsData> = {
    monthly_goal: 0,
    current_donations: 0,
    active_partners_count: 0,
    surplus_balance: 0,
    new_partners_count: 0
  };
  
  let surplusBalance = 0;
  let processedDonations: Array<{
    id: number;
    amount: number;
    date: string;
    donor_id: number;
    donors: { id: number; name: string } | null;
  }> = [];

  try {
    // Fetch all necessary data in parallel for better performance
    const [statsResult, surplusResult, recentDonationsResult] = await Promise.all([
      // Dashboard stats
      supabase
        .from("missionary_dashboard_stats")
        .select("*")
        .eq("missionary_id", missionaryId)
        .single(),
      
      // Surplus balance
      supabase
        .from("surplus_balance")
        .select("balance")
        .eq("missionary_id", missionaryId)
        .single(),
      
      // Recent donations
      supabase
        .from("donor_donations")
        .select("id, amount, date, donor_id, donors(id, name)")
        .eq("missionary_id", missionaryId)
        .order("date", { ascending: false })
        .limit(10)
    ]);

    // Process stats data
    statsData = statsResult.data as StatsData || statsData;

    // Process surplus data
    surplusBalance = parseFloat(surplusResult.data?.balance || "0");

    // Process and type-check the donations data
    if (recentDonationsResult.data) {
      processedDonations = recentDonationsResult.data.map((donation: any) => {
        // Extract donor data safely
        const donorData = donation.donors && typeof donation.donors === 'object' ? {
          id: Number(donation.donors.id),
          name: String(donation.donors.name)
        } : null;
        
        return {
          id: Number(donation.id),
          amount: Number(donation.amount),
          date: String(donation.date),
          donor_id: Number(donation.donor_id),
          donors: donorData
        };
      });
    }
  } catch (error) {
    console.error("Error fetching overview data:", error);
    // Default values are already set above
  }

  return (
    <ErrorBoundaryProvider componentName="Overview Tab">
      <div className="space-y-8">
        <h2 className="text-2xl font-bold tracking-tight">Overview</h2>
        <p className="text-muted-foreground">
          View your dashboard metrics and recent activity.
        </p>
        <Suspense fallback={<OverviewTabSkeleton />}>
          <OverviewTab
            missionaryId={missionaryId}
            statsData={statsData as StatsData}
            surplusBalance={surplusBalance}
            recentDonations={processedDonations}
          />
        </Suspense>
      </div>
    </ErrorBoundaryProvider>
  );
} 