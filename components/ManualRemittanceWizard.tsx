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

"use client"

import { useState, useEffect, useCallback } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { createClient } from "@/utils/supabase/client"
import { Plus, Trash, CheckCircle, Loader2, ArrowLeft, Search, UserPlus, Mail, Phone, AlertCircle } from "lucide-react"
import { toast } from "@/hooks/use-toast"
import { Progress } from "@/components/ui/progress"
import { PostgrestError } from "@supabase/supabase-js"
import { createDonor } from "@/actions/donors" // Import the server action
import { submitDonations } from "@/actions/donations" // Import the donation submission action

/**
 * Props for the ManualRemittanceWizard component
 */
interface ManualRemittanceWizardProps {
  /** ID of the user for whom the remittance is being recorded */
  userId: string;
  /** Optional title for the wizard */
  title?: string;
  /** Optional callback function to be called after successful submission */
  onSuccess?: () => void;
  /** Optional callback function to be called after submission failure */
  onError?: (error: string) => void;
}

/**
 * Interface representing a donor in the system
 */
interface Donor {
  /** Unique identifier for the donor */
  id: string;
  /** Full name of the donor */
  name: string;
  /** Optional email of the donor */
  email?: string;
  /** Optional phone number of the donor */
  phone?: string;
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

/**
 * Interface for new donor form data
 */
interface NewDonorForm {
  name: string;
  email: string;
  phone: string;
  showForm: boolean;
  emailError?: string;
}

/**
 * Validates an email address
 * @param email - Email address to validate
 * @returns True if the email is valid, false otherwise
 */
const isValidEmail = (email: string): boolean => {
  if (!email) return true; // Empty email is considered valid (it's optional)
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

export function ManualRemittanceWizard({ 
  userId, 
  title = "Manual Remittance",
  onSuccess,
  onError
}: ManualRemittanceWizardProps) {
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
    [userId, searchMode],
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
    
    if (!isValidEmail(newDonorForm.email)) {
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
   * Creates a new donor in the database using server action
   * @param name - Name of the new donor
   * @param email - Optional email of the new donor
   * @param phone - Optional phone number of the new donor
   * @returns The newly created donor or null if creation failed
   */
  const handleCreateDonor = async (name: string, email?: string, phone?: string) => {
    setLoading(true)
    try {
      // First check if donor with this name already exists in the database
      const { data: existingDonors, error: searchError } = await supabase
        .from("donors")
        .select("id, name, email, phone")
        .ilike("name", name.trim())
        .limit(1)
        
      if (!searchError && existingDonors && existingDonors.length > 0) {
        // Donor already exists, return it
        return existingDonors[0]
      }
      
      // Use the server action instead of client-side Supabase
      const result = await createDonor(name, email, phone)

      if (result.error) {
        throw new Error(result.error)
      }

      const newDonor = result.donor
      
      if (newDonor) {
        // Immediately add the new donor to search results to ensure it's available
        setSearchResults(prevResults => {
          // Check if donor already exists in results to avoid duplicates
          const exists = prevResults.some(d => d.id === newDonor.id);
          if (!exists) {
            return [newDonor, ...prevResults];
          }
          return prevResults;
        });
        
        // Force a refresh of the search results
        setTimeout(() => {
          debouncedSearch(name.trim())
        }, 500)
        
        return newDonor
      }
      return null
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'An unknown error occurred'
      toast({ title: "Error creating partner", description: errorMessage, variant: "destructive" })
      return null
    } finally {
      setLoading(false)
    }
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
   * 
   * IMPORTANT IMPLEMENTATION NOTES:
   * 1. We use a server action (submitDonations) that bypasses RLS restrictions
   * 2. The key fix was adding the 'recorded_by' field in the server action
   * 3. We prevent multiple submissions with loading state
   * 4. We provide detailed feedback to users based on success/failure
   * 5. Detailed logs are available for debugging but hidden from users
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
          missionary_id: userId, // Use the userId prop instead of hardcoded missionaryId
          date: new Date().toISOString(),
          source: "offline" as const,
          status: "completed" as const,
          recorded_by: userId // Add the recorded_by field to fix the type error
        };
      });

      // Use the server action instead of client-side Supabase
      const result = await submitDonations(entries);

      // Display detailed logs for debugging - can be removed in production
      // if (result.logs) {
      //   console.log("Donation submission logs:", result.logs);
      // }

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

  // Handle email input change with validation
  const handleEmailChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const email = e.target.value;
    setNewDonorForm(prev => ({ 
      ...prev, 
      email,
      emailError: email && !isValidEmail(email) ? "Please enter a valid email address" : undefined
    }));
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
                Next: Assign Partners
              </Button>
            </div>
          )}

          {step === 2 && (
            <div className="space-y-6">
              {donorEntries.map((entry, index) => (
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
                          
                          {/* Add toggle button to switch between search modes */}
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
                            <Label htmlFor="newDonorName">Partner Name</Label>
                            <Input
                              id="newDonorName"
                              value={newDonorForm.name}
                              onChange={(e) => setNewDonorForm(prev => ({ ...prev, name: e.target.value }))}
                              placeholder="Full Name"
                            />
                          </div>
                          
                          <div className="space-y-2">
                            <Label htmlFor="newDonorEmail" className="flex items-center">
                              <Mail className="h-4 w-4 mr-1" /> Email (Optional)
                            </Label>
                            <div className="relative">
                              <Input
                                id="newDonorEmail"
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
                            <Label htmlFor="newDonorPhone" className="flex items-center">
                              <Phone className="h-4 w-4 mr-1" /> Phone (Optional)
                            </Label>
                            <Input
                              id="newDonorPhone"
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
                  <Plus className="mr-2 h-4 w-4" /> Add Partner
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

