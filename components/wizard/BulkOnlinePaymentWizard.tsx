"use client";

import { useEffect, useState } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { WizardStepOne } from "./WizardStepOne";
import { WizardStepTwo } from "./WizardStepTwo";
import { WizardStepThree } from "./WizardStepThree";
import { WizardStepFour } from "./WizardStepFour";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { RefreshCw } from "lucide-react";

export interface BulkOnlinePaymentWizardProps {
  missionaryId: string;
  missionaryName: string;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

/**
 * BulkOnlinePaymentWizard Component
 * 
 * A multi-step wizard for processing bulk online payments for missionaries.
 * Handles donor selection, payment entry, review, and processing.
 * 
 * @param missionaryId - The ID of the missionary receiving the payment
 * @param missionaryName - The name of the missionary
 * @param onSuccess - Optional callback for successful payment completion
 * @param onError - Optional callback for payment errors
 */
export function BulkOnlinePaymentWizard({ 
  missionaryId, 
  missionaryName,
  onSuccess,
  onError
}: BulkOnlinePaymentWizardProps) {
  // Local state for step management
  const [currentStep, setCurrentStep] = useState(1);
  
  const { 
    resetState, 
    initializeWithMissionary, 
    clearStorage 
  } = usePaymentWizardStore();

  // Initialize the store with missionary data
  useEffect(() => {
    // Clear any previous data
    clearStorage();
    resetState();
    initializeWithMissionary(missionaryId, missionaryName);
  }, [missionaryId, missionaryName, resetState, initializeWithMissionary, clearStorage]);

  // Handle step navigation
  const goToNextStep = () => setCurrentStep(prev => Math.min(prev + 1, 4));
  const goToPrevStep = () => setCurrentStep(prev => Math.max(prev - 1, 1));
  
  // Reset the wizard
  const handleReset = () => {
    clearStorage();
    resetState();
    initializeWithMissionary(missionaryId, missionaryName);
    setCurrentStep(1);
  };

  // Handle successful payment completion
  const handleSuccess = () => {
    // Call the onSuccess callback if provided
    if (onSuccess) {
      onSuccess();
    }
  };
  
  // Handle payment errors
  const handleError = (error: string) => {
    // Call the onError callback if provided
    if (onError) {
      onError(error);
    }
  };

  return (
    <ErrorBoundary>
      <div className="space-y-4 max-w-full overflow-hidden">
        <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-4">
          <h2 className="text-xl sm:text-2xl font-bold">Donation Wizard</h2>
          <div className="flex items-center justify-center overflow-x-auto py-2 sm:py-0">
            {[1, 2, 3, 4].map((step) => (
              <div key={step} className="flex items-center">
                <div 
                  className={`w-7 h-7 sm:w-8 sm:h-8 rounded-full flex items-center justify-center text-sm ${
                    step === currentStep 
                      ? "bg-primary text-primary-foreground" 
                      : step < currentStep 
                        ? "bg-primary/80 text-primary-foreground" 
                        : "bg-gray-200 dark:bg-gray-700 text-gray-500"
                  }`}
                >
                  {step}
                </div>
                {step < 4 && (
                  <div 
                    className={`w-6 sm:w-10 h-1 ${
                      step < currentStep 
                        ? "bg-primary/80" 
                        : "bg-gray-200 dark:bg-gray-700"
                    }`}
                  />
                )}
              </div>
            ))}
          </div>
        </div>

        {/* Reset button */}
        <div className="flex justify-end">
          <Button 
            variant="outline" 
            size="sm" 
            onClick={handleReset}
            className="mb-2"
          >
            <RefreshCw className="h-3 w-3 sm:h-4 sm:w-4 mr-1 sm:mr-2" /> 
            <span className="text-xs sm:text-sm">Reset</span>
          </Button>
        </div>

        {/* Wizard steps */}
        <WizardStepOne 
          onNext={goToNextStep} 
          visible={currentStep === 1} 
        />
        
        <WizardStepTwo 
          onNext={goToNextStep} 
          onPrev={goToPrevStep} 
          visible={currentStep === 2} 
        />
        
        <WizardStepThree 
          onNext={goToNextStep} 
          onPrev={goToPrevStep} 
          visible={currentStep === 3} 
        />
        
        <WizardStepFour 
          onPrev={goToPrevStep} 
          visible={currentStep === 4}
          onSuccess={handleSuccess}
          onError={handleError}
        />
      </div>
    </ErrorBoundary>
  );
} 