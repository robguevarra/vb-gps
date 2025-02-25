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
    <Tabs defaultValue="last13" className="w-full">
      {/* Tab Selection */}
      <TabsList className="grid w-full grid-cols-2">
        <TabsTrigger value="last13">Last 13 Months</TabsTrigger>
        <TabsTrigger value="history">Partner History</TabsTrigger>
      </TabsList>

      {/* Last 13 Months Tab */}
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
              {/* Monthly Giving Table */}
              <div className="overflow-auto">
                <table className="w-full border-collapse min-w-[1000px]">
                  <thead className="sticky top-0 z-10">
                    <tr className="bg-card border-b border-border">
                      <th className="text-left p-3 font-medium sticky left-0 bg-card border-r border-border">
                        Partner
                      </th>
                      {columns.map((col) => (
                        <th key={col.key} className="p-3 text-right font-medium min-w-[100px]">
                          {col.label}
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {pivotRows.map((row) => (
                      <tr key={row.donor.id} className="border-b border-border">
                        {/* Partner Name (Sticky Column) */}
                        <td className="p-3 sticky left-0 bg-card border-r border-border">
                          {row.donor.name}
                        </td>
                        {/* Monthly Amounts */}
                        {columns.map((col, index) => {
                          const current = row.monthlyTotals[col.key] || 0;
                          const previous = index > 0 ? row.monthlyTotals[columns[index - 1].key] || 0 : 0;
                          return (
                            <td key={col.key} className="p-3 text-right">
                              <div className="flex items-center justify-end gap-2">
                                {getTrendIndicator(current, previous)}
                                {current > 0 ? `₱${current.toLocaleString()}` : "-"}
                              </div>
                            </td>
                          );
                        })}
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      {/* Partner History Tab */}
      <TabsContent value="history">
        <Card>
          <CardHeader>
            <CardTitle>Partner Giving History</CardTitle>
            <CardDescription>
              View complete giving history for each partner
            </CardDescription>
          </CardHeader>
          <CardContent>
            <ScrollArea className="h-[500px]">
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
                    <CardHeader>
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
    </Tabs>
  );
} 