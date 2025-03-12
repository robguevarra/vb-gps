/**
 * OverviewTab Component
 * 
 * Client component that displays the missionary dashboard overview tab.
 * This component receives pre-fetched data from the server component
 * and handles client-side interactivity.
 * 
 * Implementation Notes:
 * - Receives data from server component for better performance
 * - Handles client-side interactivity and animations
 * - Implements modular component architecture
 * - Uses React Server Components pattern with client islands
 * 
 * @component
 */

"use client";

import { LeaveRequestModal } from "./LeaveRequestModal";
import { SurplusRequestModal } from "./SurplusRequestModal";
import { DashboardCards } from "./DashboardCards";
import { RecentDonations } from "./RecentDonations";
import { Button } from "@/components/ui/button";
import { RefreshCw } from "lucide-react";
import { useState, Suspense } from "react";
import { useRouter, usePathname, useSearchParams } from "next/navigation";

// Define interfaces for type safety
interface DonationData {
  id: number;
  amount: number;
  date: string;
  donor_id: number;
  donors: { id: number; name: string } | null;
}

interface StatsData {
  monthly_goal: number;
  current_donations: number;
  active_partners_count: number;
  surplus_balance: number;
  new_partners_count: number;
}

interface OverviewTabProps {
  missionaryId: string;
  statsData?: StatsData;
  surplusBalance?: number;
  recentDonations?: DonationData[];
}

/**
 * RefreshButton Component
 * 
 * Client component that handles the refresh functionality.
 * This is separated to properly handle the useSearchParams hook
 * which needs to be wrapped in a Suspense boundary.
 */
function RefreshButton() {
  const [isRefreshing, setIsRefreshing] = useState(false);
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  
  // Handle manual refresh
  const handleRefresh = () => {
    setIsRefreshing(true);
    
    // Add a timestamp parameter to force a fresh server request
    const newParams = new URLSearchParams(searchParams?.toString() || "");
    newParams.set("refresh", Date.now().toString());
    router.push(`${pathname}?${newParams.toString()}`);
    
    // Reset the refreshing state after a delay
    setTimeout(() => {
      setIsRefreshing(false);
    }, 1000);
  };

  return (
    <Button 
      variant="outline" 
      size="sm" 
      onClick={handleRefresh}
      className="flex items-center gap-1 text-xs"
      disabled={isRefreshing}
    >
      <RefreshCw className={`h-3 w-3 ${isRefreshing ? 'animate-spin' : ''}`} />
      {isRefreshing ? 'Refreshing...' : 'Refresh Data'}
    </Button>
  );
}

export default function OverviewTab({ 
  missionaryId, 
  statsData = {
    monthly_goal: 0,
    current_donations: 0,
    active_partners_count: 0,
    surplus_balance: 0,
    new_partners_count: 0
  }, 
  surplusBalance = 0, 
  recentDonations = [] 
}: OverviewTabProps) {
  return (
    <div className="space-y-8">
      {/* Refresh Button with Suspense boundary */}
      <div className="flex justify-end">
        <Suspense fallback={
          <Button variant="outline" size="sm" disabled className="flex items-center gap-1 text-xs">
            <RefreshCw className="h-3 w-3" />
            Loading...
          </Button>
        }>
          <RefreshButton />
        </Suspense>
      </div>
      
      {/* Action Buttons Section */}
      <div className="flex flex-col sm:flex-row gap-4 justify-between">
        <LeaveRequestModal missionaryId={missionaryId} />
        <SurplusRequestModal 
          surplusBalance={surplusBalance} 
          missionaryId={missionaryId} 
        />
      </div>
      
      {/* Dashboard Cards Section */}
      <DashboardCards
        monthlyGoal={statsData.monthly_goal}
        currentDonations={statsData.current_donations}
        currentPartnersCount={statsData.active_partners_count}
        surplusBalance={statsData.surplus_balance}
        newPartnersCount={statsData.new_partners_count}
      />
      
      {/* Recent Donations Section */}
      <RecentDonations
        donations={recentDonations.map(d => ({
          id: d.id,
          donor_name: d.donors?.name || `Donor #${d.donor_id}`,
          amount: d.amount,
          date: d.date
        }))}
        missionaryId={missionaryId}
      />
    </div>
  );
} 