"use client";

import { useState, useCallback, useMemo } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Loader2, Plus, Check, AlertCircle, Search, Users } from "lucide-react";
import { Donor } from "@/stores/paymentWizardStore";
import { DonorCreationForm } from "./DonorCreationForm";
import { AnimatePresence, motion } from "framer-motion";
import { useDonorsInfiniteQuery } from "@/hooks/useDonorsQuery";
import { VirtualizedDonorList } from "@/components/VirtualizedDonorList";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Badge } from "@/components/ui/badge";

interface DonorSearchProps {
  searchTerm: string;
}

/**
 * DonorSearch Component
 * 
 * Displays search results for donors and allows selecting them.
 * Optimized for large datasets with infinite scrolling and virtualization.
 * 
 * @param searchTerm - The search term to filter donors by
 */
export function DonorSearch({ searchTerm }: DonorSearchProps) {
  const { 
    selectedDonors, 
    addDonor
  } = usePaymentWizardStore();
  
  const [showDonorForm, setShowDonorForm] = useState(false);

  // Use infinite query for data fetching
  const { 
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
    isLoading, 
    error 
  } = useDonorsInfiniteQuery({
    searchTerm,
    pageSize: 20,
    enabled: searchTerm.length >= 2
  });
  
  // Flatten all pages of donor data
  const donors = useMemo(() => {
    return data?.pages.flatMap(page => page.data) || [];
  }, [data]);
  
  // Total count from the latest page
  const totalCount = useMemo(() => {
    if (!data?.pages.length) return 0;
    return data.pages[data.pages.length - 1].pagination.totalCount;
  }, [data]);

  // Memoized handlers
  const isDonorSelected = useCallback((donorId: string) => {
    return !!selectedDonors[donorId];
  }, [selectedDonors]);

  const handleSelectDonor = useCallback((donor: Donor) => {
    // Ensure donor.id is a string before adding to store
    addDonor({
      ...donor,
      id: String(donor.id)
    });
  }, [addDonor]);

  const handleOpenDonorForm = useCallback(() => {
    setShowDonorForm(true);
  }, []);

  const handleDonorCreated = useCallback((donor: Donor) => {
    addDonor(donor);
    setShowDonorForm(false);
  }, [addDonor]);

  const handleCancelDonorCreation = useCallback(() => {
    setShowDonorForm(false);
  }, []);

  // Error state
  if (error) {
    return (
      <div className="p-4 bg-red-50 dark:bg-red-900/20 text-red-800 dark:text-red-200 rounded-md">
        {error instanceof Error ? error.message : 'Failed to search donors. Please try again.'}
      </div>
    );
  }

  // No results state
  if (donors.length === 0 && searchTerm.length >= 2 && !isLoading) {
    return (
      <>
        <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-md text-center">
          <div className="flex items-center justify-center mb-2">
            <AlertCircle className="h-5 w-5 text-amber-500 mr-2" />
            <p className="text-gray-700 dark:text-gray-200 font-medium">No donors found matching "{searchTerm}"</p>
          </div>
          
          <p className="text-sm text-gray-600 dark:text-gray-300 mb-3">
            Try using a different search term or check the spelling. You can also create a new donor if needed.
          </p>
          
          <Alert className="mb-3 text-left bg-blue-50 dark:bg-blue-900/20 border-blue-200 dark:border-blue-800">
            <Search className="h-4 w-4 text-blue-500 dark:text-blue-400" />
            <AlertDescription className="text-xs text-blue-700 dark:text-blue-300">
              <strong>Search Tips:</strong> Try using just the first name, last name, or part of the email address.
            </AlertDescription>
          </Alert>
          
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
      {donors.length > 0 && (
        <div className="flex justify-between items-center mb-2">
          <div className="text-xs text-gray-500 flex items-center">
            <Users className="h-3 w-3 mr-1" />
            <span>Found {totalCount} donors matching "{searchTerm}"</span>
            {totalCount > donors.length && (
              <Badge variant="outline" className="ml-2 text-[10px] py-0 h-4">
                Showing {donors.length}
              </Badge>
            )}
          </div>
          
          <Button 
            variant="ghost" 
            size="sm" 
            className="h-7 text-xs"
            onClick={handleOpenDonorForm}
          >
            <Plus className="h-3 w-3 mr-1" /> New Donor
          </Button>
        </div>
      )}
      
      <VirtualizedDonorList 
        donors={donors} 
        onSelectDonor={handleSelectDonor}
        isLoading={isLoading && donors.length === 0}
        isFetchingNextPage={isFetchingNextPage}
        hasNextPage={!!hasNextPage}
        fetchNextPage={fetchNextPage}
        selectedDonors={selectedDonors}
      />

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