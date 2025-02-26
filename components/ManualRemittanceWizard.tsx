/**
 * ManualRemittanceWizard Component
 * 
 * A multi-step form wizard for recording manual (offline) donations with multiple donors.
 * This component is crucial for finance officers and missionaries to record offline donations
 * in a structured and validated way.
 * 
 * Key Features:
 * - Two-step wizard interface:
 *   1. Total amount entry
 *   2. Donor distribution with dynamic donor entries
 * - Real-time donor search with debouncing
 * - New donor creation capability
 * - Amount validation and balancing
 * - Progress tracking
 * - Success animations
 * 
 * Technical Implementation:
 * - Uses debounced search for efficient API calls
 * - Implements real-time validation
 * - Handles concurrent donor creation
 * - Manages complex form state
 * - Provides immediate visual feedback
 * 
 * Performance Considerations:
 * - Debounced search to prevent API flooding
 * - Optimized re-renders with proper state management
 * - Efficient donor lookup and creation
 * 
 * @component
 */

"use client"

import { useState, useEffect, useCallback } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { createClient } from "@/utils/supabase/client"
import { Plus, Trash, CheckCircle, Loader2, ArrowLeft, Search, UserPlus } from "lucide-react"
import { toast } from "@/hooks/use-toast"
import { Progress } from "@/components/ui/progress"
import { PostgrestError } from "@supabase/supabase-js"
import { createDonor } from "@/actions/donors" // Import the server action
import { submitDonations } from "@/actions/donations" // Import the donation submission action

/**
 * Props for the ManualRemittanceWizard component
 */
interface ManualRemittanceWizardProps {
  /** ID of the missionary for whom the remittance is being recorded */
  missionaryId: string;
}

/**
 * Interface representing a donor in the system
 */
interface Donor {
  /** Unique identifier for the donor */
  id: string;
  /** Full name of the donor */
  name: string;
}

/**
 * Interface for a donor entry in the remittance form
 */
interface DonorEntry {
  /** ID of the donor */
  donorId: string;
  /** Amount contributed by this donor */
  amount: string;
  /** Name of the donor (for display purposes) */
  donorName?: string;
}

export function ManualRemittanceWizard({ missionaryId }: ManualRemittanceWizardProps) {
  // Initialize Supabase client for database operations
  const supabase = createClient()

  // State Management
  const [step, setStep] = useState<1 | 2>(1)
  const [totalAmount, setTotalAmount] = useState("")
  const [donorEntries, setDonorEntries] = useState<DonorEntry[]>([
    { donorId: "", amount: "" },
  ])
  const [loading, setLoading] = useState(false)
  const [success, setSuccess] = useState(false)
  const [searchTerm, setSearchTerm] = useState("")
  const [searchResults, setSearchResults] = useState<Donor[]>([])
  const [searchLoading, setSearchLoading] = useState(false)

  /**
   * Debounced search function to prevent excessive API calls
   * Searches for donors based on the input term
   */
  const debouncedSearch = useCallback(
    debounce(async (term: string) => {
      setSearchLoading(true)
      try {
        let query = supabase.from("donors").select("id, name")

        if (term.trim()) {
          // Use ilike for case-insensitive matching with wildcards
          query = query.ilike("name", `%${term.trim()}%`)
        } else {
          query = query.order("created_at", { ascending: false }).limit(10)
        }

        const { data, error } = await query
        if (!error) {
          setSearchResults(data || [])
        }
      } catch (error) {
        toast({ title: "Search Error", description: "Failed to fetch donors" })
      } finally {
        setSearchLoading(false)
      }
    }, 300),
    [],
  )

  // Trigger donor search when search term changes
  useEffect(() => {
    debouncedSearch(searchTerm)
  }, [searchTerm, debouncedSearch])

  /**
   * Creates a new donor in the database using server action
   * @param name - Name of the new donor
   * @returns The ID of the newly created donor
   */
  const handleCreateDonor = async (name: string) => {
    setLoading(true)
    try {
      // Use the server action instead of client-side Supabase
      const result = await createDonor(name)

      if (result.error) {
        throw new Error(result.error)
      }

      const newDonor = result.donor
      
      if (newDonor) {
        setSearchResults((prevResults) => [...prevResults, newDonor])
        return newDonor.id
      }
      return null
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'An unknown error occurred'
      toast({ title: "Error creating donor", description: errorMessage, variant: "destructive" })
      return null
    } finally {
      setLoading(false)
    }
  }

  /**
   * Handles the selection of a donor from the search results
   * @param index - Index of the donor entry being modified
   * @param donor - Selected donor object
   */
  const handleSelectDonor = (index: number, donor: Donor) => {
    const newEntries = [...donorEntries]
    newEntries[index] = { ...newEntries[index], donorId: donor.id, donorName: donor.name }
    setDonorEntries(newEntries)
    setSearchTerm("")
    setSearchResults([])
  }

  /**
   * Adds a new empty donor entry to the form
   */
  const handleAddDonorEntry = () => {
    setDonorEntries([...donorEntries, { donorId: "", amount: "", donorName: "" }])
  }

  /**
   * Removes a donor entry from the form
   * @param index - Index of the donor entry to remove
   */
  const handleRemoveDonorEntry = (index: number) => {
    setDonorEntries(donorEntries.filter((_, i) => i !== index))
  }

  /**
   * Validates the total amount entry in step 1
   * @returns boolean indicating if the total amount is valid
   */
  const validateStep1 = () => {
    const total = Number.parseFloat(totalAmount)
    return !isNaN(total) && total > 0
  }

  /**
   * Validates the donor distribution in step 2
   * Checks if:
   * 1. All donors are selected
   * 2. All amounts are valid
   * 3. Total matches the initial amount
   * @returns boolean indicating if the distribution is valid
   */
  const validateStep2 = () => {
    const sum = donorEntries.reduce((acc, entry) => {
      const amount = Number.parseFloat(entry.amount)
      return acc + (isNaN(amount) ? 0 : amount)
    }, 0)

    return (
      Math.abs(sum - Number.parseFloat(totalAmount)) <= 0.01 &&
      donorEntries.every(
        (entry) =>
          String(entry.donorId).trim() !== "" &&
          !isNaN(Number.parseFloat(entry.amount)) &&
          Number.parseFloat(entry.amount) > 0,
      )
    )
  }

  /**
   * Handles the final submission of the remittance
   * Creates donation records for each donor entry using server action
   */
  const handleSubmit = async () => {
    if (loading) return; // Prevent multiple submissions
    
    setLoading(true);
    try {
      const entries = donorEntries.map((entry) => {
        const amount = Number.parseFloat(entry.amount);
        return {
          donor_id: entry.donorId,
          amount,
          missionary_id: missionaryId,
          date: new Date().toISOString(),
          source: "offline" as const,
          status: "completed" as const,
        };
      });

      // Use the server action instead of client-side Supabase
      const result = await submitDonations(entries);

      if (!result.success) {
        throw new Error(result.error || "Unknown error occurred");
      }

      setSuccess(true);
      setTimeout(() => {
        setSuccess(false);
        setStep(1);
        setTotalAmount("");
        setDonorEntries([{ donorId: "", amount: "" }]);
      }, 2000);

      // Show different success messages based on the result
      if (result.partialSuccess) {
        toast({
          title: "Partial success",
          description: `${result.insertedCount} of ${result.totalCount} donations were successfully recorded.`,
          variant: "default",
        });
      } else {
        toast({
          title: "Remittance submitted successfully!",
          description: "All donations have been recorded.",
        });
      }
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'An unknown error occurred';
      toast({
        title: "Submission failed",
        description: errorMessage,
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle className="text-2xl font-bold text-center">Manual Remittance</CardTitle>
      </CardHeader>
      <CardContent className="space-y-6">
        <Progress value={step === 1 ? 50 : 100} className="w-full" />

        <p className="text-center text-muted-foreground">
          {step === 1 ? "Enter total amount" : "Distribute donations to donors"}
        </p>

        <div className="relative">
          {success && (
            <div className="absolute inset-0 bg-background/90 flex items-center justify-center rounded-lg z-10">
              <div className="text-center space-y-4">
                <CheckCircle className="h-12 w-12 text-green-500 mx-auto animate-bounce" />
                <p className="font-semibold">Remittance recorded successfully!</p>
              </div>
            </div>
          )}

          {step === 1 && (
            <div className="space-y-6">
              <div className="space-y-2">
                <Label htmlFor="totalAmount" className="text-lg">
                  Total Amount
                </Label>
                <Input
                  id="totalAmount"
                  type="number"
                  value={totalAmount}
                  onChange={(e) => setTotalAmount(e.target.value)}
                  placeholder="0.00"
                  className="text-2xl h-16 text-center"
                />
              </div>

              <Button size="lg" className="w-full" onClick={() => setStep(2)} disabled={!validateStep1()}>
                Next: Assign Donors
              </Button>
            </div>
          )}

          {step === 2 && (
            <div className="space-y-6">
              {donorEntries.map((entry, index) => (
                <Card key={index} className="p-4">
                  <div className="space-y-4">
                    <div className="flex justify-between items-center">
                      <Label className="text-lg">Donor {index + 1}</Label>
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
                        placeholder="Search for a donor..."
                        value={entry.donorName || searchTerm}
                        onChange={(e) => {
                          if (!entry.donorId) {
                            setSearchTerm(e.target.value)
                          }
                        }}
                        disabled={!!entry.donorId}
                        className="pl-8"
                      />
                    </div>

                    {searchTerm.trim() && !entry.donorId && (
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
                                </li>
                              ))}
                            </ul>
                          )}
                          {!searchLoading && searchResults.length === 0 && (
                            <div className="p-2 text-muted-foreground">No donors found.</div>
                          )}
                        </CardContent>
                      </Card>
                    )}

                    {!entry.donorId && (
                      <Button
                        type="button"
                        variant="outline"
                        size="sm"
                        onClick={async () => {
                          if (!searchTerm.trim() || loading) return;
                          
                          const newDonorId = await handleCreateDonor(searchTerm)
                          if (newDonorId) {
                            const newDonor = searchResults.find((d) => d.id === newDonorId)
                            if (newDonor) {
                              handleSelectDonor(index, newDonor)
                            }
                          }
                        }}
                        disabled={!searchTerm.trim()}
                        className="w-full"
                      >
                        <UserPlus className="mr-2 h-4 w-4" /> Create New Donor
                      </Button>
                    )}

                    <div className="space-y-2">
                      <Label htmlFor={`amount-${index}`}>Amount</Label>
                      <Input
                        id={`amount-${index}`}
                        type="number"
                        value={entry.amount}
                        onChange={(e) => {
                          const newEntries = [...donorEntries]
                          newEntries[index].amount = e.target.value
                          setDonorEntries(newEntries)
                        }}
                        placeholder="0.00"
                      />
                    </div>
                  </div>
                </Card>
              ))}

              <div className="flex gap-4">
                <Button variant="outline" className="flex-1" onClick={handleAddDonorEntry}>
                  <Plus className="mr-2 h-4 w-4" /> Add Donor
                </Button>

                <Button size="lg" className="flex-1" onClick={handleSubmit} disabled={!validateStep2() || loading}>
                  {loading ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Submitting...
                    </>
                  ) : (
                    "Submit Remittance"
                  )}
                </Button>
              </div>

              <Button variant="ghost" onClick={() => setStep(1)} className="w-full">
                <ArrowLeft className="mr-2 h-4 w-4" /> Back to Total Amount
              </Button>
            </div>
          )}
        </div>

        {step === 2 && (
          <Card className="bg-muted">
            <CardContent className="p-4">
              <div className="flex justify-between font-medium">
                <span>Total Entered:</span>
                <span>
                  ₱
                  {donorEntries
                    .reduce((acc, entry) => acc + (Number.parseFloat(entry.amount) || 0), 0)
                    .toLocaleString()}
                </span>
              </div>
              <div className="flex justify-between mt-2">
                <span>Declared Total:</span>
                <span>₱{Number.parseFloat(totalAmount).toLocaleString()}</span>
              </div>
            </CardContent>
          </Card>
        )}
      </CardContent>
    </Card>
  )
}

/**
 * Utility function to debounce function calls
 * @param func - Function to debounce
 * @param delay - Delay in milliseconds
 */
function debounce(func: (...args: any[]) => void, delay: number) {
  let timeoutId: NodeJS.Timeout
  return (...args: any[]) => {
    clearTimeout(timeoutId)
    timeoutId = setTimeout(() => func(...args), delay)
  }
}

