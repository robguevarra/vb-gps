"use client"; // <-- add this directive at the top

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatDate, formatCurrency } from "@/lib/utils";
import { useState } from "react";
import DonorHistoryModal from "./DonorHistoryModal";

interface Donation {
  id: string | number;
  donor_name: string;
  date: string;
  amount: number;
}

interface RecentDonationsProps {
  donations: Donation[];
  missionaryId: string; // <-- new prop for filtering modal data
}

export default function RecentDonations({ donations, missionaryId }: RecentDonationsProps) {
  const [donorModalOpen, setDonorModalOpen] = useState(false);
  const [selectedDonor, setSelectedDonor] = useState<string>("");

  const openModal = (donorName: string) => {
    setSelectedDonor(donorName);
    setDonorModalOpen(true);
  };

  return (
    <>
      <Card className="bg-white dark:bg-gray-800 shadow-lg rounded-xl overflow-hidden">
        <CardHeader>
          <CardTitle className="text-2xl font-bold text-gray-900 dark:text-white">
            Recent Donations
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {donations.length > 0 ? (
              donations.map((donation) => (
                <div
                  key={donation.id}
                  className="flex justify-between items-center border-b border-gray-200 dark:border-gray-700 pb-4 last:border-b-0 last:pb-0"
                >
                  <div>
                    <button
                      onClick={() => openModal(donation.donor_name)}
                      className="font-semibold text-gray-800 dark:text-gray-200 hover:underline"
                    >
                      {donation.donor_name}
                    </button>
                    <p className="text-sm text-gray-500 dark:text-gray-400">
                      {formatDate(donation.date)}
                    </p>
                  </div>
                  <p className="text-lg font-bold text-green-600 dark:text-green-400">
                    {formatCurrency(donation.amount)}
                  </p>
                </div>
              ))
            ) : (
              <p className="text-gray-500 dark:text-gray-400">
                No donations yet.
              </p>
            )}
          </div>
        </CardContent>
      </Card>
      {/* Render the donor modal */}
      <DonorHistoryModal
        donorName={selectedDonor}
        missionaryId={missionaryId}
        open={donorModalOpen}
        onOpenChange={setDonorModalOpen}
      />
    </>
  );
}