"use client";

import { Suspense } from "react";
import dynamic from "next/dynamic";
import { PaymentWizardSkeleton } from "./PaymentWizardSkeleton";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { BulkOnlinePaymentWizard } from "@/components/wizard/BulkOnlinePaymentWizard";

interface BulkOnlinePaymentWizardWrapperProps {
  missionaryId: string;
  missionaryName: string;
}

/**
 * BulkOnlinePaymentWizardWrapper Component
 * 
 * Client component wrapper for the BulkOnlinePaymentWizard.
 * Handles lazy loading of the wizard component and provides a skeleton loading state.
 * 
 * @param missionaryId - The ID of the missionary
 * @param missionaryName - The name of the missionary
 */
export function BulkOnlinePaymentWizardWrapper({ 
  missionaryId,
  missionaryName
}: BulkOnlinePaymentWizardWrapperProps) {
  return (
    <ErrorBoundary>
      <Suspense fallback={<PaymentWizardSkeleton />}>
        <BulkOnlinePaymentWizard 
          missionaryId={missionaryId} 
          missionaryName={missionaryName} 
        />
      </Suspense>
    </ErrorBoundary>
  );
} 