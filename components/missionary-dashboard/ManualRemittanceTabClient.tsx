"use client";

import { useState, useEffect, Suspense, lazy, useCallback, useMemo } from "react";
import { useToast } from "@/hooks/use-toast";
import { createClient } from "@/utils/supabase/client";
import { AlertCircle, CheckCircle } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { motion, AnimatePresence, useReducedMotion } from "framer-motion";
import { BulkOnlinePaymentWizardWrapper } from "@/components/missionary-dashboard/BulkOnlinePaymentWizardWrapper";
import { ErrorBoundary } from "react-error-boundary";
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { AlertCircle as AlertCircleIcon, CheckCircle as CheckCircleIcon, RefreshCcw } from 'lucide-react';
import { safelyGetData, safelyStoreData, safelyRemoveData, clearByPrefix } from '@/utils/storage';
import { trackPerformance } from '@/utils/performance';

interface ManualRemittanceTabClientProps {
  missionaryId: string;
  missionaryName: string;
  initialError?: string;
}

/**
 * ManualRemittanceTabClient Component
 * 
 * Client component that handles manual remittance functionality for missionaries.
 * Implements optimized state management, error handling, and animations.
 * 
 * @param missionaryId - The ID of the missionary
 * @param missionaryName - The name of the missionary
 * @param initialError - Optional initial error message
 */
export function ManualRemittanceTabClient({
  missionaryId,
  missionaryName,
  initialError
}: ManualRemittanceTabClientProps) {
  const { toast } = useToast();
  const [paymentStatus, setPaymentStatus] = useState<"idle" | "pending" | "completed" | "failed">("idle");
  const [error, setError] = useState<string | null>(initialError || null);
  const shouldReduceMotion = useReducedMotion();
  
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('ManualRemittanceTabClient');
    return endTracking;
  }, []);

  // Function to reset payment status - memoized with useCallback
  const handleResetPaymentStatus = useCallback(() => {
    setPaymentStatus("idle");
    setError(null);
    
    // Clear ALL localStorage items related to payments
    clearByPrefix(`payment_`);
    
    // Clear any polling intervals
    const pollingId = safelyGetData<string>(`payment_polling_${missionaryId}`, "");
    if (pollingId) {
      try {
        clearInterval(parseInt(pollingId));
      } catch (err) {
        console.error("Error clearing interval:", err);
      }
    }
  }, [missionaryId]);

  // Check for payment status on component mount and window focus
  useEffect(() => {
    const checkPaymentStatus = async () => {
      try {
        // Get payment state from localStorage
        const paymentState = safelyGetData<{
          missionaryId: string;
          invoiceId: string;
          invoiceUrl: string;
          timestamp: string;
        } | null>(`payment_state_${missionaryId}`, null);
        
        if (!paymentState) {
          // Ensure payment status is idle if no payment state exists
          setPaymentStatus("idle");
          return;
        }
        
        // Check if the payment state is for the current missionary
        if (paymentState.missionaryId !== missionaryId) {
          setPaymentStatus("idle");
          return;
        }
        
        // Check if there's a recent payment (within the last 30 minutes)
        const paymentTime = new Date(paymentState.timestamp).getTime();
        const currentTime = new Date().getTime();
        const timeDiff = currentTime - paymentTime;
        const thirtyMinutesInMs = 30 * 60 * 1000;
        
        if (timeDiff < thirtyMinutesInMs) {
          // Check if there's a payment status in localStorage
          const paymentStatusData = safelyGetData<{
            status: "idle" | "pending" | "completed" | "failed";
            invoiceUrl?: string;
            invoiceId?: string;
          } | null>(`payment_status_${missionaryId}`, null);
          
          if (paymentStatusData) {
            setPaymentStatus(paymentStatusData.status);
            
            // If status is completed, set a timer to automatically reset to idle after 5 seconds
            if (paymentStatusData.status === "completed") {
              setTimeout(() => {
                handleResetPaymentStatus();
              }, 5000); // 5 seconds
            }
          } else {
            // If no status is found but there's a recent payment, set status to pending
            setPaymentStatus("pending");
          }
          
          // If status is still pending, check the database directly
          if (!paymentStatusData || paymentStatusData.status === "pending") {
            // Get the invoice ID from payment state
            const invoiceId = paymentState.invoiceId;
            if (invoiceId) {
              // First try to check the payment_transactions table
              const supabase = createClient();
              const { data, error } = await supabase
                .from("payment_transactions")
                .select("status")
                .eq("invoice_id", invoiceId)
                .single();
                
              if (error) {
                // Check if this is a 406 Not Acceptable error, which means the record doesn't exist yet
                if (error.code === "406" || error.code === "PGRST116") {
                  // If no transaction is found in the database, try to check the status directly from Xendit API
                  await checkXenditPaymentStatus(invoiceId);
                } else {
                  console.error("Error checking payment transaction:", error);
                }
              } else if (data) {
                if (data.status === "paid") {
                  setPaymentStatus("completed");
                  
                  // Update localStorage
                  safelyRemoveData(`payment_status_${missionaryId}`);
                  
                  // Set a timer to automatically reset to idle after 5 seconds
                  setTimeout(() => {
                    handleResetPaymentStatus();
                  }, 5000); // 5 seconds
                } else if (data.status === "expired" || data.status === "failed") {
                  setPaymentStatus("failed");
                  
                  // Update localStorage
                  safelyRemoveData(`payment_status_${missionaryId}`);
                }
              } else {
                // If no transaction is found in the database, try to check the status directly from Xendit API
                await checkXenditPaymentStatus(invoiceId);
              }
            }
          }
        } else {
          // Payment is older than 30 minutes, reset to idle
          setPaymentStatus("idle");
          
          // Clear localStorage to prevent future checks from finding this old payment
          safelyRemoveData(`payment_status_${missionaryId}`);
        }
      } catch (error) {
        console.error("Error checking payment status:", error);
        setError("Failed to check payment status");
      }
    };
    
    // Function to check payment status directly from Xendit API
    const checkXenditPaymentStatus = async (invoiceId: string) => {
      try {
        // Call our API endpoint to check the invoice status
        const response = await fetch(`/api/xendit/check-invoice?invoiceId=${invoiceId}`);
        
        if (!response.ok) {
          console.error("Error checking Xendit invoice status:", response.statusText);
          return;
        }
        
        const data = await response.json();
        
        if (data.status === "PAID") {
          setPaymentStatus("completed");
          
          // Update localStorage
          safelyRemoveData(`payment_status_${missionaryId}`);
          
          // Set a timer to automatically reset to idle after 5 seconds
          setTimeout(() => {
            handleResetPaymentStatus();
          }, 5000); // 5 seconds
        } else if (data.status === "EXPIRED" || data.status === "FAILED") {
          setPaymentStatus("failed");
          
          // Update localStorage
          safelyRemoveData(`payment_status_${missionaryId}`);
        } else {
          console.log("Payment status from Xendit:", data.status);
        }
      } catch (error) {
        console.error("Error checking Xendit payment status:", error);
        setError("Failed to check payment status from Xendit");
      }
    };
    
    // Check payment status on mount
    checkPaymentStatus();
    
    // Check payment status when window gets focus
    const handleFocus = () => {
      checkPaymentStatus();
    };
    
    window.addEventListener('focus', handleFocus);
    
    return () => {
      window.removeEventListener('focus', handleFocus);
      
      // Clear any polling intervals when component unmounts
      const pollingId = safelyGetData<string>(`payment_polling_${missionaryId}`, "");
      if (pollingId) {
        try {
          clearInterval(parseInt(pollingId));
        } catch (err) {
          console.error("Error clearing interval:", err);
        }
        safelyRemoveData(`payment_polling_${missionaryId}`);
      }
    };
  }, [missionaryId, handleResetPaymentStatus]);

  // Memoized success handler
  const handleBulkOnlineSuccess = useCallback(() => {
    // Set payment status to pending
    setPaymentStatus("pending");
    
    // Store payment status in localStorage
    safelyRemoveData(`payment_status_${missionaryId}`);
    
    toast({
      title: "Success",
      description: "Payment process initiated successfully",
    });
  }, [missionaryId, toast]);
  
  // Memoized error handler
  const handleBulkOnlineError = useCallback((error: string) => {
    // Set payment status to failed
    setPaymentStatus("failed");
    setError(error);
    
    // Store payment status in localStorage
    safelyRemoveData(`payment_status_${missionaryId}`);
    
    toast({
      title: "Error",
      description: `Payment process failed: ${error}`,
      variant: "destructive"
    });
  }, [missionaryId, toast]);

  // Function to get payment URL from localStorage
  const getPaymentUrl = useCallback(() => {
    // First try to get the payment info which contains the direct link
    const paymentInfoStr = safelyGetData<{
      invoiceUrl?: string;
      invoiceId?: string;
    } | null>(`payment_${missionaryId}`, null);
    const paymentStatusStr = safelyGetData<{
      status: string;
      invoiceUrl?: string;
      invoiceId?: string;
    } | null>(`payment_status_${missionaryId}`, null);
    
    let paymentUrl = null;
    
    // Try to get the direct payment URL from various sources
    if (paymentStatusStr) {
      try {
        const paymentStatusObj = paymentStatusStr;
        if (paymentStatusObj.invoiceUrl) {
          paymentUrl = paymentStatusObj.invoiceUrl;
        } else if (paymentStatusObj.invoiceId) {
          paymentUrl = `https://checkout.xendit.co/web/${paymentStatusObj.invoiceId}`;
        }
      } catch (e) {
        console.error("Error parsing payment status:", e);
      }
    }
    
    if (!paymentUrl && paymentInfoStr) {
      try {
        const paymentInfo = paymentInfoStr;
        // Check if we have a direct URL stored
        if (paymentInfo.invoiceUrl) {
          paymentUrl = paymentInfo.invoiceUrl;
        } else if (paymentInfo.invoiceId) {
          // Fallback to constructing URL from invoice ID
          paymentUrl = `https://checkout.xendit.co/web/${paymentInfo.invoiceId}`;
        }
      } catch (e) {
        console.error("Error parsing payment info:", e);
      }
    }
    
    // If we couldn't get the URL from payment info, try the payment state
    if (!paymentUrl && safelyGetData<{
      invoiceUrl?: string;
      invoiceId?: string;
    } | null>(`payment_state_${missionaryId}`, null)) {
      try {
        const paymentState = safelyGetData<{
          invoiceUrl?: string;
          invoiceId?: string;
        } | null>(`payment_state_${missionaryId}`, null);
        if (paymentState && paymentState.invoiceUrl) {
          paymentUrl = paymentState.invoiceUrl;
        } else if (paymentState && paymentState.invoiceId) {
          // Fallback to constructing URL from invoice ID
          paymentUrl = `https://checkout.xendit.co/web/${paymentState.invoiceId}`;
        }
      } catch (err) {
        console.error("Error parsing payment state:", err);
      }
    }
    
    return paymentUrl;
  }, [missionaryId]);

  // Animation variants with reduced motion support
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: { 
      opacity: 1,
      transition: { 
        duration: shouldReduceMotion ? 0 : 0.3,
        when: "beforeChildren",
        staggerChildren: shouldReduceMotion ? 0 : 0.1
      }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 10 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { duration: shouldReduceMotion ? 0 : 0.3 }
    }
  };

  const alertVariants = {
    hidden: { opacity: 0, scale: shouldReduceMotion ? 1 : 0.95 },
    visible: { 
      opacity: 1, 
      scale: 1,
      transition: { duration: shouldReduceMotion ? 0 : 0.3 }
    },
    exit: { 
      opacity: 0, 
      scale: shouldReduceMotion ? 1 : 0.95,
      transition: { duration: shouldReduceMotion ? 0 : 0.2 }
    }
  };

  return (
    <ErrorBoundary fallback={<div className="p-4 text-red-500">An error occurred while loading the payment interface</div>}>
      <motion.div
        variants={containerVariants}
        initial="hidden"
        animate="visible"
        className="flex flex-col gap-4 sm:gap-6"
      >
        <div className="flex flex-col gap-4 sm:gap-6 lg:flex-row">
          <motion.div 
            variants={itemVariants}
            className="flex-1 space-y-3 sm:space-y-4"
          >
            <h2 className="text-xl sm:text-2xl font-semibold">Manual Remittance</h2>
            <p className="text-xs sm:text-sm text-muted-foreground">
              Generate a payment link to collect donations from multiple donors in a single transaction.
            </p>
            
            <AnimatePresence mode="wait">
              {paymentStatus === "pending" && (
                <motion.div
                  key="pending"
                  variants={alertVariants}
                  initial="hidden"
                  animate="visible"
                  exit="exit"
                  layout
                >
                  <Alert className="mb-3 sm:mb-4 border-yellow-200 dark:border-yellow-800 bg-yellow-50 dark:bg-yellow-900/20">
                    <AlertCircleIcon className="h-4 w-4 text-yellow-600 dark:text-yellow-400" />
                    <AlertTitle className="text-sm sm:text-base text-yellow-800 dark:text-yellow-300">Payment in progress</AlertTitle>
                    <AlertDescription className="text-xs sm:text-sm text-yellow-700 dark:text-yellow-400">
                      Your payment is being processed. Please complete the payment in the opened tab.
                      
                      {/* Payment link section */}
                      {(() => {
                        const paymentUrl = getPaymentUrl();
                        
                        if (paymentUrl) {
                          return (
                            <motion.div 
                              initial={{ opacity: 0 }}
                              animate={{ opacity: 1 }}
                              transition={{ delay: shouldReduceMotion ? 0 : 0.2 }}
                              className="mt-2 sm:mt-3 p-2 sm:p-3 bg-white dark:bg-gray-800 rounded-md border border-yellow-200 dark:border-yellow-800"
                            >
                              <p className="text-xs sm:text-sm text-gray-600 dark:text-gray-300 flex items-center">
                                <AlertCircleIcon className="h-3 w-3 sm:h-3.5 sm:w-3.5 mr-1 sm:mr-1.5 text-yellow-600 dark:text-yellow-400 flex-shrink-0" />
                                If the payment tab didn&apos;t open automatically:
                              </p>
                              <a 
                                href={paymentUrl}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="mt-2 flex items-center justify-center w-full px-3 sm:px-4 py-1.5 sm:py-2 text-xs sm:text-sm font-medium text-yellow-700 bg-yellow-100 hover:bg-yellow-200 dark:text-yellow-200 dark:bg-yellow-900/40 dark:hover:bg-yellow-900/60 rounded-md transition-colors duration-200 border border-yellow-300 dark:border-yellow-700"
                              >
                                <span className="mr-1 sm:mr-2">Open Payment Link</span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="lucide lucide-external-link">
                                  <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                                  <polyline points="15 3 21 3 21 9"></polyline>
                                  <line x1="10" y1="14" x2="21" y2="3"></line>
                                </svg>
                              </a>
                            </motion.div>
                          );
                        }
                        
                        return null;
                      })()}
                      
                      <motion.button 
                        whileHover={shouldReduceMotion ? {} : { scale: 1.02 }}
                        whileTap={shouldReduceMotion ? {} : { scale: 0.98 }}
                        onClick={handleResetPaymentStatus}
                        className="block mt-2 sm:mt-3 text-xs sm:text-sm text-yellow-600 dark:text-yellow-400 underline"
                      >
                        Start a new payment
                      </motion.button>
                    </AlertDescription>
                  </Alert>
                </motion.div>
              )}
              
              {paymentStatus === "completed" && (
                <motion.div
                  key="completed"
                  variants={alertVariants}
                  initial="hidden"
                  animate="visible"
                  exit="exit"
                  layout
                >
                  <Alert className="bg-green-50 border-green-200 dark:bg-green-900/20 dark:border-green-800">
                    <CheckCircleIcon className="h-4 w-4 text-green-600 dark:text-green-400" />
                    <AlertTitle>Payment completed</AlertTitle>
                    <AlertDescription>
                      Your payment has been successfully processed. The donations have been recorded.
                      <motion.button 
                        whileHover={shouldReduceMotion ? {} : { scale: 1.02 }}
                        whileTap={shouldReduceMotion ? {} : { scale: 0.98 }}
                        onClick={handleResetPaymentStatus}
                        className="block mt-2 text-sm text-green-600 dark:text-green-400 underline"
                      >
                        Start a new payment
                      </motion.button>
                    </AlertDescription>
                  </Alert>
                </motion.div>
              )}
              
              {paymentStatus === "failed" && (
                <motion.div
                  key="failed"
                  variants={alertVariants}
                  initial="hidden"
                  animate="visible"
                  exit="exit"
                  layout
                >
                  <Alert className="bg-red-50 border-red-200 dark:bg-red-900/20 dark:border-red-800">
                    <AlertCircleIcon className="h-4 w-4 text-red-600 dark:text-red-400" />
                    <AlertTitle>Payment failed</AlertTitle>
                    <AlertDescription>
                      There was an issue processing your payment: {error || "Please try again"}.
                      <motion.button 
                        whileHover={shouldReduceMotion ? {} : { scale: 1.02 }}
                        whileTap={shouldReduceMotion ? {} : { scale: 0.98 }}
                        onClick={handleResetPaymentStatus}
                        className="block mt-2 text-sm text-red-600 dark:text-red-400 underline"
                      >
                        Start a new payment
                      </motion.button>
                    </AlertDescription>
                  </Alert>
                </motion.div>
              )}
            </AnimatePresence>
            
            <motion.div 
              variants={itemVariants}
              className="bg-white p-3 sm:p-4 rounded-md shadow dark:bg-gray-800"
            >
              <h3 className="text-base sm:text-lg font-medium">Online Payment Instructions</h3>
              <p className="text-xs sm:text-sm mt-2 text-muted-foreground">
                1. Enter the total amount to be collected in Philippine Peso (₱).<br />
                2. Add multiple donors with their contribution amounts.<br />
                3. Click &quot;Pay Now&quot; to process the payment directly.<br />
                4. Choose from multiple payment methods including credit/debit cards, e-wallets, bank transfers, and more.
              </p>
            </motion.div>
          </motion.div>
          
          <motion.aside 
            variants={itemVariants}
            className="w-full lg:w-96 xl:w-[30rem] max-w-full"
          >
            <div className="bg-white dark:bg-gray-800 rounded-md shadow p-2 sm:p-4 overflow-hidden">
              {paymentStatus === "idle" ? (
                <BulkOnlinePaymentWizardWrapper
                  missionaryId={missionaryId}
                  missionaryName={missionaryName}
                  onSuccess={handleBulkOnlineSuccess}
                  onError={handleBulkOnlineError}
                />
              ) : (
                <motion.div 
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: shouldReduceMotion ? 0 : 0.3 }}
                  className="p-3 sm:p-4 text-center"
                >
                  <h3 className="text-base sm:text-lg font-medium mb-3 sm:mb-4">
                    {paymentStatus === "pending" ? "Payment in Progress" : 
                     paymentStatus === "completed" ? "Payment Completed" : 
                     "Payment Failed"}
                  </h3>
                  <p className="text-xs sm:text-sm text-muted-foreground mb-3 sm:mb-4">
                    {paymentStatus === "pending" ? 
                      "Please complete your payment in the opened tab." : 
                     paymentStatus === "completed" ? 
                      "Your payment has been successfully processed." : 
                      "There was an issue with your payment."}
                  </p>
                  <motion.button
                    whileHover={shouldReduceMotion ? {} : { scale: 1.02 }}
                    whileTap={shouldReduceMotion ? {} : { scale: 0.98 }}
                    onClick={handleResetPaymentStatus}
                    className="px-3 sm:px-4 py-1.5 sm:py-2 text-xs sm:text-sm bg-primary text-primary-foreground rounded-md hover:bg-primary/90 transition-colors duration-200"
                  >
                    Start New Payment
                  </motion.button>
                </motion.div>
              )}
            </div>
          </motion.aside>
        </div>
      </motion.div>
    </ErrorBoundary>
  );
} 