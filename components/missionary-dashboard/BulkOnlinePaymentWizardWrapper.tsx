"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { PaymentWizardSkeleton } from "./PaymentWizardSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { BulkOnlinePaymentWizardProps } from "../wizard/BulkOnlinePaymentWizard";
import { trackPerformance } from "@/utils/performance";

// Dynamically import the BulkOnlinePaymentWizard component with optimized loading
const BulkOnlinePaymentWizard = dynamic(
  () => import("../wizard/BulkOnlinePaymentWizard").then(mod => mod.BulkOnlinePaymentWizard),
  {
    loading: () => <PaymentWizardSkeleton />,
    ssr: false,
  }
);

// Preload function for the BulkOnlinePaymentWizard
const preloadBulkOnlinePaymentWizard = () => {
  // This will start loading the component in the background
  import("../wizard/BulkOnlinePaymentWizard");
};

/**
 * Props for the BulkOnlinePaymentWizardWrapper component
 */
export interface BulkOnlinePaymentWizardWrapperProps {
  missionaryId: string;
  missionaryName: string;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

/**
 * BulkOnlinePaymentWizardWrapper Component
 * 
 * A wrapper component that lazy loads the BulkOnlinePaymentWizard component
 * and provides error boundary protection. Implements optimized code splitting,
 * preloading, and performance tracking.
 * 
 * @param missionaryId - The ID of the missionary receiving the payment
 * @param missionaryName - The name of the missionary
 * @param onSuccess - Optional callback for successful payment completion
 * @param onError - Optional callback for payment errors
 */
export function BulkOnlinePaymentWizardWrapper({
  missionaryId,
  missionaryName,
  onSuccess,
  onError
}: BulkOnlinePaymentWizardWrapperProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('BulkOnlinePaymentWizardWrapper');
    return endTracking;
  }, []);

  // Preload the wizard component when this wrapper mounts
  useEffect(() => {
    preloadBulkOnlinePaymentWizard();
  }, []);

  const handleError = (error: Error) => {
    console.error('Payment wizard error:', error);
    if (onError) {
      onError(error.message || 'An error occurred in the payment wizard');
    }
  };

  return (
    <ErrorBoundary 
      fallback={
        <div className="p-4 text-red-500 border border-red-200 rounded-md">
          There was an error loading the payment wizard. Please try again or contact support.
        </div>
      }
      onError={handleError}
    >
      <Suspense fallback={<PaymentWizardSkeleton />}>
        <BulkOnlinePaymentWizard 
          missionaryId={missionaryId} 
          missionaryName={missionaryName}
          onSuccess={onSuccess}
          onError={onError}
        />
      </Suspense>
    </ErrorBoundary>
  );
} 