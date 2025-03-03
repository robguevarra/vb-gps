"use client";

import { useState } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowLeft, ArrowRight, CheckCircle } from "lucide-react";
import { motion } from "framer-motion";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";

interface WizardStepThreeProps {
  onNext: () => void;
  onPrev: () => void;
  visible: boolean;
}

/**
 * WizardStepThree Component
 * 
 * Third step of the payment wizard where users review and confirm their donation details.
 * This component displays a summary of selected donors and amounts, and allows adding notes.
 */
export function WizardStepThree({ onNext, onPrev, visible }: WizardStepThreeProps) {
  const { 
    selectedDonors, 
    donorEntries,
    totalAmount,
    notes,
    setNotes
  } = usePaymentWizardStore();

  // Don't render if not visible
  if (!visible) return null;

  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -10 }}
      transition={{ duration: 0.3 }}
    >
      <Card>
        <CardHeader>
          <CardTitle className="text-xl font-semibold">Step 3: Review and Confirm</CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          {/* Summary */}
          <div className="rounded-md border p-4">
            <h3 className="font-medium mb-3">Donation Summary</h3>
            <div className="space-y-3">
              {donorEntries.map((entry, index) => {
                const donor = selectedDonors[entry.donorId];
                if (!donor) return null;
                
                return (
                  <div key={`${donor.id}-${index}`} className="flex justify-between items-center py-2 border-b last:border-0">
                    <div>
                      <p className="font-medium">{donor.name}</p>
                      {donor.email && (
                        <p className="text-sm text-gray-500">{donor.email}</p>
                      )}
                    </div>
                    <p className="font-medium">${parseFloat(entry.amount).toFixed(2)}</p>
                  </div>
                );
              })}
              
              <div className="flex justify-between items-center pt-3 font-bold">
                <span>Total</span>
                <span>${totalAmount.toFixed(2)}</span>
              </div>
            </div>
          </div>
          
          {/* Notes */}
          <div>
            <Label htmlFor="notes">Additional Notes (Optional)</Label>
            <Textarea
              id="notes"
              placeholder="Add any additional information about this payment..."
              className="mt-1"
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
              rows={4}
            />
          </div>
          
          {/* Confirmation */}
          <div className="bg-green-50 dark:bg-green-900/20 p-4 rounded-md border border-green-200 dark:border-green-800">
            <div className="flex items-start">
              <CheckCircle className="h-5 w-5 text-green-600 dark:text-green-400 mr-2 mt-0.5" />
              <div>
                <p className="font-medium text-green-800 dark:text-green-300">Ready to Process</p>
                <p className="text-sm text-green-700 dark:text-green-400">
                  Please review the information above. Click "Next" to proceed to payment processing.
                </p>
              </div>
            </div>
          </div>
        </CardContent>
        <CardFooter className="flex justify-between">
          <Button variant="outline" onClick={onPrev}>
            <ArrowLeft className="mr-2 h-4 w-4" /> Back
          </Button>
          <Button onClick={onNext}>
            Next <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </CardFooter>
      </Card>
    </motion.div>
  );
} 