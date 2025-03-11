"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { FinanceRemittanceWizardSkeleton } from "./FinanceRemittanceWizardSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { trackPerformance } from "@/utils/performance";

// Define the props interface
interface FinanceRemittanceWizardProps {
  userId: string;
  title?: string;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

// Dynamically import the FinanceRemittanceWizard component
const FinanceRemittanceWizard = dynamic(
  () => import("./FinanceRemittanceWizard").then(mod => mod.default),
  {
    loading: () => <FinanceRemittanceWizardSkeleton />,
    ssr: false,
  }
);

// Preload function for the FinanceRemittanceWizard
const preloadFinanceRemittanceWizard = () => {
  // This will start loading the component in the background
  import("./FinanceRemittanceWizard");
};

/**
 * FinanceRemittanceWizardWrapper Component
 * 
 * A wrapper component that lazy loads the FinanceRemittanceWizard component
 * and provides error boundary protection. Implements optimized code splitting,
 * preloading, and performance tracking.
 * 
 * @param userId - ID of the finance officer recording the remittance
 * @param title - Optional title for the wizard
 * @param onSuccess - Optional callback function to be called after successful submission
 * @param onError - Optional callback function to be called after submission failure
 */
export function FinanceRemittanceWizardWrapper({ 
  userId, 
  title,
  onSuccess,
  onError 
}: FinanceRemittanceWizardProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('FinanceRemittanceWizardWrapper');
    return endTracking;
  }, []);

  // Preload the wizard component when this wrapper mounts
  useEffect(() => {
    preloadFinanceRemittanceWizard();
  }, []);

  const handleError = (error: Error) => {
    console.error('Finance remittance wizard error:', error);
    if (onError) {
      onError(error.message || 'An error occurred in the wizard');
    }
  };

  return (
    <ErrorBoundary 
      fallback={
        <div className="p-4 text-red-500 border border-red-200 rounded-md">
          There was an error loading the finance remittance wizard. Please try again or contact support.
        </div>
      }
      onError={handleError}
    >
      <Suspense fallback={<FinanceRemittanceWizardSkeleton />}>
        <FinanceRemittanceWizard 
          userId={userId}
          title={title}
          onSuccess={onSuccess}
          onError={onError}
        />
      </Suspense>
    </ErrorBoundary>
  );
}