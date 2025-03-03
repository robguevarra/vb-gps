"use client";

import { useState } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { AlertCircle, ArrowLeft, ArrowRight, Trash, DollarSign } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { motion } from "framer-motion";

interface WizardStepTwoProps {
  onNext: () => void;
  onPrev: () => void;
  visible: boolean;
}

/**
 * WizardStepTwo Component
 * 
 * Second step of the payment wizard where users enter donation amounts for each selected donor.
 * This component handles amount entry, validation, and navigation between steps.
 */
export function WizardStepTwo({ onNext, onPrev, visible }: WizardStepTwoProps) {
  const { 
    donorEntries, 
    updateDonorEntry,
    removeDonorEntry,
    selectedDonors,
    totalAmount
  } = usePaymentWizardStore();

  const [errors, setErrors] = useState<Record<number, string>>({});

  // Don't render if not visible
  if (!visible) return null;

  // Validate all entries and check if we can proceed
  const validateEntries = () => {
    const newErrors: Record<number, string> = {};
    let hasErrors = false;

    donorEntries.forEach((entry, index) => {
      const amount = parseFloat(entry.amount);
      if (isNaN(amount) || amount <= 0) {
        newErrors[index] = "Please enter a valid amount";
        hasErrors = true;
      }
    });

    setErrors(newErrors);
    return !hasErrors;
  };

  const handleNextStep = () => {
    if (validateEntries()) {
      onNext();
    }
  };

  const handleAmountChange = (index: number, value: string) => {
    // Only allow numbers and decimal point
    const sanitizedValue = value.replace(/[^0-9.]/g, '');
    
    // Ensure only one decimal point
    const parts = sanitizedValue.split('.');
    const formattedValue = parts.length > 1 
      ? `${parts[0]}.${parts.slice(1).join('')}`
      : sanitizedValue;
    
    updateDonorEntry(index, { amount: formattedValue });
    
    // Clear error when user types
    if (errors[index]) {
      const newErrors = { ...errors };
      delete newErrors[index];
      setErrors(newErrors);
    }
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -10 }}
      transition={{ duration: 0.3 }}
    >
      <Card>
        <CardHeader>
          <CardTitle className="text-xl font-semibold">Step 2: Enter Donation Amounts</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {donorEntries.length > 0 ? (
            <>
              {donorEntries.map((entry, index) => {
                const donor = selectedDonors[entry.donorId];
                if (!donor) return null;
                
                return (
                  <div key={`${donor.id}-${index}`} className="p-4 border rounded-md">
                    <div className="flex justify-between items-start mb-2">
                      <div>
                        <h3 className="font-medium">{donor.name}</h3>
                        {donor.email && (
                          <p className="text-sm text-gray-500">{donor.email}</p>
                        )}
                      </div>
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => removeDonorEntry(index)}
                        className="h-8 w-8 p-0 text-red-500"
                      >
                        <Trash className="h-4 w-4" />
                      </Button>
                    </div>
                    
                    <div className="mt-2">
                      <Label htmlFor={`amount-${index}`}>Donation Amount</Label>
                      <div className="relative mt-1">
                        <DollarSign className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
                        <Input
                          id={`amount-${index}`}
                          placeholder="0.00"
                          className="pl-8"
                          value={entry.amount}
                          onChange={(e) => handleAmountChange(index, e.target.value)}
                        />
                      </div>
                      {errors[index] && (
                        <p className="text-sm text-red-500 mt-1">{errors[index]}</p>
                      )}
                    </div>
                  </div>
                );
              })}

              {/* Total amount */}
              <div className="mt-6 p-4 bg-gray-50 dark:bg-gray-800 rounded-md">
                <div className="flex justify-between items-center">
                  <span className="font-medium">Total Amount:</span>
                  <span className="text-lg font-bold">${totalAmount.toFixed(2)}</span>
                </div>
              </div>
            </>
          ) : (
            <Alert variant="destructive">
              <AlertCircle className="h-4 w-4" />
              <AlertDescription>
                Please add at least one donor with a valid amount.
              </AlertDescription>
            </Alert>
          )}
        </CardContent>
        <CardFooter className="flex justify-between">
          <Button variant="outline" onClick={onPrev}>
            <ArrowLeft className="mr-2 h-4 w-4" /> Back
          </Button>
          <Button 
            onClick={handleNextStep} 
            disabled={donorEntries.length === 0 || totalAmount <= 0}
          >
            Next <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </CardFooter>
      </Card>
    </motion.div>
  );
} 