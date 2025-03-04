/**
 * BulkOnlinePaymentWizard Component
 * 
 * A specialized wizard that allows missionaries to collect donations from multiple partners
 * using a single payment link, making it easier to handle group donations or family contributions.
 * 
 * This is the refactored version that uses smaller, focused components and Zustand for state management.
 */

"use client"

import { useEffect, useState, useCallback } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Alert, AlertTitle, AlertDescription } from "@/components/ui/alert";
import { AlertCircle } from "lucide-react";
import { WizardStepOne } from "@/components/wizard/WizardStepOne";
import { WizardStepTwo } from "@/components/wizard/WizardStepTwo";
import { WizardStepThree } from "@/components/wizard/WizardStepThree";
import { WizardStepFour } from "@/components/wizard/WizardStepFour";
import { DonorCreationForm } from "@/components/wizard/DonorCreationForm";
import { AnimatePresence } from "framer-motion";
import { trackPerformance } from "@/utils/performance";

interface BulkOnlinePaymentWizardProps {
  /** ID of the missionary generating the payment link */
  missionaryId: string;
  /** Name of the missionary (for display purposes) */
  missionaryName: string;
  /** Optional title for the wizard */
  title?: string;
  /** Optional callback function to be called after successful link generation */
  onSuccess?: () => void;
  /** Optional callback function to be called after link generation failure */
  onError?: (error: string) => void;
}

/**
 * BulkOnlinePaymentWizard Component
 * 
 * A specialized wizard that allows missionaries to collect donations from multiple partners
 * using a single payment link, making it easier to handle group donations or family contributions.
 * 
 * Key Features:
 * - Multiple partner entry with amounts
 * - Single payment link generation for total amount
 * - Individual donation records for each partner
 * - Real-time partner search and creation
 * - Mobile-friendly interface
 */
export function BulkOnlinePaymentWizard({
  missionaryId,
  missionaryName,
  title = "Bulk Online Payment",
  onSuccess,
  onError
}: BulkOnlinePaymentWizardProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('BulkOnlinePaymentWizard');
    return endTracking;
  }, []);

  // Use local state for wizard step
  const [currentStep, setCurrentStep] = useState(1);

  const { 
    initializeWithMissionary, 
    isNewDonorFormOpen,
    setIsNewDonorFormOpen
  } = usePaymentWizardStore();
  
  // Initialize the store with missionary data
  useEffect(() => {
    initializeWithMissionary(missionaryId, missionaryName);
    
    // Set up callbacks for localStorage events
    const handleStorageChange = (e: StorageEvent) => {
      if (e.key === `payment_status_${missionaryId}`) {
        try {
          const status = JSON.parse(e.newValue || '{}');
          if (status.status === 'completed' && onSuccess) {
            onSuccess();
          } else if (status.status === 'failed' && onError) {
            onError('Payment failed');
          }
        } catch (err) {
          console.error('Error parsing storage event:', err);
        }
      }
    };
    
    window.addEventListener('storage', handleStorageChange);
    return () => window.removeEventListener('storage', handleStorageChange);
  }, [missionaryId, missionaryName, initializeWithMissionary, onSuccess, onError]);
  
  // Navigation handlers
  const handleNext = useCallback(() => {
    setCurrentStep(prev => prev + 1);
  }, []);

  const handlePrev = useCallback(() => {
    setCurrentStep(prev => prev - 1);
  }, []);
  
  // Custom error fallback UI
  const errorFallback = (
    <Alert variant="destructive" className="my-4">
      <AlertCircle className="h-4 w-4" />
      <AlertTitle>Payment Wizard Error</AlertTitle>
      <AlertDescription>
        <p className="mb-2">There was an error loading the payment wizard.</p>
        <p className="mb-2">Please try refreshing the page or contact support if the issue persists.</p>
      </AlertDescription>
    </Alert>
  );
  
  return (
    <ErrorBoundary fallback={errorFallback}>
      <div className="space-y-4">
        <h2 className="text-2xl font-bold">{title}</h2>
        
        {/* Wizard Steps - Only render the current step */}
        <WizardStepOne 
          onNext={handleNext} 
          visible={currentStep === 1} 
        />
        
        <WizardStepTwo 
          onNext={handleNext} 
          onPrev={handlePrev} 
          visible={currentStep === 2} 
        />
        
        <WizardStepThree 
          onNext={handleNext} 
          onPrev={handlePrev} 
          visible={currentStep === 3} 
        />
        
        <WizardStepFour 
          onPrev={handlePrev} 
          visible={currentStep === 4} 
          onSuccess={onSuccess}
          onError={onError}
        />
        
        {/* New Donor Form Modal */}
        <AnimatePresence>
          {isNewDonorFormOpen && (
            <DonorCreationForm 
              onSuccess={(donor) => {
                // Add the new donor to the selected donors
                const { addDonor } = usePaymentWizardStore.getState();
                addDonor(donor);
                setIsNewDonorFormOpen(false);
              }}
              onCancel={() => {
                setIsNewDonorFormOpen(false);
              }}
            />
          )}
        </AnimatePresence>
      </div>
    </ErrorBoundary>
  );
} 