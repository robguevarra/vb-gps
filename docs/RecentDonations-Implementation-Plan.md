# RecentDonations Component Optimization Plan

## Overview

The RecentDonations component displays recent donation transactions in a card layout, with animations and a modal for detailed donor history. It's currently implemented as a client component with several performance and architectural issues that need optimization.

## Current Implementation Analysis

- **Architecture**: Pure client component with excessive animations
- **Data Flow**: Receives pre-processed data from parent (server component)
- **Animation Issues**: 
  - Multiple nested motion elements
  - Numerous animation variants defined in-component
  - Heavy use of animation triggering state updates
- **Performance Issues**:
  - No virtualization for large lists
  - Unnecessary re-renders during state transitions
  - Complex hover/tap animations on each item
  - Modal uses client-side data fetching

## Optimization Goals

1. Convert to a hybrid architecture with proper component separation
2. Optimize animations for performance and accessibility
3. Implement proper loading states
4. Improve modal implementation for better performance
5. Enhance touch device support

## Implementation Plan

### Phase 1: Component Architecture Refactoring

1. Create the following component files:
   - `/components/RecentDonationsWrapper.tsx` (server component)
   - `/components/RecentDonationsClient.tsx` (client component)
   - `/components/RecentDonationsSkeleton.tsx` (skeleton loader)
   - `/components/DonorHistoryModalClient.tsx` (client modal component)

2. Server component responsibilities:
   - Handle data fetching and pre-processing
   - Ensure correct data format
   - Pass processed data to client component
   - Handle error boundaries

3. Client component responsibilities:
   - Handle animations and interactivity
   - Manage modal state
   - Optimize rendering performance

### Phase 2: Animation Optimization

1. Implement optimized animations:
   - Use CSS transitions for hover effects instead of Framer Motion
   - Consolidate animation variants
   - Implement staggered animations only for visible items
   - Add support for reduced motion preferences

2. Optimize re-render patterns:
   - Use proper memoization
   - Move animation state management to custom hook
   - Consolidate animation variants

### Phase 3: Modal Optimization

1. Improve DonorHistoryModal:
   - Convert to hybrid architecture
   - Handle server-side data fetching
   - Implement proper loading states
   - Add pagination for large datasets

### Phase 4: Performance Enhancements

1. Add virtualization for large lists:
   - Implement windowing for better performance
   - Only animate visible items
   - Optimize scroll performance

## Implementation Details

### Server Component (RecentDonationsWrapper.tsx)

```tsx
// Implementation pattern for the server component
import { createClient } from "@/utils/supabase/server";
import { RecentDonationsClient } from "./RecentDonationsClient";
import { Suspense } from "react";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";
import { RecentDonationsSkeleton } from "./RecentDonationsSkeleton";

interface RecentDonationsWrapperProps {
  missionaryId: string;
}

export async function RecentDonationsWrapper({ missionaryId }: RecentDonationsWrapperProps) {
  const supabase = await createClient();
  
  // Fetch recent donations
  const { data: recentDonations } = await supabase
    .from("donor_donations")
    .select("id, donor_id, amount, date")
    .eq("missionary_id", missionaryId)
    .order("date", { ascending: false })
    .limit(10);
  
  // Process donations data
  const processedDonations = [];
  
  if (recentDonations && recentDonations.length > 0) {
    // Get unique donor IDs and fetch donor names in a single query
    const donorIds = [...new Set(recentDonations.map(donation => donation.donor_id))];
    const { data: donors } = await supabase
      .from("donors")
      .select("id, name")
      .in("id", donorIds);
    
    // Create a map of donor IDs to names for quick lookup
    const donorMap = new Map();
    if (donors) {
      donors.forEach(donor => {
        donorMap.set(donor.id, donor.name);
      });
    }
    
    // Process each donation with donor name
    recentDonations.forEach(donation => {
      const donorName = donorMap.get(donation.donor_id) || `Donor #${donation.donor_id}`;
      processedDonations.push({
        id: donation.id,
        donor_name: donorName,
        amount: donation.amount,
        date: donation.date
      });
    });
  }
  
  return (
    <ErrorBoundaryProvider componentName="Recent Donations">
      <Suspense fallback={<RecentDonationsSkeleton />}>
        <RecentDonationsClient 
          donations={processedDonations} 
          missionaryId={missionaryId} 
        />
      </Suspense>
    </ErrorBoundaryProvider>
  );
}
```

### Client Component (RecentDonationsClient.tsx)

```tsx
"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatDate } from "@/lib/utils";
import { useState, useCallback } from "react";
import { DonorHistoryModalClient } from "./DonorHistoryModalClient";
import { Inbox } from "lucide-react";
import { motion, AnimatePresence, useReducedMotion } from "framer-motion";

interface Donation {
  id: string | number;
  donor_name: string;
  date: string;
  amount: number;
}

interface RecentDonationsClientProps {
  donations: Donation[];
  missionaryId: string;
}

export function RecentDonationsClient({ donations, missionaryId }: RecentDonationsClientProps) {
  const [partnerModalOpen, setPartnerModalOpen] = useState(false);
  const [selectedPartner, setSelectedPartner] = useState<string>("");
  const shouldReduceMotion = useReducedMotion();
  
  const openModal = useCallback((donorName: string) => {
    setSelectedPartner(donorName);
    setPartnerModalOpen(true);
  }, []);

  // Animation variants - simplified and consolidated
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: shouldReduceMotion ? 0 : 0.05,
      }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 10 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { duration: 0.3 }
    }
  };

  return (
    <>
      <Card className="overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-300">
        <CardHeader className="bg-muted/10 px-6 py-4">
          <CardTitle className="text-lg font-semibold">Recent Transactions</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          <div className="divide-y divide-border">
            {donations.length > 0 ? (
              <motion.div
                initial="hidden"
                animate="visible"
                variants={containerVariants}
                className="max-h-[400px] overflow-auto"
              >
                {donations.map((donation) => (
                  <motion.div
                    key={donation.id}
                    variants={itemVariants}
                    className="flex items-center justify-between p-4 hover:bg-muted/20 transition-colors"
                  >
                    <div className="grid gap-1">
                      <div 
                        className="font-medium cursor-pointer hover:text-primary transition-colors"
                        onClick={() => openModal(donation.donor_name)}
                      >
                        {donation.donor_name}
                      </div>
                      <div className="text-sm text-muted-foreground">
                        {formatDate(donation.date)}
                      </div>
                    </div>
                    <div className="font-semibold text-emerald-600">
                      ₱{donation.amount.toLocaleString()}
                    </div>
                  </motion.div>
                ))}
              </motion.div>
            ) : (
              <motion.div 
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.3 }}
                className="p-6 text-center text-muted-foreground"
              >
                <Inbox className="mx-auto h-8 w-8 mb-2" />
                <p>No recent transactions</p>
              </motion.div>
            )}
          </div>
        </CardContent>
      </Card>

      <DonorHistoryModalClient
        donorName={selectedPartner}
        missionaryId={missionaryId}
        open={partnerModalOpen}
        onOpenChange={setPartnerModalOpen}
      />
    </>
  );
}
```

### Skeleton Component (RecentDonationsSkeleton.tsx)

```tsx
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
```

### Modal Component (DonorHistoryModalClient.tsx)

```tsx
"use client";

import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-react";
import { useDonorHistory } from "@/hooks/useDonorHistory"; // Custom hook to fetch donor history

interface DonorHistoryModalClientProps {
  donorName: string;
  missionaryId: string;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export function DonorHistoryModalClient({
  donorName,
  missionaryId,
  open,
  onOpenChange,
}: DonorHistoryModalClientProps) {
  // Use custom hook to fetch donor history
  const { donations, isLoading, error } = useDonorHistory({
    donorName,
    missionaryId,
    enabled: open && !!donorName,
  });

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Giving History for {donorName}</DialogTitle>
        </DialogHeader>
        {isLoading ? (
          <div className="flex justify-center items-center p-4">
            <Loader2 className="animate-spin h-6 w-6 text-primary" />
          </div>
        ) : error ? (
          <p className="text-destructive p-4">{error.message}</p>
        ) : (
          <div className="space-y-4 max-h-[400px] overflow-y-auto">
            {donations?.length > 0 ? (
              donations.map((donation) => (
                <div key={donation.id} className="p-2 border-b border-border">
                  <p>
                    <strong>Date:</strong>{" "}
                    {new Date(donation.date).toLocaleDateString()}
                  </p>
                  <p>
                    <strong>Amount:</strong> ₱
                    {donation.amount.toLocaleString()}
                  </p>
                </div>
              ))
            ) : (
              <p className="p-4 text-muted-foreground">No donation history found for this partner.</p>
            )}
          </div>
        )}
        <div className="mt-4 flex justify-end">
          <Button variant="ghost" onClick={() => onOpenChange(false)}>
            Close
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
```

### Custom Hook (useDonorHistory.ts)

```tsx
import { useQuery } from "@tanstack/react-query";
import { createClient } from "@/utils/supabase/client";

interface Donation {
  id: number | string;
  amount: number;
  date: string;
  donor_name: string;
}

interface UseDonorHistoryProps {
  donorName: string;
  missionaryId: string;
  enabled?: boolean;
}

export function useDonorHistory({ donorName, missionaryId, enabled = true }: UseDonorHistoryProps) {
  return useQuery({
    queryKey: ["donorHistory", donorName, missionaryId],
    queryFn: async (): Promise<Donation[]> => {
      if (!donorName) return [];
      
      const supabase = createClient();
      let donorDonations: Donation[] = [];
      
      // Check if the donorName is in the format "Donor #123"
      const donorIdMatch = donorName.match(/Donor #(\d+)/);
      
      if (donorIdMatch) {
        // If it's a fallback donor name, use the donor_id directly
        const donorId = parseInt(donorIdMatch[1], 10);
        
        const { data, error } = await supabase
          .from("donor_donations")
          .select("id, amount, date")
          .eq("missionary_id", missionaryId)
          .eq("donor_id", donorId)
          .order("date", { ascending: false });
          
        if (!error && data) {
          donorDonations = data.map(record => ({
            id: record.id,
            amount: record.amount,
            date: record.date,
            donor_name: donorName
          }));
        } else if (error) {
          throw new Error(`Failed to fetch donation history: ${error.message}`);
        }
      } else {
        // Otherwise try to get with proper joins
        const { data, error } = await supabase
          .from("donor_donations")
          .select("id, amount, date, donor_id, donors!inner(name)")
          .eq("missionary_id", missionaryId)
          .eq("donors.name", donorName)
          .order("date", { ascending: false });

        if (!error && data) {
          donorDonations = data.map(record => ({
            id: record.id,
            amount: record.amount,
            date: record.date,
            donor_name: record.donors?.name || donorName
          }));
        } else if (error) {
          throw new Error(`Failed to fetch donation history: ${error.message}`);
        }
      }
      
      return donorDonations;
    },
    enabled: enabled && !!donorName && !!missionaryId,
  });
}
```

## Performance Impact

Expected improvements:

1. **Initial Load Time**: 50-60% reduction
   - Moving data processing to server
   - Eliminating client-side waterfall requests
   - Proper skeleton loading

2. **Animation Performance**: 70-80% improvement
   - Reduced number of animated elements
   - Optimized animation triggers
   - Respect for reduced motion preferences

3. **Interaction Responsiveness**: 40-50% improvement
   - Optimized modal data fetching with React Query
   - Reduced re-renders
   - Better touch device support

4. **Bundle Size**: 20-30% reduction
   - More efficient component architecture
   - Optimized animation code

## Implementation Timeline

1. **Phase 1**: Create component files and implement basic structure (1 day)
2. **Phase 2**: Optimize animations (1 day)
3. **Phase 3**: Implement modal optimizations (1 day)
4. **Phase 4**: Final testing and refinement (1 day)

Total implementation time: 4 days

## Success Criteria

The optimization will be considered successful when:

1. The component renders 50% faster than before
2. Animations run smoothly at 60fps on mid-range devices
3. The component correctly respects user's motion preferences
4. The modal loads data efficiently with proper loading states