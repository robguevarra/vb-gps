"use client"; // <-- add this directive at the top

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatDate, formatCurrency } from "@/lib/utils";
import { useState } from "react";
import DonorHistoryModal from "./DonorHistoryModal";
import { Inbox } from "lucide-react";

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
                    <div className="font-medium">{donation.donor_name}</div>
                    <div className="text-sm text-muted-foreground">
                      {formatDate(donation.date)}
                    </div>
                  </div>
                  <div className="font-semibold text-emerald-600">
                    ₱{donation.amount.toLocaleString()}
                  </div>
                </div>
              ))
            ) : (
              <div className="p-6 text-center text-muted-foreground">
                <Inbox className="mx-auto h-8 w-8 mb-2" />
                <p>No recent transactions</p>
              </div>
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