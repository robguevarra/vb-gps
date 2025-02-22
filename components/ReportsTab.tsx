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

interface ReportsTabProps {
  missionaryId: string;
  last13MonthDonations: Array<{
    id: number;
    amount: number;
    date: string;
    donor_id: number;
    donors: { id: number; name: string } | null;
  }>;
  allTimeDonors: Array<{
    donor_id: number;
    amount: number;
    date: string;
    donors: { id: number; name: string } | null;
  }>;
}

export function ReportsTab({
  missionaryId,
  last13MonthDonations,
  allTimeDonors,
}: ReportsTabProps) {
  const { columns, pivotRows } = pivotLast13Months(last13MonthDonations);
  const currentMonthData = getCurrentMonthData(last13MonthDonations);

  return (
    <div className="w-full relative" style={{ zIndex: 0 }}>
      <Tabs defaultValue="current" className="w-full space-y-6">
        <TabsList className="flex flex-col sm:grid sm:grid-cols-3 gap-2 sm:gap-0">
          <TabsTrigger value="current" className="flex items-center gap-2">
            <Calendar className="h-4 w-4" />
            Current Month
          </TabsTrigger>
          <TabsTrigger value="last13" className="flex items-center gap-2">
            <TrendingUp className="h-4 w-4" />
            Last 13 Months
          </TabsTrigger>
          <TabsTrigger value="partners" className="flex items-center gap-2">
            <Users className="h-4 w-4" />
            All Partners
          </TabsTrigger>
        </TabsList>

        {/* Current Month View - Mobile Friendly */}
        <TabsContent value="current">
          <Card>
            <CardHeader className="space-y-2">
              <CardTitle className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2">
                <span>{format(new Date(), "MMMM yyyy")}</span>
                <Badge variant="secondary" className="text-lg w-fit">
                  ₱{currentMonthData.totalAmount.toLocaleString()}
                </Badge>
              </CardTitle>
              <CardDescription>
                {currentMonthData.partners.length} active partners this month
              </CardDescription>
            </CardHeader>
            <CardContent className="relative p-0">
              <div className="sticky top-0 z-10 bg-card border-b border-border">
                <div className="grid grid-cols-2 sm:grid-cols-[2fr,1fr,1fr] px-4 py-3">
                  <div className="font-medium">Partner</div>
                  <div className="font-medium text-right sm:text-left">Amount</div>
                  <div className="hidden sm:block font-medium">Date</div>
                </div>
              </div>
              <ScrollArea className="h-[400px]" type="always">
                <div className="divide-y divide-border">
                  {currentMonthData.donations.map((donation, idx) => (
                    <div
                      key={idx}
                      className="grid grid-cols-2 sm:grid-cols-[2fr,1fr,1fr] px-4 py-3 hover:bg-accent/50 transition-colors"
                    >
                      <div className="truncate">{donation.donorName}</div>
                      <div className="text-right sm:text-left">₱{donation.amount.toLocaleString()}</div>
                      <div className="hidden sm:block">
                        {format(new Date(donation.date), "MMM d, yyyy")}
                      </div>
                      {/* Mobile date display */}
                      <div className="col-span-2 sm:hidden text-sm text-muted-foreground mt-1">
                        {format(new Date(donation.date), "MMM d, yyyy")}
                      </div>
                    </div>
                  ))}
                </div>
              </ScrollArea>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Last 13 Months - Mobile Friendly */}
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
                {/* Table Container */}
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
                    <tbody className="divide-y divide-border">
                      {pivotRows.map((row) => (
                        <tr
                          key={`pivot-${row.donorId}`}
                          className="hover:bg-accent/50 transition-colors"
                        >
                          <td className="p-3 sticky left-0 bg-card border-r border-border">
                            <div className="truncate max-w-[200px]">
                              {row.donorName}
                            </div>
                          </td>
                          {row.monthlyAmounts.map((amt, idx) => (
                            <td
                              key={idx}
                              className={`p-3 text-right ${
                                amt > 0 ? 'text-foreground' : 'text-muted-foreground'
                              }`}
                            >
                              {amt > 0 ? `₱${amt.toLocaleString()}` : "—"}
                            </td>
                          ))}
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                {/* Mobile View - Alternative Display */}
                <div className="block sm:hidden">
                  <div className="p-4 text-center text-muted-foreground">
                    Please rotate your device or use a larger screen to view the detailed monthly breakdown.
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* All Partners - Mobile Friendly */}
        <TabsContent value="partners">
          <Card>
            <CardHeader>
              <CardTitle>Partner History</CardTitle>
              <CardDescription>
                Complete giving history for all partners
              </CardDescription>
            </CardHeader>
            <CardContent className="relative p-0">
              <div className="sticky top-0 z-10 bg-card border-b border-border">
                <div className="grid grid-cols-2 sm:grid-cols-[2fr,1fr,1fr] px-4 py-3">
                  <div className="font-medium">Partner</div>
                  <div className="font-medium text-right">Total</div>
                  <div className="hidden sm:block font-medium text-right">Frequency</div>
                </div>
              </div>
              <ScrollArea className="h-[500px]" type="always">
                <div className="divide-y divide-border">
                  {aggregatePartners(allTimeDonors).map((partner) => (
                    <div
                      key={`alltime-${partner.donorId}`}
                      className="grid grid-cols-2 sm:grid-cols-[2fr,1fr,1fr] px-4 py-3 hover:bg-accent/50 transition-colors"
                    >
                      <div className="truncate">{partner.donorName}</div>
                      <div className="text-right">₱{partner.totalAmount.toLocaleString()}</div>
                      <div className="hidden sm:block text-right">
                        {partner.donationsCount} {partner.donationsCount === 1 ? 'time' : 'times'}
                      </div>
                      {/* Mobile frequency display */}
                      <div className="col-span-2 sm:hidden text-sm text-muted-foreground mt-1 text-right">
                        {partner.donationsCount} {partner.donationsCount === 1 ? 'time' : 'times'}
                      </div>
                    </div>
                  ))}
                </div>
              </ScrollArea>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}

/**
 * Build pivot data for last 13 months. Returns an array of columns (one for each
 * of the 13 months) plus a row for each donor, with monthly sums.
 */
function pivotLast13Months(
  donations: ReportsTabProps["last13MonthDonations"]
) {
  // Make a list of Date columns (ascending from oldest to newest).
  const now = new Date();
  // We want 13 months, so build an array from oldest to newest
  const columns: { key: string; label: string; date: Date }[] = [];
  for (let i = 13; i > 0; i--) {
    const d = addMonths(new Date(now.getFullYear(), now.getMonth(), 1), -i);
    // e.g. "Sep '23"
    const label = format(d, "MMM ''yy");
    columns.push({
      key: format(d, "yyyy-MM"),
      label,
      date: d,
    });
  }

  // Group by donor then by month "yyyy-MM"
  const donorMap = new Map<
    number,
    {
      donorName: string;
      monthlyAmounts: Record<string, number>; // monthKey => amount
    }
  >();

  donations.forEach((don) => {
    const donorId = don.donor_id;
    const donorName = don.donors?.name ?? "Unknown Donor";
    const monthKey = format(new Date(don.date), "yyyy-MM");
    const group = donorMap.get(donorId) || {
      donorName,
      monthlyAmounts: {},
    };
    group.monthlyAmounts[monthKey] =
      (group.monthlyAmounts[monthKey] ?? 0) + don.amount;
    donorMap.set(donorId, group);
  });

  // Convert each donor group into a row with 13 monthly sums
  const pivotRows = Array.from(donorMap.entries()).map(([donorId, info]) => {
    const monthlyAmounts = columns.map((col) => {
      return info.monthlyAmounts[col.key] ?? 0;
    });
    return {
      donorId,
      donorName: info.donorName,
      monthlyAmounts,
    };
  });

  return { columns, pivotRows };
}

/**
 * Aggregate all-time donors
 */
function aggregatePartners(allTimeDonors: ReportsTabProps["allTimeDonors"]) {
  const map = new Map<
    number,
    { donorName: string; totalAmount: number; donationsCount: number }
  >();

  for (const dd of allTimeDonors) {
    const donorId = dd.donor_id;
    const donorName = dd.donors?.name ?? "Unknown Donor";
    if (!map.has(donorId)) {
      map.set(donorId, {
        donorName,
        totalAmount: dd.amount,
        donationsCount: 1,
      });
    } else {
      const existing = map.get(donorId)!;
      existing.totalAmount += dd.amount;
      existing.donationsCount += 1;
    }
  }

  return Array.from(map.entries()).map(([donorId, details]) => ({
    donorId,
    donorName: details.donorName,
    totalAmount: details.totalAmount,
    donationsCount: details.donationsCount,
  }));
}

// Update getCurrentMonthData to return flat donation list
function getCurrentMonthData(donations: ReportsTabProps["last13MonthDonations"]) {
  const now = new Date();
  const currentMonth = {
    start: startOfMonth(now),
    end: endOfMonth(now),
  };

  const currentMonthDonations = donations
    .filter((donation) =>
      isWithinInterval(new Date(donation.date), currentMonth)
    )
    .map(donation => ({
      donorId: donation.donor_id,
      donorName: donation.donors?.name ?? "Unknown Partner",
      date: donation.date,
      amount: donation.amount,
    }))
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

  const totalAmount = currentMonthDonations.reduce(
    (sum, donation) => sum + donation.amount,
    0
  );

  return {
    totalAmount,
    donations: currentMonthDonations,
    partners: Array.from(
      currentMonthDonations.reduce((map, donation) => {
        const key = donation.donorId;
        const existing = map.get(key) || { amount: 0, count: 0 };
        map.set(key, {
          amount: existing.amount + donation.amount,
          count: existing.count + 1,
        });
        return map;
      }, new Map())
    ).length,
  };
} 