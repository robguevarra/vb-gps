"use client";

import { useState } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { AlertCircle, ArrowRight, Search, X } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { DonorSearch } from "./DonorSearch";
import { motion } from "framer-motion";

interface WizardStepOneProps {
  onNext: () => void;
  visible: boolean;
}

/**
 * WizardStepOne Component
 * 
 * First step of the payment wizard where users search for and select donors.
 * This component handles donor selection and navigation to the next step.
 */
export function WizardStepOne({ onNext, visible }: WizardStepOneProps) {
  const { 
    selectedDonors, 
    selectedDonorCount,
    removeDonor
  } = usePaymentWizardStore();

  const [searchTerm, setSearchTerm] = useState("");
  const [showResults, setShowResults] = useState(false);
  const [error, setError] = useState("");

  // Don't render if not visible
  if (!visible) return null;

  const handleSearch = () => {
    if (searchTerm.trim().length < 2) {
      setError("Please enter at least 2 characters to search");
      setShowResults(false);
      return;
    }
    
    setError("");
    setShowResults(true);
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      handleSearch();
    }
  };

  const handleNextStep = () => {
    if (selectedDonorCount === 0) {
      setError("Please select at least one donor");
      return;
    }
    
    // Add debugging to log selected donors
    console.log('Selected donors before proceeding:', selectedDonors);
    
    setError("");
    onNext();
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
          <CardTitle className="text-xl font-semibold">Step 1: Select Donors</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex space-x-2">
            <div className="relative flex-1">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input
                placeholder="Search donors by name or email"
                className="pl-8"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                onKeyDown={handleKeyDown}
              />
            </div>
            <Button onClick={handleSearch}>Search</Button>
          </div>

          {error && (
            <Alert variant="destructive">
              <AlertCircle className="h-4 w-4" />
              <AlertDescription>{error}</AlertDescription>
            </Alert>
          )}

          {showResults && (
            <DonorSearch searchTerm={searchTerm} />
          )}

          {selectedDonorCount > 0 && (
            <div className="mt-6">
              <h3 className="font-medium mb-2">Selected Donors ({selectedDonorCount})</h3>
              <div className="space-y-2">
                {Object.values(selectedDonors).map((donor) => (
                  <div
                    key={donor.id}
                    className="flex justify-between items-center p-3 bg-gray-50 dark:bg-gray-800 rounded-md"
                  >
                    <div>
                      <p className="font-medium">{donor.name}</p>
                      {donor.email && (
                        <p className="text-sm text-gray-500">{donor.email}</p>
                      )}
                    </div>
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => removeDonor(donor.id)}
                      className="h-8 w-8 p-0"
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
              </div>
            </div>
          )}
        </CardContent>
        <CardFooter className="flex justify-end">
          <Button onClick={handleNextStep}>
            Next <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </CardFooter>
      </Card>
    </motion.div>
  );
} 