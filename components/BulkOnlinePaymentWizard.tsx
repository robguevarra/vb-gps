/**
 * BulkOnlinePaymentWizard Component
 * 
 * A specialized wizard that allows missionaries to collect donations from multiple partners
 * using a single payment link, making it easier to handle group donations or family contributions.
 * 
 * Key Features:
 * - Multiple partner entry with amounts
 * - Single payment link generation for total amount
 * - Individual donation records for each partner
 * - Real-time partner search and creation
 * - Mobile-friendly interface
 */

"use client"

import { useState, useEffect, useCallback } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card"
import { createClient } from "@/utils/supabase/client"
import { Plus, Trash, CheckCircle, Loader2, ArrowLeft, Search, UserPlus, Mail, Phone, AlertCircle, Copy, Link as LinkIcon, Share2, X, CreditCard, Wallet } from "lucide-react"
import { toast } from "@/hooks/use-toast"
import { Progress } from "@/components/ui/progress"
import { z } from "zod"
import { Badge } from "@/components/ui/badge"

// Validation schema for partner entries
const partnerEntrySchema = z.object({
  donorId: z.string(),
  donorName: z.string().optional(),
  amount: z.string(),
  email: z.string().email().optional(),
  phone: z.string().optional(),
});

interface BulkOnlinePaymentWizardProps {
  /** ID of the missionary generating the payment link */
  missionaryId: string;
  /** Name of the missionary (for display purposes) */
  missionaryName: string;
  /** Optional title for the wizard */
  title?: string;
  /** Optional callback function to be called after successful link generation */
  onSuccess?: () => void;
  /** Optional callback function to be called after link generation failure */
  onError?: (error: string) => void;
}

interface Donor {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

interface DonorEntry {
  donorId: string;
  donorName?: string;
  amount: string;
  email?: string;
  phone?: string;
}

interface NewDonorForm {
  name: string;
  email: string;
  phone: string;
  showForm: boolean;
  emailError?: string;
}

export function BulkOnlinePaymentWizard({
  missionaryId,
  missionaryName,
  title = "Bulk Online Payment",
  onSuccess,
  onError
}: BulkOnlinePaymentWizardProps) {
  // Initialize Supabase client
  const supabase = createClient();

  // State Management
  const [step, setStep] = useState<1 | 2>(1);
  const [totalAmount, setTotalAmount] = useState("");
  const [donorEntries, setDonorEntries] = useState<DonorEntry[]>([
    { donorId: "", amount: "" }
  ]);
  const [loading, setLoading] = useState(false);
  const [searchTerms, setSearchTerms] = useState<string[]>([""]);
  const [searchResults, setSearchResults] = useState<Donor[]>([]);
  const [searchLoading, setSearchLoading] = useState(false);
  const [paymentLink, setPaymentLink] = useState<string | null>(null);
  const [linkCopied, setLinkCopied] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [newDonorForm, setNewDonorForm] = useState<NewDonorForm>({
    name: "",
    email: "",
    phone: "",
    showForm: false,
    emailError: undefined
  });
  // Add state for user authentication and profile
  const [userEmail, setUserEmail] = useState<string | null>(null);
  const [userName, setUserName] = useState<string | null>(null);
  const [profileLoading, setProfileLoading] = useState(false);
  const [profileError, setProfileError] = useState<string | null>(null);
  const [activeSearchIndex, setActiveSearchIndex] = useState<number | null>(null);

  // Check authentication and get user profile on component mount
  useEffect(() => {
    const getUserProfile = async (retryCount = 0) => {
      setProfileLoading(true);
      
      try {
        // First, check if the user is authenticated
        const { data: { user }, error: userError } = await supabase.auth.getUser();
        
        if (userError || !user) {
          console.error("Authentication error:", userError);
          return;
        }
        
        // Set user email from auth
        if (user.email) {
          setUserEmail(user.email);
        }
        
        // Try to get profile
        const { data: profile, error: profileError } = await supabase
          .from("profiles")
          .select("full_name, email")
          .eq("id", user.id)
          .single();
          
        if (!profileError && profile) {
          setUserName(profile.full_name);
          // Update email if available in profile
          if (profile.email) {
            setUserEmail(profile.email);
          }
        }
      } catch (error) {
        console.error("Exception in getUserProfile:", error);
        
        // Retry on unexpected errors
        if (retryCount < 3) {
          setTimeout(() => getUserProfile(retryCount + 1), 1000);
          return;
        }
      } finally {
        setProfileLoading(false);
      }
    };
    
    getUserProfile();
  }, []);

  // Debounced search function
  const debouncedSearch = useCallback(
    debounce(async (term: string) => {
      if (!term.trim()) {
        setSearchResults([]);
        return;
      }

      setSearchLoading(true);
      try {
        const { data, error } = await supabase
          .from("donors")
          .select("id, name, email, phone")
          .ilike("name", `%${term.trim()}%`)
          .limit(10);

        if (error) throw error;
        setSearchResults(data || []);
      } catch (error) {
        console.error("Partner search error:", error);
        toast({
          title: "Search Error",
          description: "Failed to search for partners",
          variant: "destructive"
        });
      } finally {
        setSearchLoading(false);
      }
    }, 300),
    []
  );

  // Add handleSearchPartners function
  const handleSearchPartners = (term: string, index: number) => {
    // Update the search term for the specific index
    const newSearchTerms = [...searchTerms];
    newSearchTerms[index] = term;
    setSearchTerms(newSearchTerms);
    
    // Call the debounced search with the term
    debouncedSearch(term);
  };

  // Search effect
  useEffect(() => {
    // Only search if there's an active search index
    if (activeSearchIndex !== null && searchTerms[activeSearchIndex]) {
      debouncedSearch(searchTerms[activeSearchIndex]);
    }
  }, [searchTerms, activeSearchIndex, debouncedSearch]);

  // Validation functions
  const validateStep1 = () => {
    const total = Number.parseFloat(totalAmount);
    return !isNaN(total) && total > 0;
  };

  const validateStep2 = () => {
    if (donorEntries.length === 0) return false;

    const sum = donorEntries.reduce((acc, entry) => {
      const amount = Number.parseFloat(entry.amount);
      return acc + (isNaN(amount) ? 0 : amount);
    }, 0);

    const totalAmountValue = Number.parseFloat(totalAmount);

    // Check if the first partner has a valid email (required for payment)
    // const primaryPartner = donorEntries[0];
    // const hasPrimaryEmail = primaryPartner && primaryPartner.email && primaryPartner.email.includes('@');

    // Validate that all entries have a valid donorId and amount
    const allEntriesValid = donorEntries.every(
      (entry) => {
        // Check if donorId exists and is not empty
        const hasValidDonorId = entry.donorId && String(entry.donorId).trim() !== "";
        
        // Check if amount is a valid positive number
        const amount = Number.parseFloat(entry.amount);
        const hasValidAmount = !isNaN(amount) && amount > 0;
        
        return hasValidDonorId && hasValidAmount;
      }
    );

    // Check if total matches sum of individual amounts (with small tolerance for floating point errors)
    const totalMatchesSum = Math.abs(sum - totalAmountValue) <= 0.01;

    return allEntriesValid && totalMatchesSum;
  };

  // Handler functions
  const handleSelectDonor = (index: number, donor: Donor) => {
    const newEntries = [...donorEntries];
    newEntries[index] = {
      ...newEntries[index],
      donorId: donor.id,
      donorName: donor.name,
      email: donor.email || "",
      phone: donor.phone || ""
    };
    setDonorEntries(newEntries);
    
    // Update the search term to show the selected donor name
    const newSearchTerms = [...searchTerms];
    newSearchTerms[index] = donor.name;
    setSearchTerms(newSearchTerms);
    
    setSearchResults([]);
  };

  const handleAddDonorEntry = () => {
    setDonorEntries([...donorEntries, { donorId: "", amount: "" }]);
    setSearchTerms([...searchTerms, ""]);
  };

  const handleRemoveDonorEntry = (index: number) => {
    setDonorEntries(donorEntries.filter((_, i) => i !== index));
    setSearchTerms(searchTerms.filter((_, i) => i !== index));
  };

  // Fix handleCreateDonor function
  const handleCreateDonor = async () => {
    if (!newDonorForm.name.trim() || loading) return;
    
    // Validate email
    if (!newDonorForm.email || !newDonorForm.email.includes('@')) {
      setNewDonorForm(prev => ({
        ...prev,
        emailError: "Please enter a valid email address"
      }));
      return;
    }

    setLoading(true);
    try {
      const { data: newDonor, error } = await supabase
        .from("donors")
        .insert({
          name: newDonorForm.name,
          email: newDonorForm.email,
          phone: newDonorForm.phone
        })
        .select("*")
        .single();

      if (error) throw error;

      if (newDonor) {
        // Find the active search index or default to 0
        const index = activeSearchIndex !== null ? activeSearchIndex : 0;
        handleSelectDonor(index, newDonor);
        setNewDonorForm({
          name: "",
          email: "",
          phone: "",
          showForm: false,
          emailError: undefined
        });
      }
    } catch (error) {
      console.error("Error creating partner:", error);
      toast({
        title: "Error",
        description: "Failed to create new partner. Please check your permissions or try again later.",
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };

  const generatePaymentLink = async () => {
    setLoading(true);
    setError(null);

    try {
      // Check if we have user email
      if (!userEmail) {
        throw new Error("No email found for payment contact. Please log in again or update your profile.");
      }

      // Format donor entries for storage in payment_details
      const donorDetails = donorEntries.map(entry => ({
        donorId: String(entry.donorId),
        donorName: entry.donorName || "Anonymous",
        amount: parseFloat(entry.amount),
        // Only include email if it's a valid email
        ...(entry.email ? { email: entry.email } : {}),
        ...(entry.phone ? { phone: entry.phone } : {})
      }));
      
      // Create the invoice with donor details stored in payment_details
      // Use the missionary's profile as the primary contact
      const response = await fetch("/api/xendit/create-invoice", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          donationType: "missionary",
          recipientId: missionaryId,
          amount: parseFloat(totalAmount),
          donor: {
            name: userName || missionaryName || "Missionary",
            email: userEmail,
          },
          notes: `Bulk donation for ${missionaryName} from multiple partners:\n` +
            donorEntries.map(d => `- ${d.donorName || "Anonymous"}: ₱${parseFloat(d.amount).toLocaleString()}`).join("\n"),
          // Add donor details to payment_details for webhook processing
          payment_details: {
            isBulkDonation: true,
            donors: donorDetails,
            recipientId: missionaryId,
            recipientName: missionaryName
          }
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        console.error("Payment link generation error:", errorData);
        
        // Provide a more user-friendly error message
        let errorMessage = "Failed to generate payment link";
        
        if (errorData.details && typeof errorData.details === 'string') {
          // Check for specific error types
          if (errorData.details.includes("payment methods are not available") || 
              errorData.details.includes("payment methods are currently unavailable")) {
            errorMessage = "Payment gateway configuration issue detected. Please try again later or contact support for assistance.";
          } else {
            errorMessage = errorData.details;
          }
        } else if (errorData.error) {
          errorMessage = errorData.error;
        }
        
        throw new Error(errorMessage);
      }

      const data = await response.json();
      setPaymentLink(data.invoiceUrl);
      
      // Store the invoice ID for status checking
      if (data.invoiceId) {
        localStorage.setItem(`payment_${missionaryId}`, JSON.stringify({
          invoiceId: data.invoiceId,
          amount: totalAmount,
          timestamp: new Date().toISOString(),
          partnerCount: donorEntries.length
        }));
      }
      
      // Move to step 2 to show success message
      setStep(2);
      
      // Automatically open the payment link in a new tab
      if (data.invoiceUrl) {
        // Open with specific parameters to ensure all payment options are available
        window.open(data.invoiceUrl, '_blank', 'noopener,noreferrer');
      }
      
      // Call onSuccess callback if provided
      if (onSuccess) {
        onSuccess();
      }
    } catch (error) {
      console.error("Error generating payment link:", error);
      setError(error instanceof Error ? error.message : "Unknown error");
      
      // Call onError callback if provided
      if (onError) {
        onError(error instanceof Error ? error.message : "Unknown error");
      }
    } finally {
      setLoading(false);
    }
  };

  // Add a function to handle the payment in the current window
  const handlePayNow = () => {
    if (!paymentLink) return;
    
    // Save current state to localStorage before navigating
    if (step === 2) {
      localStorage.setItem(`payment_state_${missionaryId}`, JSON.stringify({
        missionaryId: missionaryId,
        step: step,
        totalAmount: totalAmount,
        timestamp: new Date().toISOString()
      }));
      
      // Open payment page in a new tab with specific parameters to ensure all payment options are available
      window.open(paymentLink, '_blank', 'noopener,noreferrer');
    }
  };

  const copyToClipboard = async () => {
    if (!paymentLink) return;

    try {
      await navigator.clipboard.writeText(paymentLink);
      setLinkCopied(true);
      
      toast({
        title: "Link copied",
        description: "Payment link copied to clipboard",
      });

      setTimeout(() => setLinkCopied(false), 3000);
    } catch (error) {
      toast({
        title: "Copy failed",
        description: "Could not copy to clipboard. Please copy manually.",
        variant: "destructive",
      });
    }
  };

  const shareLink = async () => {
    if (!paymentLink) return;

    if (navigator.share) {
      try {
        await navigator.share({
          title: `Donation for ${missionaryName}`,
          text: `Please use this link to complete your donation to ${missionaryName}`,
          url: paymentLink,
        });
      } catch (error) {
        if (error instanceof Error && error.name !== "AbortError") {
          toast({
            title: "Share failed",
            description: "Could not share the payment link",
            variant: "destructive",
          });
        }
      }
    } else {
      copyToClipboard();
    }
  };

  const getTotalFromDonors = () => {
    return donorEntries.reduce((sum, entry) => {
      const amount = Number.parseFloat(entry.amount);
      return sum + (isNaN(amount) ? 0 : amount);
    }, 0);
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold">{title}</h2>
        {step === 2 && (
          <Button variant="outline" size="sm" onClick={() => {
            setStep(1);
            setPaymentLink(null);
            setError(null);
          }}>
            <ArrowLeft className="mr-2 h-4 w-4" />
            Create New Link
          </Button>
        )}
      </div>

      {step === 1 ? (
        <div className="space-y-6">
          {/* Step 1: Enter total amount */}
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="totalAmount">Total Amount (₱)</Label>
              <Input
                id="totalAmount"
                type="number"
                placeholder="0.00"
                value={totalAmount}
                onChange={(e) => setTotalAmount(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <div className="flex items-center justify-between">
                <Label>Partner Entries</Label>
              </div>

              <div className="space-y-4">
                {donorEntries.map((entry, index) => (
                  <div
                    key={index}
                    className={`p-4 border rounded-md ${
                      index === 0 ? "border-primary" : "border-input"
                    }`}
                  >
                    <div className="flex items-center justify-between mb-2">
                      <div className="flex items-center">
                        <span className="text-sm font-medium">
                          {index === 0 ? (
                            <Badge variant="outline" className="bg-primary/10">
                              Payment Contact
                            </Badge>
                          ) : (
                            `Partner ${index + 1}`
                          )}
                        </span>
                      </div>
                      {index > 0 && (
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleRemoveDonorEntry(index)}
                        >
                          <X className="h-4 w-4" />
                        </Button>
                      )}
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label htmlFor={`donor-${index}`}>Select Partner</Label>
                        <div className="relative">
                          {entry.donorId ? (
                            <div className="flex items-center">
                              <Input
                                id={`donor-${index}`}
                                value={entry.donorName || ""}
                                className="pr-10"
                                readOnly
                              />
                              <Button
                                type="button"
                                variant="ghost"
                                size="sm"
                                className="absolute right-0 top-0 h-full"
                                onClick={() => {
                                  // Clear the donor selection
                                  const newEntries = [...donorEntries];
                                  newEntries[index] = {
                                    ...newEntries[index],
                                    donorId: "",
                                    donorName: "",
                                    email: "",
                                    phone: ""
                                  };
                                  setDonorEntries(newEntries);
                                  
                                  // Clear the search term
                                  const newSearchTerms = [...searchTerms];
                                  newSearchTerms[index] = "";
                                  setSearchTerms(newSearchTerms);
                                }}
                              >
                                <X className="h-4 w-4" />
                              </Button>
                            </div>
                          ) : (
                            <>
                              <Input
                                id={`donor-${index}`}
                                placeholder="Search partners..."
                                value={searchTerms[index] || ""}
                                onChange={(e) => {
                                  handleSearchPartners(e.target.value, index);
                                }}
                                onFocus={() => setActiveSearchIndex(index)}
                              />
                              {activeSearchIndex === index && searchResults.length > 0 && (
                                <div className="absolute z-10 w-full mt-1 bg-white border rounded-md shadow-lg max-h-60 overflow-auto">
                                  {searchLoading ? (
                                    <div className="p-2 text-center">
                                      <Loader2 className="h-4 w-4 animate-spin mx-auto" />
                                    </div>
                                  ) : (
                                    <>
                                      {searchResults.map((donor) => (
                                        <div
                                          key={donor.id}
                                          className="p-2 hover:bg-gray-100 cursor-pointer"
                                          onClick={() => handleSelectDonor(index, donor)}
                                        >
                                          <div className="font-medium">{donor.name}</div>
                                          {donor.email && (
                                            <div className="text-xs text-gray-500">
                                              {donor.email}
                                            </div>
                                          )}
                                        </div>
                                      ))}
                                      <div
                                        className="p-2 hover:bg-gray-100 cursor-pointer border-t"
                                        onClick={() => {
                                          setNewDonorForm({
                                            ...newDonorForm,
                                            showForm: true,
                                          });
                                          // Clear the search term for the active index
                                          if (activeSearchIndex !== null) {
                                            const newSearchTerms = [...searchTerms];
                                            newSearchTerms[activeSearchIndex] = "";
                                            setSearchTerms(newSearchTerms);
                                          }
                                          setSearchResults([]);
                                        }}
                                      >
                                        <div className="flex items-center text-primary">
                                          <Plus className="h-4 w-4 mr-2" />
                                          Create New Partner
                                        </div>
                                      </div>
                                    </>
                                  )}
                                </div>
                              )}
                            </>
                          )}
                        </div>
                        {entry.donorName && !entry.donorId && (
                          <div className="text-sm font-medium mt-1">
                            {entry.donorName}
                          </div>
                        )}
                      </div>

                      <div className="space-y-2">
                        <Label htmlFor={`amount-${index}`}>Amount (₱)</Label>
                        <Input
                          id={`amount-${index}`}
                          type="number"
                          placeholder="0.00"
                          value={entry.amount}
                          onChange={(e) => {
                            const newEntries = [...donorEntries];
                            newEntries[index].amount = e.target.value;
                            setDonorEntries(newEntries);
                          }}
                        />
                      </div>
                    </div>

                    {/* Show email field for selected donor */}
                    {entry.donorId && (
                      <div className="mt-4">
                        <Label htmlFor={`email-${index}`}>Email (Optional)</Label>
                        <Input
                          id={`email-${index}`}
                          type="email"
                          placeholder="partner@example.com"
                          value={entry.email || ""}
                          onChange={(e) => {
                            const newEntries = [...donorEntries];
                            newEntries[index].email = e.target.value;
                            setDonorEntries(newEntries);
                          }}
                        />
                      </div>
                    )}
                  </div>
                ))}
                
                <Button
                  variant="outline"
                  className="w-full"
                  onClick={handleAddDonorEntry}
                  disabled={donorEntries.length >= 10}
                >
                  <Plus className="mr-2 h-4 w-4" />
                  Add Another Partner
                </Button>
              </div>
            </div>

            {/* Create New Partner Form */}
            {newDonorForm.showForm && (
              <div className="border rounded-md p-4 space-y-4">
                <div className="flex items-center justify-between">
                  <h3 className="text-sm font-medium">Create New Partner</h3>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() =>
                      setNewDonorForm({
                        ...newDonorForm,
                        showForm: false,
                      })
                    }
                  >
                    <X className="h-4 w-4" />
                  </Button>
                </div>

                <div className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="newDonorName">Name</Label>
                    <Input
                      id="newDonorName"
                      placeholder="Partner Name"
                      value={newDonorForm.name}
                      onChange={(e) =>
                        setNewDonorForm({
                          ...newDonorForm,
                          name: e.target.value,
                        })
                      }
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="newDonorEmail">Email</Label>
                    <Input
                      id="newDonorEmail"
                      type="email"
                      placeholder="partner@example.com"
                      value={newDonorForm.email}
                      onChange={(e) =>
                        setNewDonorForm({
                          ...newDonorForm,
                          email: e.target.value,
                          emailError: undefined,
                        })
                      }
                    />
                    {newDonorForm.emailError && (
                      <p className="text-sm text-red-500">
                        {newDonorForm.emailError}
                      </p>
                    )}
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="newDonorPhone">Phone (Optional)</Label>
                    <Input
                      id="newDonorPhone"
                      placeholder="Phone Number"
                      value={newDonorForm.phone}
                      onChange={(e) =>
                        setNewDonorForm({
                          ...newDonorForm,
                          phone: e.target.value,
                        })
                      }
                    />
                  </div>

                  <Button
                    className="w-full"
                    onClick={handleCreateDonor}
                    disabled={!newDonorForm.name}
                  >
                    Create Partner
                  </Button>
                </div>
              </div>
            )}

            <div className="pt-4 border-t">
              <div className="flex justify-between text-sm mb-2">
                <span>Total Amount:</span>
                <span className="font-medium">
                  ₱
                  {!isNaN(Number.parseFloat(totalAmount))
                    ? Number.parseFloat(totalAmount).toLocaleString()
                    : "0.00"}
                </span>
              </div>

              <div className="flex justify-between text-sm mb-4">
                <span>Total from Partners:</span>
                <span
                  className={
                    getTotalFromDonors() !== parseFloat(totalAmount) && !isNaN(parseFloat(totalAmount))
                      ? "text-red-500 font-medium"
                      : "font-medium"
                  }
                >
                  ₱{getTotalFromDonors().toLocaleString()}
                  {getTotalFromDonors() !== parseFloat(totalAmount) && !isNaN(parseFloat(totalAmount)) && (
                    <span className="ml-2 text-xs">
                      (Mismatch: ₱
                      {Math.abs(
                        getTotalFromDonors() - parseFloat(totalAmount)
                      ).toLocaleString()}
                      )
                    </span>
                  )}
                </span>
              </div>

              <Button
                className="w-full"
                size="lg"
                onClick={generatePaymentLink}
                disabled={!validateStep2() || loading || !userEmail}
              >
                {loading ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Processing Payment...
                  </>
                ) : (
                  <>
                    <Wallet className="mr-2 h-4 w-4" />
                    Pay Now (₱{
                      !isNaN(Number.parseFloat(totalAmount)) 
                        ? Number.parseFloat(totalAmount).toLocaleString() 
                        : "0.00"
                    })
                  </>
                )}
              </Button>
            </div>
          </div>

          {!userEmail && !profileLoading && (
            <div className="text-center text-sm text-red-500 mt-2">
              A valid email address is required to process payment.
            </div>
          )}

          {error && (
            <div className="bg-destructive/15 border border-destructive text-destructive px-4 py-3 rounded-md">
              <div className="flex items-start">
                <AlertCircle className="h-5 w-5 mr-2 mt-0.5" />
                <div>
                  <p className="font-medium">Error processing payment</p>
                  <p className="text-sm">{error}</p>
                </div>
              </div>
            </div>
          )}
        </div>
      ) : (
        <div className="space-y-6">
          {/* Step 2: Success */}
          <div className="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-md">
            <div className="flex items-start">
              <CheckCircle className="h-5 w-5 mr-2 mt-0.5 text-green-500" />
              <div>
                <p className="font-medium">Payment Link Generated</p>
                <p className="text-sm">
                  A payment page has been opened in a new tab. If it didn't open automatically or you're experiencing issues with payment options, please click the "Pay Now" button below to try again.
                </p>
              </div>
            </div>
          </div>

          <div className="space-y-4">
            <div className="p-4 border rounded-md">
              <h3 className="text-sm font-medium mb-2">Payment Details</h3>
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Total Amount:</span>
                  <span>
                    ₱
                    {!isNaN(Number.parseFloat(totalAmount))
                      ? Number.parseFloat(totalAmount).toLocaleString()
                      : "0.00"}
                  </span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Partners:</span>
                  <span>{donorEntries.length}</span>
                </div>
              </div>
            </div>

            <div className="space-y-2">
              <Button 
                className="w-full" 
                variant="default" 
                onClick={handlePayNow}
                size="lg"
              >
                <Wallet className="mr-2 h-4 w-4" />
                Pay Now
              </Button>
              
              <div className="flex gap-2 mt-2">
                <Button 
                  className="flex-1" 
                  variant="outline" 
                  size="sm"
                  onClick={copyToClipboard}
                >
                  <Copy className="mr-2 h-4 w-4" />
                  {linkCopied ? "Copied!" : "Copy Link"}
                </Button>
                
                <Button 
                  className="flex-1" 
                  variant="outline" 
                  size="sm"
                  onClick={shareLink}
                >
                  <Share2 className="mr-2 h-4 w-4" />
                  Share
                </Button>
              </div>
              
              <p className="text-xs text-center text-muted-foreground mt-2">
                You'll be redirected to our payment provider to complete your transaction securely.
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function debounce(func: (...args: any[]) => void, delay: number) {
  let timeoutId: NodeJS.Timeout;
  return (...args: any[]) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func(...args), delay);
  };
} 