"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { ManualRemittanceWizardSkeleton } from "./ManualRemittanceWizardSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { trackPerformance } from "@/utils/performance";

// Define the props interface
interface ManualRemittanceWizardProps {
  userId: string;
  title?: string;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

// Dynamically import the ManualRemittanceWizard component
const ManualRemittanceWizard = dynamic(
  () => import("./ManualRemittanceWizard").then(mod => mod.ManualRemittanceWizard),
  {
    loading: () => <ManualRemittanceWizardSkeleton />,
    ssr: false,
  }
);

// Preload function for the ManualRemittanceWizard
const preloadManualRemittanceWizard = () => {
  // This will start loading the component in the background
  import("./ManualRemittanceWizard");
};

/**
 * ManualRemittanceWizardWrapper Component
 * 
 * A wrapper component that lazy loads the ManualRemittanceWizard component
 * and provides error boundary protection. Implements optimized code splitting,
 * preloading, and performance tracking.
 * 
 * @param userId - ID of the user for whom the remittance is being recorded
 * @param title - Optional title for the wizard
 * @param onSuccess - Optional callback function to be called after successful submission
 * @param onError - Optional callback function to be called after submission failure
 */
export function ManualRemittanceWizardWrapper({ 
  userId, 
  title,
  onSuccess,
  onError 
}: ManualRemittanceWizardProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('ManualRemittanceWizardWrapper');
    return endTracking;
  }, []);

  // Preload the wizard component when this wrapper mounts
  useEffect(() => {
    preloadManualRemittanceWizard();
  }, []);

  const handleError = (error: Error) => {
    console.error('Manual remittance wizard error:', error);
    if (onError) {
      onError(error.message || 'An error occurred in the wizard');
    }
  };

  return (
    <ErrorBoundary 
      fallback={
        <div className="p-4 text-red-500 border border-red-200 rounded-md">
          There was an error loading the remittance wizard. Please try again or contact support.
        </div>
      }
      onError={handleError}
    >
      <Suspense fallback={<ManualRemittanceWizardSkeleton />}>
        <ManualRemittanceWizard 
          userId={userId}
          title={title}
          onSuccess={onSuccess}
          onError={onError}
        />
      </Suspense>
    </ErrorBoundary>
  );
}