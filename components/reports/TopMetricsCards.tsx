import React from "react";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { ArrowUpIcon, ArrowDownIcon } from "lucide-react";

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
  const percentChange =
    currentPercentAllMissionaries - lastMonthPercentAllMissionaries;
  const isPositiveChange = percentChange >= 0;

  return (
    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
      {/* Total Donations This Month */}
      <Card>
        <CardContent className="pt-6">
          <div className="text-sm font-medium text-gray-500">
            Total Donations This Month
          </div>
          <div className="mt-2 text-3xl font-bold">
            ₱{formatNumber(totalDonationsThisMonth)}
          </div>
        </CardContent>
      </Card>

      {/* Current Total % */}
      <Card>
        <CardContent className="pt-6">
          <div className="text-sm font-medium text-gray-500">
            Current Total %
          </div>
          <div className="mt-2 text-3xl font-bold">
            {formatNumber(currentPercentAllMissionaries)}%
          </div>
        </CardContent>
      </Card>

      {/* % Change from Last Month */}
      <Card>
        <CardContent className="pt-6">
          <div className="text-sm font-medium text-gray-500">
            Change from Last Month
          </div>
          <div className="mt-2 flex items-center gap-2">
            <span className="text-3xl font-bold">
              {formatNumber(Math.abs(percentChange))}%
            </span>
            {isPositiveChange ? (
              <ArrowUpIcon className="h-6 w-6 text-green-500" />
            ) : (
              <ArrowDownIcon className="h-6 w-6 text-red-500" />
            )}
          </div>
        </CardContent>
      </Card>

      {/* Missionaries Below 80% */}
      <Card>
        <CardContent className="pt-6">
          <div className="text-sm font-medium text-gray-500">
            Below 80% Last Month
          </div>
          <div className="mt-2 text-3xl font-bold text-red-600">
            {countBelow80LastMonth}
          </div>
        </CardContent>
      </Card>
    </div>
  );
} 