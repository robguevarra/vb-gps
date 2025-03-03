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
 * - Enhanced animations with staggered item reveals
 * 
 * @component
 */

"use client"; // <-- add this directive at the top

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatDate, formatCurrency } from "@/lib/utils";
import { memo, useMemo, useCallback, useState } from "react";
import PartnerHistoryModal from "./DonorHistoryModal";
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
  /** Loading state for the component */
  isLoading?: boolean;
}

/**
 * Skeleton component for loading state
 */
function RecentDonationsSkeleton() {
  return (
    <Card className="overflow-hidden shadow-sm animate-pulse">
      <CardHeader className="bg-muted/10 px-6 py-4">
        <div className="h-6 w-48 bg-gray-200 rounded" />
      </CardHeader>
      <CardContent className="p-0">
        <div className="divide-y divide-border">
          {[...Array(5)].map((_, i) => (
            <div key={i} className="flex items-center justify-between p-4">
              <div className="grid gap-1">
                <div className="h-5 w-32 bg-gray-200 rounded" />
                <div className="h-4 w-24 bg-gray-200 rounded" />
              </div>
              <div className="h-6 w-24 bg-gray-200 rounded" />
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  );
}

/**
 * Empty state component
 */
const EmptyState = memo(function EmptyState() {
  return (
    <div className="p-6 text-center text-muted-foreground">
      <Inbox className="mx-auto h-8 w-8 mb-2" />
      <p>No recent transactions</p>
    </div>
  );
});

/**
 * Individual donation item component with memoization
 */
const DonationItem = memo(function DonationItem({ 
  donation,
  onOpenModal 
}: { 
  donation: Donation;
  onOpenModal: (donorName: string) => void;
}) {
  const formattedAmount = useMemo(() => 
    formatCurrency(donation.amount),
    [donation.amount]
  );

  const formattedDate = useMemo(() => 
    formatDate(donation.date),
    [donation.date]
  );

  return (
    <div className="flex items-center justify-between p-4 transition-colors hover:bg-muted/50">
      <div className="grid gap-1">
        <button
          onClick={() => onOpenModal(donation.donor_name)}
          className="font-medium text-left hover:text-primary transition-colors"
        >
          {donation.donor_name}
        </button>
        <div className="text-sm text-muted-foreground">
          {formattedDate}
        </div>
      </div>
      <div className="font-semibold text-emerald-600">
        {formattedAmount}
      </div>
    </div>
  );
});

/**
 * Main RecentDonations component with optimized rendering
 */
export default function RecentDonations({ 
  donations, 
  missionaryId,
  isLoading = false 
}: RecentDonationsProps) {
  const [partnerModalOpen, setPartnerModalOpen] = useState(false);
  const [selectedPartner, setSelectedPartner] = useState<string>("");

  const openModal = useCallback((donorName: string) => {
    setSelectedPartner(donorName);
    setPartnerModalOpen(true);
  }, []);

  if (isLoading) {
    return <RecentDonationsSkeleton />;
  }

  return (
    <>
      <Card className="overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-300">
        <CardHeader className="bg-muted/10 px-6 py-4">
          <CardTitle className="text-lg font-semibold">Recent Transactions</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          <div className="divide-y divide-border">
            {donations.length > 0 ? (
              <div className="max-h-[400px] overflow-auto">
                {donations.map((donation) => (
                  <DonationItem
                    key={donation.id}
                    donation={donation}
                    onOpenModal={openModal}
                  />
                ))}
              </div>
            ) : (
              <EmptyState />
            )}
          </div>
        </CardContent>
      </Card>

      {/* Partner History Modal */}
      <PartnerHistoryModal
        donorName={selectedPartner}
        missionaryId={missionaryId}
        open={partnerModalOpen}
        onOpenChange={setPartnerModalOpen}
      />
    </>
  );
}