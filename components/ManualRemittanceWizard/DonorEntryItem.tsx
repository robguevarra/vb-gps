"use client"

import { useState } from "react"
import { Card, CardContent } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Button } from "@/components/ui/button"
import { Search, Trash, UserPlus, Loader2, AlertCircle, Mail, Phone } from "lucide-react"
import { isValidEmail } from "../utils/validation"

interface Donor {
  id: string
  name: string
  email?: string
  phone?: string
}

interface DonorEntry {
  donorId: string
  amount: string
  donorName?: string
}

interface NewDonorForm {
  name: string
  email: string
  phone: string
  showForm: boolean
  emailError?: string
}

interface DonorEntryItemProps {
  index: number
  entry: DonorEntry
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
  handleRemoveDonorEntry: (index: number) => void
  updateDonorEntry: (index: number, entry: Partial<DonorEntry>) => void
}

export function DonorEntryItem({
  index,
  entry,
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
  handleRemoveDonorEntry,
  updateDonorEntry
}: DonorEntryItemProps) {
  // Handle email input change with validation
  const handleEmailChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const email = e.target.value
    setNewDonorForm(prev => ({ 
      ...prev, 
      email,
      emailError: email && !isValidEmail(email) ? "Please enter a valid email address" : undefined
    }))
  }

  return (
    <Card key={index} className="p-4">
      <div className="space-y-4">
        <div className="flex justify-between items-center">
          <Label className="text-lg">Partner {index + 1}</Label>
          {index > 0 && (
            <Button variant="ghost" size="sm" onClick={() => handleRemoveDonorEntry(index)}>
              <Trash className="h-4 w-4 text-red-500" />
            </Button>
          )}
        </div>

        <div className="relative">
          <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
          <Input
            type="text"
            placeholder="Search for a partner..."
            value={entry.donorName || searchTerm}
            onChange={(e) => {
              if (!entry.donorId) {
                setSearchTerm(e.target.value)
                // Update the new donor form name as well
                setNewDonorForm(prev => ({
                  ...prev,
                  name: e.target.value
                }))
              }
            }}
            disabled={!!entry.donorId}
            className="pl-8"
          />
        </div>

        {searchTerm.trim() && !entry.donorId && !newDonorForm.showForm && (
          <Card className="mt-2">
            <CardContent className="p-2">
              {searchLoading && (
                <div className="flex items-center justify-center p-2 text-muted-foreground">
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Searching...
                </div>
              )}
              {!searchLoading && searchResults.length > 0 && (
                <ul className="space-y-1">
                  {searchResults.map((donor) => (
                    <li
                      key={donor.id}
                      className="p-2 hover:bg-accent rounded-md cursor-pointer transition-colors"
                      onClick={() => handleSelectDonor(index, donor)}
                    >
                      {donor.name}
                      {donor.email && <span className="text-xs text-muted-foreground ml-2">{donor.email}</span>}
                    </li>
                  ))}
                </ul>
              )}
              {!searchLoading && searchResults.length === 0 && (
                <div className="p-2 text-muted-foreground">No partners found.</div>
              )}
              
              {/* Toggle button to switch between search modes */}
              <div className="mt-2 pt-2 border-t flex justify-between items-center">
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  onClick={() => setSearchMode(searchMode === "previous" ? "all" : "previous")}
                  className="text-xs"
                >
                  {searchMode === "previous" ? "Search all partners" : "Search previous partners"}
                </Button>
                
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => {
                    if (!searchTerm.trim() || loading) return;
                    setNewDonorForm(prev => ({
                      ...prev,
                      name: searchTerm,
                      showForm: true
                    }));
                  }}
                  disabled={!searchTerm.trim()}
                  className="text-xs"
                >
                  <UserPlus className="mr-1 h-3 w-3" /> Create New
                </Button>
              </div>
            </CardContent>
          </Card>
        )}

        {!entry.donorId && !newDonorForm.showForm && (
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={() => {
              if (!searchTerm.trim() || loading) return;
              setNewDonorForm(prev => ({
                ...prev,
                name: searchTerm,
                showForm: true
              }));
            }}
            disabled={!searchTerm.trim()}
            className="w-full"
          >
            <UserPlus className="mr-2 h-4 w-4" /> Create New Partner
          </Button>
        )}

        {!entry.donorId && newDonorForm.showForm && (
          <Card className="p-4 border-dashed">
            <div className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor={`newDonorName-${index}`}>Partner Name</Label>
                <Input
                  id={`newDonorName-${index}`}
                  value={newDonorForm.name}
                  onChange={(e) => setNewDonorForm(prev => ({ ...prev, name: e.target.value }))}
                  placeholder="Full Name"
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor={`newDonorEmail-${index}`} className="flex items-center">
                  <Mail className="h-4 w-4 mr-1" /> Email (Optional)
                </Label>
                <div className="relative">
                  <Input
                    id={`newDonorEmail-${index}`}
                    type="email"
                    value={newDonorForm.email}
                    onChange={handleEmailChange}
                    placeholder="email@example.com"
                    className={newDonorForm.emailError ? "border-red-500 pr-10" : ""}
                  />
                  {newDonorForm.emailError && (
                    <AlertCircle className="h-4 w-4 text-red-500 absolute right-3 top-3" />
                  )}
                </div>
                {newDonorForm.emailError && (
                  <p className="text-xs text-red-500">{newDonorForm.emailError}</p>
                )}
              </div>
              
              <div className="space-y-2">
                <Label htmlFor={`newDonorPhone-${index}`} className="flex items-center">
                  <Phone className="h-4 w-4 mr-1" /> Phone (Optional)
                </Label>
                <Input
                  id={`newDonorPhone-${index}`}
                  type="tel"
                  value={newDonorForm.phone}
                  onChange={(e) => setNewDonorForm(prev => ({ ...prev, phone: e.target.value }))}
                  placeholder="+1234567890"
                />
              </div>
              
              <div className="flex gap-2">
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => setNewDonorForm(prev => ({ ...prev, showForm: false, emailError: undefined }))}
                  className="flex-1"
                >
                  Cancel
                </Button>
                <Button
                  type="button"
                  variant="default"
                  size="sm"
                  onClick={() => handleCreateAndSelectDonor(
                    newDonorForm.name,
                    newDonorForm.email,
                    newDonorForm.phone,
                    index
                  )}
                  disabled={!newDonorForm.name.trim() || loading || !!newDonorForm.emailError}
                  className="flex-1"
                >
                  {loading ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Creating...
                    </>
                  ) : (
                    "Save Partner"
                  )}
                </Button>
              </div>
            </div>
          </Card>
        )}

        <div className="space-y-2">
          <Label htmlFor={`amount-${index}`}>Amount</Label>
          <Input
            id={`amount-${index}`}
            type="number"
            value={entry.amount}
            onChange={(e) => {
              updateDonorEntry(index, { amount: e.target.value })
            }}
            placeholder="0.00"
          />
        </div>
      </div>
    </Card>
  )
}