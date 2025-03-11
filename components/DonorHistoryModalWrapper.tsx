"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { DonorHistoryModalSkeleton } from "./DonorHistoryModalSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { trackPerformance } from "@/utils/performance";

// Define the props interface
interface DonorHistoryModalProps {
  donorName: string;
  missionaryId: string;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

// Dynamically import the DonorHistoryModalClient component
const DonorHistoryModalClient = dynamic(
  () => import("./DonorHistoryModalClient").then(mod => mod.DonorHistoryModalClient),
  {
    loading: () => <DonorHistoryModalSkeleton />,
    ssr: false,
  }
);

// Preload function for the DonorHistoryModalClient
const preloadDonorHistoryModal = () => {
  // Start loading the component in the background
  import("./DonorHistoryModalClient");
};

/**
 * DonorHistoryModalWrapper Component
 * 
 * A wrapper component that lazy loads the DonorHistoryModalClient component
 * and provides error boundary protection. Implements optimized code splitting,
 * preloading, and performance tracking.
 * 
 * @param donorName - The name of the donor to show history for
 * @param missionaryId - The ID of the missionary
 * @param open - Whether the modal is open
 * @param onOpenChange - Callback to change the open state
 */
export function DonorHistoryModalWrapper({ 
  donorName, 
  missionaryId, 
  open, 
  onOpenChange 
}: DonorHistoryModalProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('DonorHistoryModalWrapper');
    return endTracking;
  }, []);

  // Preload the modal component when this wrapper mounts
  useEffect(() => {
    if (open) {
      preloadDonorHistoryModal();
    }
  }, [open]);

  const handleError = (error: Error) => {
    console.error('Donor history modal error:', error);
    // Close the modal on error
    onOpenChange(false);
  };

  if (!open) return null;

  return (
    <ErrorBoundary 
      fallback={
        <div className="p-4 text-red-500 border border-red-200 rounded-md">
          There was an error loading the donor history. Please try again.
        </div>
      }
      onError={handleError}
    >
      <Suspense fallback={<DonorHistoryModalSkeleton />}>
        <DonorHistoryModalClient 
          donorName={donorName}
          missionaryId={missionaryId}
          open={open}
          onOpenChange={onOpenChange}
        />
      </Suspense>
    </ErrorBoundary>
  );
}