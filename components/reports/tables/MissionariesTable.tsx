import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Profile, DonationMap } from "@/types/reports";
import { getCurrentMonthRatio } from "@/utils/reports";

interface MissionariesTableProps {
  missionaries: Profile[];
  missionaryFilter: string;
  setMissionaryFilter: (value: string) => void;
  missionaryPage: number;
  setMissionaryPage: (page: number) => void;
  pageSize: number;
  openMissionaryModal: (missionary: Profile) => void;
  openFullMissionaryReport: (missionary: Profile) => void;
  donationMap: DonationMap;
  formatNumber: (num: number, fractionDigits?: number) => string;
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
  donationMap,
  formatNumber,
}: MissionariesTableProps) {
  // Filter missionaries based on search
  const filteredMissionaries = missionaries.filter((m) =>
    m.full_name.toLowerCase().includes(missionaryFilter.toLowerCase())
  );

  // Pagination
  const totalMissionaries = filteredMissionaries.length;
  const totalPages = Math.ceil(totalMissionaries / pageSize);
  const startIdx = (missionaryPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const pagedMissionaries = filteredMissionaries.slice(startIdx, endIdx);

  return (
    <div className="space-y-4">
      {/* Search input */}
      <div className="flex items-center gap-2">
        <Input
          type="text"
          placeholder="Search missionaries..."
          value={missionaryFilter}
          onChange={(e) => setMissionaryFilter(e.target.value)}
          className="max-w-sm"
        />
      </div>

      {/* Missionaries table for desktop */}
      <div className="border rounded-md hidden md:block">
        <table className="min-w-full text-sm">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-2 text-left">Name</th>
              <th className="px-4 py-2 text-left">Monthly Goal</th>
              <th className="px-4 py-2 text-left">Current Month %</th>
              <th className="px-4 py-2 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            {pagedMissionaries.map((m) => {
              const currentRatio = getCurrentMonthRatio(m, donationMap);
              const below80 = currentRatio < 80;
              const progressWidth = Math.min(100, currentRatio);
              const progressColor = below80 ? "bg-red-200" : "bg-green-200";
              const textColor = below80 ? "text-red-600" : "text-green-700";

              return (
                <tr key={m.id} className="border-t">
                  <td className="px-4 py-2">{m.full_name}</td>
                  <td className="px-4 py-2">₱{formatNumber(m.monthly_goal)}</td>
                  <td className="px-4 py-2">
                    <div className="flex items-center gap-2">
                      <div className="flex-1 h-2 bg-gray-100 rounded-full overflow-hidden">
                        <div 
                          className={`h-full ${progressColor} transition-all duration-500`}
                          style={{ width: `${progressWidth}%` }}
                        />
                      </div>
                      <span className={`font-semibold ${textColor} w-16 text-right`}>
                        {formatNumber(currentRatio)}%
                      </span>
                    </div>
                  </td>
                  <td className="px-4 py-2">
                    <div className="flex items-center gap-2">
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

            {pagedMissionaries.length === 0 && (
              <tr>
                <td colSpan={4} className="px-4 py-2 text-center text-gray-500">
                  No missionaries found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
      
      {/* Missionaries cards for mobile */}
      <div className="space-y-4 md:hidden">
        {pagedMissionaries.map((m) => {
          const currentRatio = getCurrentMonthRatio(m, donationMap);
          const below80 = currentRatio < 80;
          const progressWidth = Math.min(100, currentRatio);
          const progressColor = below80 ? "bg-red-200" : "bg-green-200";
          const textColor = below80 ? "text-red-600" : "text-green-700";
          
          return (
            <div key={m.id} className="border rounded-lg p-4 space-y-3">
              <div className="font-medium text-base">{m.full_name}</div>
              
              <div className="grid grid-cols-2 gap-2">
                <div>
                  <div className="text-xs text-gray-500">Monthly Goal</div>
                  <div>₱{formatNumber(m.monthly_goal)}</div>
                </div>
                
                <div>
                  <div className="text-xs text-gray-500">Current Month</div>
                  <div className={`font-semibold ${textColor}`}>
                    {formatNumber(currentRatio)}%
                  </div>
                </div>
              </div>
              
              <div className="h-2 bg-gray-100 rounded-full overflow-hidden w-full">
                <div 
                  className={`h-full ${progressColor} transition-all duration-500`}
                  style={{ width: `${progressWidth}%` }}
                />
              </div>
              
              <div className="flex justify-between gap-2 pt-2">
                <Button
                  variant="outline"
                  size="sm"
                  className="flex-1 h-10" // Increased touch target
                  onClick={() => openMissionaryModal(m)}
                >
                  Last 6 Months
                </Button>
                <Button
                  variant="outline"
                  size="sm"
                  className="flex-1 h-10" // Increased touch target
                  onClick={() => openFullMissionaryReport(m)}
                >
                  Full Report
                </Button>
              </div>
            </div>
          );
        })}
        
        {pagedMissionaries.length === 0 && (
          <div className="text-center py-4 text-gray-500">
            No missionaries found.
          </div>
        )}
      </div>

      {/* Pagination controls */}
      {totalMissionaries > pageSize && (
        <div className="flex flex-wrap items-center gap-2 justify-center md:justify-end">
          <Button
            variant="outline"
            size="sm"
            className="h-10 px-4" // Increased touch target
            disabled={missionaryPage <= 1}
            onClick={() => setMissionaryPage(missionaryPage - 1)}
          >
            Previous
          </Button>
          <span className="text-sm px-2">
            Page {missionaryPage} of {totalPages}
          </span>
          <Button
            variant="outline"
            size="sm"
            className="h-10 px-4" // Increased touch target
            disabled={missionaryPage >= totalPages}
            onClick={() => setMissionaryPage(missionaryPage + 1)}
          >
            Next
          </Button>
        </div>
      )}
    </div>
  );
} 