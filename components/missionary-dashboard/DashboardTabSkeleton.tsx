/**
 * DashboardTabSkeleton Component
 * 
 * This component provides tailored skeleton loading states for each dashboard tab.
 * It's designed to match the layout of the actual content to minimize layout shift
 * when the real content loads.
 * 
 * Features:
 * - Tab-specific skeleton layouts that match the final UI
 * - Subtle animations to indicate loading state
 * - Responsive design that matches the actual components
 * - Optimized for perceived performance
 * 
 * @component
 */

import { Skeleton } from "@/components/ui/skeleton";
import { Card } from "@/components/ui/card";

interface DashboardTabSkeletonProps {
  /** The type of tab to show a skeleton for */
  type: "overview" | "history" | "approvals" | "manual-remittance" | "reports" | "staff-reports";
}

export function DashboardTabSkeleton({ type }: DashboardTabSkeletonProps) {
  // Common skeleton components
  const DashboardCardsSkeleton = () => (
    <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
      {[...Array(5)].map((_, i) => (
        <div key={i} className="p-6 space-y-4 border rounded-lg bg-card animate-pulse">
          <div className="flex items-center justify-between">
            <Skeleton className="h-10 w-10 rounded-full" />
            <Skeleton className="h-6 w-16" />
          </div>
          <div className="space-y-2">
            <Skeleton className="h-4 w-24" />
            <Skeleton className="h-8 w-32" />
          </div>
          <Skeleton className="h-2 w-full mt-4" />
        </div>
      ))}
    </div>
  );

  const RecentDonationsSkeleton = () => (
    <Card className="p-6 mt-8">
      <div className="flex justify-between items-center mb-6">
        <Skeleton className="h-7 w-48" />
        <Skeleton className="h-9 w-32" />
      </div>
      <div className="space-y-4">
        {[...Array(5)].map((_, i) => (
          <div key={i} className="flex items-center justify-between py-2 animate-pulse">
            <div className="flex items-center gap-3">
              <Skeleton className="h-10 w-10 rounded-full" />
              <div>
                <Skeleton className="h-4 w-32 mb-2" />
                <Skeleton className="h-3 w-24" />
              </div>
            </div>
            <Skeleton className="h-6 w-20" />
          </div>
        ))}
      </div>
    </Card>
  );

  const TableSkeleton = () => (
    <div className="rounded-md border mt-6">
      <div className="p-4 bg-muted/20">
        <Skeleton className="h-8 w-48" />
      </div>
      <div className="divide-y">
        {[...Array(5)].map((_, i) => (
          <div key={i} className="p-4 flex justify-between items-center animate-pulse">
            <div className="space-y-2">
              <Skeleton className="h-5 w-48" />
              <Skeleton className="h-4 w-32" />
            </div>
            <Skeleton className="h-9 w-24" />
          </div>
        ))}
      </div>
    </div>
  );

  const FormSkeleton = () => (
    <Card className="p-6 mt-6">
      <Skeleton className="h-8 w-64 mb-6" />
      <div className="space-y-4">
        <div className="grid gap-4 md:grid-cols-2">
          <div className="space-y-2">
            <Skeleton className="h-4 w-32" />
            <Skeleton className="h-10 w-full" />
          </div>
          <div className="space-y-2">
            <Skeleton className="h-4 w-32" />
            <Skeleton className="h-10 w-full" />
          </div>
        </div>
        <div className="space-y-2">
          <Skeleton className="h-4 w-32" />
          <Skeleton className="h-10 w-full" />
        </div>
        <div className="space-y-2">
          <Skeleton className="h-4 w-32" />
          <Skeleton className="h-24 w-full" />
        </div>
        <div className="flex justify-end">
          <Skeleton className="h-10 w-32" />
        </div>
      </div>
    </Card>
  );

  const ChartSkeleton = () => (
    <Card className="p-6 mt-6">
      <Skeleton className="h-8 w-48 mb-6" />
      <Skeleton className="h-[300px] w-full rounded-md" />
    </Card>
  );

  // Render different skeletons based on tab type
  switch (type) {
    case "overview":
      return (
        <div className="space-y-8">
          <h2 className="text-2xl font-semibold">Overview</h2>
          
          <div className="flex flex-col sm:flex-row gap-4 justify-between">
            <Skeleton className="h-10 w-40" />
            <Skeleton className="h-10 w-40" />
          </div>
          
          <DashboardCardsSkeleton />
          <RecentDonationsSkeleton />
        </div>
      );
    
    case "history":
      return (
        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">Request History</h2>
          <div className="flex justify-between items-center">
            <div className="flex gap-2">
              <Skeleton className="h-10 w-24" />
              <Skeleton className="h-10 w-24" />
            </div>
            <Skeleton className="h-10 w-32" />
          </div>
          <TableSkeleton />
        </div>
      );
    
    case "approvals":
      return (
        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">Pending Approvals</h2>
          <div className="flex justify-between items-center">
            <Skeleton className="h-10 w-48" />
            <Skeleton className="h-10 w-32" />
          </div>
          <TableSkeleton />
        </div>
      );
    
    case "manual-remittance":
      return (
        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">Manual Remittance</h2>
          <FormSkeleton />
        </div>
      );
    
    case "reports":
      return (
        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">My Reports</h2>
          <div className="flex gap-2 mb-6">
            <Skeleton className="h-10 w-24" />
            <Skeleton className="h-10 w-24" />
            <Skeleton className="h-10 w-24" />
          </div>
          <DashboardCardsSkeleton />
          <ChartSkeleton />
        </div>
      );
    
    case "staff-reports":
      return (
        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">Staff Performance</h2>
          <div className="flex gap-2 mb-6">
            <Skeleton className="h-10 w-24" />
            <Skeleton className="h-10 w-24" />
          </div>
          <ChartSkeleton />
          <TableSkeleton />
        </div>
      );
    
    default:
      return (
        <div className="space-y-8">
          <h2 className="text-2xl font-semibold">Loading...</h2>
          <DashboardCardsSkeleton />
        </div>
      );
  }
} 