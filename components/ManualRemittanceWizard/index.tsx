"use client"

import { useState, useEffect, useCallback, memo } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { createClient } from "@/utils/supabase/client"
import { CheckCircle } from "lucide-react"
import { toast } from "@/hooks/use-toast"
import { Progress } from "@/components/ui/progress"
import { createDonor } from "@/actions/donors" // Import the server action
import { submitDonations } from "@/actions/donations" // Import the donation submission action
import { TotalAmountStep } from "./TotalAmountStep"
import { DonorAllocationStep } from "./DonorAllocationStep"
import { debounce } from "../utils/validation"
import { ManualRemittanceWizardProps, Donor, DonorEntry, NewDonorForm } from "./types"
import { trackPerformance } from "@/utils/performance"

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
 * - New donor creation capability with optional email and phone
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
function ManualRemittanceWizardComponent({ 
  userId, 
  title = "Manual Remittance",
  onSuccess,
  onError
}: ManualRemittanceWizardProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('ManualRemittanceWizard');
    return endTracking;
  }, []);

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
  const [searchMode, setSearchMode] = useState<"previous" | "all">("previous")
  const [newDonorForm, setNewDonorForm] = useState<NewDonorForm>({
    name: "",
    email: "",
    phone: "",
    showForm: false,
    emailError: undefined
  })

  /**
   * Debounced search function to prevent excessive API calls
   * Searches for donors based on the input term
   * First searches for donors who have previously given to this missionary,
   * then allows searching from all donors
   */
  const debouncedSearch = useCallback(
    debounce(async (term: string) => {
      setSearchLoading(true)
      try {
        if (searchMode === "previous") {
          // First search for donors who have previously given to this missionary
          const { data: previousDonors, error: previousError } = await supabase
            .from("donor_donations")
            .select(`
              donor_id,
              donors:donor_id(id, name, email, phone)
            `)
            .eq("missionary_id", userId)
            .order("date", { ascending: false })
            
          if (previousError) {
            console.error("Error fetching previous donors:", previousError)
          } else if (previousDonors && previousDonors.length > 0) {
            // Extract unique donors from the results
            const uniqueDonors: Donor[] = []
            const donorIds = new Set()
            
            previousDonors.forEach(item => {
              if (item.donors && typeof item.donors === 'object' && 'id' in item.donors) {
                const donor = item.donors as unknown as Donor
                if (!donorIds.has(donor.id)) {
                  donorIds.add(donor.id)
                  
                  // Only include donors that match the search term if one is provided
                  if (!term.trim() || donor.name.toLowerCase().includes(term.toLowerCase())) {
                    uniqueDonors.push(donor)
                  }
                }
              }
            })
            
            setSearchResults(uniqueDonors)
            setSearchLoading(false)
            return
          }
        }
        
        // If no previous donors found or searchMode is "all", search all donors
        let query = supabase.from("donors").select("id, name, email, phone")

        if (term.trim()) {
          // Use ilike for case-insensitive matching with wildcards
          query = query.ilike("name", `%${term.trim()}%`)
        } else {
          query = query.order("created_at", { ascending: false }).limit(10)
        }

        const { data, error } = await query
        if (!error) {
          setSearchResults(data || [])
        } else {
          console.error("Error searching donors:", error)
        }
      } catch (error) {
        toast({ title: "Search Error", description: "Failed to fetch partners" })
      } finally {
        setSearchLoading(false)
      }
    }, 300),
    [userId, searchMode, supabase],
  )

  // Trigger donor search when search term changes
  useEffect(() => {
    debouncedSearch(searchTerm)
  }, [searchTerm, debouncedSearch])

  /**
   * Validates the email in the new donor form
   * @returns True if the email is valid, false otherwise
   */
  const validateEmail = (): boolean => {
    if (!newDonorForm.email) return true; // Empty email is valid (it's optional)
    
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(newDonorForm.email)) {
      setNewDonorForm(prev => ({
        ...prev,
        emailError: "Please enter a valid email address"
      }));
      return false;
    }
    
    setNewDonorForm(prev => ({
      ...prev,
      emailError: undefined
    }));
    return true;
  };

  /**
   * Handles the selection of a donor from the search results
   * @param index - Index of the donor entry being modified
   * @param donor - Selected donor object
   */
  const handleSelectDonor = (index: number, donor: Donor) => {
    const newEntries = [...donorEntries]
    newEntries[index] = { 
      ...newEntries[index], 
      donorId: donor.id, 
      donorName: donor.name 
    }
    setDonorEntries(newEntries)
    setSearchTerm("")
    setSearchResults([])
    // Reset new donor form
    setNewDonorForm({
      name: "",
      email: "",
      phone: "",
      showForm: false,
      emailError: undefined
    })
    // Reset search mode to previous for next search
    setSearchMode("previous")
  }

  /**
   * Creates a new donor in the database using server action
   * @param name - Name of the new donor
   * @param email - Optional email of the new donor
   * @param phone - Optional phone number of the new donor
   * @param index - Index of the donor entry to update after creation
   */
  const handleCreateAndSelectDonor = async (name: string, email: string, phone: string, index: number) => {
    if (!name.trim() || loading) return;
    
    // Validate email before proceeding
    if (!validateEmail()) return;
    
    setLoading(true);
    try {
      // Use the server action instead of client-side Supabase
      const result = await createDonor(name, email, phone);

      if (result.error) {
        throw new Error(result.error);
      }

      const newDonor = result.donor;
      
      if (newDonor) {
        // Directly update the donor entry with the new donor
        const newEntries = [...donorEntries];
        newEntries[index] = { 
          ...newEntries[index], 
          donorId: newDonor.id, 
          donorName: newDonor.name 
        };
        setDonorEntries(newEntries);
        
        // Reset search and form state
        setSearchTerm("");
        setSearchResults([]);
        setNewDonorForm({
          name: "",
          email: "",
          phone: "",
          showForm: false,
          emailError: undefined
        });
        
        toast({ 
          title: "Partner created", 
          description: `${newDonor.name} has been added successfully.` 
        });
      }
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'An unknown error occurred';
      toast({ 
        title: "Error creating partner", 
        description: errorMessage, 
        variant: "destructive" 
      });
    } finally {
      setLoading(false);
    }
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
   * Updates a specific donor entry
   * @param index - Index of the donor entry to update
   * @param entry - Partial donor entry with fields to update
   */
  const updateDonorEntry = (index: number, entry: Partial<DonorEntry>) => {
    const newEntries = [...donorEntries]
    newEntries[index] = { ...newEntries[index], ...entry }
    setDonorEntries(newEntries)
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
          missionary_id: userId,
          date: new Date().toISOString(),
          source: "offline" as const,
          status: "completed" as const,
          recorded_by: userId
        };
      });

      // Use the server action for donation submission
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

      // Show success message
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
      
      // Call the onSuccess callback if provided
      if (onSuccess) {
        onSuccess();
      }
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'An unknown error occurred';
      toast({
        title: "Submission failed",
        description: errorMessage,
        variant: "destructive",
      });
      
      // Call the onError callback if provided
      if (onError) {
        onError(errorMessage);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle className="text-2xl font-bold text-center">{title}</CardTitle>
      </CardHeader>
      <CardContent className="space-y-6">
        <Progress value={step === 1 ? 50 : 100} className="w-full" />

        <p className="text-center text-muted-foreground">
          {step === 1 ? "Enter total amount" : "Distribute donations to partners"}
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
            <TotalAmountStep
              totalAmount={totalAmount}
              setTotalAmount={setTotalAmount}
              onNext={() => setStep(2)}
              isValid={validateStep1()}
            />
          )}

          {step === 2 && (
            <DonorAllocationStep
              donorEntries={donorEntries}
              totalAmount={totalAmount}
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
              handleAddDonorEntry={handleAddDonorEntry}
              handleRemoveDonorEntry={handleRemoveDonorEntry}
              updateDonorEntry={updateDonorEntry}
              handleSubmit={handleSubmit}
              goBack={() => setStep(1)}
              isValid={validateStep2()}
            />
          )}
        </div>
      </CardContent>
    </Card>
  )
}

// Memoize the component to prevent unnecessary re-renders
export const ManualRemittanceWizard = memo(ManualRemittanceWizardComponent)