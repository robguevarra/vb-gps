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

interface Donation {
  id: number | string;
  amount: number;
  date: string;
  donor_name: string;
}

interface DonorHistoryModalProps {
  donorName: string;
  missionaryId: string;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export default function DonorHistoryModal({
  donorName,
  missionaryId,
  open,
  onOpenChange,
}: DonorHistoryModalProps) {
  const [donations, setDonations] = useState<Donation[]>([]);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string>("");

  useEffect(() => {
    if (open) {
      setLoading(true);
      const supabase = createClient();

      supabase
        .from("donor_donations")
        .select("id, amount, date, donors(name)")
        .eq("missionary_id", missionaryId)
        .then((res) => {
          if (res.error) throw res.error;
          
          // Filter by donor name and map
          const donorDonations = (res.data || [])
            .filter((record: any) => record.donors?.name === donorName)
            .map((record: any) => ({
              id: record.id,
              amount: record.amount,
              date: record.date,
              donor_name: record.donors?.name,
            }));

          setDonations(donorDonations);
        })
        .catch((err) => setError(err.message))
        .finally(() => setLoading(false));
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
              <p>No donation history found for this donor.</p>
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