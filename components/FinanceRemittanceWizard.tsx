/**
 * FinanceRemittanceWizard Component
 * 
 * A multi-step form wizard for finance officers to record manual (offline) donations 
 * with multiple donors for specific missionaries. This component is designed for the 
 * finance dashboard to handle church envelope donations.
 * 
 * Key Features:
 * - Three-step wizard interface:
 *   1. Missionary selection
 *   2. Total amount entry
 *   3. Donor distribution with dynamic donor entries
 * - Real-time donor search with debouncing
 * - New donor creation capability with email validation
 * - Amount validation and balancing
 * - Progress tracking
 * - Success animations
 * 
 * @component
 */

"use client"

import { useState, useEffect, useCallback, useRef } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { createClient } from "@/utils/supabase/client"
import { Plus, Trash, CheckCircle, Loader2, ArrowLeft, Search, UserPlus, Mail, Phone, AlertCircle } from "lucide-react"
import { toast } from "@/hooks/use-toast"
import { Progress } from "@/components/ui/progress"
import { createDonor } from "@/actions/donors" 
import { submitDonations } from "@/actions/donations"
import { useRouter } from "next/navigation"
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { createBrowserClient } from "@supabase/ssr"

/**
 * Props for the FinanceRemittanceWizard component
 */
interface FinanceRemittanceWizardProps {
  /** List of missionaries that can receive donations */
  missionaries: Array<{
    id: string;
    full_name: string;
    role?: string;
  }>;
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

export default function FinanceRemittanceWizard({ missionaries }: FinanceRemittanceWizardProps) {
  // Initialize router for refreshing the page after submission
  const router = useRouter();
  
  // Initialize Supabase client for database operations
  const supabase = createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );

  // Dialog state
  const [open, setOpen] = useState(false);
  
  // User state
  const [user, setUser] = useState<any>(null);
  
  // Wizard step state (1: Missionary selection, 2: Total amount, 3: Donor distribution)
  const [step, setStep] = useState<1 | 2 | 3>(1);
  
  // Form state
  const [missionaryId, setMissionaryId] = useState("");
  const [totalAmount, setTotalAmount] = useState("");
  const [notes, setNotes] = useState("");
  const [donorEntries, setDonorEntries] = useState<DonorEntry[]>([
    { donorId: "", amount: "" },
  ]);
  
  // UI state
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  
  // Donor search state
  const [searchTerm, setSearchTerm] = useState("");
  const [searchResults, setSearchResults] = useState<Donor[]>([]);
  const [searchLoading, setSearchLoading] = useState(false);
  const [donorSelected, setDonorSelected] = useState(false);
  const timeoutRef = useRef<NodeJS.Timeout | null>(null);
  
  // New donor form state
  const [newDonorForm, setNewDonorForm] = useState<NewDonorForm>({
    name: "",
    email: "",
    phone: "",
    showForm: false,
    emailError: undefined
  });
  
  // Error state
  const [formError, setFormError] = useState<string | null>(null);

  // Fetch the current session on mount
  useEffect(() => {
    async function getSession() {
      const {
        data: { session },
      } = await supabase.auth.getSession();
      if (session && session.user) {
        setUser(session.user);
      }
    }
    getSession();
  }, [supabase]);

  // Reset form when dialog is closed
  useEffect(() => {
    if (!open) {
      setStep(1);
      setMissionaryId("");
      setTotalAmount("");
      setNotes("");
      setDonorEntries([{ donorId: "", amount: "" }]);
      setSearchTerm("");
      setSearchResults([]);
      setFormError(null);
      setSuccess(false);
    }
  }, [open]);

  /**
   * Debounced search function to prevent excessive API calls
   * Searches for donors based on the input term
   */
  const debouncedSearch = useCallback(
    debounce(async (term: string) => {
      setSearchLoading(true);
      try {
        if (!term.trim()) {
          // If search term is empty, fetch recent donors
          const { data, error } = await supabase
            .from("donors")
            .select("id, name, email, phone")
            .order("created_at", { ascending: false })
            .limit(10);
            
          if (!error) {
            setSearchResults(data || []);
          }
        } else {
          // Use API endpoint for searching donors
          const res = await fetch(`/api/donors/suggestions?search=${encodeURIComponent(term)}`);
          if (res.ok) {
            const data = await res.json();
            setSearchResults(data.donors || []);
          } else {
            setSearchResults([]);
          }
        }
      } catch (error) {
        toast({ title: "Search Error", description: "Failed to fetch partners" });
      } finally {
        setSearchLoading(false);
      }
    }, 300),
    [],
  );

  // Trigger donor search when search term changes
  useEffect(() => {
    if (searchTerm) {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
      timeoutRef.current = setTimeout(() => {
        debouncedSearch(searchTerm);
      }, 300);
    } else {
      setSearchResults([]);
    }
    
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, [searchTerm, debouncedSearch]);

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
   * Handles the selection of a donor from the search results
   */
  const handleSuggestionClick = (donor: Donor, index: number) => {
    const newEntries = [...donorEntries];
    newEntries[index] = { 
      ...newEntries[index], 
      donorId: donor.id, 
      donorName: donor.name 
    };
    setDonorEntries(newEntries);
    setSearchTerm("");
    setSearchResults([]);
    setDonorSelected(true);
  };

  /**
   * Creates a new donor in the database using server action
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
  };

  /**
   * Adds a new empty donor entry to the form
   */
  const handleAddDonorEntry = () => {
    setDonorEntries([...donorEntries, { donorId: "", amount: "", donorName: "" }]);
  };

  /**
   * Removes a donor entry from the form
   */
  const handleRemoveDonorEntry = (index: number) => {
    setDonorEntries(donorEntries.filter((_, i) => i !== index));
  };

  /**
   * Validates the missionary selection in step 1
   */
  const validateStep1 = () => {
    return missionaryId.trim() !== "";
  };

  /**
   * Validates the total amount entry in step 2
   */
  const validateStep2 = () => {
    const total = Number.parseFloat(totalAmount);
    return !isNaN(total) && total > 0;
  };

  /**
   * Validates the donor distribution in step 3
   */
  const validateStep3 = () => {
    const sum = donorEntries.reduce((acc, entry) => {
      const amount = Number.parseFloat(entry.amount);
      return acc + (isNaN(amount) ? 0 : amount);
    }, 0);

    return (
      Math.abs(sum - Number.parseFloat(totalAmount)) <= 0.01 &&
      donorEntries.every(
        (entry) =>
          String(entry.donorId).trim() !== "" &&
          !isNaN(Number.parseFloat(entry.amount)) &&
          Number.parseFloat(entry.amount) > 0,
      )
    );
  };

  /**
   * Handles the final submission of the remittance
   */
  const handleSubmit = async () => {
    if (loading) return; // Prevent multiple submissions
    
    // Ensure the user session is loaded
    if (!user) {
      setFormError("User session not loaded. Please try again.");
      return;
    }
    
    setFormError(null);
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
          recorded_by: user.id, // Important: Set the recorded_by field
          notes: notes,
        };
      });

      // Use the server action for submission
      const result = await submitDonations(entries);

      // Add diagnostic logging
      console.log("[FinanceRemittanceWizard] Submission result:", result);
      if (result.logs) {
        console.log("[FinanceRemittanceWizard] Server logs:", result.logs);
      }

      if (!result.success) {
        throw new Error(result.error || "Unknown error occurred");
      }

      // Show success state
      setSuccess(true);
      
      // Show appropriate toast message
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
      
      // Close dialog and refresh page after a delay
      setTimeout(() => {
        setOpen(false);
        router.refresh();
      }, 2000);
      
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'An unknown error occurred';
      setFormError(errorMessage);
      toast({
        title: "Submission failed",
        description: errorMessage,
        variant: "destructive",
      });
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

  // Calculate progress percentage based on current step
  const progressValue = step === 1 ? 33 : step === 2 ? 66 : 100;

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button>Record Donation</Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[600px] md:max-w-[700px]">
        <DialogHeader>
          <DialogTitle className="text-2xl font-bold text-center">Record Church Envelope Donation</DialogTitle>
        </DialogHeader>
        
        <div className="space-y-6 py-4">
          <Progress value={progressValue} className="w-full" />

          <p className="text-center text-muted-foreground">
            {step === 1 ? "Select Missionary" : 
             step === 2 ? "Enter total amount" : 
             "Distribute donations to partners"}
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

            {/* Step 1: Missionary Selection */}
            {step === 1 && (
              <div className="space-y-6">
                <div className="space-y-2">
                  <Label htmlFor="missionary" className="text-lg">
                    Select Missionary
                  </Label>
                  <select
                    id="missionary"
                    value={missionaryId}
                    onChange={(e) => setMissionaryId(e.target.value)}
                    required
                    className="w-full rounded-md border p-2 h-12"
                  >
                    <option value="">Select Missionary</option>
                    {missionaries.map((m) => (
                      <option key={m.id} value={m.id}>
                        {m.full_name} {m.role ? `(${m.role.replace(/_/g, " ")})` : ""}
                      </option>
                    ))}
                  </select>
                </div>

                <Button 
                  size="lg" 
                  className="w-full" 
                  onClick={() => setStep(2)} 
                  disabled={!validateStep1()}
                >
                  Next: Enter Amount
                </Button>
              </div>
            )}

            {/* Step 2: Total Amount */}
            {step === 2 && (
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

                <div className="flex gap-4">
                  <Button variant="outline" className="flex-1" onClick={() => setStep(1)}>
                    <ArrowLeft className="mr-2 h-4 w-4" /> Back
                  </Button>
                  <Button 
                    size="lg" 
                    className="flex-1" 
                    onClick={() => setStep(3)} 
                    disabled={!validateStep2()}
                  >
                    Next: Assign Partners
                  </Button>
                </div>
              </div>
            )}

            {/* Step 3: Donor Distribution */}
            {step === 3 && (
              <div className="space-y-6">
                <div className="space-y-2">
                  <Label htmlFor="notes" className="text-lg">
                    Notes (Optional)
                  </Label>
                  <Input
                    id="notes"
                    value={notes}
                    onChange={(e) => setNotes(e.target.value)}
                    placeholder="Add any additional notes about this donation"
                  />
                </div>
                
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
                              setSearchTerm(e.target.value);
                              setDonorSelected(false);
                              // Update the new donor form name as well
                              setNewDonorForm(prev => ({
                                ...prev,
                                name: e.target.value
                              }));
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
                              <ul className="space-y-1 max-h-40 overflow-y-auto">
                                {searchResults.map((donor) => (
                                  <li
                                    key={donor.id}
                                    className="p-2 hover:bg-accent rounded-md cursor-pointer transition-colors"
                                    onClick={() => handleSuggestionClick(donor, index)}
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
                          step="0.01"
                          value={entry.amount}
                          onChange={(e) => {
                            const newEntries = [...donorEntries];
                            newEntries[index].amount = e.target.value;
                            setDonorEntries(newEntries);
                          }}
                          placeholder="0.00"
                        />
                      </div>
                    </div>
                  </Card>
                ))}

                {formError && (
                  <div className="text-red-500 text-sm p-2 bg-red-50 rounded-md border border-red-200">
                    {formError}
                  </div>
                )}

                <div className="flex gap-4">
                  <Button variant="outline" className="flex-1" onClick={handleAddDonorEntry}>
                    <Plus className="mr-2 h-4 w-4" /> Add Partner
                  </Button>

                  <Button 
                    size="lg" 
                    className="flex-1" 
                    onClick={handleSubmit} 
                    disabled={!validateStep3() || loading || !user}
                  >
                    {loading ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Submitting...
                      </>
                    ) : (
                      "Submit Remittance"
                    )}
                  </Button>
                </div>

                <Button variant="ghost" onClick={() => setStep(2)} className="w-full">
                  <ArrowLeft className="mr-2 h-4 w-4" /> Back to Total Amount
                </Button>

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
                      <span>₱{Number.parseFloat(totalAmount || "0").toLocaleString()}</span>
                    </div>
                  </CardContent>
                </Card>
              </div>
            )}
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}

/**
 * Utility function to debounce function calls
 * @param func - Function to debounce
 * @param delay - Delay in milliseconds
 */
function debounce(func: (...args: any[]) => void, delay: number) {
  let timeoutId: NodeJS.Timeout;
  return (...args: any[]) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func(...args), delay);
  };
} 