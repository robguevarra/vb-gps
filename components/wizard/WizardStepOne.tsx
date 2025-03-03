"use client";

import { useState } from "react";
import { usePaymentWizardStore, Partner } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { AlertCircle, ArrowRight, Search, X, UserPlus, Users } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { DonorSearch } from "./DonorSearch";
import { PartnerCreationForm } from "./PartnerCreationForm";
import { AnimatePresence, motion } from "framer-motion";
import { Badge } from "@/components/ui/badge";

interface WizardStepOneProps {
  onNext: () => void;
  visible: boolean;
}

/**
 * WizardStepOne Component
 * 
 * First step of the payment wizard where users search for and select donors.
 * This component handles donor selection, partner addition, and navigation to the next step.
 */
export function WizardStepOne({ onNext, visible }: WizardStepOneProps) {
  const { 
    selectedDonors, 
    selectedDonorCount,
    donorPartners,
    removeDonor,
    addPartner,
    removePartner
  } = usePaymentWizardStore();

  const [searchTerm, setSearchTerm] = useState("");
  const [showResults, setShowResults] = useState(false);
  const [error, setError] = useState("");
  const [showPartnerForm, setShowPartnerForm] = useState(false);
  const [activeDonorId, setActiveDonorId] = useState<string | null>(null);

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
    console.log('Donor partners before proceeding:', donorPartners);
    
    setError("");
    onNext();
  };

  const handleAddPartner = (donorId: string) => {
    console.log('Opening partner form for donor:', donorId);
    setActiveDonorId(donorId);
    setShowPartnerForm(true);
  };

  const handlePartnerFormSuccess = (partnerData: Omit<Partner, 'id' | 'donorId'>) => {
    if (activeDonorId) {
      addPartner(activeDonorId, partnerData);
      setShowPartnerForm(false);
      setActiveDonorId(null);
    }
  };

  const handlePartnerFormCancel = () => {
    setShowPartnerForm(false);
    setActiveDonorId(null);
  };

  const getPartnerCount = (donorId: string): number => {
    return (donorPartners[donorId] || []).length;
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -10 }}
      transition={{ duration: 0.3 }}
    >
      <Card className="overflow-hidden">
        <CardHeader className="px-4 py-3 sm:px-6 sm:py-4">
          <CardTitle className="text-lg sm:text-xl font-semibold">Step 1: Select Donors</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3 sm:space-y-4 px-4 sm:px-6">
          <div className="flex flex-col sm:flex-row gap-2">
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
            <Button onClick={handleSearch} className="w-full sm:w-auto">Search</Button>
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
            <div className="mt-4 sm:mt-6">
              <h3 className="font-medium mb-2">Selected Donors ({selectedDonorCount})</h3>
              <div className="space-y-3 sm:space-y-4">
                {Object.values(selectedDonors).map((donor) => (
                  <div
                    key={donor.id}
                    className="p-2 sm:p-3 bg-gray-50 dark:bg-gray-800 rounded-md"
                  >
                    <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-2">
                      <div>
                        <p className="font-medium">{donor.name}</p>
                        {donor.email && (
                          <p className="text-sm text-gray-500">{donor.email}</p>
                        )}
                      </div>
                      <div className="flex items-center gap-2 mt-2 sm:mt-0">
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => handleAddPartner(donor.id)}
                          className="h-8 text-xs sm:text-sm flex-1 sm:flex-none"
                        >
                          <UserPlus className="h-3 w-3 sm:h-4 sm:w-4 mr-1" />
                          Add Partner
                        </Button>
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => removeDonor(donor.id)}
                          className="h-8 w-8 p-0"
                        >
                          <X className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                    
                    {/* Display partners if any */}
                    {getPartnerCount(donor.id) > 0 && (
                      <div className="mt-3 pl-3 sm:pl-4 border-l-2 border-gray-200 dark:border-gray-700">
                        <div className="flex items-center mb-2">
                          <Users className="h-3 w-3 sm:h-4 sm:w-4 mr-1 text-gray-500" />
                          <span className="text-xs sm:text-sm font-medium">Partners</span>
                        </div>
                        <div className="space-y-2">
                          {(donorPartners[donor.id] || []).map((partner) => (
                            <div 
                              key={partner.id}
                              className="flex justify-between items-center p-2 bg-gray-100 dark:bg-gray-700 rounded-md"
                            >
                              <div className="flex-1 mr-2">
                                <p className="text-xs sm:text-sm font-medium truncate">{partner.name}</p>
                                {partner.email && (
                                  <p className="text-xs text-gray-500 truncate">{partner.email}</p>
                                )}
                              </div>
                              <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => removePartner(donor.id, partner.id)}
                                className="h-7 w-7 p-0 flex-shrink-0"
                              >
                                <X className="h-3 w-3" />
                              </Button>
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
        </CardContent>
        <CardFooter className="flex justify-end px-4 py-3 sm:px-6 sm:py-4">
          <Button onClick={handleNextStep} className="text-sm sm:text-base">
            Next <ArrowRight className="ml-1 sm:ml-2 h-3 w-3 sm:h-4 sm:w-4" />
          </Button>
        </CardFooter>
      </Card>

      {/* Partner Creation Form Modal */}
      <AnimatePresence>
        {showPartnerForm && activeDonorId && (
          <PartnerCreationForm
            donorId={activeDonorId}
            donorName={selectedDonors[activeDonorId]?.name || ""}
            onSuccess={handlePartnerFormSuccess}
            onCancel={handlePartnerFormCancel}
          />
        )}
      </AnimatePresence>
    </motion.div>
  );
} 