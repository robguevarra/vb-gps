"use client";

import { useState, useEffect } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Loader2, Plus, Check } from "lucide-react";
import { Donor } from "@/stores/paymentWizardStore";
import { DonorCreationForm } from "./DonorCreationForm";
import { AnimatePresence } from "framer-motion";

interface DonorSearchProps {
  searchTerm: string;
}

/**
 * DonorSearch Component
 * 
 * Displays search results for donors and allows selecting them.
 * This component handles searching for donors and adding them to the selected list.
 */
export function DonorSearch({ searchTerm }: DonorSearchProps) {
  const { 
    selectedDonors, 
    addDonor
  } = usePaymentWizardStore();
  
  const [isLoading, setIsLoading] = useState(false);
  const [results, setResults] = useState<Donor[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [showDonorForm, setShowDonorForm] = useState(false);

  // Search for donors when the search term changes
  useEffect(() => {
    const searchDonors = async () => {
      if (!searchTerm || searchTerm.length < 2) {
        setResults([]);
        return;
      }

      setIsLoading(true);
      setError(null);

      try {
        // Use the server API endpoint for donor search
        const response = await fetch(`/api/donors/search?term=${encodeURIComponent(searchTerm)}`);
        
        if (!response.ok) {
          const errorData = await response.json();
          throw new Error(errorData.error || 'Failed to search donors');
        }
        
        const data = await response.json();
        console.log(`Search for "${searchTerm}" returned ${data.length} results:`, data);
        
        setResults(data || []);
      } catch (err) {
        console.error('Error searching donors:', err);
        setError('Failed to search donors. Please try again.');
        setResults([]);
      } finally {
        setIsLoading(false);
      }
    };

    searchDonors();
  }, [searchTerm]);

  // Check if a donor is already selected
  const isDonorSelected = (donorId: string) => {
    return !!selectedDonors[donorId];
  };

  // Handle selecting a donor
  const handleSelectDonor = (donor: Donor) => {
    // Ensure donor.id is a string before adding to store
    addDonor({
      ...donor,
      id: String(donor.id)
    });
  };

  // Handle opening the donor creation form
  const handleOpenDonorForm = () => {
    console.log('Opening donor form');
    setShowDonorForm(true);
  };

  // Handle successful donor creation
  const handleDonorCreated = (donor: Donor) => {
    addDonor(donor);
    setShowDonorForm(false);
  };

  // Handle canceling donor creation
  const handleCancelDonorCreation = () => {
    setShowDonorForm(false);
  };

  if (isLoading) {
    return (
      <div className="flex justify-center items-center py-8">
        <Loader2 className="h-8 w-8 animate-spin text-gray-400" />
      </div>
    );
  }

  if (error) {
    return (
      <div className="p-4 bg-red-50 dark:bg-red-900/20 text-red-800 dark:text-red-200 rounded-md">
        {error}
      </div>
    );
  }

  if (results.length === 0 && searchTerm.length >= 2) {
    return (
      <>
        <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-md text-center">
          <p className="text-gray-600 dark:text-gray-300">No donors found matching "{searchTerm}"</p>
          <Button 
            variant="outline" 
            className="mt-2"
            onClick={handleOpenDonorForm}
          >
            <Plus className="h-4 w-4 mr-1" /> Create New Donor
          </Button>
        </div>

        {/* Donor Creation Form Modal */}
        <AnimatePresence>
          {showDonorForm && (
            <DonorCreationForm
              onSuccess={handleDonorCreated}
              onCancel={handleCancelDonorCreation}
            />
          )}
        </AnimatePresence>
      </>
    );
  }

  return (
    <>
      <div className="space-y-2">
        {results.map((donor) => (
          <Card 
            key={donor.id}
            className={`p-3 flex justify-between items-center cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors ${
              isDonorSelected(donor.id) ? 'border-primary' : ''
            }`}
            onClick={() => handleSelectDonor(donor)}
          >
            <div>
              <p className="font-medium">{donor.name}</p>
              {donor.email && (
                <p className="text-sm text-gray-500">{donor.email}</p>
              )}
            </div>
            <Button
              variant={isDonorSelected(donor.id) ? "default" : "outline"}
              size="sm"
              className={isDonorSelected(donor.id) ? "pointer-events-none" : ""}
            >
              {isDonorSelected(donor.id) ? (
                <>
                  <Check className="h-4 w-4 mr-1" /> Selected
                </>
              ) : (
                <>
                  <Plus className="h-4 w-4 mr-1" /> Select
                </>
              )}
            </Button>
          </Card>
        ))}
      </div>

      {/* Donor Creation Form Modal */}
      <AnimatePresence>
        {showDonorForm && (
          <DonorCreationForm
            onSuccess={handleDonorCreated}
            onCancel={handleCancelDonorCreation}
          />
        )}
      </AnimatePresence>
    </>
  );
} 