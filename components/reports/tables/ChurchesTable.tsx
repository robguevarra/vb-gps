import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Profile, Church, DonationMap } from "@/types/reports";
import { getDonationForChurch, getChurchMonthlyGoal } from "@/utils/reports";

interface ChurchesTableProps {
  churches: Church[];
  missionaries: Profile[];
  churchFilter: string;
  setChurchFilter: (value: string) => void;
  churchPage: number;
  setChurchPage: (page: number) => void;
  pageSize: number;
  openChurchModal: (church: Church) => void;
  donationMap: DonationMap;
  formatNumber: (num: number, fractionDigits?: number) => string;
}

export function ChurchesTable({
  churches,
  missionaries,
  churchFilter,
  setChurchFilter,
  churchPage,
  setChurchPage,
  pageSize,
  openChurchModal,
  donationMap,
  formatNumber,
}: ChurchesTableProps) {
  // Filter churches based on search
  const filteredChurches = churches.filter((ch) =>
    ch.name.toLowerCase().includes(churchFilter.toLowerCase())
  );

  // Pagination
  const totalChurches = filteredChurches.length;
  const totalPages = Math.ceil(totalChurches / pageSize);
  const startIdx = (churchPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const pagedChurches = filteredChurches.slice(startIdx, endIdx);

  // Get current month and year
  const now = new Date();
  const currentYear = now.getFullYear();
  const currentMonth = now.getMonth();

  return (
    <div className="space-y-4">
      {/* Search input */}
      <div className="flex items-center gap-2">
        <Input
          type="text"
          placeholder="Search churches..."
          value={churchFilter}
          onChange={(e) => setChurchFilter(e.target.value)}
          className="max-w-sm"
        />
      </div>

      {/* Churches table */}
      <div className="border rounded-md">
        <table className="min-w-full text-sm">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-2 text-left">Church Name</th>
              <th className="px-4 py-2 text-left">Monthly Goal</th>
              <th className="px-4 py-2 text-left">Current Month %</th>
              <th className="px-4 py-2 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            {pagedChurches.map((ch) => {
              const monthlyGoal = getChurchMonthlyGoal(ch.id, missionaries);
              const currentMonthDonations = getDonationForChurch(
                ch.id,
                missionaries,
                donationMap,
                currentYear,
                currentMonth
              );
              const currentRatio =
                monthlyGoal > 0 ? (currentMonthDonations / monthlyGoal) * 100 : 0;
              const below80 = currentRatio < 80;

              return (
                <tr key={ch.id} className="border-t">
                  <td className="px-4 py-2">{ch.name}</td>
                  <td className="px-4 py-2">₱{formatNumber(monthlyGoal)}</td>
                  <td
                    className={`px-4 py-2 ${
                      below80 ? "text-red-600 font-semibold" : ""
                    }`}
                  >
                    {formatNumber(currentRatio)}%
                  </td>
                  <td className="px-4 py-2">
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => openChurchModal(ch)}
                    >
                      View Details
                    </Button>
                  </td>
                </tr>
              );
            })}

            {pagedChurches.length === 0 && (
              <tr>
                <td colSpan={4} className="px-4 py-2 text-center text-gray-500">
                  No churches found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination controls */}
      {totalChurches > pageSize && (
        <div className="flex items-center gap-2 justify-end">
          <Button
            variant="outline"
            size="sm"
            disabled={churchPage <= 1}
            onClick={() => setChurchPage(churchPage - 1)}
          >
            Previous
          </Button>
          <span className="text-sm">
            Page {churchPage} of {totalPages}
          </span>
          <Button
            variant="outline"
            size="sm"
            disabled={churchPage >= totalPages}
            onClick={() => setChurchPage(churchPage + 1)}
          >
            Next
          </Button>
        </div>
      )}
    </div>
  );
} 