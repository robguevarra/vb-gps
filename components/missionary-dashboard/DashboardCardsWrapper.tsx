/**
 * DashboardCardsWrapper Component
 * 
 * Server component that fetches dashboard metrics data and passes it to the client-side
 * DashboardCards component for rendering with animations.
 * 
 * This component implements the "Server Component with Client Islands" pattern:
 * - Server-side data fetching for better performance
 * - Client-side animations for enhanced user experience
 * - Proper error handling and loading states
 * 
 * @component
 */

import { createClient } from "@/utils/supabase/server";
import { DashboardCardClient } from "@/components/DashboardCardClient";
import { Suspense } from "react";
import { Skeleton } from "@/components/ui/skeleton";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Alert, AlertTitle, AlertDescription } from "@/components/ui/alert";
import { AlertCircle } from "lucide-react";

interface DashboardCardsWrapperProps {
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

interface ProfileData {
  monthly_goal: number;
  local_church_id: string;
}

interface DonationData {
  amount: string;
}

interface SurplusData {
  balance: string;
}

/**
 * Skeleton loader for dashboard cards
 */
function DashboardCardsSkeleton() {
  return (
    <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
      {[...Array(5)].map((_, i) => (
        <div key={i} className="p-6 space-y-4 border rounded-lg">
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
  );
}

/**
 * Server component that fetches dashboard metrics and passes them to the client component
 */
export async function DashboardCardsWrapper({ missionaryId }: DashboardCardsWrapperProps) {
  const supabase = await createClient();
  
  try {
    // First, try to get data from the pre-calculated stats table for better performance
    const { data: statsData, error: statsError } = await supabase
      .from("missionary_dashboard_stats")
      .select("*")
      .eq("missionary_id", missionaryId)
      .single();
    
    if (statsData) {
      // If we have pre-calculated stats, use them
      const typedStatsData = statsData as StatsData;
      return (
        <ErrorBoundary fallback={<DashboardCardsSkeleton />}>
          <Suspense fallback={<DashboardCardsSkeleton />}>
            <DashboardCardClient
              monthlyGoal={typedStatsData.monthly_goal || 0}
              currentDonations={typedStatsData.current_donations || 0}
              currentPartnersCount={typedStatsData.active_partners_count || 0}
              surplusBalance={typedStatsData.surplus_balance || 0}
              newPartnersCount={typedStatsData.new_partners_count || 0}
            />
          </Suspense>
        </ErrorBoundary>
      );
    }
    
    // If pre-calculated stats are not available, fetch data directly
    
    // Get missionary profile to get their monthly goal
    const { data: profileData, error: profileError } = await supabase
      .from("profiles")
      .select("monthly_goal, local_church_id")
      .eq("id", missionaryId)
      .single();
    
    if (profileError) {
      console.error("Error fetching missionary profile:", profileError);
      return (
        <div className="p-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-md">
          <p className="text-red-600 dark:text-red-400">Error loading dashboard data. Please try again later.</p>
        </div>
      );
    }
    
    // Get current month's donations
    const currentDate = new Date();
    const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
    
    // Format dates for Supabase query
    const startDate = firstDayOfMonth.toISOString().split('T')[0];
    const endDate = lastDayOfMonth.toISOString().split('T')[0];
    
    // Fetch donations in parallel for better performance
    const [donationsResult, surplusResult, partnersResult, newPartnersResult] = await Promise.all([
      // Current month's donations
      supabase
        .from("donations")
        .select("amount")
        .eq("missionary_id", missionaryId)
        .gte("donation_date", startDate)
        .lte("donation_date", endDate)
        .throwOnError(),
      
      // Current surplus balance
      supabase
        .from("surplus_balance")
        .select("balance")
        .eq("missionary_id", missionaryId)
        .single()
        .throwOnError(),
      
      // Active partners (unique donors this month)
      supabase
        .from("donations")
        .select("donor_id", { count: "exact", head: true })
        .eq("missionary_id", missionaryId)
        .gte("donation_date", startDate)
        .lte("donation_date", endDate)
        .throwOnError(),
      
      // New partners this month
      supabase.rpc("get_new_partners_count", { 
        missionary_id_param: missionaryId,
        start_date_param: startDate,
        end_date_param: endDate
      }).throwOnError()
    ]).catch(error => {
      console.error("Error fetching dashboard data:", error);
      return [{ data: [] }, { data: { balance: "0" } }, { count: 0 }, { data: 0 }];
    });
    
    // Calculate current donations total
    const donationsData = donationsResult.data as DonationData[] || [];
    const currentDonations = donationsData.reduce((sum: number, donation) => 
      sum + (parseFloat(donation.amount) || 0), 0);
    
    // Get surplus balance
    const surplusData = surplusResult.data as SurplusData;
    const surplusBalance = parseFloat(surplusData?.balance || "0");
    
    // Get active partners count
    const currentPartnersCount = partnersResult.count || 0;
    
    // Get new partners count
    const newPartnersCount = newPartnersResult.data || 0;
    
    // Type the profile data
    const typedProfileData = profileData as ProfileData;
    
    // Custom fallback UI for dashboard cards errors
    const dashboardCardsErrorFallback = (
      <Alert variant="destructive" className="my-4">
        <AlertCircle className="h-4 w-4" />
        <AlertTitle>Dashboard Cards Error</AlertTitle>
        <AlertDescription>
          <p className="mb-2">There was an error loading the dashboard cards.</p>
          <p className="mb-2">Please try refreshing the page or contact support if the issue persists.</p>
        </AlertDescription>
      </Alert>
    );

    return (
      <ErrorBoundary fallback={dashboardCardsErrorFallback}>
        <Suspense fallback={<DashboardCardsSkeleton />}>
          <DashboardCardClient
            monthlyGoal={typedProfileData?.monthly_goal || 0}
            currentDonations={currentDonations}
            currentPartnersCount={currentPartnersCount}
            surplusBalance={surplusBalance}
            newPartnersCount={newPartnersCount}
          />
        </Suspense>
      </ErrorBoundary>
    );
  } catch (error) {
    console.error("Unexpected error in DashboardCardsWrapper:", error);
    return (
      <div className="p-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-md">
        <p className="text-red-600 dark:text-red-400">An unexpected error occurred. Please try again later.</p>
      </div>
    );
  }
} 