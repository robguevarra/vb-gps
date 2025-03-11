"use client";

import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { format } from "date-fns";
import { TrendingUp, TrendingDown, Minus, Calendar } from "lucide-react";
import { useState, useCallback, useMemo } from "react";
import { useReducedMotion } from "framer-motion";
import { motion, AnimatePresence } from "framer-motion";

interface ReportsTabClientProps {
  columns: Array<{
    key: string;
    label: string;
    start: Date;
    end: Date;
  }>;
  pivotRows: Array<{
    donor: {
      id: number;
      name: string;
    };
    monthlyTotals: Record<string, number>;
  }>;
  donorHistory: Array<{
    donor: {
      id: number;
      name: string;
    };
    donations: Array<{
      donor_id: number;
      amount: number;
      date: string;
      donors: {
        id: number;
        name: string;
      } | null;
    }>;
    total: number;
  }>;
  monthlyTotals: Array<{
    column: {
      key: string;
      label: string;
      start: Date;
      end: Date;
    };
    total: number;
    prevTotal: number;
  }>;
  grandTotal: number;
  activePartners: number;
}

/**
 * ReportsTabClient Component
 * 
 * A client component that renders the Reports Tab with pre-processed data.
 * Focuses on UI rendering and interactions, while all data processing is done on the server.
 * 
 * @component
 */
export function ReportsTabClient({
  columns,
  pivotRows,
  donorHistory,
  monthlyTotals,
  grandTotal,
  activePartners
}: ReportsTabClientProps) {
  const [activeTab, setActiveTab] = useState<"history" | "last13">("history");
  const shouldReduceMotion = useReducedMotion();

  /**
   * Determines the trend indicator based on donation amounts
   * Memoized to prevent unnecessary recalculations
   */
  const getTrendIndicator = useCallback((current: number, previous: number) => {
    if (current === 0 && previous === 0) {
      return <Minus className="h-4 w-4 text-gray-400" />;
    }
    if (current >= previous) {
      return <TrendingUp className="h-4 w-4 text-green-500" />;
    }
    return <TrendingDown className="h-4 w-4 text-red-500" />;
  }, []);

  // Sort pivotRows by total donations for consistent rendering
  const sortedPivotRows = useMemo(() => {
    return [...pivotRows].sort((a, b) => {
      // Calculate total donations for each partner
      const totalA = columns.reduce((sum, col) => sum + (a.monthlyTotals[col.key] || 0), 0);
      const totalB = columns.reduce((sum, col) => sum + (b.monthlyTotals[col.key] || 0), 0);
      // Sort by total (highest first)
      return totalB - totalA;
    });
  }, [pivotRows, columns]);

  // Animation variants
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: { 
      opacity: 1,
      transition: { 
        duration: shouldReduceMotion ? 0 : 0.3,
        when: "beforeChildren",
        staggerChildren: shouldReduceMotion ? 0 : 0.05
      }
    },
    exit: { 
      opacity: 0,
      transition: { duration: shouldReduceMotion ? 0 : 0.2 }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 10 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { duration: shouldReduceMotion ? 0 : 0.3 }
    }
  };

  return (
    <div className="w-full">
      <Tabs 
        defaultValue="history" 
        className="w-full"
        onValueChange={(value) => setActiveTab(value as "history" | "last13")}
      >
        {/* Tab Selection */}
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="history">Partner History</TabsTrigger>
          <TabsTrigger value="last13">Last 13 Months</TabsTrigger>
        </TabsList>

        {/* Partner History Tab */}
        <TabsContent value="history">
          <AnimatePresence mode="wait">
            {activeTab === "history" && (
              <motion.div
                key="history"
                variants={containerVariants}
                initial="hidden"
                animate="visible"
                exit="exit"
              >
                <Card>
                  <CardHeader>
                    <CardTitle>Partner Giving History</CardTitle>
                    <CardDescription>
                      View complete giving history for each partner
                    </CardDescription>
                  </CardHeader>
                  <CardContent>
                    <ScrollArea className="h-[500px] md:h-[600px]">
                      {/* Partner History List */}
                      <div className="space-y-6">
                        {donorHistory.map(({ donor, donations, total }, index) => (
                          <motion.div 
                            key={donor.id}
                            variants={itemVariants}
                            custom={index}
                          >
                            <Card>
                              <CardHeader className="pb-2">
                                <div className="flex items-center justify-between">
                                  <CardTitle className="text-lg">{donor.name}</CardTitle>
                                  <Badge variant="secondary">
                                    Total: ₱{total.toLocaleString()}
                                  </Badge>
                                </div>
                              </CardHeader>
                              <CardContent>
                                <div className="space-y-2">
                                  {donations
                                    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
                                    .map((donation, donationIndex) => (
                                      <div
                                        key={`${donation.donor_id}-${donation.date}-${donationIndex}`}
                                        className="flex items-center justify-between text-sm"
                                      >
                                        <div className="flex items-center gap-2">
                                          <Calendar className="h-4 w-4 text-muted-foreground" />
                                          {format(new Date(donation.date), "MMM d, yyyy")}
                                        </div>
                                        <span>₱{donation.amount.toLocaleString()}</span>
                                      </div>
                                    ))}
                                </div>
                              </CardContent>
                            </Card>
                          </motion.div>
                        ))}
                      </div>
                    </ScrollArea>
                  </CardContent>
                </Card>
              </motion.div>
            )}
          </AnimatePresence>
        </TabsContent>

        {/* Last 13 Months Tab */}
        <TabsContent value="last13">
          <AnimatePresence mode="wait">
            {activeTab === "last13" && (
              <motion.div
                key="last13"
                variants={containerVariants}
                initial="hidden"
                animate="visible"
                exit="exit"
              >
                <Card>
                  <CardHeader>
                    <CardTitle>Monthly Partner Giving</CardTitle>
                    <CardDescription>
                      Track partner giving patterns over the last 13 months
                    </CardDescription>
                  </CardHeader>
                  <CardContent className="p-0">
                    <div className="relative">
                      {/* Mobile View - Monthly Cards */}
                      <div className="block md:hidden">
                        <div className="space-y-6 p-4">
                          {monthlyTotals.map((monthData, monthIndex) => {
                            const month = monthData.column;
                            // Get all donations for this month
                            const monthlyDonations = sortedPivotRows
                              .map(row => ({
                                donor: row.donor,
                                amount: row.monthlyTotals[month.key] || 0,
                                // Get previous month's amount for trend
                                previousAmount: monthIndex > 0 
                                  ? row.monthlyTotals[columns[monthIndex - 1]?.key] || 0 
                                  : 0
                              }))
                              .filter(d => d.amount > 0); // Only show donors with donations
                            
                            return (
                              <motion.div
                                key={month.key}
                                variants={itemVariants}
                                custom={monthIndex}
                              >
                                <Card className="shadow-sm">
                                  <CardHeader className="pb-2 bg-muted/30">
                                    <div className="flex items-center justify-between">
                                      <CardTitle className="text-base">{month.label}</CardTitle>
                                      <div className="flex items-center gap-2">
                                        {getTrendIndicator(monthData.total, monthData.prevTotal)}
                                        <Badge variant="secondary">
                                          Total: ₱{monthData.total.toLocaleString()}
                                        </Badge>
                                      </div>
                                    </div>
                                    <CardDescription className="mt-1">
                                      {monthlyDonations.length} {monthlyDonations.length === 1 ? 'partner' : 'partners'} contributed
                                    </CardDescription>
                                  </CardHeader>
                                  <CardContent className="pt-3">
                                    {monthlyDonations.length > 0 ? (
                                      <ScrollArea className="max-h-[250px]">
                                        <div className="space-y-3">
                                          {/* Show all donors for the month */}
                                          {monthlyDonations.map((donation, index) => (
                                            <div 
                                              key={`${month.key}-${donation.donor.id}`}
                                              className={`flex items-center justify-between text-sm ${index !== monthlyDonations.length - 1 ? "pb-3 border-b border-border/40" : ""}`}
                                            >
                                              <span className="font-medium">{donation.donor.name}</span>
                                              <div className="flex items-center gap-2">
                                                {getTrendIndicator(donation.amount, donation.previousAmount)}
                                                <span className="tabular-nums">₱{donation.amount.toLocaleString()}</span>
                                              </div>
                                            </div>
                                          ))}
                                        </div>
                                      </ScrollArea>
                                    ) : (
                                      <div className="text-sm text-muted-foreground py-2 text-center">
                                        No donations recorded
                                      </div>
                                    )}
                                  </CardContent>
                                </Card>
                              </motion.div>
                            );
                          })}
                        </div>
                      </div>

                      {/* Desktop View - Enhanced Table */}
                      <div className="hidden md:block">
                        <motion.div 
                          variants={itemVariants}
                          className="bg-muted/20 rounded-lg p-3 mb-4"
                        >
                          <div className="flex items-center justify-between">
                            <div>
                              <h3 className="text-base font-medium">Summary</h3>
                              <p className="text-xs text-muted-foreground">Last 13 months of partner giving</p>
                            </div>
                            <div className="flex items-center gap-3">
                              <div className="text-right">
                                <div className="text-xs text-muted-foreground">Total Donations</div>
                                <div className="text-lg font-semibold tabular-nums">
                                  ₱{grandTotal.toLocaleString()}
                                </div>
                              </div>
                              <div className="text-right">
                                <div className="text-xs text-muted-foreground">Active Partners</div>
                                <div className="text-lg font-semibold tabular-nums">
                                  {activePartners}
                                </div>
                              </div>
                            </div>
                          </div>
                        </motion.div>
                        
                        <motion.div 
                          variants={itemVariants}
                          className="rounded-lg border overflow-hidden"
                        >
                          <div className="overflow-auto max-h-[450px]">
                            <table className="w-full border-collapse min-w-[1000px]">
                              <thead>
                                <tr className="bg-muted/50">
                                  <th className="text-left py-2 px-3 font-medium sticky left-0 bg-muted/50 border-r z-20">
                                    Partner
                                  </th>
                                  {columns.map((col) => (
                                    <th key={col.key} className="py-2 px-2 text-right font-medium min-w-[90px]">
                                      <div className="flex flex-col items-end">
                                        <span className="text-sm">{format(col.start, "MMM")}</span>
                                        <span className="text-xs text-muted-foreground">{format(col.start, "yyyy")}</span>
                                      </div>
                                    </th>
                                  ))}
                                  <th className="py-2 px-2 text-right font-medium bg-muted/30 min-w-[100px]">
                                    <div className="flex flex-col items-end">
                                      <span className="text-sm">Total</span>
                                      <span className="text-xs text-muted-foreground">All Months</span>
                                    </div>
                                  </th>
                                </tr>
                              </thead>
                              <tbody>
                                {/* Monthly Totals Row */}
                                <tr className="bg-muted/20 border-b-2 border-border">
                                  <td className="py-2 px-3 font-medium sticky left-0 bg-muted/20 border-r z-20">
                                    Monthly Total
                                  </td>
                                  {monthlyTotals.map((monthData) => (
                                    <td key={monthData.column.key} className="py-2 px-2 text-right font-medium">
                                      <div className="flex items-center justify-end gap-1">
                                        {getTrendIndicator(monthData.total, monthData.prevTotal)}
                                        <span className="tabular-nums text-sm">₱{monthData.total.toLocaleString()}</span>
                                      </div>
                                    </td>
                                  ))}
                                  <td className="py-2 px-2 text-right font-medium bg-muted/30">
                                    <span className="tabular-nums text-sm">₱{grandTotal.toLocaleString()}</span>
                                  </td>
                                </tr>
                                
                                {/* Partner Rows */}
                                {sortedPivotRows.map((row) => {
                                  // Calculate partner total across all months
                                  const partnerTotal = columns.reduce((sum, col) => sum + (row.monthlyTotals[col.key] || 0), 0);
                                  
                                  // Skip partners with no donations in the period
                                  if (partnerTotal === 0) return null;
                                  
                                  return (
                                    <tr key={row.donor.id} className="border-b border-border hover:bg-muted/10 transition-colors">
                                      {/* Partner Name (Sticky Column) */}
                                      <td className="py-2 px-3 sticky left-0 bg-card border-r z-20">
                                        <div className="font-medium text-sm">{row.donor.name}</div>
                                      </td>
                                      
                                      {/* Monthly Amounts */}
                                      {columns.map((col, index) => {
                                        const current = row.monthlyTotals[col.key] || 0;
                                        const previous = index > 0 ? row.monthlyTotals[columns[index - 1].key] || 0 : 0;
                                        
                                        return (
                                          <td key={col.key} className={`py-2 px-2 text-right ${current > 0 ? "" : "text-muted-foreground"}`}>
                                            <div className="flex items-center justify-end gap-1">
                                              {current > 0 && getTrendIndicator(current, previous)}
                                              <span className="tabular-nums text-sm">{current > 0 ? `₱${current.toLocaleString()}` : "—"}</span>
                                            </div>
                                          </td>
                                        );
                                      })}
                                      
                                      {/* Partner Total */}
                                      <td className="py-2 px-2 text-right font-medium bg-muted/30">
                                        <span className="tabular-nums text-sm">₱{partnerTotal.toLocaleString()}</span>
                                      </td>
                                    </tr>
                                  );
                                }).filter(Boolean)}
                              </tbody>
                            </table>
                          </div>
                        </motion.div>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            )}
          </AnimatePresence>
        </TabsContent>
      </Tabs>
    </div>
  );
}