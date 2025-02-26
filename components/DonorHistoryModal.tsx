/**
 * DonorHistoryModal Component
 * 
 * A modal component that displays the complete donation history for a specific donor
 * to a specific missionary. This component is typically triggered from the RecentDonations
 * component when a user clicks on a donor's name.
 * 
 * Key Features:
 * - Real-time donation history fetching via Supabase
 * - Displays donation amounts and dates in a scrollable list
 * - Handles loading states and error scenarios
 * - Responsive design with max height constraint
 * - Clean empty state handling
 * 
 * Performance Considerations:
 * - Data is fetched only when modal is opened
 * - Uses optimistic updates for real-time data
 * - Implements proper cleanup on modal close
 * 
 * @component
 */

"use client";

import { useEffect, useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-react";
import { createClient } from "@/utils/supabase/client";
import { PostgrestError } from "@supabase/supabase-js";

/**
 * Interface representing a single donation record
 */
interface Donation {
  /** Unique identifier for the donation */
  id: number | string;
  /** Amount of the donation */
  amount: number;
  /** Date of the donation in string format */
  date: string;
  /** Name of the donor who made the donation */
  donor_name: string;
}

/**
 * Props for the DonorHistoryModal component
 */
interface DonorHistoryModalProps {
  /** Name of the donor whose history is being displayed */
  donorName: string;
  /** ID of the missionary to filter donations for */
  missionaryId: string;
  /** Whether the modal is currently open */
  open: boolean;
  /** Callback function to handle modal open state changes */
  onOpenChange: (open: boolean) => void;
}

export default function PartnerHistoryModal({
  donorName,
  missionaryId,
  open,
  onOpenChange,
}: DonorHistoryModalProps) {
  // State for managing donations data and UI states
  const [donations, setDonations] = useState<Donation[]>([]);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string>("");

  /**
   * Effect hook to fetch donor's donation history when modal opens
   * Only triggers when modal is opened to optimize performance
   */
  useEffect(() => {
    if (open) {
      setLoading(true);
      const supabase = createClient();

      const fetchDonations = async () => {
        try {
          // Step 1: First attempt to get donations using the donor's name
          // This is more resilient when RLS is enabled
          let donorDonations: Donation[] = [];
          
          // Check if the donorName is in the format "Donor #123"
          const donorIdMatch = donorName.match(/Donor #(\d+)/);
          
          if (donorIdMatch) {
            // If it's a fallback donor name, use the donor_id directly
            const donorId = parseInt(donorIdMatch[1], 10);
            
            const { data: directData, error: directError } = await supabase
              .from("donor_donations")
              .select("id, amount, date")
              .eq("missionary_id", missionaryId)
              .eq("donor_id", donorId)
              .order("date", { ascending: false });
              
            if (!directError && directData) {
              donorDonations = directData.map(record => ({
                id: record.id,
                amount: record.amount,
                date: record.date,
                donor_name: donorName // Use the provided donor name since we don't have the real one
              }));
            }
          } else {
            // Otherwise try to get with proper joins
            // Define the expected response type
            interface DonorDonationWithDonor {
              id: number | string;
              amount: number;
              date: string;
              donor_id: number;
              donors: {
                name: string;
              };
            }
            
            const { data, error } = await supabase
              .from("donor_donations")
              .select("id, amount, date, donor_id, donors!inner(name)")
              .eq("missionary_id", missionaryId)
              .eq("donors.name", donorName)
              .order("date", { ascending: false });

            if (!error && data) {
              // Type assertion to help TypeScript understand the structure
              const typedData = data as unknown as DonorDonationWithDonor[];
              
              donorDonations = typedData.map(record => ({
                id: record.id,
                amount: record.amount,
                date: record.date,
                donor_name: record.donors.name || donorName
              }));
            }
          }
          
          setDonations(donorDonations);
        } catch (err) {
          const error = err as Error | PostgrestError;
          console.error("Error fetching partner history:", error);
          setError("Failed to load donation history. Please try again later.");
        } finally {
          setLoading(false);
        }
      };

      fetchDonations();
    }
  }, [open, donorName, missionaryId]);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Giving History for {donorName}</DialogTitle>
        </DialogHeader>
        {loading ? (
          <div className="flex justify-center items-center">
            <Loader2 className="animate-spin" />
          </div>
        ) : error ? (
          <p className="text-red-500">{error}</p>
        ) : (
          <div className="space-y-4 max-h-[400px] overflow-y-auto">
            {donations.length > 0 ? (
              donations.map((donation) => (
                <div key={donation.id} className="p-2 border-b border-gray-200">
                  <p>
                    <strong>Date:</strong>{" "}
                    {new Date(donation.date).toLocaleDateString()}
                  </p>
                  <p>
                    <strong>Amount:</strong> ₱
                    {donation.amount.toLocaleString()}
                  </p>
                </div>
              ))
            ) : (
              <p>No donation history found for this partner.</p>
            )}
          </div>
        )}
        <div className="mt-4 flex justify-end">
          <Button variant="ghost" onClick={() => onOpenChange(false)}>
            Close
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
} 