/**
 * RecentDonationsWrapper Component
 *
 * Server component that fetches and processes recent donation data
 * to be displayed in the RecentDonationsClient component. This
 * component follows the hybrid architecture pattern with server-side
 * data fetching and client-side interactivity.
 * 
 * Features:
 * - Server-side data fetching for better performance
 * - Client-side animations for enhanced user experience
 * - Proper error handling and loading states
 * - Includes streaming markers for performance testing
 *
 * @component
 */

import { createClient } from "@/utils/supabase/server";
import { RecentDonationsClient } from "./RecentDonationsClient";
import { Suspense } from "react";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";
import { RecentDonationsSkeleton } from "./RecentDonationsSkeleton";

interface RecentDonationsWrapperProps {
  missionaryId: string;
}

// Define the donation type for type safety
interface ProcessedDonation {
  id: string | number;
  donor_name: string;
  amount: number;
  date: string;
}

export async function RecentDonationsWrapper({ missionaryId }: RecentDonationsWrapperProps) {
  const supabase = await createClient();
  
  // Fetch recent donations in one query
  const { data: recentDonations } = await supabase
    .from("donor_donations")
    .select("id, donor_id, amount, date")
    .eq("missionary_id", missionaryId)
    .order("date", { ascending: false })
    .limit(10);
  
  // Process donations data
  const processedDonations: ProcessedDonation[] = [];
  
  if (recentDonations && recentDonations.length > 0) {
    // Get unique donor IDs and fetch donor names in a single query
    const donorIds = [...new Set(recentDonations.map(donation => donation.donor_id))];
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
  
  return (
    <ErrorBoundaryProvider componentName="Recent Donations">
      <Suspense fallback={<RecentDonationsSkeleton />}>
        <div data-streaming-marker="recent-donations">
          <RecentDonationsClient 
            donations={processedDonations} 
            missionaryId={missionaryId} 
          />
        </div>
      </Suspense>
    </ErrorBoundaryProvider>
  );
}