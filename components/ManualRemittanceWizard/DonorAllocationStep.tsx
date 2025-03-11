"use client"

import React, { memo } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Plus, ArrowLeft, Loader2 } from "lucide-react"
import { DonorEntryItem } from "./DonorEntryItem"
import { Donor, DonorEntry, NewDonorForm } from "./types"

interface DonorAllocationStepProps {
  donorEntries: DonorEntry[]
  totalAmount: string
  searchTerm: string
  setSearchTerm: (term: string) => void
  searchResults: Donor[]
  searchLoading: boolean
  searchMode: "previous" | "all"
  setSearchMode: (mode: "previous" | "all") => void
  newDonorForm: NewDonorForm
  setNewDonorForm: (form: NewDonorForm) => void
  loading: boolean
  handleSelectDonor: (index: number, donor: Donor) => void
  handleCreateAndSelectDonor: (name: string, email: string, phone: string, index: number) => void
  handleAddDonorEntry: () => void
  handleRemoveDonorEntry: (index: number) => void
  updateDonorEntry: (index: number, entry: Partial<DonorEntry>) => void
  handleSubmit: () => void
  goBack: () => void
  isValid: boolean
}

function DonorAllocationStepComponent({
  donorEntries,
  totalAmount,
  searchTerm,
  setSearchTerm,
  searchResults,
  searchLoading,
  searchMode,
  setSearchMode,
  newDonorForm,
  setNewDonorForm,
  loading,
  handleSelectDonor,
  handleCreateAndSelectDonor,
  handleAddDonorEntry,
  handleRemoveDonorEntry,
  updateDonorEntry,
  handleSubmit,
  goBack,
  isValid
}: DonorAllocationStepProps) {
  // Calculate the total entered amount
  const totalEntered = donorEntries
    .reduce((acc, entry) => acc + (Number.parseFloat(entry.amount) || 0), 0)
    .toLocaleString()

  // Format the declared total amount
  const formattedTotalAmount = Number.parseFloat(totalAmount).toLocaleString()

  return (
    <div className="space-y-6">
      {donorEntries.map((entry, index) => (
        <DonorEntryItem
          key={index}
          index={index}
          entry={entry}
          searchTerm={searchTerm}
          setSearchTerm={setSearchTerm}
          searchResults={searchResults}
          searchLoading={searchLoading}
          searchMode={searchMode}
          setSearchMode={setSearchMode}
          newDonorForm={newDonorForm}
          setNewDonorForm={setNewDonorForm}
          loading={loading}
          handleSelectDonor={handleSelectDonor}
          handleCreateAndSelectDonor={handleCreateAndSelectDonor}
          handleRemoveDonorEntry={handleRemoveDonorEntry}
          updateDonorEntry={updateDonorEntry}
        />
      ))}

      <div className="flex gap-4">
        <Button variant="outline" className="flex-1" onClick={handleAddDonorEntry}>
          <Plus className="mr-2 h-4 w-4" /> Add Partner
        </Button>

        <Button size="lg" className="flex-1" onClick={handleSubmit} disabled={!isValid || loading}>
          {loading ? (
            <>
              <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Submitting...
            </>
          ) : (
            "Submit Remittance"
          )}
        </Button>
      </div>

      <Button variant="ghost" onClick={goBack} className="w-full">
        <ArrowLeft className="mr-2 h-4 w-4" /> Back to Total Amount
      </Button>

      <Card className="bg-muted">
        <CardContent className="p-4">
          <div className="flex justify-between font-medium">
            <span>Total Entered:</span>
            <span>₱{totalEntered}</span>
          </div>
          <div className="flex justify-between mt-2">
            <span>Declared Total:</span>
            <span>₱{formattedTotalAmount}</span>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}

// Memoize the component to prevent unnecessary re-renders
export const DonorAllocationStep = memo(DonorAllocationStepComponent)