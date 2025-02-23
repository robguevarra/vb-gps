import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Profile } from "@/types";
import { PartnersTable } from "@/components/reports/PartnersTable";

export function MissionaryLast6Modal({
  isOpen,
  onClose,
  missionary,
  getLastXMonthsRatios,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  getLastXMonthsRatios: (m: Profile, x: number) => Array<{ label: string; ratio: number }>;
  formatNumber: (num: number) => string;
}) {
  if (!missionary) return null;
  const data = getLastXMonthsRatios(missionary, 6);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl">
        <DialogHeader>
          <DialogTitle className="text-lg">Last 6 Months: {missionary.full_name}</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <div className="overflow-x-auto border rounded-md">
            <table className="min-w-full text-sm">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 border-b">Month</th>
                  <th className="px-4 py-2 border-b">% of Goal</th>
                  <th className="px-4 py-2 border-b">Progress</th>
                </tr>
              </thead>
              <tbody>
                {data.map((r) => (
                  <tr key={r.label}>
                    <td className="px-4 py-2 border-b">{r.label}</td>
                    <td className="px-4 py-2 border-b">{formatNumber(r.ratio)}%</td>
                    <td className="px-4 py-2 border-b">
                      <div className="w-32 h-2 bg-gray-200 rounded-full overflow-hidden">
                        <div 
                          className="h-full bg-primary" 
                          style={{ width: `${Math.min(r.ratio, 100)}%` }}
                        />
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}

export function FullMissionaryReportModal({
  isOpen,
  onClose,
  missionary,
  donations,
  thirteenMonthKeys,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  donations: any[];
  thirteenMonthKeys: string[];
  formatNumber: (num: number) => string;
}) {
  if (!missionary) return null;

  // Build partner data structure matching GlobalReportsTab's implementation
  const partnerMap: Record<number, { 
    donorId: number;
    donorName: string;
    email: string;
    phone: string;
    monthlySums: Record<string, number>;
  }> = {};

  donations
    .filter(d => d.missionary_id === missionary.id)
    .forEach(dd => {
      if (dd.donor_id && dd.donors) {
        const donorId = dd.donor_id;
        if (!partnerMap[donorId]) {
          partnerMap[donorId] = {
            donorId,
            donorName: dd.donors.name || "Unknown",
            email: dd.donors.email || "",
            phone: dd.donors.phone || "",
            monthlySums: {},
          };
        }
        const date = new Date(dd.date);
        const monthKey = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}`;
        partnerMap[donorId].monthlySums[monthKey] = 
          (partnerMap[donorId].monthlySums[monthKey] || 0) + (dd.amount || 0);
      }
    });

  const partnerRows = Object.values(partnerMap);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-[95vw] w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>Full Report - {missionary.full_name}</DialogTitle>
        </DialogHeader>

        <div className="mt-4 space-y-4">
          <p className="text-sm">
            Partner donations across last 13 months
          </p>

          <div className="overflow-x-auto border rounded-md">
            <table className="min-w-full text-left text-sm">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 border-b">Partner</th>
                  <th className="px-4 py-2 border-b">Email</th>
                  <th className="px-4 py-2 border-b">Phone</th>
                  {thirteenMonthKeys.map((key) => (
                    <th key={key} className="px-4 py-2 border-b">{key}</th>
                  ))}
                  <th className="px-4 py-2 border-b">Total</th>
                </tr>
              </thead>
              <tbody>
                {partnerRows.map((p) => {
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

                {partnerRows.length === 0 && (
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
        </div>
      </DialogContent>
    </Dialog>
  );
} 