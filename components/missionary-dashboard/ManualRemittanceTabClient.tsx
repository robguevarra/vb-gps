"use client";

import { useState, useEffect, Suspense, lazy } from "react";
import { useToast } from "@/hooks/use-toast";
import { createClient } from "@/utils/supabase/client";
import { AlertCircle, CheckCircle } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { motion, AnimatePresence, useReducedMotion } from "framer-motion";
import { BulkOnlinePaymentWizardWrapper } from "@/components/missionary-dashboard/BulkOnlinePaymentWizardWrapper";
import { ErrorBoundary } from "@/components/ErrorBoundary";

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
  
  // Function to reset payment status
  const handleResetPaymentStatus = () => {
    setPaymentStatus("idle");
    setError(null);
    
    // Clear ALL localStorage items related to payments
    localStorage.removeItem(`payment_status_${missionaryId}`);
    localStorage.removeItem(`payment_state_${missionaryId}`);
    localStorage.removeItem(`payment_${missionaryId}`);
    localStorage.removeItem(`payment_polling_${missionaryId}`);
    
    // Clear any polling intervals
    const pollingId = localStorage.getItem(`payment_polling_${missionaryId}`);
    if (pollingId) {
      try {
        clearInterval(parseInt(pollingId));
      } catch (err) {
        console.error("Error clearing interval:", err);
      }
    }
  };

  // Check for payment status on component mount and window focus
  useEffect(() => {
    const checkPaymentStatus = async () => {
      try {
        // Get payment state from localStorage
        const paymentStateStr = localStorage.getItem(`payment_state_${missionaryId}`);
        if (!paymentStateStr) {
          // Ensure payment status is idle if no payment state exists
          setPaymentStatus("idle");
          return;
        }
        
        const paymentState = JSON.parse(paymentStateStr);
        
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
          const paymentStatusStr = localStorage.getItem(`payment_status_${missionaryId}`);
          let status = null;
          
          if (paymentStatusStr) {
            status = JSON.parse(paymentStatusStr);
            setPaymentStatus(status.status);
            
            // If status is completed, set a timer to automatically reset to idle after 5 seconds
            if (status.status === "completed") {
              setTimeout(() => {
                handleResetPaymentStatus();
              }, 5000); // 5 seconds
            }
          } else {
            // If no status is found but there's a recent payment, set status to pending
            setPaymentStatus("pending");
          }
          
          // If status is still pending, check the database directly
          if (!status || status.status === "pending") {
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
                  localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
                    status: "completed",
                    timestamp: new Date().toISOString()
                  }));
                  
                  // Set a timer to automatically reset to idle after 5 seconds
                  setTimeout(() => {
                    handleResetPaymentStatus();
                  }, 5000); // 5 seconds
                } else if (data.status === "expired" || data.status === "failed") {
                  setPaymentStatus("failed");
                  
                  // Update localStorage
                  localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
                    status: "failed",
                    timestamp: new Date().toISOString()
                  }));
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
          localStorage.removeItem(`payment_status_${missionaryId}`);
          localStorage.removeItem(`payment_state_${missionaryId}`);
          localStorage.removeItem(`payment_${missionaryId}`);
          localStorage.removeItem(`payment_polling_${missionaryId}`);
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
          localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
            status: "completed",
            timestamp: new Date().toISOString()
          }));
          
          // Set a timer to automatically reset to idle after 5 seconds
          setTimeout(() => {
            handleResetPaymentStatus();
          }, 5000); // 5 seconds
        } else if (data.status === "EXPIRED" || data.status === "FAILED") {
          setPaymentStatus("failed");
          
          // Update localStorage
          localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
            status: "failed",
            timestamp: new Date().toISOString()
          }));
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
      const pollingId = localStorage.getItem(`payment_polling_${missionaryId}`);
      if (pollingId) {
        try {
          clearInterval(parseInt(pollingId));
        } catch (err) {
          console.error("Error clearing interval:", err);
        }
        localStorage.removeItem(`payment_polling_${missionaryId}`);
      }
    };
  }, [missionaryId]);

  const handleBulkOnlineSuccess = () => {
    // Set payment status to pending
    setPaymentStatus("pending");
    
    // Store payment status in localStorage
    localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
      status: "pending",
      timestamp: new Date().toISOString()
    }));
    
    toast({
      title: "Success",
      description: "Payment process initiated successfully",
    });
  };
  
  const handleBulkOnlineError = (error: string) => {
    // Set payment status to failed
    setPaymentStatus("failed");
    setError(error);
    
    // Store payment status in localStorage
    localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
      status: "failed",
      timestamp: new Date().toISOString()
    }));
    
    toast({
      title: "Error",
      description: `Payment process failed: ${error}`,
      variant: "destructive"
    });
  };

  // Function to get payment URL from localStorage
  const getPaymentUrl = () => {
    // First try to get the payment info which contains the direct link
    const paymentInfoStr = localStorage.getItem(`payment_${missionaryId}`);
    const paymentStateStr = localStorage.getItem(`payment_state_${missionaryId}`);
    const paymentStatusStr = localStorage.getItem(`payment_status_${missionaryId}`);
    
    let paymentUrl = null;
    
    // Try to get the direct payment URL from various sources
    if (paymentStatusStr) {
      try {
        const paymentStatusObj = JSON.parse(paymentStatusStr);
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
        const paymentInfo = JSON.parse(paymentInfoStr);
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
    if (!paymentUrl && paymentStateStr) {
      try {
        const paymentState = JSON.parse(paymentStateStr);
        if (paymentState.invoiceUrl) {
          paymentUrl = paymentState.invoiceUrl;
        } else if (paymentState.invoiceId) {
          // Fallback to constructing URL from invoice ID
          paymentUrl = `https://checkout.xendit.co/web/${paymentState.invoiceId}`;
        }
      } catch (e) {
        console.error("Error parsing payment state:", e);
      }
    }
    
    return paymentUrl;
  };

  // Animation variants
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
    <ErrorBoundary>
      <motion.div
        variants={containerVariants}
        initial="hidden"
        animate="visible"
        className="flex flex-col gap-6"
      >
        <div className="flex flex-col gap-6 md:flex-row">
          <motion.div 
            variants={itemVariants}
            className="flex-1 space-y-4"
          >
            <h2 className="text-2xl font-semibold">Manual Remittance</h2>
            <p className="text-muted-foreground text-sm">
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
                  <Alert className="mb-4 border-yellow-200 dark:border-yellow-800 bg-yellow-50 dark:bg-yellow-900/20">
                    <AlertCircle className="h-4 w-4 text-yellow-600 dark:text-yellow-400" />
                    <AlertTitle className="text-yellow-800 dark:text-yellow-300">Payment in progress</AlertTitle>
                    <AlertDescription className="text-yellow-700 dark:text-yellow-400">
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
                              className="mt-3 p-3 bg-white dark:bg-gray-800 rounded-md border border-yellow-200 dark:border-yellow-800"
                            >
                              <p className="text-sm text-gray-600 dark:text-gray-300 flex items-center">
                                <AlertCircle className="h-3.5 w-3.5 mr-1.5 text-yellow-600 dark:text-yellow-400 flex-shrink-0" />
                                If the payment tab didn&apos;t open automatically:
                              </p>
                              <a 
                                href={paymentUrl}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="mt-2 flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-yellow-700 bg-yellow-100 hover:bg-yellow-200 dark:text-yellow-200 dark:bg-yellow-900/40 dark:hover:bg-yellow-900/60 rounded-md transition-colors duration-200 border border-yellow-300 dark:border-yellow-700"
                              >
                                <span className="mr-2">Open Payment Link</span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="lucide lucide-external-link">
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
                        className="block mt-3 text-sm text-yellow-600 dark:text-yellow-400 underline"
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
                    <CheckCircle className="h-4 w-4 text-green-600 dark:text-green-400" />
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
                    <AlertCircle className="h-4 w-4 text-red-600 dark:text-red-400" />
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
              className="bg-white p-4 rounded-md shadow dark:bg-gray-800"
            >
              <h3 className="text-lg font-medium">Online Payment Instructions</h3>
              <p className="text-sm mt-2 text-muted-foreground">
                1. Enter the total amount to be collected.<br />
                2. Add multiple donors with their contribution amounts.<br />
                3. Click &quot;Pay Now&quot; to process the payment directly.<br />
                4. Choose from multiple payment methods including credit/debit cards, e-wallets, bank transfers, and more.
              </p>
            </motion.div>
          </motion.div>
          
          <motion.aside 
            variants={itemVariants}
            className="w-full md:w-96 lg:w-[30rem]"
          >
            <div className="bg-white dark:bg-gray-800 rounded-md shadow p-4">
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
                  className="p-4 text-center"
                >
                  <h3 className="text-lg font-medium mb-4">
                    {paymentStatus === "pending" ? "Payment in Progress" : 
                     paymentStatus === "completed" ? "Payment Completed" : 
                     "Payment Failed"}
                  </h3>
                  <p className="text-sm text-muted-foreground mb-4">
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
                    className="px-4 py-2 bg-primary text-primary-foreground rounded-md hover:bg-primary/90"
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