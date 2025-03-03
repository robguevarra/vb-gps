"use client";

import { Suspense } from "react";
import dynamic from "next/dynamic";
import { PaymentWizardSkeleton } from "./PaymentWizardSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { BulkOnlinePaymentWizardProps } from "../wizard/BulkOnlinePaymentWizard";

// Dynamically import the BulkOnlinePaymentWizard component
const BulkOnlinePaymentWizard = dynamic(
  () => import("../wizard/BulkOnlinePaymentWizard").then(mod => mod.BulkOnlinePaymentWizard),
  {
    loading: () => <div className="p-4 text-center">Loading payment wizard...</div>,
    ssr: false,
  }
);

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
 * and provides error boundary protection.
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
  return (
    <ErrorBoundary fallback={<div className="p-4 text-red-500">Error loading payment wizard</div>}>
      <BulkOnlinePaymentWizard 
        missionaryId={missionaryId} 
        missionaryName={missionaryName}
        onSuccess={onSuccess}
        onError={onError}
      />
    </ErrorBoundary>
  );
} 