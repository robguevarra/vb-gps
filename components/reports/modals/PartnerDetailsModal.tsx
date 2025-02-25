import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { PartnerRow, DonorDonation } from "@/types/reports";
import { formatNumber } from "@/utils/reports";

interface PartnerDetailsModalProps {
  isOpen: boolean;
  onClose: () => void;
  partner: PartnerRow | null;
  donations: DonorDonation[];
  missionaryNameMap: Record<string, string>;
}

export function PartnerDetailsModal({
  isOpen,
  onClose,
  partner,
  donations,
  missionaryNameMap,
}: PartnerDetailsModalProps) {
  if (!partner) return null;

  // Filter all donation entries for this partner
  const partnerDonations = donations
    .filter((d) => d.donor_id === partner.id)
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-3xl w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>Partner History: {partner.name}</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <table className="min-w-full text-left text-sm border">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-2 border-b">Date</th>
                <th className="px-4 py-2 border-b">Missionary</th>
                <th className="px-4 py-2 border-b">Amount (₱)</th>
                <th className="px-4 py-2 border-b">Source</th>
                <th className="px-4 py-2 border-b">Status</th>
                <th className="px-4 py-2 border-b">Notes</th>
              </tr>
            </thead>
            <tbody>
              {partnerDonations.map((don) => {
                const missionaryName =
                  missionaryNameMap[don.missionary_id] || "Unknown";
                return (
                  <tr key={don.id}>
                    <td className="px-4 py-2 border-b">
                      {new Date(don.date).toLocaleDateString()}
                    </td>
                    <td className="px-4 py-2 border-b">{missionaryName}</td>
                    <td className="px-4 py-2 border-b">
                      ₱{formatNumber(don.amount)}
                    </td>
                    <td className="px-4 py-2 border-b">{don.source}</td>
                    <td className="px-4 py-2 border-b">{don.status}</td>
                    <td className="px-4 py-2 border-b">{don.notes || ""}</td>
                  </tr>
                );
              })}
              {partnerDonations.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={6}>
                    No donations found for this partner.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </DialogContent>
    </Dialog>
  );
} 