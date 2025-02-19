import React from "react";
import { Button } from "@/components/ui/button";
import { Profile, Church } from "@/types";

interface ChurchesTableProps {
  churches: Church[];
  missionaries: Profile[];
  churchFilter: string;
  setChurchFilter: (val: string) => void;
  churchPage: number;
  setChurchPage: (page: number) => void;
  pageSize: number;
  openChurchModal: (ch: Church) => void;
  getDonationForChurch: (chId: number, year: number, month: number) => number;
  getChurchMonthlyGoal: (chId: number) => number;
  formatNumber: (num: number) => string;
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
  getDonationForChurch,
  getChurchMonthlyGoal,
  formatNumber,
}: ChurchesTableProps) {
  const filtered = churches.filter((ch) =>
    ch.name.toLowerCase().includes(churchFilter.toLowerCase())
  );
  const totalPages = Math.ceil(filtered.length / pageSize);
  const startIdx = (churchPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const pageData = filtered.slice(startIdx, endIdx);

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold mb-2">All Churches</h2>
      <div className="flex items-center gap-2 mb-2">
        <input
          type="text"
          className="border px-2 py-1 text-sm rounded"
          placeholder="Filter by church name..."
          value={churchFilter}
          onChange={(e) => {
            setChurchFilter(e.target.value);
            setChurchPage(1);
          }}
        />
      </div>

      <div className="overflow-x-auto border rounded-md">
        <table className="min-w-full text-left text-sm">
          <thead className="bg-gray-50 dark:bg-gray-800">
            <tr>
              <th className="px-4 py-2 border-b">Church</th>
              <th className="px-4 py-2 border-b">Monthly Goal (Sum)</th>
              <th className="px-4 py-2 border-b">Current %</th>
              <th className="px-4 py-2 border-b">Actions</th>
            </tr>
          </thead>
          <tbody>
            {pageData.map((ch) => {
              const now = new Date();
              const y = now.getFullYear();
              const mo = now.getMonth();
              const donation = getDonationForChurch(ch.id, y, mo);
              const goal = getChurchMonthlyGoal(ch.id);
              const ratio = goal > 0 ? (donation / goal) * 100 : 0;
              return (
                <tr key={ch.id}>
                  <td className="px-4 py-2 border-b">{ch.name}</td>
                  <td className="px-4 py-2 border-b">₱{formatNumber(goal)}</td>
                  <td className="px-4 py-2 border-b">{formatNumber(ratio)}%</td>
                  <td className="px-4 py-2 border-b">
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
            {pageData.length === 0 && (
              <tr>
                <td className="px-4 py-2 border-b" colSpan={4}>
                  No results found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      <div className="mt-2 flex items-center gap-2">
        <Button
          variant="outline"
          size="sm"
          disabled={churchPage <= 1}
          onClick={() => setChurchPage(churchPage - 1)}
        >
          Prev
        </Button>
        <span className="text-sm">
          Page {churchPage} of {Math.max(totalPages, 1)}
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
    </div>
  );
} 