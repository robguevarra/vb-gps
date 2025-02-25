import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Profile, DonorDonation, DonationMap } from "@/types/reports";
import { formatNumber } from "@/utils/reports";

interface FullMissionaryReportModalProps {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  donations: DonorDonation[];
  donationMap: DonationMap;
  thirteenMonthKeys: string[];
  partnerPage: number;
  setPartnerPage: (page: number) => void;
}

export function FullMissionaryReportModal({
  isOpen,
  onClose,
  missionary,
  donations,
  donationMap,
  thirteenMonthKeys,
  partnerPage,
  setPartnerPage,
}: FullMissionaryReportModalProps) {
  if (!missionary) return null;

  // Filter all donations for this missionary
  const missionaryDonations = donations.filter(
    (d) => d.missionary_id === missionary.id
  );

  // Build partnerMap => donor_id => { 'YYYY-MM' => sum }
  const partnerMap: Record<number, Record<string, number>> = {};
  const donorInfoMap: Record<number, DonorDonation["donors"]> = {};

  missionaryDonations.forEach((don) => {
    if (don.donor_id) {
      if (!partnerMap[don.donor_id]) {
        partnerMap[don.donor_id] = {};
      }
      if (don.donors) {
        donorInfoMap[don.donor_id] = don.donors;
      }
      const dateObj = new Date(don.date);
      const yy = dateObj.getFullYear();
      const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
      const key = `${yy}-${mm}`;
      partnerMap[don.donor_id][key] =
        (partnerMap[don.donor_id][key] || 0) + don.amount;
    }
  });

  // Convert partnerMap into an array of partner rows
  type PartnerRow = {
    donorId: number;
    donorName: string;
    email: string;
    phone: string;
    monthlySums: Record<string, number>;
  };

  const partnerRows: PartnerRow[] = Object.keys(partnerMap).map((idStr) => {
    const donorId = Number(idStr);
    const sums = partnerMap[donorId];
    const donor = donorInfoMap[donorId];
    return {
      donorId,
      donorName: donor?.name || "Unknown",
      email: donor?.email || "",
      phone: donor?.phone || "",
      monthlySums: sums,
    };
  });

  // Pagination for partner rows
  const pPageSize = 10;
  const totalPartners = partnerRows.length;
  const totalPartnerPages = Math.ceil(totalPartners / pPageSize);
  const startIdx = (partnerPage - 1) * pPageSize;
  const endIdx = startIdx + pPageSize;
  const pagedPartners = partnerRows.slice(startIdx, endIdx);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-[95vw] w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>Full Report - {missionary.full_name}</DialogTitle>
        </DialogHeader>

        <div className="mt-4 space-y-4">
          <p className="text-sm">
            Below is a table of donor partners (rows) vs. the last 13 months (columns).
          </p>

          <div className="overflow-x-auto border rounded-md">
            <table className="min-w-full text-left text-sm">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 border-b">Partner Name</th>
                  <th className="px-4 py-2 border-b">Email</th>
                  <th className="px-4 py-2 border-b">Phone</th>
                  {thirteenMonthKeys.map((key) => (
                    <th key={key} className="px-4 py-2 border-b">{key}</th>
                  ))}
                  <th className="px-4 py-2 border-b">Total</th>
                </tr>
              </thead>
              <tbody>
                {pagedPartners.map((p) => {
                  let rowTotal = 0;
                  return (
                    <tr key={p.donorId}>
                      <td className="px-4 py-2 border-b">{p.donorName}</td>
                      <td className="px-4 py-2 border-b">{p.email}</td>
                      <td className="px-4 py-2 border-b">{p.phone}</td>
                      {thirteenMonthKeys.map((monthKey) => {
                        const val = p.monthlySums[monthKey] || 0;
                        rowTotal += val;
                        return (
                          <td key={monthKey} className="px-4 py-2 border-b">
                            ₱{formatNumber(val)}
                          </td>
                        );
                      })}
                      <td className="px-4 py-2 border-b font-semibold">
                        ₱{formatNumber(rowTotal)}
                      </td>
                    </tr>
                  );
                })}

                {pagedPartners.length === 0 && (
                  <tr>
                    <td
                      className="px-4 py-2 border-b"
                      colSpan={thirteenMonthKeys.length + 4}
                    >
                      No partners found.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

          {/* Pagination controls for partners (only if needed) */}
          {partnerRows.length > pPageSize && (
            <div className="mt-2 flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                disabled={partnerPage <= 1}
                onClick={() => setPartnerPage(partnerPage - 1)}
              >
                Prev
              </Button>
              <span className="text-sm">
                Page {partnerPage} of {Math.max(totalPartnerPages, 1)}
              </span>
              <Button
                variant="outline"
                size="sm"
                disabled={partnerPage >= totalPartnerPages}
                onClick={() => setPartnerPage(partnerPage + 1)}
              >
                Next
              </Button>
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
} 