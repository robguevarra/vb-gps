import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Profile, DonationMap } from "@/types/reports";
import { getLastXMonthsRatios, formatNumber } from "@/utils/reports";

interface MissionaryLast6ModalProps {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  donationMap: DonationMap;
}

export function MissionaryLast6Modal({
  isOpen,
  onClose,
  missionary,
  donationMap,
}: MissionaryLast6ModalProps) {
  if (!missionary) return null;
  const data = getLastXMonthsRatios(missionary, donationMap, 6);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>Last 6 Months: {missionary.full_name}</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <table className="min-w-full text-left text-sm border">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-2 border-b">Month</th>
                <th className="px-4 py-2 border-b">% of Goal</th>
              </tr>
            </thead>
            <tbody>
              {data.map((r) => (
                <tr key={r.label}>
                  <td className="px-4 py-2 border-b">{r.label}</td>
                  <td className="px-4 py-2 border-b">{formatNumber(r.ratio)}%</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </DialogContent>
    </Dialog>
  );
} 