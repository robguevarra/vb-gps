/**
 * OverviewTab Component
 * 
 * Server Component that displays the missionary dashboard overview tab.
 * This component has been optimized to fetch data on the server side
 * and pass it to client components for rendering.
 * 
 * Implementation Notes:
 * - Converted to a Server Component to optimize data fetching
 * - Uses server-side Supabase client to bypass RLS restrictions
 * - Separates data fetching from UI rendering for better performance
 * - Passes data to client components for interactive elements
 * - Implements nested Suspense boundaries for progressive loading
 * - Uses streaming to improve perceived performance
 * - Preloads other tab data in the background after rendering
 * 
 * Data Fetching Strategy:
 * - Two-step query to handle foreign key relationship issues with Supabase
 * - Fallback mechanism for missing donor data
 * - Uses server-side Supabase client to bypass RLS restrictions
 * - Parallel data fetching for independent sections
 */

import { createClient } from "@/utils/supabase/server";
import { RecentDonationsWrapper } from "@/components/RecentDonationsWrapper";
import { DashboardCardsWrapper } from "@/components/missionary-dashboard/DashboardCardsWrapper";
import { LeaveRequestModalWrapper } from "@/components/missionary-dashboard/LeaveRequestModalWrapper";
import { SurplusRequestModalWrapper } from "@/components/missionary-dashboard/SurplusRequestModalWrapper";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";
import { Suspense } from "react";
import { Skeleton } from "@/components/ui/skeleton";
import { Card } from "@/components/ui/card";
import { BackgroundTabPreloader } from "@/components/missionary-dashboard/BackgroundTabPreloader";

// Define interfaces for type safety
interface DonationData {
  id: string;
  donor_id: number;
  amount: number;
  date: string;
  donor_name?: string;
}

interface OverviewTabProps {
  missionaryId: string;
}

// Skeleton loaders for individual sections
function ActionButtonsSkeleton() {
  return (
    <div className="flex flex-col sm:flex-row gap-4 justify-between">
      <Skeleton className="h-10 w-40" />
      <Skeleton className="h-10 w-40" />
    </div>
  );
}

// Async component for fetching and rendering surplus balance
async function SurplusRequestSection({ missionaryId }: { missionaryId: string }) {
  const supabase = await createClient();
  
  // Fetch surplus balance for the SurplusRequestModalWrapper
  const { data: surplusData } = await supabase
    .from("surplus_balance")
    .select("balance")
    .eq("missionary_id", missionaryId)
    .single();
  
  const surplusBalance = parseFloat(surplusData?.balance || "0");
  
  return (
    <SurplusRequestModalWrapper 
      surplusBalance={surplusBalance} 
      missionaryId={missionaryId} 
    />
  );
}

export default async function OverviewTab({ missionaryId }: OverviewTabProps) {
  return (
    <ErrorBoundaryProvider componentName="Overview Tab">
      <div className="space-y-8">
        <h2 className="text-2xl font-semibold">Overview</h2>
        
        {/* Action Buttons Section with Suspense */}
        <div className="flex flex-col sm:flex-row gap-4 justify-between">
          {/* Leave Request Button loads immediately */}
          <LeaveRequestModalWrapper missionaryId={missionaryId} />
          
          {/* Surplus Request Button with Suspense for data fetching */}
          <Suspense fallback={<Skeleton className="h-10 w-40" />}>
            <SurplusRequestSection missionaryId={missionaryId} />
          </Suspense>
        </div>
        
        {/* Dashboard Cards Section with Suspense */}
        <Suspense fallback={
          <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
            {[...Array(5)].map((_, i) => (
              <div key={i} className="p-6 space-y-4 border rounded-lg bg-card animate-pulse">
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
        }>
          <DashboardCardsWrapper missionaryId={missionaryId} />
        </Suspense>
        
        {/* Recent Donations Section with Suspense */}
        <Suspense fallback={
          <Card className="p-6">
            <div className="flex justify-between items-center mb-6">
              <Skeleton className="h-7 w-48" />
              <Skeleton className="h-9 w-32" />
            </div>
            <div className="space-y-4">
              {[...Array(5)].map((_, i) => (
                <div key={i} className="flex items-center justify-between py-2 animate-pulse">
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
        }>
          <RecentDonationsWrapper missionaryId={missionaryId} />
        </Suspense>
        
        {/* Background preloader for other tabs */}
        <BackgroundTabPreloader missionaryId={missionaryId} />
      </div>
    </ErrorBoundaryProvider>
  );
} 