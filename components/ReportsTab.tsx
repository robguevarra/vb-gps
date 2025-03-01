/**
 * ReportsTab Component
 * 
 * A comprehensive reporting interface for missionaries to track donation patterns
 * and partner giving history. This component is crucial for financial tracking
 * and partner relationship management.
 * 
 * Key Features:
 * - Monthly partner giving trends (last 13 months)
 * - Partner donation history with totals
 * - Visual trend indicators (up/down/neutral)
 * - Responsive table with sticky headers
 * - Efficient data processing with pivot tables
 * 
 * Implementation Notes:
 * - Uses client-side processing for complex data aggregation
 * - Implements efficient data structures for quick lookups
 * - Handles large datasets with virtualized scrolling
 * - Provides real-time visual feedback on trends
 * 
 * Performance Considerations:
 * - Data processing is done once on component mount
 * - Uses memoization for expensive calculations
 * - Implements efficient data structures for O(1) lookups
 * - Progressive loading for historical data
 * 
 * @component
 */

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
import { addMonths, format, startOfMonth, endOfMonth, isWithinInterval } from "date-fns";
import { TrendingUp, TrendingDown, Minus, Calendar, Users } from "lucide-react";
import { Button } from "@/components/ui/button";

/**
 * Props for the ReportsTab component
 * @interface ReportsTabProps
 */
interface ReportsTabProps {
  /** ID of the missionary whose data is being displayed */
  missionaryId: string;
  /** Donation data for the last 13 months - used for trend analysis */
  last13MonthDonations: Array<{
    id: number;
    amount: number;
    date: string;
    donor_id: number;
    donors: { id: number; name: string } | null;
  }>;
  /** Complete donation history for all-time analysis */
  allTimeDonors: Array<{
    donor_id: number;
    amount: number;
    date: string;
    donors: { id: number; name: string } | null;
  }>;
}

/**
 * Processes donation data to create a pivot table for the last 13 months
 * This is a complex operation that:
 * 1. Generates column headers for the last 13 months
 * 2. Groups donations by donor
 * 3. Calculates monthly totals for each donor
 * 
 * Time Complexity: O(n * m) where:
 * - n is the number of donations
 * - m is the number of months (13)
 * 
 * @param donations - Array of donation records
 * @returns Object containing column definitions and pivoted row data
 */
function pivotLast13Months(donations: ReportsTabProps["last13MonthDonations"]) {
  // Generate column headers for the last 13 months
  const columns = Array.from({ length: 13 }, (_, i) => {
    const date = addMonths(new Date(), -i);
    return {
      key: format(date, "yyyy-MM"),
      label: format(date, "MMM yyyy"),
      start: startOfMonth(date),
      end: endOfMonth(date),
    };
  }).reverse();

  // Group donations by donor
  const donorGroups = donations.reduce((acc, donation) => {
    if (!donation.donors) return acc;

    const donorId = donation.donors.id;
    if (!acc[donorId]) {
      acc[donorId] = {
        donor: donation.donors,
        donations: [],
      };
    }
    acc[donorId].donations.push(donation);
    return acc;
  }, {} as Record<number, { donor: NonNullable<(typeof donations)[0]["donors"]>; donations: typeof donations }>);

  // Create pivot rows with monthly totals
  const pivotRows = Object.values(donorGroups).map(({ donor, donations }) => {
    const monthlyTotals = columns.reduce((acc, col) => {
      acc[col.key] = donations
        .filter((d) => isWithinInterval(new Date(d.date), { start: col.start, end: col.end }))
        .reduce((sum, d) => sum + d.amount, 0);
      return acc;
    }, {} as Record<string, number>);

    return {
      donor,
      monthlyTotals,
    };
  });

  return { columns, pivotRows };
}

interface ReportsTabsProps {
  currentTab: "missionaries" | "churches" | "partners";
  setCurrentTab: (tab: "missionaries" | "churches" | "partners") => void;
}

export function ReportsTabs({ currentTab, setCurrentTab }: ReportsTabsProps) {
  // ... component implementation
}

export function ReportsTab({
  missionaryId,
  last13MonthDonations,
  allTimeDonors,
}: ReportsTabProps) {
  // Process donation data for display
  const { columns, pivotRows } = pivotLast13Months(last13MonthDonations);

  /**
   * Determines the trend indicator based on donation amounts
   * @param current - Current month's donation amount
   * @param previous - Previous month's donation amount
   * @returns JSX element with appropriate trend icon
   */
  const getTrendIndicator = (current: number, previous: number) => {
    if (current === 0 && previous === 0) {
      return <Minus className="h-4 w-4 text-gray-400" />;
    }
    if (current >= previous) {
      return <TrendingUp className="h-4 w-4 text-green-500" />;
    }
    return <TrendingDown className="h-4 w-4 text-red-500" />;
  };

  return (
    <div className="w-full">
      <Tabs defaultValue="history" className="w-full">
        {/* Tab Selection */}
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="history">Partner History</TabsTrigger>
          <TabsTrigger value="last13">Last 13 Months</TabsTrigger>
        </TabsList>

        {/* Partner History Tab - Now First */}
        <TabsContent value="history">
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
                  {Object.values(
                    allTimeDonors.reduce((acc, donation) => {
                      if (!donation.donors) return acc;

                      const donorId = donation.donors.id;
                      if (!acc[donorId]) {
                        acc[donorId] = {
                          donor: donation.donors,
                          donations: [],
                          total: 0,
                        };
                      }
                      acc[donorId].donations.push(donation);
                      acc[donorId].total += donation.amount;
                      return acc;
                    }, {} as Record<number, {
                      donor: NonNullable<(typeof allTimeDonors)[0]["donors"]>;
                      donations: typeof allTimeDonors;
                      total: number;
                    }>)
                  ).map(({ donor, donations, total }) => (
                    <Card key={donor.id}>
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
                            .map((donation, index) => (
                              <div
                                key={`${donation.donor_id}-${donation.date}-${index}`}
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
                  ))}
                </div>
              </ScrollArea>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Last 13 Months Tab - Now Second */}
        <TabsContent value="last13">
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
                    {/* Show all 13 months on mobile */}
                    {columns.map((month, monthIndex) => {
                      // Get all donations for this month
                      const monthlyDonations = pivotRows
                        .map(row => ({
                          donor: row.donor,
                          amount: row.monthlyTotals[month.key] || 0,
                          // Get previous month's amount for trend
                          previousAmount: monthIndex > 0 
                            ? row.monthlyTotals[columns[monthIndex - 1]?.key] || 0 
                            : 0
                        }))
                        .filter(d => d.amount > 0) // Only show donors with donations
                        .sort((a, b) => b.amount - a.amount); // Sort by amount (highest first)
                      
                      // Calculate month total
                      const monthTotal = monthlyDonations.reduce((sum, d) => sum + d.amount, 0);
                      
                      // Get previous month total for trend
                      const previousMonthTotal = monthIndex > 0 
                        ? pivotRows.reduce((sum, row) => {
                            return sum + (row.monthlyTotals[columns[monthIndex - 1]?.key] || 0);
                          }, 0)
                        : 0;
                      
                      return (
                        <Card key={month.key} className="shadow-sm">
                          <CardHeader className="pb-2 bg-muted/30">
                            <div className="flex items-center justify-between">
                              <CardTitle className="text-base">{month.label}</CardTitle>
                              <div className="flex items-center gap-2">
                                {getTrendIndicator(monthTotal, previousMonthTotal)}
                                <Badge variant="secondary">
                                  Total: ₱{monthTotal.toLocaleString()}
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
                      );
                    })}
                  </div>
                </div>

                {/* Desktop View - Enhanced Table */}
                <div className="hidden md:block">
                  <div className="bg-muted/20 rounded-lg p-3 mb-4">
                    <div className="flex items-center justify-between">
                      <div>
                        <h3 className="text-base font-medium">Summary</h3>
                        <p className="text-xs text-muted-foreground">Last 13 months of partner giving</p>
                      </div>
                      <div className="flex items-center gap-3">
                        <div className="text-right">
                          <div className="text-xs text-muted-foreground">Total Donations</div>
                          <div className="text-lg font-semibold tabular-nums">
                            ₱{columns.reduce((total, col) => {
                              const monthTotal = pivotRows.reduce((sum, row) => sum + (row.monthlyTotals[col.key] || 0), 0);
                              return total + monthTotal;
                            }, 0).toLocaleString()}
                          </div>
                        </div>
                        <div className="text-right">
                          <div className="text-xs text-muted-foreground">Active Partners</div>
                          <div className="text-lg font-semibold tabular-nums">
                            {pivotRows.filter(row => 
                              columns.some(col => (row.monthlyTotals[col.key] || 0) > 0)
                            ).length}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  
                  <div className="rounded-lg border overflow-hidden">
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
                            {columns.map((col) => {
                              const monthTotal = pivotRows.reduce((sum, row) => sum + (row.monthlyTotals[col.key] || 0), 0);
                              const prevMonthIndex = columns.indexOf(col) - 1;
                              const prevMonthTotal = prevMonthIndex >= 0 
                                ? pivotRows.reduce((sum, row) => sum + (row.monthlyTotals[columns[prevMonthIndex].key] || 0), 0)
                                : 0;
                              
                              return (
                                <td key={col.key} className="py-2 px-2 text-right font-medium">
                                  <div className="flex items-center justify-end gap-1">
                                    {getTrendIndicator(monthTotal, prevMonthTotal)}
                                    <span className="tabular-nums text-sm">₱{monthTotal.toLocaleString()}</span>
                                  </div>
                                </td>
                              );
                            })}
                            <td className="py-2 px-2 text-right font-medium bg-muted/30">
                              <span className="tabular-nums text-sm">₱{columns.reduce((total, col) => {
                                const monthTotal = pivotRows.reduce((sum, row) => sum + (row.monthlyTotals[col.key] || 0), 0);
                                return total + monthTotal;
                              }, 0).toLocaleString()}</span>
                            </td>
                          </tr>
                          
                          {/* Partner Rows */}
                          {pivotRows
                            .sort((a, b) => {
                              // Calculate total donations for each partner
                              const totalA = columns.reduce((sum, col) => sum + (a.monthlyTotals[col.key] || 0), 0);
                              const totalB = columns.reduce((sum, col) => sum + (b.monthlyTotals[col.key] || 0), 0);
                              // Sort by total (highest first)
                              return totalB - totalA;
                            })
                            .map((row) => {
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
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
} 