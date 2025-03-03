"use client";

import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Alert, AlertTitle, AlertDescription } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";
import { CheckCircle, AlertCircle, Loader2, ExternalLink } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";

interface PaymentStatusIndicatorProps {
  onRetry?: () => void;
}

/**
 * PaymentStatusIndicator Component
 * 
 * Displays the current payment status with appropriate visual feedback.
 * This component shows different alerts based on the payment status.
 */
export function PaymentStatusIndicator({ onRetry }: PaymentStatusIndicatorProps) {
  const { 
    paymentStatus, 
    paymentUrl, 
    error 
  } = usePaymentWizardStore();

  // Animation variants
  const alertVariants = {
    hidden: { opacity: 0, y: 10 },
    visible: { opacity: 1, y: 0 },
    exit: { opacity: 0, y: -10 }
  };

  return (
    <AnimatePresence mode="wait">
      {paymentStatus === 'idle' && (
        <motion.div
          key="idle"
          variants={alertVariants}
          initial="hidden"
          animate="visible"
          exit="exit"
          transition={{ duration: 0.3 }}
        >
          <Alert className="bg-blue-50 border-blue-200 dark:bg-blue-900/20 dark:border-blue-800">
            <AlertCircle className="h-4 w-4 text-blue-600 dark:text-blue-400" />
            <AlertTitle>Ready to process payment</AlertTitle>
            <AlertDescription>
              Click the "Pay Now" button to generate a payment link and complete your donation.
            </AlertDescription>
          </Alert>
        </motion.div>
      )}
      
      {paymentStatus === 'pending' && (
        <motion.div
          key="pending"
          variants={alertVariants}
          initial="hidden"
          animate="visible"
          exit="exit"
          transition={{ duration: 0.3 }}
        >
          <Alert className="bg-yellow-50 border-yellow-200 dark:bg-yellow-900/20 dark:border-yellow-800">
            <Loader2 className="h-4 w-4 text-yellow-600 dark:text-yellow-400 animate-spin" />
            <AlertTitle>Payment in progress</AlertTitle>
            <AlertDescription>
              <p className="mb-2">Please complete your payment in the opened tab.</p>
              
              {paymentUrl && (
                <Button
                  variant="outline"
                  size="sm"
                  className="mt-2 text-yellow-700 border-yellow-300 hover:bg-yellow-100 dark:text-yellow-400 dark:border-yellow-700 dark:hover:bg-yellow-900/20"
                  onClick={() => window.open(paymentUrl, '_blank')}
                >
                  <ExternalLink className="mr-2 h-4 w-4" />
                  Open Payment Link Again
                </Button>
              )}
            </AlertDescription>
          </Alert>
        </motion.div>
      )}
      
      {paymentStatus === 'completed' && (
        <motion.div
          key="completed"
          variants={alertVariants}
          initial="hidden"
          animate="visible"
          exit="exit"
          transition={{ duration: 0.3 }}
        >
          <Alert className="bg-green-50 border-green-200 dark:bg-green-900/20 dark:border-green-800">
            <CheckCircle className="h-4 w-4 text-green-600 dark:text-green-400" />
            <AlertTitle>Payment completed</AlertTitle>
            <AlertDescription>
              Your payment has been successfully processed. Thank you for your donation!
            </AlertDescription>
          </Alert>
        </motion.div>
      )}
      
      {paymentStatus === 'failed' && (
        <motion.div
          key="failed"
          variants={alertVariants}
          initial="hidden"
          animate="visible"
          exit="exit"
          transition={{ duration: 0.3 }}
        >
          <Alert variant="destructive">
            <AlertCircle className="h-4 w-4" />
            <AlertTitle>Payment failed</AlertTitle>
            <AlertDescription>
              <p className="mb-2">{error || "There was an issue processing your payment."}</p>
              
              {onRetry && (
                <Button
                  variant="outline"
                  size="sm"
                  className="mt-2 border-red-300 hover:bg-red-100 dark:border-red-800 dark:hover:bg-red-900/20"
                  onClick={onRetry}
                >
                  Try Again
                </Button>
              )}
            </AlertDescription>
          </Alert>
        </motion.div>
      )}
    </AnimatePresence>
  );
} 