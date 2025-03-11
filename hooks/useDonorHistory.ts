/**
 * useDonorHistory Hook
 *
 * A custom React Query hook for fetching donation history for a specific donor.
 * This hook provides a clean and efficient way to fetch, cache, and handle
 * loading/error states for donor history data.
 */

import { useQuery } from "@tanstack/react-query";
import { createClient } from "@/utils/supabase/client";

interface Donation {
  id: number | string;
  amount: number;
  date: string;
  donor_name: string;
}

interface UseDonorHistoryProps {
  donorName: string;
  missionaryId: string;
  enabled?: boolean;
}

export function useDonorHistory({ donorName, missionaryId, enabled = true }: UseDonorHistoryProps) {
  return useQuery({
    queryKey: ["donorHistory", donorName, missionaryId],
    queryFn: async (): Promise<Donation[]> => {
      if (!donorName) return [];
      
      const supabase = createClient();
      let donorDonations: Donation[] = [];
      
      // Check if the donorName is in the format "Donor #123"
      const donorIdMatch = donorName.match(/Donor #(\d+)/);
      
      if (donorIdMatch) {
        // If it's a fallback donor name, use the donor_id directly
        const donorId = parseInt(donorIdMatch[1], 10);
        
        const { data, error } = await supabase
          .from("donor_donations")
          .select("id, amount, date")
          .eq("missionary_id", missionaryId)
          .eq("donor_id", donorId)
          .order("date", { ascending: false });
          
        if (!error && data) {
          donorDonations = data.map(record => ({
            id: record.id,
            amount: record.amount,
            date: record.date,
            donor_name: donorName
          }));
        } else if (error) {
          throw new Error(`Failed to fetch donation history: ${error.message}`);
        }
      } else {
        // Otherwise try to get with proper joins
        const { data, error } = await supabase
          .from("donor_donations")
          .select("id, amount, date, donor_id, donors!inner(name)")
          .eq("missionary_id", missionaryId)
          .eq("donors.name", donorName)
          .order("date", { ascending: false });

        if (!error && data) {
          donorDonations = data.map(record => ({
            id: record.id,
            amount: record.amount,
            date: record.date,
            donor_name: (record.donors as any)?.name || donorName
          }));
        } else if (error) {
          throw new Error(`Failed to fetch donation history: ${error.message}`);
        }
      }
      
      return donorDonations;
    },
    enabled: enabled && !!donorName && !!missionaryId,
    staleTime: 5 * 60 * 1000, // 5 minutes
    cacheTime: 30 * 60 * 1000, // 30 minutes
  });
}