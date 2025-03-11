"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { VirtualizedDonorListSkeleton } from "./VirtualizedDonorListSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { trackPerformance } from "@/utils/performance";

// Define interface for Donor
interface Donor {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

// Define the props interface
interface VirtualizedDonorListProps {
  donors: Donor[];
  onSelectDonor: (donor: Donor) => void;
  isLoading?: boolean;
  isFetchingNextPage?: boolean;
  hasNextPage?: boolean;
  fetchNextPage?: () => void;
  emptyMessage?: string;
  selectedDonors?: Record<string, Donor>;
}

// Dynamically import the VirtualizedDonorList component
const VirtualizedDonorList = dynamic(
  () => import("./VirtualizedDonorList").then(mod => mod.VirtualizedDonorList),
  {
    loading: () => <VirtualizedDonorListSkeleton />,
    ssr: false,
  }
);

// Preload function for the VirtualizedDonorList
const preloadVirtualizedDonorList = () => {
  // This will start loading the component in the background
  import("./VirtualizedDonorList");
};

/**
 * VirtualizedDonorListWrapper Component
 * 
 * A wrapper component that lazy loads the VirtualizedDonorList component
 * and provides error boundary protection. Implements optimized code splitting,
 * preloading, and performance tracking.
 */
export function VirtualizedDonorListWrapper(props: VirtualizedDonorListProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('VirtualizedDonorListWrapper');
    return endTracking;
  }, []);

  // Preload the component when this wrapper mounts
  useEffect(() => {
    preloadVirtualizedDonorList();
  }, []);

  const handleError = (error: Error) => {
    console.error('Virtualized donor list error:', error);
  };

  return (
    <ErrorBoundary 
      fallback={
        <div className="p-4 text-red-500 border border-red-200 rounded-md">
          There was an error loading the donor list. Please try again or contact support.
        </div>
      }
      onError={handleError}
    >
      <Suspense fallback={<VirtualizedDonorListSkeleton />}>
        <VirtualizedDonorList {...props} />
      </Suspense>
    </ErrorBoundary>
  );
}