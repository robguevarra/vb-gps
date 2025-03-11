"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { OnlinePaymentWizardSkeleton } from "./OnlinePaymentWizardSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { trackPerformance } from "@/utils/performance";

// Define the props interface
interface OnlinePaymentWizardProps {
  missionaryId: string;
  missionaryName: string;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

// Dynamically import the OnlinePaymentWizard component
const OnlinePaymentWizard = dynamic(
  () => import("./OnlinePaymentWizard").then(mod => mod.default),
  {
    loading: () => <OnlinePaymentWizardSkeleton />,
    ssr: false,
  }
);

// Preload function for the OnlinePaymentWizard
const preloadOnlinePaymentWizard = () => {
  // This will start loading the component in the background
  import("./OnlinePaymentWizard");
};

/**
 * OnlinePaymentWizardWrapper Component
 * 
 * A wrapper component that lazy loads the OnlinePaymentWizard component
 * and provides error boundary protection. Implements optimized code splitting,
 * preloading, and performance tracking.
 * 
 * @param missionaryId - ID of the missionary for whom the payment is being made
 * @param missionaryName - Name of the missionary
 * @param onSuccess - Optional callback function to be called after successful submission
 * @param onError - Optional callback function to be called after submission failure
 */
export function OnlinePaymentWizardWrapper({ 
  missionaryId, 
  missionaryName,
  onSuccess,
  onError 
}: OnlinePaymentWizardProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('OnlinePaymentWizardWrapper');
    return endTracking;
  }, []);

  // Preload the wizard component when this wrapper mounts
  useEffect(() => {
    preloadOnlinePaymentWizard();
  }, []);

  const handleError = (error: Error) => {
    console.error('Online payment wizard error:', error);
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
      <Suspense fallback={<OnlinePaymentWizardSkeleton />}>
        <OnlinePaymentWizard 
          missionaryId={missionaryId}
          missionaryName={missionaryName}
          onSuccess={onSuccess}
          onError={onError}
        />
      </Suspense>
    </ErrorBoundary>
  );
}