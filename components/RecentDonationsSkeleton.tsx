/**
 * RecentDonationsSkeleton Component
 *
 * A skeleton loading state displayed while the RecentDonations data
 * is being fetched. This provides visual feedback during loading
 * to improve perceived performance.
 *
 * @component
 */

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";

export function RecentDonationsSkeleton() {
  return (
    <Card className="overflow-hidden shadow-sm">
      <CardHeader className="bg-muted/10 px-6 py-4">
        <CardTitle className="text-lg font-semibold">
          <Skeleton className="h-6 w-40" />
        </CardTitle>
      </CardHeader>
      <CardContent className="p-0">
        <div className="divide-y divide-border">
          {Array.from({ length: 5 }).map((_, index) => (
            <div key={index} className="flex items-center justify-between p-4">
              <div className="grid gap-1">
                <Skeleton className="h-5 w-24" />
                <Skeleton className="h-4 w-20" />
              </div>
              <Skeleton className="h-5 w-16" />
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  );
}