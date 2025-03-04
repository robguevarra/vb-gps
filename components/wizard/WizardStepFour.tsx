"use client";

import { useState, useEffect, useCallback, useMemo } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { ArrowLeft, CreditCard, Loader2, CheckCircle, AlertCircle, Bug } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { motion, useReducedMotion } from "framer-motion";
import { createClient } from "@/utils/supabase/client";
import { cn } from "@/lib/utils";
import { safelyStoreData, safelyRemoveData } from '@/utils/storage';
import { trackPerformance, measureExecutionTime } from '@/utils/performance';

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

  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('WizardStepFour');
    return endTracking;
  }, []);

  // Clean up polling interval on component unmount
  useEffect(() => {
    return () => {
      if (pollingInterval) {
        clearInterval(pollingInterval);
      }
    };
  }, [pollingInterval]);

  // Memoize donation data preparation to avoid recalculating on every render
  const donationData = useMemo(() => {
    return donorEntries.map(entry => {
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
  }, [donorEntries, selectedDonors]);

  // Memoize primary donor to avoid recalculating on every render
  const primaryDonor = useMemo(() => {
    return donorEntries.length > 0 ? selectedDonors[donorEntries[0].donorId] : null;
  }, [donorEntries, selectedDonors]);

  // Don't render if not visible - AFTER all hooks are defined
  if (!visible) return null;

  const handleGeneratePaymentLink = async () => {
    setIsGeneratingLink(true);
    setError(null);
    
    try {
      const supabase = createClient();
      
      // Add detailed logging for debugging
      console.log('Mapped donation data:', JSON.stringify(donationData, null, 2));
      
      if (!primaryDonor) {
        throw new Error('No donors selected');
      }
      
      // Prepare the request payload
      const payload = {
        donationType: "missionary",
        recipientId: missionaryId,
        amount: totalAmount,
        donor: {
          name: primaryDonor.name,
          email: primaryDonor.email || `${primaryDonor.name.toLowerCase().replace(/\s+/g, '.')}@example.com`,
          phone: primaryDonor.phone || ''
        },
        payment_details: {
          isBulkDonation: true,
          donors: donationData,
          recipientId: missionaryId,
          recipientName: missionaryName
        },
        notes: notes || 'Manual remittance'
      };
      
      // Log the payload for debugging
      console.log('Payment request payload:', JSON.stringify(payload, null, 2));
      
      // Send the request to create the invoice
      const response = await fetch('/api/xendit/create-invoice', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      });
      
      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        console.error('Error response:', errorData);
        throw new Error(errorData.error || 'Failed to generate payment link');
      }
      
      const data = await response.json();
      console.log('Payment link generated successfully:', data);
      
      // Update the payment information
      setPaymentUrl(data.invoiceUrl);
      setInvoiceId(data.invoiceId);
      setPaymentStatus('pending');
      
      // Store payment state in localStorage for persistence
      safelyStoreData(`payment_state_${missionaryId}`, {
        missionaryId,
        invoiceId: data.invoiceId,
        invoiceUrl: data.invoiceUrl,
        timestamp: new Date().toISOString()
      });
      
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
          safelyStoreData(`payment_status_${missionaryId}`, {
            status: 'completed',
            timestamp: new Date().toISOString()
          });
          
          // Call the onSuccess callback if provided
          if (onSuccess) {
            onSuccess();
          }
        } else if (data.status === 'EXPIRED' || data.status === 'FAILED') {
          setPaymentStatus('failed');
          clearInterval(interval);
          
          // Update localStorage
          safelyStoreData(`payment_status_${missionaryId}`, {
            status: 'failed',
            timestamp: new Date().toISOString()
          });
          
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
    safelyStoreData(`payment_polling_${missionaryId}`, interval.toString());
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