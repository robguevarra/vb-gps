import React from "react";
import { Button } from "@/components/ui/button";
import { Profile } from "@/types"; // or your actual path to the Profile interface

interface MissionariesTableProps {
  missionaries: Profile[];
  missionaryFilter: string;
  setMissionaryFilter: (val: string) => void;
  missionaryPage: number;
  setMissionaryPage: (page: number) => void;
  pageSize: number;
  openMissionaryModal: (m: Profile) => void;
  openFullMissionaryReport: (m: Profile) => void;
  getCurrentMonthRatio: (m: Profile) => number;
  formatNumber: (num: number) => string;
}

export function MissionariesTable({
  missionaries,
  missionaryFilter,
  setMissionaryFilter,
  missionaryPage,
  setMissionaryPage,
  pageSize,
  openMissionaryModal,
  openFullMissionaryReport,
  getCurrentMonthRatio,
  formatNumber,
}: MissionariesTableProps) {
  // Filter + paginate
  const filtered = missionaries.filter((m) =>
    m.full_name.toLowerCase().includes(missionaryFilter.toLowerCase())
  );
  const totalPages = Math.ceil(filtered.length / pageSize);
  const startIdx = (missionaryPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const pageData = filtered.slice(startIdx, endIdx);

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold mb-2">All Missionaries</h2>
      <div className="flex items-center gap-2 mb-2">
        <input
          type="text"
          className="border px-2 py-1 text-sm rounded"
          placeholder="Filter by name..."
          value={missionaryFilter}
          onChange={(e) => {
            setMissionaryFilter(e.target.value);
            setMissionaryPage(1);
          }}
        />
      </div>

      <div className="overflow-x-auto border rounded-md">
        <table className="min-w-full text-left text-sm">
          <thead className="bg-gray-50 dark:bg-gray-800">
            <tr>
              <th className="px-4 py-2 border-b">Name</th>
              <th className="px-4 py-2 border-b">Role</th>
              <th className="px-4 py-2 border-b">Monthly Goal</th>
              <th className="px-4 py-2 border-b">Current %</th>
              <th className="px-4 py-2 border-b">Actions</th>
            </tr>
          </thead>
          <tbody>
            {pageData.map((m) => {
              const ratio = getCurrentMonthRatio(m);
              return (
                <tr key={m.id}>
                  <td className="px-4 py-2 border-b">{m.full_name}</td>
                  <td className="px-4 py-2 border-b">{m.role}</td>
                  <td className="px-4 py-2 border-b">₱{formatNumber(m.monthly_goal || 0)}</td>
                  <td className="px-4 py-2 border-b">{formatNumber(ratio)}%</td>
                  <td className="px-4 py-2 border-b">
                    <div className="flex gap-2">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => openMissionaryModal(m)}
                      >
                        Last 6 Months
                      </Button>
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => openFullMissionaryReport(m)}
                      >
                        Full Report
                      </Button>
                    </div>
                  </td>
                </tr>
              );
            })}
            {pageData.length === 0 && (
              <tr>
                <td className="px-4 py-2 border-b" colSpan={5}>
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
          disabled={missionaryPage <= 1}
          onClick={() => setMissionaryPage(missionaryPage - 1)}
        >
          Prev
        </Button>
        <span className="text-sm">
          Page {missionaryPage} of {Math.max(totalPages, 1)}
        </span>
        <Button
          variant="outline"
          size="sm"
          disabled={missionaryPage >= totalPages}
          onClick={() => setMissionaryPage(missionaryPage + 1)}
        >
          Next
        </Button>
      </div>
    </div>
  );
} 