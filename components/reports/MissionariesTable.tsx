import React from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Profile } from "@/types"; // or your actual path to the Profile interface
import { Search, ChevronLeft, ChevronRight, BarChart2, FileText } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";

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

  // Helper function to determine status color based on ratio
  const getStatusColor = (ratio: number) => {
    if (ratio >= 100) return "bg-green-500";
    if (ratio >= 80) return "bg-green-400";
    if (ratio >= 60) return "bg-yellow-400";
    if (ratio >= 40) return "bg-orange-400";
    return "bg-red-500";
  };

  // Helper function to get text color based on ratio
  const getTextColor = (ratio: number) => {
    if (ratio >= 80) return "text-green-700";
    if (ratio >= 60) return "text-yellow-700";
    if (ratio >= 40) return "text-orange-700";
    return "text-red-700";
  };

  // Helper function to get badge variant based on ratio
  const getBadgeVariant = (ratio: number) => {
    if (ratio >= 100) return "default";
    if (ratio >= 80) return "secondary";
    if (ratio >= 60) return "outline";
    if (ratio >= 40) return "destructive";
    return "destructive";
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row justify-between gap-4">
        <h2 className="text-xl font-semibold">Missionary Performance</h2>
        <div className="relative max-w-xs w-full">
          <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
          <Input
            type="text"
            className="pl-8 h-9"
            placeholder="Search missionaries..."
            value={missionaryFilter}
            onChange={(e) => {
              setMissionaryFilter(e.target.value);
              setMissionaryPage(1);
            }}
          />
        </div>
      </div>

      <Card className="overflow-hidden border shadow-sm">
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b bg-muted/50">
                <th className="px-4 py-3 text-left font-medium text-muted-foreground">Name</th>
                <th className="px-4 py-3 text-left font-medium text-muted-foreground">Role</th>
                <th className="px-4 py-3 text-left font-medium text-muted-foreground">Monthly Goal</th>
                <th className="px-4 py-3 text-left font-medium text-muted-foreground">Current Month</th>
                <th className="px-4 py-3 text-left font-medium text-muted-foreground">Actions</th>
              </tr>
            </thead>
            <tbody>
              {pageData.map((m) => {
                const ratio = getCurrentMonthRatio(m);
                const statusColor = getStatusColor(ratio);
                const textColor = getTextColor(ratio);
                const badgeVariant = getBadgeVariant(ratio);
                
                return (
                  <tr key={m.id} className="border-b hover:bg-muted/30 transition-colors">
                    <td className="px-4 py-3 font-medium">{m.full_name}</td>
                    <td className="px-4 py-3 capitalize">
                      <Badge variant="outline" className="capitalize">
                        {m.role?.replace('_', ' ')}
                      </Badge>
                    </td>
                    <td className="px-4 py-3">₱{formatNumber(m.monthly_goal || 0)}</td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-3">
                        <div className="w-full max-w-[120px] h-2 bg-muted rounded-full overflow-hidden">
                          <div 
                            className={`h-full ${statusColor} transition-all duration-500`} 
                            style={{ width: `${Math.min(ratio, 100)}%` }}
                          />
                        </div>
                        <Badge variant={badgeVariant} className={`${textColor} font-medium`}>
                          {formatNumber(ratio)}%
                        </Badge>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex gap-2">
                        <Tooltip>
                          <TooltipTrigger asChild>
                            <Button
                              variant="outline"
                              size="sm"
                              className="h-8 px-2 gap-1"
                              onClick={() => openMissionaryModal(m)}
                            >
                              <BarChart2 className="h-3.5 w-3.5" />
                              <span>6 Months</span>
                            </Button>
                          </TooltipTrigger>
                          <TooltipContent>
                            <p>View last 6 months performance</p>
                          </TooltipContent>
                        </Tooltip>
                        
                        <Tooltip>
                          <TooltipTrigger asChild>
                            <Button
                              variant="outline"
                              size="sm"
                              className="h-8 px-2 gap-1"
                              onClick={() => openFullMissionaryReport(m)}
                            >
                              <FileText className="h-3.5 w-3.5" />
                              <span>Full Report</span>
                            </Button>
                          </TooltipTrigger>
                          <TooltipContent>
                            <p>View complete 13-month report</p>
                          </TooltipContent>
                        </Tooltip>
                      </div>
                    </td>
                  </tr>
                );
              })}
              {pageData.length === 0 && (
                <tr>
                  <td className="px-4 py-8 text-center text-muted-foreground" colSpan={5}>
                    {missionaryFilter ? (
                      <>No missionaries matching "<strong>{missionaryFilter}</strong>"</>
                    ) : (
                      "No missionaries found"
                    )}
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </Card>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <p className="text-sm text-muted-foreground">
            Showing <span className="font-medium">{startIdx + 1}</span> to{" "}
            <span className="font-medium">{Math.min(endIdx, filtered.length)}</span> of{" "}
            <span className="font-medium">{filtered.length}</span> missionaries
          </p>
          
          <div className="flex items-center gap-1">
            <Button
              variant="outline"
              size="sm"
              className="h-8 w-8 p-0"
              disabled={missionaryPage <= 1}
              onClick={() => setMissionaryPage(missionaryPage - 1)}
            >
              <ChevronLeft className="h-4 w-4" />
            </Button>
            <div className="flex items-center gap-1.5 px-2">
              {Array.from({ length: Math.min(totalPages, 5) }, (_, i) => {
                // Logic to show pages around current page
                let pageNum = i + 1;
                if (totalPages > 5) {
                  if (missionaryPage > 3) {
                    pageNum = missionaryPage - 3 + i;
                  }
                  if (missionaryPage > totalPages - 2) {
                    pageNum = totalPages - 4 + i;
                  }
                }
                
                if (pageNum <= totalPages) {
                  return (
                    <Button
                      key={pageNum}
                      variant={missionaryPage === pageNum ? "default" : "outline"}
                      size="sm"
                      className="h-8 w-8 p-0"
                      onClick={() => setMissionaryPage(pageNum)}
                    >
                      {pageNum}
                    </Button>
                  );
                }
                return null;
              })}
            </div>
            <Button
              variant="outline"
              size="sm"
              className="h-8 w-8 p-0"
              disabled={missionaryPage >= totalPages}
              onClick={() => setMissionaryPage(missionaryPage + 1)}
            >
              <ChevronRight className="h-4 w-4" />
            </Button>
          </div>
        </div>
      )}
    </div>
  );
} 