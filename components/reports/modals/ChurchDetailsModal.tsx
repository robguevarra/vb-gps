import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Profile, Church, DonationMap } from "@/types/reports";
import { getDonationForMissionary, formatNumber } from "@/utils/reports";

interface ChurchDetailsModalProps {
  isOpen: boolean;
  onClose: () => void;
  selectedChurch: Church | null;
  missionaries: Profile[];
  donationMap: DonationMap;
}

export function ChurchDetailsModal({
  isOpen,
  onClose,
  selectedChurch,
  missionaries,
  donationMap,
}: ChurchDetailsModalProps) {
  if (!selectedChurch) return null;

  // We'll show last 3 months + current => 4 columns
  const now = new Date();
  const columns: { label: string; year: number; month: number }[] = [];
  for (let i = 0; i < 4; i++) {
    const dt = new Date(now.getFullYear(), now.getMonth() - i, 1);
    columns.unshift({
      label: `${dt.getFullYear()}-${String(dt.getMonth() + 1).padStart(2, "0")}`,
      year: dt.getFullYear(),
      month: dt.getMonth(),
    });
  }

  const relevantMissionaries = missionaries.filter(
    (m) => m.local_church_id === selectedChurch.id
  );

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-4xl w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>
            {selectedChurch.name} - Last 3 Months + Current
          </DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <table className="min-w-full text-left text-sm border">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-2 border-b">Missionary</th>
                {columns.map((c) => (
                  <th className="px-4 py-2 border-b" key={c.label}>
                    {c.label}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {relevantMissionaries.map((m) => (
                <tr key={m.id}>
                  <td className="px-4 py-2 border-b">{m.full_name}</td>
                  {columns.map((c) => {
                    const donated = getDonationForMissionary(
                      m.id,
                      donationMap,
                      c.year,
                      c.month
                    );
                    const mg = m.monthly_goal || 0;
                    const ratio = mg > 0 ? (donated / mg) * 100 : 0;
                    const below80 = ratio < 80;
                    return (
                      <td
                        key={c.label}
                        className={`px-4 py-2 border-b ${
                          below80 ? "text-red-600 font-semibold" : ""
                        }`}
                      >
                        {formatNumber(ratio)}%
                      </td>
                    );
                  })}
                </tr>
              ))}
              {relevantMissionaries.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={columns.length + 1}>
                    No missionaries found for this church.
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