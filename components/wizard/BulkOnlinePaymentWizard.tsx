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

interface BulkOnlinePaymentWizardProps {
  missionaryId: string;
  missionaryName: string;
}

/**
 * BulkOnlinePaymentWizard Component
 * 
 * A multi-step wizard for processing bulk online payments for missionaries.
 * This component manages the flow between different steps of the payment process.
 */
export function BulkOnlinePaymentWizard({
  missionaryId,
  missionaryName,
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

  return (
    <ErrorBoundary>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h2 className="text-2xl font-bold">Bulk Online Payment</h2>
          <div className="flex items-center space-x-2">
            {[1, 2, 3, 4].map((step) => (
              <div key={step} className="flex items-center">
                <div 
                  className={`w-8 h-8 rounded-full flex items-center justify-center ${
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
                    className={`w-10 h-1 ${
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
            className="mb-4"
          >
            <RefreshCw className="h-4 w-4 mr-2" /> Reset Wizard
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
        />
      </div>
    </ErrorBoundary>
  );
} 