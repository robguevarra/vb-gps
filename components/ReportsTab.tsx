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
import { addMonths, format } from "date-fns"; // helpful for date manipulations

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
  // 1) Build a pivot table for the last 13 months
  const { columns, pivotRows } = pivotLast13Months(last13MonthDonations);

  return (
    <Tabs defaultValue="last13" className="w-full space-y-4">
      {/* Tabs Navigation */}
      <TabsList className="grid w-full grid-cols-2">
        <TabsTrigger value="last13">Last 13 Months</TabsTrigger>
        <TabsTrigger value="partners">Partners</TabsTrigger>
      </TabsList>

      {/* Last 13 Months (Pivot) */}
      <TabsContent value="last13">
        <Card className="rounded-lg shadow">
          <CardHeader>
            <CardTitle>Last 13 Months</CardTitle>
            <CardDescription className="mt-1 text-sm text-muted-foreground">
              Each donor&apos;s monthly giving over the past 13 months
            </CardDescription>
          </CardHeader>
          <CardContent className="p-0">
            <ScrollArea className="h-[400px]">
              <table className="w-full border-t border-gray-100 dark:border-gray-800 text-sm">
                <thead className="bg-muted/50">
                  <tr>
                    <th className="py-3 px-4 font-medium text-left">Partner</th>
                    {columns.map((col) => (
                      <th
                        key={col.key}
                        className="py-3 px-2 font-medium text-right min-w-[72px]"
                      >
                        {col.label}
                      </th>
                    ))}
                  </tr>
                </thead>
                <tbody className="[&>tr:nth-child(even)]:bg-muted/10">
                  {pivotRows.map((row) => (
                    <tr
                      key={`pivot-${row.donorId}`}
                      className="hover:bg-accent transition-colors"
                    >
                      <td className="py-2 px-4">
                        {row.donorName || "Unknown Donor"}
                      </td>
                      {row.monthlyAmounts.map((amt, idx) => (
                        <td key={idx} className="py-2 px-2 text-right">
                          {amt > 0 ? `₱${amt.toLocaleString()}` : "-"}
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </ScrollArea>
          </CardContent>
        </Card>
      </TabsContent>

      {/* All-Time Partners */}
      <TabsContent value="partners">
        <Card className="rounded-lg shadow">
          <CardHeader>
            <CardTitle>All-Time Partners</CardTitle>
            <CardDescription className="mt-1 text-sm text-muted-foreground">
              Summaries of each partner&apos;s total giving
            </CardDescription>
          </CardHeader>
          <CardContent className="p-0">
            <ScrollArea className="h-[400px]">
              <table className="w-full border-t border-gray-100 dark:border-gray-800 text-sm">
                <thead className="bg-muted/50">
                  <tr>
                    <th className="text-left py-3 px-4 font-medium">Partner</th>
                    <th className="text-right py-3 px-4 font-medium">
                      Total Giving
                    </th>
                    <th className="text-right py-3 px-4 font-medium">
                      Donations Count
                    </th>
                  </tr>
                </thead>
                <tbody className="[&>tr:nth-child(even)]:bg-muted/10">
                  {aggregatePartners(allTimeDonors).map((partner) => (
                    <tr
                      key={`alltime-${partner.donorId}`}
                      className="hover:bg-accent transition-colors"
                    >
                      <td className="py-2 px-4">{partner.donorName}</td>
                      <td className="py-2 px-4 text-right">
                        ₱{partner.totalAmount.toLocaleString()}
                      </td>
                      <td className="py-2 px-4 text-right">
                        {partner.donationsCount}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </ScrollArea>
          </CardContent>
        </Card>
      </TabsContent>
    </Tabs>
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