"use client"

import { useState, useEffect } from "react";
import { BulkOnlinePaymentWizard } from "@/components/BulkOnlinePaymentWizard";
import { useToast } from "@/hooks/use-toast";
import { createClient } from "@/utils/supabase/client";
import { AlertCircle, CheckCircle } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";

interface ManualRemittanceTabWrapperProps {
  missionaryId: string;
}

export function ManualRemittanceTabWrapper({ missionaryId }: ManualRemittanceTabWrapperProps) {
  const { toast } = useToast();
  const [missionaryName, setMissionaryName] = useState<string>("");
  const [paymentStatus, setPaymentStatus] = useState<"idle" | "pending" | "completed" | "failed">("idle");
  const [lastPaymentTimestamp, setLastPaymentTimestamp] = useState<string | null>(null);
  
  // Fetch missionary name on component mount
  useEffect(() => {
    const fetchMissionaryName = async () => {
      try {
        const supabase = createClient();
        const { data, error } = await supabase
          .from("profiles")
          .select("full_name") // Only select full_name, not email
          .eq("id", missionaryId)
          .single();
          
        if (error) {
          return;
        }
        
        if (data) {
          setMissionaryName(data.full_name);
        }
      } catch (err) {
      }
    };
    
    fetchMissionaryName();
  }, [missionaryId]);

  // Check for payment status on component mount and window focus
  useEffect(() => {
    const checkPaymentStatus = async () => {
      try {
        // Get payment state from localStorage
        const paymentStateStr = localStorage.getItem(`payment_state_${missionaryId}`);
        if (!paymentStateStr) {
          return;
        }
        
        const paymentState = JSON.parse(paymentStateStr);
        
        // Check if the payment state is for the current missionary
        if (paymentState.missionaryId !== missionaryId) {
          return;
        }
        
        // Set the last payment timestamp
        setLastPaymentTimestamp(paymentState.timestamp);
        
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
                }
              } else if (data) {
                if (data.status === "paid") {
                  setPaymentStatus("completed");
                  
                  // Update localStorage
                  localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
                    status: "completed",
                    timestamp: new Date().toISOString()
                  }));
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
        }
      } catch (error) {
      }
    };
    
    // Function to check payment status directly from Xendit API
    const checkXenditPaymentStatus = async (invoiceId: string) => {
      try {
        // Call our API endpoint to check the invoice status
        const response = await fetch(`/api/xendit/check-invoice?invoiceId=${invoiceId}`);
        
        if (!response.ok) {
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
        } else if (data.status === "EXPIRED" || data.status === "FAILED") {
          setPaymentStatus("failed");
          
          // Update localStorage
          localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
            status: "failed",
            timestamp: new Date().toISOString()
          }));
        } else {
        }
      } catch (error) {
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
  
  const handleResetPaymentStatus = () => {
    setPaymentStatus("idle");
    
    // Clear localStorage items
    localStorage.removeItem(`payment_status_${missionaryId}`);
    localStorage.removeItem(`payment_state_${missionaryId}`);
    localStorage.removeItem(`payment_${missionaryId}`);
    
    // Clear any polling intervals
    const pollingId = localStorage.getItem(`payment_polling_${missionaryId}`);
    if (pollingId) {
      try {
        clearInterval(parseInt(pollingId));
      } catch (err) {
      }
      localStorage.removeItem(`payment_polling_${missionaryId}`);
    }
  };

  return (
    <div className="flex flex-col gap-6">
      <div className="flex flex-col gap-6 md:flex-row">
        <div className="flex-1 space-y-4">
          <h2 className="text-2xl font-semibold">Manual Remittance</h2>
          <p className="text-muted-foreground text-sm">
            Generate a payment link to collect donations from multiple donors in a single transaction.
          </p>
          
          {paymentStatus === "pending" && (
            <Alert className="bg-yellow-50 border-yellow-200 dark:bg-yellow-900/20 dark:border-yellow-800">
              <AlertCircle className="h-4 w-4 text-yellow-600 dark:text-yellow-400" />
              <AlertTitle>Payment in progress</AlertTitle>
              <AlertDescription>
                Your payment link has been generated and opened in a new tab. Please complete the payment process.
                <button 
                  onClick={handleResetPaymentStatus}
                  className="block mt-2 text-sm text-yellow-600 dark:text-yellow-400 underline"
                >
                  Start a new payment
                </button>
              </AlertDescription>
            </Alert>
          )}
          
          {paymentStatus === "completed" && (
            <Alert className="bg-green-50 border-green-200 dark:bg-green-900/20 dark:border-green-800">
              <CheckCircle className="h-4 w-4 text-green-600 dark:text-green-400" />
              <AlertTitle>Payment completed</AlertTitle>
              <AlertDescription>
                Your payment has been successfully processed. The donations have been recorded.
                <button 
                  onClick={handleResetPaymentStatus}
                  className="block mt-2 text-sm text-green-600 dark:text-green-400 underline"
                >
                  Start a new payment
                </button>
              </AlertDescription>
            </Alert>
          )}
          
          {paymentStatus === "failed" && (
            <Alert className="bg-red-50 border-red-200 dark:bg-red-900/20 dark:border-red-800">
              <AlertCircle className="h-4 w-4 text-red-600 dark:text-red-400" />
              <AlertTitle>Payment failed</AlertTitle>
              <AlertDescription>
                There was an issue processing your payment. Please try again.
                <button 
                  onClick={handleResetPaymentStatus}
                  className="block mt-2 text-sm text-red-600 dark:text-red-400 underline"
                >
                  Start a new payment
                </button>
              </AlertDescription>
            </Alert>
          )}
          
          <div className="bg-white p-4 rounded-md shadow dark:bg-gray-800">
            <h3 className="text-lg font-medium">Online Payment Instructions</h3>
            <p className="text-sm mt-2 text-muted-foreground">
              1. Enter the total amount to be collected.<br />
              2. Add multiple donors with their contribution amounts.<br />
              3. Click "Pay Now" to process the payment directly.<br />
              4. Choose from multiple payment methods including credit/debit cards, e-wallets, bank transfers, and more.
            </p>
          </div>
        </div>
        
        <aside className="w-full md:w-96 lg:w-[30rem]">
          <div className="bg-white dark:bg-gray-800 rounded-md shadow p-4">
            {paymentStatus === "idle" ? (
              <BulkOnlinePaymentWizard
                missionaryId={missionaryId}
                missionaryName={missionaryName || "Missionary"}
                title="Manual Remittance"
                onSuccess={handleBulkOnlineSuccess}
                onError={handleBulkOnlineError}
              />
            ) : (
              <div className="p-4 text-center">
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
                <button
                  onClick={handleResetPaymentStatus}
                  className="px-4 py-2 bg-primary text-primary-foreground rounded-md hover:bg-primary/90"
                >
                  Start New Payment
                </button>
              </div>
            )}
          </div>
        </aside>
      </div>
    </div>
  );
} 