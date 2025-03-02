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

import { useState, useEffect, useCallback, useRef } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card"
import { createClient } from "@/utils/supabase/client"
import { Plus, Trash, CheckCircle, Loader2, ArrowLeft, Search, UserPlus, Mail, Phone, AlertCircle, Copy, Link as LinkIcon, Share2, X, CreditCard, Wallet, ExternalLink } from "lucide-react"
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
  // Add state to track which partner box initiated the form
  const [formOriginIndex, setFormOriginIndex] = useState<number | null>(null);

  // Use an array of refs for dropdowns
  const dropdownRefs = useRef<(HTMLDivElement | null)[]>([]);

  // Update refs array when donor entries change
  useEffect(() => {
    // Resize the refs array to match the number of donor entries
    dropdownRefs.current = dropdownRefs.current.slice(0, donorEntries.length);
    // Fill with nulls if needed
    while (dropdownRefs.current.length < donorEntries.length) {
      dropdownRefs.current.push(null);
    }
  }, [donorEntries.length]);

  // Handle clicking outside the dropdowns
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      // If clicked outside all dropdowns, close the active one
      const clickedInsideAnyDropdown = dropdownRefs.current.some(
        (ref) => ref && ref.contains(event.target as Node)
      );
      
      if (!clickedInsideAnyDropdown) {
        setActiveSearchIndex(null);
      }
    }

    // Add event listener
    document.addEventListener("mousedown", handleClickOutside);
    
    // Clean up
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

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
          .select("full_name")
          .eq("id", user.id)
          .single();
          
        if (!profileError && profile) {
          setUserName(profile.full_name);
          // We already have email from auth, no need to get it from profile
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

  // Direct search function (not debounced) for immediate results
  const searchPartners = async (term: string) => {
    if (!term || !term.trim()) {
      setSearchResults([]);
      return;
    }

    setSearchLoading(true);
    try {
      // Add a stronger cache-busting mechanism with a random value
      const timestamp = new Date().getTime();
      const random = Math.random().toString(36).substring(2, 15);
      
      // Use the API endpoint with cache-busting parameters
      const response = await fetch(`/api/donors?search=${encodeURIComponent(term.trim())}&_t=${timestamp}&_r=${random}`, {
        // Add cache control headers
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0'
        }
      });
      
      if (!response.ok) {
        throw new Error('Failed to search partners');
      }
      
      const result = await response.json();
      console.log("Search results count:", result.donors?.length || 0);
      setSearchResults(result.donors || []);
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
  };
  
  // Debounced search function
  const debouncedSearch = useCallback(
    debounce(async (term: string) => {
      if (!term || !term.trim()) {
        setSearchResults([]);
        return;
      }

      setSearchLoading(true);
      try {
        // Add a stronger cache-busting mechanism with a random value
        const timestamp = new Date().getTime();
        const random = Math.random().toString(36).substring(2, 15);
        
        // Use the API endpoint with cache-busting parameters
        const response = await fetch(`/api/donors?search=${encodeURIComponent(term.trim())}&_t=${timestamp}&_r=${random}`, {
          // Add cache control headers
          headers: {
            'Cache-Control': 'no-cache, no-store, must-revalidate',
            'Pragma': 'no-cache',
            'Expires': '0'
          }
        });
        
        if (!response.ok) {
          throw new Error('Failed to search partners');
        }
        
        const result = await response.json();
        console.log("Debounced search results count:", result.donors?.length || 0);
        setSearchResults(result.donors || []);
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
    // Update the donor entry
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
    
    // Close the dropdown
    setActiveSearchIndex(null);
    
    // Clear search results
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
    if (!newDonorForm.name.trim()) {
      setNewDonorForm({
        ...newDonorForm,
        emailError: "Partner name is required"
      });
      return;
    }
    
    // Validate email format if provided
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (newDonorForm.email && !emailRegex.test(newDonorForm.email)) {
      setNewDonorForm({
        ...newDonorForm,
        emailError: "Please enter a valid email address"
      });
      return;
    }

    setLoading(true);
    try {
      // Check if a partner with this name or email already exists
      const searchResponse = await fetch(`/api/donors?search=${encodeURIComponent(newDonorForm.name.trim())}`);
      
      if (searchResponse.ok) {
        const searchResult = await searchResponse.json();
        const existingDonors = searchResult.donors || [];
        
        // Check for exact name match
        const exactNameMatch = existingDonors.find(
          (donor: Donor) => donor.name.toLowerCase() === newDonorForm.name.trim().toLowerCase()
        );
        
        // Check for email match if email is provided
        const emailMatch = newDonorForm.email ? 
          existingDonors.find(
            (donor: Donor) => donor.email && donor.email.toLowerCase() === newDonorForm.email.toLowerCase()
          ) : null;
          
        if (exactNameMatch) {
          setNewDonorForm({
            ...newDonorForm,
            emailError: `A partner with the name "${newDonorForm.name}" already exists. Please use a different name or select the existing partner.`
          });
          setLoading(false);
          return;
        }
        
        if (emailMatch) {
          setNewDonorForm({
            ...newDonorForm,
            emailError: `A partner with the email "${newDonorForm.email}" already exists. Please use a different email or select the existing partner.`
          });
          setLoading(false);
          return;
        }
      }

      // Create a new donor
      const response = await fetch("/api/donors", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          name: newDonorForm.name,
          email: newDonorForm.email,
          phone: newDonorForm.phone,
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || "Failed to create partner");
      }

      // Parse the response to get the new donor
      const responseData = await response.json();
      
      // Extract the donor object from the response
      // The API might return either { donor } or the donor object directly
      const newDonor = responseData.donor || responseData;
      
      console.log("New partner created successfully");
      
      // Get the index where we want to add the new donor
      const targetIndex = formOriginIndex !== null ? formOriginIndex : 0;
      
      // Create a copy of the donor entries
      const newDonorEntries = [...donorEntries];
      
      // Update the donor entry at the target index
      newDonorEntries[targetIndex] = {
        ...newDonorEntries[targetIndex],
        donorId: newDonor.id,
        donorName: newDonor.name,
        email: newDonor.email || "",
        phone: newDonor.phone || ""
      };
      
      // Update the donor entries state
      setDonorEntries(newDonorEntries);
      
      // Update the search terms to show the selected donor name
      const newSearchTerms = [...searchTerms];
      newSearchTerms[targetIndex] = newDonor.name;
      setSearchTerms(newSearchTerms);
      
      // Reset form state
      setNewDonorForm({
        name: "",
        email: "",
        phone: "",
        showForm: false,
        emailError: undefined
      });
      
      // Reset form origin index
      setFormOriginIndex(null);
      
      // Show success toast
      toast({
        title: "Success",
        description: "Partner created successfully",
      });
      
      // IMPORTANT: Instead of trying to refresh the search results,
      // we'll directly select the newly created partner
      // This bypasses any issues with search result caching
      handleSelectDonor(targetIndex, newDonor);
      
      // Also perform a search to update the search results for future searches
      // This ensures the new partner will appear in future searches
      setTimeout(() => {
        searchPartners(newDonor.name);
      }, 500);
    } catch (error) {
      console.error("Error creating partner:", error);
      
      toast({
        title: "Error",
        description: error instanceof Error ? error.message : "Failed to create partner",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const generatePaymentLink = async () => {
    setLoading(true);
    setError(null);

    try {
      // Clear any existing payment status before starting a new payment
      localStorage.removeItem(`payment_status_${missionaryId}`);
      localStorage.removeItem(`payment_state_${missionaryId}`);
      localStorage.removeItem(`payment_${missionaryId}`);
      
      // Clear any polling intervals
      const pollingId = localStorage.getItem(`payment_polling_${missionaryId}`);
      if (pollingId) {
        try {
          clearInterval(parseInt(pollingId));
        } catch (err) {
          console.error("Error clearing interval:", err);
        }
        localStorage.removeItem(`payment_polling_${missionaryId}`);
      }
      
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
      
      console.log("Creating invoice with donor count:", donorEntries.length);
      
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
      console.log("Received payment data from API - status:", data.status || "unknown");
      
      setPaymentLink(data.invoiceUrl);
      
      // Store the invoice ID for status checking
      if (data.invoiceId) {
        console.log(`Storing invoice ID in localStorage`);
        
        // Save payment info with both key formats to ensure compatibility
        const paymentInfo = {
          invoiceId: data.invoiceId,
          invoiceUrl: data.invoiceUrl,
          amount: totalAmount,
          timestamp: new Date().toISOString(),
          partnerCount: donorEntries.length
        };
        
        // Save with payment_ format (used by some functions)
        localStorage.setItem(`payment_${missionaryId}`, JSON.stringify(paymentInfo));
        
        // Also save with payment_state_ format (used by ManualRemittanceTab)
        const paymentState = {
          missionaryId: missionaryId,
          step: step,
          totalAmount: totalAmount,
          invoiceId: data.invoiceId,
          invoiceUrl: data.invoiceUrl,
          timestamp: new Date().toISOString()
        };
        localStorage.setItem(`payment_state_${missionaryId}`, JSON.stringify(paymentState));
        
        console.log("Payment state saved successfully");
      }
      
      // Move to step 2 to show success message
      setStep(2);
      
      // Automatically open the payment link in a new tab
      if (data.invoiceUrl) {
        console.log(`Opening payment link in new tab`);
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
    
    console.log(`Handling Pay Now request`);
    
    // Extract invoice ID from payment link
    // The link format is typically: https://checkout-staging.xendit.co/web/[invoice_id]
    const invoiceId = paymentLink.split('/').pop();
    console.log(`Invoice ID extracted`);
    
    // Save current state to localStorage before navigating
    if (step === 2) {
      const paymentState = {
        missionaryId: missionaryId,
        step: step,
        totalAmount: totalAmount,
        timestamp: new Date().toISOString(),
        invoiceId: invoiceId
      };
      
      console.log(`Saving payment state to localStorage`);
      localStorage.setItem(`payment_state_${missionaryId}`, JSON.stringify(paymentState));
      
      // Set payment status to pending
      const paymentStatus = {
        status: "pending",
        timestamp: new Date().toISOString(),
        invoiceId: paymentState.invoiceId,
        invoiceUrl: paymentLink // Store the direct URL
      };
      
      console.log(`Payment status set to pending`);
      localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify(paymentStatus));
      
      // Open payment page in a new tab with specific parameters to ensure all payment options are available
      console.log(`Opening payment link in new tab`);
      window.open(paymentLink, '_blank', 'noopener,noreferrer');
      
      // Start polling for payment status
      console.log("Starting payment status polling");
      startPaymentStatusPolling();
    }
  };
  
  // Add a function to poll for payment status
  const startPaymentStatusPolling = () => {
    // Try to get the invoice ID from different sources
    let invoiceId = null;
    
    // First, check payment_state
    const paymentStateStr = localStorage.getItem(`payment_state_${missionaryId}`);
    if (paymentStateStr) {
      try {
        const paymentState = JSON.parse(paymentStateStr);
        if (paymentState.invoiceId) {
          invoiceId = paymentState.invoiceId;
          console.log(`Found invoice ID in payment_state`);
        }
      } catch (err) {
        console.error("Error parsing payment_state:", err);
      }
    } else {
      console.log("No payment_state found in localStorage");
    }
    
    // If not found, check payment_ storage
    if (!invoiceId) {
      const paymentInfoStr = localStorage.getItem(`payment_${missionaryId}`);
      if (paymentInfoStr) {
        try {
          const paymentInfo = JSON.parse(paymentInfoStr);
          if (paymentInfo.invoiceId) {
            invoiceId = paymentInfo.invoiceId;
            console.log(`Found invoice ID in payment_info`);
          }
        } catch (err) {
          console.error("Error parsing payment_info:", err);
        }
      } else {
        console.log("No payment_info found in localStorage");
      }
    }
    
    // If still no invoice ID, try to extract from payment link
    if (!invoiceId && paymentLink) {
      invoiceId = paymentLink.split('/').pop();
      console.log(`Extracted invoice ID from payment link`);
    }
    
    if (!invoiceId) {
      console.log("No invoice ID found, cannot start polling");
      return;
    }
    
    console.log(`Starting payment status polling`);
    
    // Clear any existing interval first
    const existingPollingId = localStorage.getItem(`payment_polling_${missionaryId}`);
    if (existingPollingId) {
      clearInterval(parseInt(existingPollingId));
      console.log(`Cleared existing polling interval`);
    }
    
    // Set up an interval to check payment status every 5 seconds
    const intervalId = window.setInterval(async () => {
      console.log(`Polling payment status`);
      try {
        // First check payment_transactions table
        const { data: transactionData, error: transactionError } = await supabase
          .from("payment_transactions")
          .select("status, created_at, updated_at")
          .eq("invoice_id", invoiceId)
          .single();
          
        if (transactionError) {
          // If the error is a 406 (Not Acceptable) or 404 (Not Found), it might mean the transaction hasn't been created yet
          if (transactionError.code === "406" || transactionError.code === "404" || transactionError.code === "PGRST116") {
            console.log("Transaction not found yet (expected during payment processing)");
            
            // Try to check the status directly from Xendit API
            await checkXenditPaymentStatus(invoiceId);
          } else {
            console.error("Error checking payment_transactions:", transactionError);
          }
        } else if (transactionData) {
          console.log(`Found transaction with status: ${transactionData.status}`);
          
          // If payment is completed, update localStorage
          if (transactionData.status === "paid") {
            console.log(`Payment completed successfully`);
            localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
              status: "completed",
              timestamp: new Date().toISOString()
            }));
            
            // Clear the interval
            clearInterval(intervalId);
            localStorage.removeItem(`payment_polling_${missionaryId}`);
            console.log("Polling stopped: payment completed");
            
            // Auto-clear the payment status after 5 seconds
            setTimeout(() => {
              console.log("Auto-clearing completed payment status");
              // Clear ALL localStorage items related to payments
              localStorage.removeItem(`payment_status_${missionaryId}`);
              localStorage.removeItem(`payment_state_${missionaryId}`);
              localStorage.removeItem(`payment_${missionaryId}`);
              localStorage.removeItem(`payment_polling_${missionaryId}`);
            }, 5000); // 5 seconds
            
            return;
          } else if (transactionData.status === "expired" || transactionData.status === "failed") {
            console.log(`Payment failed or expired`);
            localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
              status: "failed",
              timestamp: new Date().toISOString()
            }));
            
            // Clear the interval
            clearInterval(intervalId);
            localStorage.removeItem(`payment_polling_${missionaryId}`);
            console.log("Polling stopped: payment failed or expired");
            return;
          } else {
            console.log(`Payment status is ${transactionData.status}, continuing to poll`);
          }
        }
        
        // Also check webhooks table as a backup
        const { data: webhookData, error: webhookError } = await supabase
          .from("webhooks")
          .select("payload")
          .eq("event_type", "invoice.paid")
          .order("created_at", { ascending: false })
          .limit(10);
          
        if (webhookError) {
          console.error("Error checking webhooks table:", webhookError);
        } else if (webhookData && webhookData.length > 0) {
          console.log(`Found ${webhookData.length} recent webhooks to check`);
          
          // Check if any of the webhooks contain our invoice ID
          for (const webhook of webhookData) {
            try {
              const payload = typeof webhook.payload === 'string' 
                ? JSON.parse(webhook.payload) 
                : webhook.payload;
                
              if (payload && payload.id === invoiceId) {
                console.log(`Found matching webhook`);
                
                if (payload.status === "PAID") {
                  console.log(`Webhook confirms payment completed`);
                  localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
                    status: "completed",
                    timestamp: new Date().toISOString()
                  }));
                  
                  // Clear the interval
                  clearInterval(intervalId);
                  localStorage.removeItem(`payment_polling_${missionaryId}`);
                  console.log("Polling stopped: payment completed (from webhook)");
                  
                  // Auto-clear the payment status after 5 seconds
                  setTimeout(() => {
                    console.log("Auto-clearing completed payment status");
                    // Clear ALL localStorage items related to payments
                    localStorage.removeItem(`payment_status_${missionaryId}`);
                    localStorage.removeItem(`payment_state_${missionaryId}`);
                    localStorage.removeItem(`payment_${missionaryId}`);
                    localStorage.removeItem(`payment_polling_${missionaryId}`);
                  }, 5000); // 5 seconds
                  
                  return;
                }
              }
            } catch (err) {
              console.error("Error parsing webhook payload:", err);
            }
          }
        }
        
        console.log("No payment confirmation found yet, will continue polling");
      } catch (error) {
        console.error("Error in payment status polling:", error);
      }
    }, 5000);
    
    // Function to check payment status directly from Xendit API
    const checkXenditPaymentStatus = async (invoiceId: string) => {
      try {
        console.log(`Checking Xendit API for payment status`);
        
        // Call our API endpoint to check the invoice status
        const response = await fetch(`/api/xendit/check-invoice?invoiceId=${invoiceId}`);
        
        if (!response.ok) {
          console.error(`Error checking Xendit API: ${response.status} ${response.statusText}`);
          return;
        }
        
        const data = await response.json();
        console.log(`Xendit API response status: ${data.status}`);
        
        if (data.status === "PAID") {
          console.log("Payment is completed according to Xendit API");
          localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
            status: "completed",
            timestamp: new Date().toISOString()
          }));
          
          // Clear the interval
          clearInterval(intervalId);
          localStorage.removeItem(`payment_polling_${missionaryId}`);
          console.log("Polling stopped: payment completed (from Xendit API)");
          
          // Auto-clear the payment status after 5 seconds
          setTimeout(() => {
            console.log("Auto-clearing completed payment status");
            // Clear ALL localStorage items related to payments
            localStorage.removeItem(`payment_status_${missionaryId}`);
            localStorage.removeItem(`payment_state_${missionaryId}`);
            localStorage.removeItem(`payment_${missionaryId}`);
            localStorage.removeItem(`payment_polling_${missionaryId}`);
          }, 5000); // 5 seconds
          
          return true;
        } else if (data.status === "EXPIRED" || data.status === "FAILED") {
          console.log(`Payment ${data.status.toLowerCase()}`);
          localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
            status: "failed",
            timestamp: new Date().toISOString()
          }));
          
          // Clear the interval
          clearInterval(intervalId);
          localStorage.removeItem(`payment_polling_${missionaryId}`);
          console.log(`Polling stopped: payment ${data.status.toLowerCase()}`);
          return true;
        }
        
        return false;
      } catch (error) {
        console.error("Error checking Xendit API:", error);
        return false;
      }
    };
    
    // Store the interval ID in localStorage so it can be cleared if needed
    localStorage.setItem(`payment_polling_${missionaryId}`, intervalId.toString());
    console.log(`Polling interval started`);
    
    // Clear the interval after 10 minutes (600000 ms)
    setTimeout(() => {
      clearInterval(intervalId);
      localStorage.removeItem(`payment_polling_${missionaryId}`);
      console.log("Polling automatically stopped after 10 minutes");
    }, 600000);
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

  // Add a function to handle canceling the new donor form
  const handleCancelNewDonorForm = () => {
    // Just reset everything related to the form
    setNewDonorForm({
      name: "",
      email: "",
      phone: "",
      showForm: false,
      emailError: undefined
    });
    setFormOriginIndex(null);
    setLoading(false);
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
                              {activeSearchIndex === index && (
                                <div 
                                  ref={(el) => { dropdownRefs.current[index] = el; }}
                                  className="absolute z-10 w-full mt-1 bg-white border rounded-md shadow-lg max-h-60 overflow-auto"
                                >
                                  {searchLoading ? (
                                    <div className="p-2 text-center">
                                      <Loader2 className="h-4 w-4 animate-spin mx-auto" />
                                    </div>
                                  ) : (
                                    <>
                                      {searchResults.length > 0 ? (
                                        searchResults.map((donor) => (
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
                                        ))
                                      ) : searchTerms[index] ? (
                                        <div className="p-2 text-sm text-gray-500">
                                          No partners found
                                        </div>
                                      ) : null}
                                      <div
                                        className="p-2 hover:bg-gray-100 cursor-pointer border-t"
                                        onClick={() => {
                                          // Remember which search box we're creating a partner for
                                          setFormOriginIndex(index);
                                          
                                          // Pre-fill the form with the search term
                                          setNewDonorForm({
                                            name: searchTerms[index] || "",
                                            email: "",
                                            phone: "",
                                            showForm: true,
                                            emailError: undefined
                                          });
                                          
                                          // Close the dropdown
                                          setActiveSearchIndex(null);
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
                
                {/* Only show "Add Another Partner" button when total amount doesn't match sum of partner entries */}
                {parseFloat(totalAmount) > 0 && 
                 getTotalFromDonors() !== parseFloat(totalAmount) && 
                 !isNaN(parseFloat(totalAmount)) && (
                  <Button
                    variant="outline"
                    className="w-full"
                    onClick={handleAddDonorEntry}
                    disabled={
                      donorEntries.length >= 10 || 
                      !donorEntries[donorEntries.length - 1]?.donorId || 
                      !donorEntries[donorEntries.length - 1]?.amount ||
                      isNaN(parseFloat(donorEntries[donorEntries.length - 1]?.amount || "0")) ||
                      parseFloat(donorEntries[donorEntries.length - 1]?.amount || "0") <= 0 ||
                      newDonorForm.showForm // Disable when the form is open
                    }
                  >
                    <Plus className="mr-2 h-4 w-4" />
                    Add Another Partner
                  </Button>
                )}
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
                    onClick={handleCancelNewDonorForm}
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

                  <div className="flex justify-end mt-4">
                    <Button
                      variant="outline"
                      className="mr-2"
                      onClick={handleCancelNewDonorForm}
                      disabled={loading}
                    >
                      Cancel
                    </Button>
                    <Button
                      onClick={handleCreateDonor}
                      disabled={!newDonorForm.name.trim() || !newDonorForm.email || loading}
                    >
                      {loading ? (
                        <>
                          <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                          Creating...
                        </>
                      ) : (
                        "Create Partner"
                      )}
                    </Button>
                  </div>
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
                    </span>
                  )}
                </span>
              </div>

              {/* Add helpful message when there's a mismatch - moved here */}
              {parseFloat(totalAmount) > 0 && 
               getTotalFromDonors() !== parseFloat(totalAmount) && 
               !isNaN(parseFloat(totalAmount)) && (
                <div className="mb-4 p-3 bg-amber-50 border border-amber-200 rounded-md text-sm">
                  <div className="flex items-start">
                    <AlertCircle className="h-4 w-4 text-amber-500 mr-2 mt-0.5" />
                    <div>
                      <p className="font-medium text-amber-800">Amount Mismatch</p>
                      <p className="text-amber-700 mt-1">
                        {getTotalFromDonors() < parseFloat(totalAmount) 
                          ? "The total from partners is less than the total amount. Please add more partners or adjust amounts."
                          : "The total from partners exceeds the total amount. Please adjust partner amounts."}
                      </p>
                    </div>
                  </div>
                </div>
              )}

              {/* Add success message when amounts match - moved here */}
              {parseFloat(totalAmount) > 0 && 
               Math.abs(getTotalFromDonors() - parseFloat(totalAmount)) <= 0.01 && 
               !isNaN(parseFloat(totalAmount)) && (
                <div className="mb-4 p-3 bg-green-50 border border-green-200 rounded-md text-sm">
                  <div className="flex items-start">
                    <CheckCircle className="h-4 w-4 text-green-500 mr-2 mt-0.5" />
                    <div>
                      <p className="font-medium text-green-800">Amounts Match</p>
                      <p className="text-green-700 mt-1">
                        The total from partners matches the total amount. You're ready to proceed.
                      </p>
                    </div>
                  </div>
                </div>
              )}

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
                    {Math.abs(getTotalFromDonors() - parseFloat(totalAmount)) <= 0.01 && !isNaN(parseFloat(totalAmount)) ? (
                      <CheckCircle className="mr-2 h-4 w-4" />
                    ) : (
                      <Wallet className="mr-2 h-4 w-4" />
                    )}
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
                  A payment page has been opened in a new tab with all available payment options from Xendit. If it didn't open automatically or you need to access it again, please click the "Pay Now" button below.
                </p>
                {paymentLink && (
                  <div className="mt-2 flex items-center">
                    <a 
                      href={paymentLink} 
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="inline-flex items-center text-green-700 hover:text-green-900 font-medium text-sm underline underline-offset-2"
                    >
                      Open Payment Link
                      <ExternalLink className="ml-1 h-3 w-3" />
                    </a>
                  </div>
                )}
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