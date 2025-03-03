/**
 * BulkOnlinePaymentWizard Component
 * 
 * A specialized wizard that allows missionaries to collect donations from multiple partners
 * using a single payment link, making it easier to handle group donations or family contributions.
 * 
 * This is the refactored version that uses smaller, focused components and Zustand for state management.
 */

"use client"

import { useEffect } from "react";
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
  const { 
    initializeWithMissionary, 
    isNewDonorFormOpen,
    paymentStatus,
    setError
  } = usePaymentWizardStore();
  
  // Initialize the store with missionary data
  useEffect(() => {
    initializeWithMissionary(missionaryId, missionaryName);
    
    // Set up callbacks
    if (onSuccess) {
      const handleSuccess = () => {
        if (paymentStatus === 'completed') {
          onSuccess();
        }
      };
      
      window.addEventListener('storage', handleSuccess);
      return () => window.removeEventListener('storage', handleSuccess);
    }
    
    if (onError) {
      const handleError = () => {
        if (paymentStatus === 'failed') {
          onError('Payment failed');
        }
      };
      
      window.addEventListener('storage', handleError);
      return () => window.removeEventListener('storage', handleError);
    }
  }, [missionaryId, missionaryName, initializeWithMissionary, paymentStatus, onSuccess, onError]);
  
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
        
        {/* Wizard Steps */}
        <WizardStepOne />
        <WizardStepTwo />
        <WizardStepThree />
        <WizardStepFour />
        
        {/* New Donor Form Modal */}
        <AnimatePresence>
          {isNewDonorFormOpen && (
            <DonorCreationForm 
              onSuccess={(donor) => {
                // Add the new donor to the selected donors and create an entry
                const { addSelectedDonor, addDonorEntry } = usePaymentWizardStore.getState();
                addSelectedDonor(donor);
                addDonorEntry({
                  donorId: donor.id,
                  donorName: donor.name,
                  amount: "",
                  email: donor.email,
                  phone: donor.phone
                });
              }}
            />
          )}
        </AnimatePresence>
      </div>
    </ErrorBoundary>
  );
} 