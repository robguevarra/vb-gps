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
 * 
 * Data Fetching Strategy:
 * - Two-step query to handle foreign key relationship issues with Supabase
 * - Fallback mechanism for missing donor data
 * - Uses server-side Supabase client to bypass RLS restrictions
 */

import { createClient } from "@/utils/supabase/server";
import { RecentDonationsWrapper } from "@/components/RecentDonationsWrapper";
import { DashboardCardsWrapper } from "@/components/missionary-dashboard/DashboardCardsWrapper";
import { LeaveRequestModalWrapper } from "@/components/missionary-dashboard/LeaveRequestModalWrapper";
import { SurplusRequestModalWrapper } from "@/components/missionary-dashboard/SurplusRequestModalWrapper";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";

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

export default async function OverviewTab({ missionaryId }: OverviewTabProps) {
  // Create server-side Supabase client
  const supabase = await createClient();
  
  // Fetch recent donations
  const { data: recentDonations } = await supabase
    .from("donor_donations")
    .select("id, donor_id, amount, date")
    .eq("missionary_id", missionaryId)
    .order("date", { ascending: false })
    .limit(10);
  
  // Process donations data
  const processedDonations: Array<{
    id: string | number;
    donor_name: string;
    amount: number;
    date: string;
  }> = [];
  
  if (recentDonations && recentDonations.length > 0) {
    // Get unique donor IDs
    const donorIds = [...new Set(recentDonations.map(donation => donation.donor_id))];
    
    // Fetch donor names in a single query
    const { data: donors } = await supabase
      .from("donors")
      .select("id, name")
      .in("id", donorIds);
    
    // Create a map of donor IDs to names for quick lookup
    const donorMap = new Map();
    if (donors) {
      donors.forEach(donor => {
        donorMap.set(donor.id, donor.name);
      });
    }
    
    // Process each donation with donor name
    recentDonations.forEach(donation => {
      const donorName = donorMap.get(donation.donor_id) || `Donor #${donation.donor_id}`;
      processedDonations.push({
        id: donation.id,
        donor_name: donorName,
        amount: donation.amount,
        date: donation.date
      });
    });
  }
  
  // Fetch surplus balance for the SurplusRequestModalWrapper
  const { data: surplusData } = await supabase
    .from("surplus_balance")
    .select("balance")
    .eq("missionary_id", missionaryId)
    .single();
  
  const surplusBalance = parseFloat(surplusData?.balance || "0");
  
  return (
    <ErrorBoundaryProvider componentName="Overview Tab">
      <div className="space-y-8">
        <h2 className="text-2xl font-semibold">Overview</h2>
        
        <div className="flex flex-col sm:flex-row gap-4 justify-between">
          <LeaveRequestModalWrapper missionaryId={missionaryId} />
          <SurplusRequestModalWrapper 
            surplusBalance={surplusBalance} 
            missionaryId={missionaryId} 
          />
        </div>
        
        {/* Use the new DashboardCardsWrapper component */}
        <DashboardCardsWrapper missionaryId={missionaryId} />
        
        <RecentDonationsWrapper missionaryId={missionaryId} />
      </div>
    </ErrorBoundaryProvider>
  );
} 