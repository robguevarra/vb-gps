import React from "react";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";

interface TopMetricsCardsProps {
  totalDonationsThisMonth: number;
  currentPercentAllMissionaries: number;
  lastMonthPercentAllMissionaries: number;
  countBelow80LastMonth: number;
  formatNumber: (num: number, fractionDigits?: number) => string;
}

export function TopMetricsCards({
  totalDonationsThisMonth,
  currentPercentAllMissionaries,
  lastMonthPercentAllMissionaries,
  countBelow80LastMonth,
  formatNumber,
}: TopMetricsCardsProps) {
  return (
    <div className="grid gap-4 md:grid-cols-4">
      <Card className="border shadow-sm">
        <CardHeader>
          <CardTitle className="text-sm">Total Donations (This Month)</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-2xl font-bold">
            ${formatNumber(totalDonationsThisMonth)}
          </p>
        </CardContent>
      </Card>

      <Card className="border shadow-sm">
        <CardHeader>
          <CardTitle className="text-sm">Current Total %</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-2xl font-bold">
            {formatNumber(currentPercentAllMissionaries)}%
          </p>
        </CardContent>
      </Card>

      <Card className="border shadow-sm">
        <CardHeader>
          <CardTitle className="text-sm">Last Month's Total %</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-2xl font-bold">
            {formatNumber(lastMonthPercentAllMissionaries)}%
          </p>
        </CardContent>
      </Card>

      <Card className="border shadow-sm">
        <CardHeader>
          <CardTitle className="text-sm">Below 80% Last Month</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-2xl font-bold">
            {countBelow80LastMonth}
          </p>
        </CardContent>
      </Card>
    </div>
  );
} 