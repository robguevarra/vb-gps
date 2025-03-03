import { createClient } from "@/utils/supabase/server";
import { ReportsTab } from "@/components/ReportsTab";
import { Suspense } from "react";
import { Skeleton } from "@/components/ui/skeleton";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";

interface ReportsTabWrapperProps {
  missionaryId: string;
}

/**
 * ReportsTabWrapper Component
 * 
 * Server component that fetches donation data for the missionary dashboard reports tab.
 * Implements optimized data fetching with parallel queries and proper error handling.
 * 
 * @param missionaryId - The ID of the missionary to fetch data for
 */
export async function ReportsTabWrapper({ missionaryId }: ReportsTabWrapperProps) {
  const supabase = await createClient();

  // Fetch donation data in parallel for better performance
  // Using Promise.all to prevent waterfall requests
  const [last13MonthDonationsResult, allTimeDonorsResult] = await Promise.all([
    supabase
      .from("donor_donations")
      .select("id, amount, date, donor_id, donors(id, name)")
      .eq("missionary_id", missionaryId)
      .gte("date", new Date(new Date().setMonth(new Date().getMonth() - 13)).toISOString())
      .order("date", { ascending: false })
      .throwOnError(),
    supabase
      .from("donor_donations")
      .select("donor_id, amount, date, donors(id, name)")
      .eq("missionary_id", missionaryId)
      .order("date", { ascending: false })
      .throwOnError()
  ]).catch(error => {
    console.error("Error fetching donation data:", error);
    // Return empty results in case of error
    return [{ data: [] }, { data: [] }];
  });

  // Process and type-check the data before passing to client component
  // This ensures we have clean, validated data
  const processedLast13MonthDonations = last13MonthDonationsResult.data?.map(d => ({
    id: Number(d.id),
    amount: Number(d.amount),
    date: String(d.date),
    donor_id: Number(d.donor_id),
    donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
      id: Number(d.donors.id),
      name: String(d.donors.name)
    } : null
  })) || [];

  const processedAllTimeDonors = allTimeDonorsResult.data?.map(d => ({
    donor_id: Number(d.donor_id),
    amount: Number(d.amount),
    date: String(d.date),
    donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
      id: Number(d.donors.id),
      name: String(d.donors.name)
    } : null
  })) || [];

  return (
    <ErrorBoundaryProvider componentName="Reports Tab">
      <div className="space-y-8">
        <h2 className="text-2xl font-bold tracking-tight">My Reports</h2>
        <p className="text-muted-foreground">
          Track your partner giving patterns and donation history.
        </p>
        <Suspense fallback={<ReportsTabSkeleton />}>
          <ReportsTab
            missionaryId={missionaryId}
            last13MonthDonations={processedLast13MonthDonations}
            allTimeDonors={processedAllTimeDonors}
          />
        </Suspense>
      </div>
    </ErrorBoundaryProvider>
  );
}

/**
 * Skeleton loader for the ReportsTab
 * Displays while the data is being fetched
 */
function ReportsTabSkeleton() {
  return (
    <div className="space-y-6">
      <div className="space-y-2">
        <Skeleton className="h-10 w-[200px]" />
        <Skeleton className="h-4 w-full" />
        <Skeleton className="h-4 w-3/4" />
      </div>
      <div className="grid gap-6">
        <Skeleton className="h-[400px] w-full rounded-xl" />
      </div>
    </div>
  );
} 