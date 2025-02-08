import React, { useEffect, useState } from "react";
import { createClient } from "../lib/supabase";

interface Donation {
  id: string;
  amount: number;
  date: string;
  donor_name: string;
}

interface DonorHistoryModalProps {
  open: boolean;
  donorName: string;
  missionaryId: string;
  onClose: () => void;
}

const DonorHistoryModal: React.FC<DonorHistoryModalProps> = ({ open, donorName, missionaryId, onClose }) => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [donations, setDonations] = useState<Donation[]>([]);

  useEffect(() => {
    if (open) {
      setLoading(true);
      const supabase = createClient();

      supabase
        .from("donor_donations")
        .select("id, amount, date, donors(name)")
        .eq("missionary_id", missionaryId)
        .then((donorDonationRes) => {
          if (donorDonationRes.error) throw donorDonationRes.error;

          // Filter to records where the joined donor's name matches the selected donor
          const donorDonations: Donation[] = (donorDonationRes.data || [])
            .filter((record: any) => record.donors?.name === donorName)
            .map((record: any) => ({
              id: record.id,
              amount: record.amount,
              date: record.date,
              donor_name: record.donors?.name,
            }));

          setDonations(donorDonations);
        })
        .catch((err: any) => {
          setError(err.message || "Error fetching donation history");
        })
        .finally(() => setLoading(false));
    }
  }, [open, donorName, missionaryId]);

  return (
    <div>
      {/* Render your component content here */}
    </div>
  );
};

export default DonorHistoryModal; 