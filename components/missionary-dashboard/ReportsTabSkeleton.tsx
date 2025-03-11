import { Skeleton } from "@/components/ui/skeleton";
import { Card, CardContent, CardHeader } from "@/components/ui/card";

/**
 * ReportsTabSkeleton Component
 * 
 * A placeholder UI shown while the Reports Tab data is loading.
 * Implements a responsive design with different layouts for mobile and desktop.
 */
export function ReportsTabSkeleton() {
  return (
    <div className="space-y-6">
      {/* Tab Selection Skeleton */}
      <div className="w-full grid grid-cols-2 h-10 rounded-lg bg-muted/30 overflow-hidden">
        <div className="flex items-center justify-center">
          <Skeleton className="h-4 w-24" />
        </div>
        <div className="flex items-center justify-center">
          <Skeleton className="h-4 w-24" />
        </div>
      </div>
      
      {/* Card Skeleton */}
      <Card>
        <CardHeader>
          <Skeleton className="h-6 w-48 mb-2" />
          <Skeleton className="h-4 w-72" />
        </CardHeader>
        <CardContent>
          {/* Mobile View Skeleton */}
          <div className="block md:hidden space-y-6">
            {[1, 2].map((i) => (
              <Card key={i} className="shadow-sm">
                <CardHeader className="pb-2">
                  <div className="flex items-center justify-between">
                    <Skeleton className="h-5 w-24" />
                    <Skeleton className="h-5 w-20" />
                  </div>
                  <Skeleton className="h-3 w-32 mt-2" />
                </CardHeader>
                <CardContent className="pt-3">
                  <div className="space-y-3">
                    {[1, 2, 3].map((j) => (
                      <div key={j} className="flex items-center justify-between pb-3 border-b border-border/40">
                        <Skeleton className="h-4 w-24" />
                        <Skeleton className="h-4 w-16" />
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
          
          {/* Desktop View Skeleton */}
          <div className="hidden md:block">
            {/* Summary Section */}
            <div className="bg-muted/20 rounded-lg p-3 mb-4">
              <div className="flex items-center justify-between">
                <div>
                  <Skeleton className="h-5 w-16 mb-1" />
                  <Skeleton className="h-3 w-32" />
                </div>
                <div className="flex items-center gap-3">
                  <div className="text-right">
                    <Skeleton className="h-3 w-24 mb-1" />
                    <Skeleton className="h-6 w-16 ml-auto" />
                  </div>
                  <div className="text-right">
                    <Skeleton className="h-3 w-24 mb-1" />
                    <Skeleton className="h-6 w-10 ml-auto" />
                  </div>
                </div>
              </div>
            </div>
            
            {/* Table Skeleton */}
            <div className="rounded-lg border overflow-hidden">
              <div className="p-3">
                <div className="grid grid-cols-8 gap-3 mb-3">
                  <Skeleton className="h-8 col-span-1" />
                  {[...Array(6)].map((_, i) => (
                    <Skeleton key={i} className="h-8 col-span-1" />
                  ))}
                  <Skeleton className="h-8 col-span-1" />
                </div>
                
                {/* Table Rows */}
                {[...Array(5)].map((_, i) => (
                  <div key={i} className="grid grid-cols-8 gap-3 mb-3">
                    <Skeleton className="h-6 col-span-1" />
                    {[...Array(6)].map((_, j) => (
                      <Skeleton key={j} className="h-6 col-span-1" />
                    ))}
                    <Skeleton className="h-6 col-span-1" />
                  </div>
                ))}
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}