/**
 * RecentDonations Component
 * 
 * A component that displays recent donation transactions for a missionary.
 * Features a clean card layout with donor information, dates, and amounts.
 * Includes integration with a donor history modal for detailed donor information.
 * 
 * Key Features:
 * - Displays recent transactions in a card layout
 * - Shows donor name, date, and amount for each transaction
 * - Integrates with DonorHistoryModal for detailed donor history
 * - Handles empty states with a clean placeholder
 * - Uses currency formatting for amounts
 * 
 * @component
 */

"use client"; // <-- add this directive at the top

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatDate, formatCurrency } from "@/lib/utils";
import { useState } from "react";
import DonorHistoryModal from "./DonorHistoryModal";
import { Inbox } from "lucide-react";

/**
 * Interface representing a single donation transaction
 */
interface Donation {
  /** Unique identifier for the donation */
  id: string | number;
  /** Name of the donor who made the donation */
  donor_name: string;
  /** Date when the donation was made */
  date: string;
  /** Amount of the donation */
  amount: number;
}

/**
 * Props for the RecentDonations component
 */
interface RecentDonationsProps {
  /** Array of recent donations to display */
  donations: Donation[];
  /** ID of the missionary to filter donations for in the modal */
  missionaryId: string;
}

export default function RecentDonations({ donations, missionaryId }: RecentDonationsProps) {
  // State for managing the donor history modal
  const [donorModalOpen, setDonorModalOpen] = useState(false);
  const [selectedDonor, setSelectedDonor] = useState<string>("");

  /**
   * Opens the donor history modal for a specific donor
   * @param donorName - Name of the donor to show history for
   */
  const openModal = (donorName: string) => {
    setSelectedDonor(donorName);
    setDonorModalOpen(true);
  };

  return (
    <>
      <Card className="overflow-hidden">
        <CardHeader className="bg-muted/10 px-6 py-4">
          <CardTitle className="text-lg font-semibold">Recent Transactions</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          <div className="divide-y divide-border">
            {donations.length > 0 ? (
              donations.map((donation) => (
                <div
                  key={donation.id}
                  className="flex items-center justify-between p-4 transition-colors hover:bg-muted/5"
                >
                  <div className="grid gap-1">
                    {/* Donor name with click handler for history modal */}
                    <div 
                      className="font-medium cursor-pointer hover:text-primary"
                      onClick={() => openModal(donation.donor_name)}
                    >
                      {donation.donor_name}
                    </div>
                    <div className="text-sm text-muted-foreground">
                      {formatDate(donation.date)}
                    </div>
                  </div>
                  {/* Amount display with currency formatting */}
                  <div className="font-semibold text-emerald-600">
                    ₱{donation.amount.toLocaleString()}
                  </div>
                </div>
              ))
            ) : (
              // Empty state display
              <div className="p-6 text-center text-muted-foreground">
                <Inbox className="mx-auto h-8 w-8 mb-2" />
                <p>No recent transactions</p>
              </div>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Donor History Modal */}
      <DonorHistoryModal
        donorName={selectedDonor}
        missionaryId={missionaryId}
        open={donorModalOpen}
        onOpenChange={setDonorModalOpen}
      />
    </>
  );
}