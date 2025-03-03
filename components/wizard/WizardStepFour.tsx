"use client";

import { useState, useEffect, useCallback } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { ArrowLeft, CreditCard, Loader2, CheckCircle, AlertCircle, Bug } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { motion, useReducedMotion } from "framer-motion";
import { createClient } from "@/utils/supabase/client";
import { cn } from "@/lib/utils";

interface WizardStepFourProps {
  onPrev: () => void;
  visible: boolean;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

/**
 * WizardStepFour Component
 * 
 * Final step of the payment wizard where users process the payment.
 * This component handles payment link generation and displays the payment status.
 * 
 * @param onPrev - Function to navigate to the previous step
 * @param visible - Whether this step is currently visible
 * @param onSuccess - Optional callback for successful payment
 * @param onError - Optional callback for payment errors
 */
export function WizardStepFour({ onPrev, visible, onSuccess, onError }: WizardStepFourProps) {
  const [paymentUrl, setPaymentUrl] = useState<string | null>(null);
  const [invoiceId, setInvoiceId] = useState<string | null>(null);
  const [paymentStatus, setPaymentStatus] = useState<'idle' | 'pending' | 'completed' | 'failed'>('idle');
  const [isGeneratingLink, setIsGeneratingLink] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [pollingInterval, setPollingInterval] = useState<NodeJS.Timeout | null>(null);
  const shouldReduceMotion = useReducedMotion();
  
  const {
    donorEntries,
    selectedDonors,
    totalAmount,
    missionaryId,
    missionaryName,
    notes
  } = usePaymentWizardStore();

  // Clean up polling interval on component unmount
  useEffect(() => {
    return () => {
      if (pollingInterval) {
        clearInterval(pollingInterval);
      }
    };
  }, [pollingInterval]);

  // Don't render if not visible
  if (!visible) return null;

  const handleGeneratePaymentLink = async () => {
    setIsGeneratingLink(true);
    setError(null);
    
    try {
      const supabase = createClient();
      
      // Prepare the donation data
      const donationData = donorEntries.map(entry => {
        const donor = selectedDonors[entry.donorId];
        const donorName = donor?.name || entry.donorName || 'Anonymous Donor';
        // Create a default email based on donor name if not available
        const defaultEmail = `${donorName.toLowerCase().replace(/\s+/g, '.')}@example.com`;
        
        return {
          donorId: String(entry.donorId),
          donorName: donorName,
          amount: parseFloat(entry.amount),
          email: donor?.email || entry.email || defaultEmail,
          phone: donor?.phone || entry.phone || ''
        };
      });
      
      // Add detailed logging for debugging
      console.log('Mapped donation data:', JSON.stringify(donationData, null, 2));
      
      // Get the first donor for the main donor information
      const primaryDonor = donorEntries.length > 0 ? 
        selectedDonors[donorEntries[0].donorId] : null;
      
      if (!primaryDonor) {
        throw new Error('No donors selected');
      }

      const primaryDonorName = primaryDonor.name || 'Anonymous Donor';
      const defaultPrimaryEmail = `${primaryDonorName.toLowerCase().replace(/\s+/g, '.')}@example.com`;

      // Log the request payload for debugging
      const requestPayload = {
        donationType: "missionary",
        recipientId: missionaryId,
        amount: totalAmount,
        donor: {
          name: primaryDonorName,
          email: primaryDonor.email || defaultPrimaryEmail,
          phone: primaryDonor.phone || ''
        },
        isAnonymous: false,
        payment_details: {
          isBulkDonation: true,
          donors: donationData,
          recipientId: missionaryId,
          recipientName: missionaryName
        },
        notes: notes || ''
      };
      
      console.log('Payment request payload:', requestPayload);
      
      // Call the API to generate a payment link
      const response = await fetch('/api/xendit/create-invoice', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestPayload),
      });
      
      // Log the response status for debugging
      console.log('API response status:', response.status, response.statusText);
      
      // Handle non-JSON responses
      const contentType = response.headers.get('content-type');
      if (!contentType || !contentType.includes('application/json')) {
        const textResponse = await response.text();
        console.error('Non-JSON response:', textResponse);
        throw new Error(`Server returned non-JSON response: ${response.status} ${response.statusText}`);
      }
      
      if (!response.ok) {
        // Check if the response has content before trying to parse it
        const contentType = response.headers.get('content-type');
        let errorData: { error?: string; details?: string; message?: string } = {};
        
        if (contentType && contentType.includes('application/json')) {
          const responseText = await response.text();
          if (responseText) {
            try {
              errorData = JSON.parse(responseText);
              // Log the full error details for debugging
              console.error('Full API error details:', JSON.stringify(errorData, null, 2));
            } catch (parseError) {
              console.error('Error parsing JSON response:', parseError);
              errorData = { error: 'Invalid JSON response' };
            }
          }
        }
        
        console.error('API error response:', errorData, 'Status:', response.status, response.statusText);
        
        // Provide more specific error messages based on status code
        if (response.status === 400) {
          // For validation errors, try to extract the specific validation issue
          if (errorData.details && typeof errorData.details === 'object') {
            const validationDetails = JSON.stringify(errorData.details);
            throw new Error(`Validation error: ${validationDetails}`);
          } else {
            throw new Error(errorData.error || 'Invalid request data. Please check donor information.');
          }
        } else if (response.status === 401 || response.status === 403) {
          throw new Error('Authentication error. Please log in again.');
        } else if (response.status === 404) {
          throw new Error('Payment service endpoint not found.');
        } else if (response.status === 500) {
          throw new Error('Server error processing payment. Please try again later.');
        } else {
          throw new Error(errorData.error || errorData.details || `Failed to generate payment link (${response.status}: ${response.statusText})`);
        }
      }
      
      const data = await response.json();
      console.log('Payment link generated successfully:', data);
      
      // Update the payment information
      setPaymentUrl(data.invoiceUrl);
      setInvoiceId(data.invoiceId);
      setPaymentStatus('pending');
      
      // Store payment state in localStorage for persistence
      localStorage.setItem(`payment_state_${missionaryId}`, JSON.stringify({
        missionaryId,
        invoiceId: data.invoiceId,
        invoiceUrl: data.invoiceUrl,
        timestamp: new Date().toISOString()
      }));
      
      // Open the payment link in a new tab
      window.open(data.invoiceUrl, '_blank');
      
      // Start polling for payment status
      startPaymentStatusPolling(data.invoiceId);
      
    } catch (err) {
      console.error('Error generating payment link:', err);
      const errorMessage = err instanceof Error ? err.message : 'Failed to generate payment link';
      setError(errorMessage);
      setPaymentStatus('failed');
      
      // Call the onError callback if provided
      if (onError) {
        onError(errorMessage);
      }
    } finally {
      setIsGeneratingLink(false);
    }
  };
  
  const startPaymentStatusPolling = (invoiceId: string) => {
    // Set up polling interval to check payment status
    const interval = setInterval(async () => {
      try {
        const response = await fetch(`/api/xendit/check-invoice?invoiceId=${invoiceId}`);
        
        if (!response.ok) {
          throw new Error('Failed to check payment status');
        }
        
        const data = await response.json();
        
        if (data.status === 'PAID' || data.status === 'SETTLED') {
          setPaymentStatus('completed');
          clearInterval(interval);
          
          // Update localStorage
          localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
            status: 'completed',
            timestamp: new Date().toISOString()
          }));
          
          // Call the onSuccess callback if provided
          if (onSuccess) {
            onSuccess();
          }
        } else if (data.status === 'EXPIRED' || data.status === 'FAILED') {
          setPaymentStatus('failed');
          clearInterval(interval);
          
          // Update localStorage
          localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
            status: 'failed',
            timestamp: new Date().toISOString()
          }));
          
          // Call the onError callback if provided
          if (onError) {
            onError('Payment expired or failed');
          }
        }
      } catch (err) {
        console.error('Error checking payment status:', err);
        
        // Don't call onError here as this is just a polling error, not a payment failure
      }
    }, 5000); // Check every 5 seconds
    
    // Store the interval ID in state for cleanup
    setPollingInterval(interval);
    
    // Also store it in localStorage for recovery after page refresh
    localStorage.setItem(`payment_polling_${missionaryId}`, interval.toString());
    
    // No need to return cleanup function here as we're managing the interval in state
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: visible ? 1 : 0, y: visible ? 0 : 20 }}
      exit={{ opacity: 0, y: 20 }}
      transition={{ duration: shouldReduceMotion ? 0 : 0.3 }}
      className={cn("space-y-6", !visible && "hidden")}
    >
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <CardTitle>Payment</CardTitle>
            <div className="flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={onPrev}
              >
                <ArrowLeft className="mr-2 h-4 w-4" />
                Back
              </Button>
              
              {/* Debug button - only visible in development */}
              {process.env.NODE_ENV === 'development' && (
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => {
                    console.log('Debug info:');
                    console.log('- Missionary ID:', missionaryId);
                    console.log('- Missionary Name:', missionaryName);
                    console.log('- Total Amount:', totalAmount);
                    console.log('- Donor Entries:', donorEntries);
                    console.log('- Selected Donors:', selectedDonors);
                    console.log('- Notes:', notes);
                    
                    // Test the API endpoint directly
                    fetch('/api/xendit/create-invoice', {
                      method: 'OPTIONS',
                    }).then(res => {
                      console.log('API OPTIONS response:', res.status, res.statusText);
                    }).catch(err => {
                      console.error('API OPTIONS error:', err);
                    });
                  }}
                  className="bg-yellow-100 text-yellow-800 border-yellow-300"
                >
                  <Bug className="mr-2 h-4 w-4" />
                  Debug
                </Button>
              )}
            </div>
          </div>
          <CardDescription>
            Generate a payment link to complete your donation.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* Donation summary */}
          <div className="p-4 border rounded-md">
            <h3 className="font-medium mb-2">Donation Summary</h3>
            <div className="space-y-2">
              {donorEntries.map((entry, index) => {
                const donor = selectedDonors[entry.donorId];
                if (!donor) return null;
                
                return (
                  <div key={`${donor.id}-${index}`} className="flex justify-between py-1 border-b last:border-0">
                    <span>{donor.name}</span>
                    <span className="font-medium">${parseFloat(entry.amount).toFixed(2)}</span>
                  </div>
                );
              })}
            </div>
            
            <div className="flex justify-between mt-4 pt-2 border-t font-bold">
              <span>Total Amount:</span>
              <span>${totalAmount.toFixed(2)}</span>
            </div>
          </div>
          
          {/* Payment status */}
          {paymentStatus === 'idle' && (
            <Alert className="bg-blue-50 border-blue-200 dark:bg-blue-900/20 dark:border-blue-800">
              <AlertCircle className="h-4 w-4 text-blue-600 dark:text-blue-400" />
              <AlertTitle>Ready to process payment</AlertTitle>
              <AlertDescription>
                Click the "Pay Now" button below to generate a payment link and complete your donation.
              </AlertDescription>
            </Alert>
          )}
          
          {paymentStatus === 'pending' && (
            <Alert className="bg-yellow-50 border-yellow-200 dark:bg-yellow-900/20 dark:border-yellow-800">
              <AlertCircle className="h-4 w-4 text-yellow-600 dark:text-yellow-400" />
              <AlertTitle>Payment in progress</AlertTitle>
              <AlertDescription>
                Please complete your payment in the opened tab. This page will update automatically when the payment is completed.
                
                {paymentUrl && (
                  <Button
                    variant="outline"
                    size="sm"
                    className="mt-2"
                    onClick={() => window.open(paymentUrl, '_blank')}
                  >
                    Open Payment Link Again
                  </Button>
                )}
              </AlertDescription>
            </Alert>
          )}
          
          {paymentStatus === 'completed' && (
            <Alert className="bg-green-50 border-green-200 dark:bg-green-900/20 dark:border-green-800">
              <CheckCircle className="h-4 w-4 text-green-600 dark:text-green-400" />
              <AlertTitle>Payment completed</AlertTitle>
              <AlertDescription>
                Your payment has been successfully processed. Thank you for your donation!
              </AlertDescription>
            </Alert>
          )}
          
          {paymentStatus === 'failed' && (
            <Alert variant="destructive">
              <AlertCircle className="h-4 w-4" />
              <AlertTitle>Payment failed</AlertTitle>
              <AlertDescription>
                {error || "There was an issue processing your payment. Please try again."}
              </AlertDescription>
            </Alert>
          )}
        </CardContent>
        <CardFooter className="flex justify-between">
          <Button
            variant="outline"
            onClick={onPrev}
            disabled={paymentStatus === 'pending'}
          >
            <ArrowLeft className="mr-2 h-4 w-4" />
            Previous
          </Button>
          
          {paymentStatus === 'idle' && (
            <Button
              onClick={handleGeneratePaymentLink}
              disabled={isGeneratingLink}
              className="bg-primary text-primary-foreground"
            >
              {isGeneratingLink ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Generating Link...
                </>
              ) : (
                <>
                  <CreditCard className="mr-2 h-4 w-4" />
                  Pay Now
                </>
              )}
            </Button>
          )}
          
          {paymentStatus === 'pending' && (
            <Button
              disabled
              className="bg-yellow-500 text-white"
            >
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
              Processing Payment...
            </Button>
          )}
          
          {paymentStatus === 'completed' && (
            <Button
              className="bg-green-500 text-white"
              disabled
            >
              <CheckCircle className="mr-2 h-4 w-4" />
              Payment Completed
            </Button>
          )}
          
          {paymentStatus === 'failed' && (
            <Button
              onClick={handleGeneratePaymentLink}
              disabled={isGeneratingLink}
              variant="destructive"
            >
              {isGeneratingLink ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Retrying...
                </>
              ) : (
                <>
                  <CreditCard className="mr-2 h-4 w-4" />
                  Try Again
                </>
              )}
            </Button>
          )}
        </CardFooter>
      </Card>
    </motion.div>
  );
} 