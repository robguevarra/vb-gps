import React from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Profile } from "@/types"; // or your actual path to the Profile interface
import { Search, ChevronLeft, ChevronRight, BarChart2, FileText, User, Target, TrendingUp } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
import { motion } from "framer-motion";

// Animation variants
const fadeIn = {
  hidden: { opacity: 0 },
  visible: { opacity: 1, transition: { duration: 0.3 } }
};

const slideUp = {
  hidden: { opacity: 0, y: 20 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.4 } }
};

const staggerContainer = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.05
    }
  }
};

// New animation variants
const pulse = {
  initial: { scale: 1 },
  hover: { scale: 1.02, transition: { duration: 0.2, ease: "easeInOut" } }
};

const shimmer = {
  hidden: { backgroundPosition: "200% 0" },
  visible: { 
    backgroundPosition: "0% 0", 
    transition: { 
      repeat: Infinity, 
      repeatType: "mirror" as const, 
      duration: 2.5, 
      ease: "linear" 
    } 
  }
};

const progressAnimation = {
  hidden: { width: 0, opacity: 0 },
  visible: (width: string) => ({ 
    width, 
    opacity: 1, 
    transition: { 
      duration: 0.8, 
      ease: [0.34, 1.56, 0.64, 1] // Custom spring-like easing
    } 
  })
};

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
    if (ratio >= 100) return "bg-[#00458d]";
    if (ratio >= 80) return "bg-[#0056b3]";
    if (ratio >= 60) return "bg-[#3378be]";
    if (ratio >= 40) return "bg-[#6699cc]";
    return "bg-gray-400";
  };

  // Helper function to get text color based on ratio
  const getTextColor = (ratio: number) => {
    if (ratio >= 80) return "text-[#00458d]";
    if (ratio >= 60) return "text-[#0056b3]";
    if (ratio >= 40) return "text-[#3378be]";
    return "text-gray-600";
  };

  // Helper function to get badge variant based on ratio
  const getBadgeVariant = (ratio: number) => {
    if (ratio >= 100) return "default";
    if (ratio >= 80) return "secondary";
    if (ratio >= 60) return "outline";
    if (ratio >= 40) return "outline";
    return "outline";
  };

  return (
    <div className="space-y-6">
      <motion.div 
        className="flex flex-col sm:flex-row justify-between gap-4"
        initial={{ opacity: 0, y: -10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3 }}
      >
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
      </motion.div>

      {/* Mobile Card View (visible on small screens) */}
      <motion.div 
        className="md:hidden space-y-5"
        variants={staggerContainer}
        initial="hidden"
        animate="visible"
      >
        {pageData.map((m, index) => {
          const ratio = getCurrentMonthRatio(m);
          const statusColor = getStatusColor(ratio);
          const textColor = getTextColor(ratio);
          const badgeVariant = getBadgeVariant(ratio);
          
          // Determine status text based on ratio
          const statusText = ratio >= 100 ? "Excellent" : 
                            ratio >= 80 ? "Good" : 
                            ratio >= 60 ? "Average" : 
                            ratio >= 40 ? "Below Target" : "Critical";
          
          // Determine background gradient based on performance
          const cardGradient = ratio >= 80 
            ? "bg-gradient-to-br from-[#f0f4f9] to-white dark:from-[#00458d]/10 dark:to-background" 
            : ratio >= 60 
              ? "bg-gradient-to-br from-[#f5f8fc] to-white dark:from-[#00458d]/5 dark:to-background" 
              : "bg-gradient-to-br from-[#f8fafd] to-white dark:from-gray-900/10 dark:to-background";
          
          // Determine shimmer effect color based on performance
          const shimmerColor = ratio >= 80 
            ? "before:from-[#f0f4f9]/0 before:via-[#f0f4f9]/30 before:to-[#f0f4f9]/0 dark:before:from-[#00458d]/0 dark:before:via-[#00458d]/10 dark:before:to-[#00458d]/0" 
            : ratio >= 60 
              ? "before:from-[#f5f8fc]/0 before:via-[#f5f8fc]/30 before:to-[#f5f8fc]/0 dark:before:from-[#00458d]/0 dark:before:via-[#00458d]/5 dark:before:to-[#00458d]/0" 
              : "before:from-gray-100/0 before:via-gray-100/20 before:to-gray-100/0 dark:before:from-gray-900/0 dark:before:via-gray-900/5 dark:before:to-gray-900/0";
          
          return (
            <motion.div 
              key={m.id}
              variants={slideUp}
              custom={index}
              transition={{ delay: index * 0.05 }}
              whileHover="hover"
              initial="initial"
            >
              <motion.div
                variants={pulse}
                className={`relative overflow-hidden rounded-xl border ${cardGradient} shadow-sm hover:shadow-md transition-all duration-300 before:absolute before:inset-0 before:bg-gradient-to-r ${shimmerColor} before:bg-[length:200%_100%] before:z-0 before:pointer-events-none`}
                animate="visible"
                initial="hidden"
              >
                <motion.div
                  variants={shimmer}
                  className="absolute inset-0 z-0 pointer-events-none"
                  animate="visible"
                  initial="hidden"
                />
                <Card className="bg-transparent border-0 overflow-hidden z-10 relative">
                  <CardContent className="p-0">
                    {/* Card Header with Name and Performance */}
                    <div className="p-4 border-b border-muted/40 flex justify-between items-start backdrop-blur-[2px]">
                      <div>
                        <h3 className="font-semibold text-base">{m.full_name}</h3>
                        <Badge variant="outline" className="mt-1.5 capitalize text-xs">
                          {m.role?.replace('_', ' ')}
                        </Badge>
                      </div>
                      <div className="flex flex-col items-end">
                        <motion.div
                          initial={{ scale: 0.9, opacity: 0 }}
                          animate={{ scale: 1, opacity: 1 }}
                          transition={{ 
                            type: "spring", 
                            stiffness: 300, 
                            damping: 20,
                            delay: index * 0.05 + 0.2
                          }}
                        >
                          <Badge 
                            variant={badgeVariant} 
                            className="font-medium text-lg px-3 py-1 mb-1 shadow-sm"
                          >
                            {formatNumber(ratio)}%
                          </Badge>
                        </motion.div>
                        <span className="text-xs font-medium text-muted-foreground">
                          {statusText}
                        </span>
                      </div>
                    </div>
                    
                    {/* Card Body with Performance Metrics */}
                    <div className="p-5 space-y-5">
                      {/* Monthly Goal */}
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-3">
                          <motion.div 
                            className="h-10 w-10 rounded-full bg-muted/30 flex items-center justify-center"
                            whileHover={{ rotate: 15, scale: 1.1 }}
                            transition={{ type: "spring", stiffness: 400, damping: 10 }}
                          >
                            <Target className="h-5 w-5 text-muted-foreground" />
                          </motion.div>
                          <div>
                            <p className="text-xs text-muted-foreground">Monthly Goal</p>
                            <p className="font-medium">₱{formatNumber(m.monthly_goal || 0)}</p>
                          </div>
                        </div>
                      </div>
                      
                      {/* Progress Bar */}
                      <div className="space-y-2">
                        <div className="flex justify-between items-center">
                          <span className="text-xs font-medium text-muted-foreground">Current Progress</span>
                          <motion.span 
                            className={`text-xs font-medium ${textColor}`}
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ delay: index * 0.05 + 0.4, duration: 0.3 }}
                          >
                            {formatNumber(ratio)}%
                          </motion.span>
                        </div>
                        <div className="h-3 bg-muted/40 rounded-full overflow-hidden">
                          <motion.div 
                            className={`h-full ${statusColor} rounded-full relative`}
                            custom={`${Math.min(ratio, 100)}%`}
                            variants={progressAnimation}
                          >
                            <motion.div 
                              className="absolute inset-0 bg-white/20"
                              animate={{ 
                                x: ["0%", "100%", "0%"],
                              }}
                              transition={{ 
                                duration: 2, 
                                ease: "linear", 
                                repeat: Infinity,
                                repeatType: "loop" 
                              }}
                            />
                          </motion.div>
                        </div>
                      </div>
                    </div>
                    
                    {/* Card Footer with Action Buttons */}
                    <div className="p-4 pt-0 flex gap-3">
                      <Button
                        variant="outline"
                        size="sm"
                        className="flex-1 h-10 gap-1.5 rounded-lg border-muted-foreground/20 hover:bg-muted/20 transition-all duration-200 hover:scale-[1.02]"
                        onClick={() => openMissionaryModal(m)}
                      >
                        <BarChart2 className="h-4 w-4" />
                        <span>6 Months</span>
                      </Button>
                      
                      <Button
                        variant="outline"
                        size="sm"
                        className="flex-1 h-10 gap-1.5 rounded-lg border-muted-foreground/20 hover:bg-muted/20 transition-all duration-200 hover:scale-[1.02]"
                        onClick={() => openFullMissionaryReport(m)}
                      >
                        <FileText className="h-4 w-4" />
                        <span>Full Report</span>
                      </Button>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            </motion.div>
          );
        })}
        
        {pageData.length === 0 && (
          <motion.div 
            className="p-8 text-center border rounded-lg bg-muted/30"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            {missionaryFilter ? (
              <>No missionaries matching "<strong>{missionaryFilter}</strong>"</>
            ) : (
              "No missionaries found"
            )}
          </motion.div>
        )}
      </motion.div>

      {/* Desktop Table View (hidden on small screens) */}
      <motion.div 
        className="hidden md:block"
        variants={fadeIn}
        initial="hidden"
        animate="visible"
      >
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
                {pageData.map((m, index) => {
                  const ratio = getCurrentMonthRatio(m);
                  const statusColor = getStatusColor(ratio);
                  const textColor = getTextColor(ratio);
                  const badgeVariant = getBadgeVariant(ratio);
                  
                  return (
                    <motion.tr 
                      key={m.id} 
                      className="border-b hover:bg-muted/30 transition-colors"
                      initial={{ opacity: 0, y: 10 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: index * 0.03, duration: 0.3 }}
                    >
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
                            <motion.div 
                              className={`h-full ${statusColor}`}
                              initial={{ width: 0 }}
                              animate={{ width: `${Math.min(ratio, 100)}%` }}
                              transition={{ duration: 0.5, ease: "easeOut", delay: 0.2 }}
                            />
                          </div>
                          <Badge variant={badgeVariant} className="font-medium">
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
                    </motion.tr>
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
      </motion.div>

      {/* Pagination */}
      {totalPages > 1 && (
        <motion.div 
          className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.3, duration: 0.3 }}
        >
          <p className="text-sm text-muted-foreground order-2 sm:order-1">
            Showing <span className="font-medium">{startIdx + 1}</span> to{" "}
            <span className="font-medium">{Math.min(endIdx, filtered.length)}</span> of{" "}
            <span className="font-medium">{filtered.length}</span> missionaries
          </p>
          
          <div className="flex items-center justify-center gap-1 order-1 sm:order-2">
            <Button
              variant="outline"
              size="sm"
              className="h-9 w-9 p-0"
              disabled={missionaryPage <= 1}
              onClick={() => setMissionaryPage(missionaryPage - 1)}
            >
              <ChevronLeft className="h-4 w-4" />
            </Button>
            
            <div className="hidden sm:flex items-center gap-1.5 px-2">
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
                      className="h-9 w-9 p-0"
                      onClick={() => setMissionaryPage(pageNum)}
                    >
                      {pageNum}
                    </Button>
                  );
                }
                return null;
              })}
            </div>
            
            {/* Mobile page indicator */}
            <div className="sm:hidden px-2 text-sm font-medium">
              {missionaryPage} / {totalPages}
            </div>
            
            <Button
              variant="outline"
              size="sm"
              className="h-9 w-9 p-0"
              disabled={missionaryPage >= totalPages}
              onClick={() => setMissionaryPage(missionaryPage + 1)}
            >
              <ChevronRight className="h-4 w-4" />
            </Button>
          </div>
        </motion.div>
      )}
    </div>
  );
} 