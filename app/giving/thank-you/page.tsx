"use client";

import { useEffect, useState, Suspense } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { CheckCircle, Heart, Gift, ArrowRight, Calendar, Clock, FileText, User, Loader2, AlertCircle, RefreshCw } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { motion, AnimatePresence } from "framer-motion";
import { format } from "date-fns";

// Victory Bulacan brand color
const BRAND_COLOR = "#00458d";

function ThankYouContent() {
  const searchParams = useSearchParams();
  const [loading, setLoading] = useState(true);
  const [donation, setDonation] = useState<any>(null);
  const [error, setError] = useState<string | null>(null);
  const [retrying, setRetrying] = useState(false);
  
  // Get the reference ID from URL parameters
  const referenceId = searchParams?.get("ref") || null;
  
  const fetchDonationDetails = async () => {
    if (!referenceId) {
      setError("Invalid donation reference");
      setLoading(false);
      return;
    }
    
    try {
      setLoading(true);
      const response = await fetch(`/api/donations/details?reference=${referenceId}`);
      
      if (!response.ok) {
        throw new Error(`Failed to fetch donation details (Status: ${response.status})`);
      }
      
      const data = await response.json();
      setDonation(data);
      setError(null);
    } catch (error) {
      console.error("Error fetching donation details:", error);
      setError("Failed to load donation details. Please contact support.");
    } finally {
      setLoading(false);
      setRetrying(false);
    }
  };
  
  useEffect(() => {
    fetchDonationDetails();
  }, [referenceId]);

  const handleRetry = () => {
    setRetrying(true);
    fetchDonationDetails();
  };

  // Animation variants
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  };
  
  const itemVariants = {
    hidden: { y: 20, opacity: 0 },
    visible: {
      y: 0,
      opacity: 1,
      transition: {
        type: "spring",
        stiffness: 100
      }
    }
  };

  const fadeIn = {
    hidden: { opacity: 0 },
    visible: { 
      opacity: 1,
      transition: { duration: 0.6 }
    }
  };
  
  return (
    <div className="container max-w-4xl mx-auto py-12 px-4 min-h-[80vh] flex flex-col justify-center">
      <AnimatePresence mode="wait">
        <motion.div
          key={loading ? "loading" : error ? "error" : "content"}
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: -20 }}
          transition={{ duration: 0.5 }}
          className="w-full"
        >
          <Card className="shadow-xl border-0 overflow-hidden bg-white dark:bg-gray-900">
            {/* Brand color top bar */}
            <div className="h-2 bg-[#00458d]"></div>
            
            {loading ? (
              <CardContent className="flex flex-col items-center justify-center py-16">
                <div className="relative w-20 h-20 mb-6">
                  <div className="absolute inset-0 rounded-full bg-blue-50 dark:bg-blue-900/20 flex items-center justify-center">
                    <Loader2 className="h-10 w-10 text-[#00458d] animate-spin" />
                  </div>
                </div>
                <h2 className="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-2">Processing Your Donation</h2>
                <p className="text-gray-500 dark:text-gray-400 text-center max-w-md">
                  We're retrieving your donation details. This will only take a moment...
                </p>
              </CardContent>
            ) : error ? (
              <CardContent className="py-10">
                <div className="flex flex-col items-center text-center mb-6">
                  <div className="w-20 h-20 rounded-full bg-red-50 dark:bg-red-900/20 flex items-center justify-center mb-6">
                    <AlertCircle className="h-10 w-10 text-red-500" />
                  </div>
                  <h2 className="text-2xl font-bold text-gray-800 dark:text-gray-200 mb-2">Something Went Wrong</h2>
                  <p className="text-gray-500 dark:text-gray-400 max-w-md mb-6">
                    {error}
                  </p>
                  <Button 
                    onClick={handleRetry} 
                    disabled={retrying}
                    className="bg-[#00458d] hover:bg-[#003366] text-white"
                  >
                    {retrying ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Retrying...
                      </>
                    ) : (
                      <>
                        <RefreshCw className="mr-2 h-4 w-4" />
                        Retry
                      </>
                    )}
                  </Button>
                </div>
                
                <Alert variant="destructive" className="mt-6">
                  <AlertCircle className="h-4 w-4" />
                  <AlertDescription className="ml-2">
                    If this problem persists, please contact our support team with reference: {referenceId}
                  </AlertDescription>
                </Alert>
              </CardContent>
            ) : donation ? (
              <>
                <CardHeader className="text-center pb-2 relative pt-10">
                  <motion.div 
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    transition={{ 
                      type: "spring", 
                      stiffness: 200, 
                      damping: 15,
                      delay: 0.2 
                    }}
                    className="mx-auto mb-6 bg-blue-50 dark:bg-blue-900/20 w-24 h-24 rounded-full flex items-center justify-center"
                  >
                    <CheckCircle className="h-12 w-12 text-[#00458d]" />
                  </motion.div>
                  
                  <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.4 }}
                  >
                    <CardTitle className="text-3xl md:text-4xl font-bold text-[#00458d]">
                      Thank You!
                    </CardTitle>
                    <p className="text-xl mt-2 text-gray-700 dark:text-gray-300">
                      Your donation has been recorded successfully
                    </p>
                  </motion.div>
                </CardHeader>
                
                <CardContent>
                  <motion.div 
                    variants={containerVariants}
                    initial="hidden"
                    animate="visible"
                    className="space-y-8 py-4"
                  >
                    <motion.div variants={itemVariants}>
                      <div className="bg-gray-50 dark:bg-gray-800/50 rounded-lg overflow-hidden border border-gray-100 dark:border-gray-700">
                        <div className="px-4 py-3 bg-[#00458d]/10 border-b border-gray-100 dark:border-gray-700">
                          <h3 className="font-medium text-[#00458d] flex items-center">
                            <FileText className="h-4 w-4 mr-2" />
                            Donation Summary
                          </h3>
                        </div>
                        
                        <div className="p-4 grid grid-cols-1 md:grid-cols-2 gap-4">
                          <div className="space-y-1">
                            <p className="text-xs text-gray-500 dark:text-gray-400">Reference Number</p>
                            <p className="font-medium text-gray-800 dark:text-gray-200 flex items-center">
                              {donation.reference_id || referenceId}
                            </p>
                          </div>
                          
                          <div className="space-y-1">
                            <p className="text-xs text-gray-500 dark:text-gray-400">Amount</p>
                            <p className="font-medium text-xl text-[#00458d]">
                              ₱{parseFloat(donation.amount).toLocaleString('en-PH', {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2
                              })}
                            </p>
                          </div>
                          
                          <div className="space-y-1">
                            <p className="text-xs text-gray-500 dark:text-gray-400">Date</p>
                            <p className="font-medium text-gray-800 dark:text-gray-200 flex items-center">
                              <Calendar className="h-3.5 w-3.5 mr-1.5 text-gray-400" />
                              {donation.created_at ? format(new Date(donation.created_at), 'MMM d, yyyy') : '-'}
                            </p>
                          </div>
                          
                          <div className="space-y-1">
                            <p className="text-xs text-gray-500 dark:text-gray-400">Time</p>
                            <p className="font-medium text-gray-800 dark:text-gray-200 flex items-center">
                              <Clock className="h-3.5 w-3.5 mr-1.5 text-gray-400" />
                              {donation.created_at ? format(new Date(donation.created_at), 'h:mm a') : '-'}
                            </p>
                          </div>
                          
                          <div className="space-y-1 md:col-span-2">
                            <p className="text-xs text-gray-500 dark:text-gray-400">Status</p>
                            <div className="flex items-center">
                              <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400">
                                <CheckCircle className="h-3 w-3 mr-1" /> 
                                {donation.status || 'Completed'}
                              </span>
                              
                              {donation.payment_method && (
                                <span className="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400">
                                  {donation.payment_method}
                                </span>
                              )}
                            </div>
                          </div>
                        </div>
                      </div>
                    </motion.div>
                    
                    <motion.div variants={itemVariants}>
                      <div className="bg-gray-50 dark:bg-gray-800/50 rounded-lg overflow-hidden border border-gray-100 dark:border-gray-700">
                        <div className="px-4 py-3 bg-[#00458d]/10 border-b border-gray-100 dark:border-gray-700">
                          <h3 className="font-medium text-[#00458d] flex items-center">
                            <Heart className="h-4 w-4 mr-2" />
                            Recipient Details
                          </h3>
                        </div>
                        
                        <div className="p-4">
                          <div className="flex justify-between items-center">
                            <div className="flex items-center">
                              <div className="w-10 h-10 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center mr-3">
                                <User className="h-5 w-5 text-[#00458d]" />
                              </div>
                              <div>
                                <span className="font-medium text-gray-800 dark:text-gray-200">
                                  {donation.recipient?.full_name || donation.recipient?.name || 'Recipient'}
                                </span>
                                {donation.donor?.email && (
                                  <p className="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                                    Donor: {donation.donor.name || donation.donor.email}
                                  </p>
                                )}
                              </div>
                            </div>
                            <span className="font-medium text-[#00458d]">
                              ₱{parseFloat(donation.amount).toLocaleString('en-PH', {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2
                              })}
                            </span>
                          </div>
                          
                          {donation.notes && (
                            <div className="mt-4 pt-4 border-t border-gray-100 dark:border-gray-700">
                              <p className="text-xs text-gray-500 dark:text-gray-400 mb-1">Note:</p>
                              <p className="text-sm text-gray-700 dark:text-gray-300">
                                {donation.notes}
                              </p>
                            </div>
                          )}
                        </div>
                      </div>
                    </motion.div>
                    
                    <motion.div variants={itemVariants}>
                      <div className="bg-[#00458d]/5 dark:bg-[#00458d]/10 rounded-lg p-6 border border-[#00458d]/10 dark:border-[#00458d]/20">
                        <div className="flex items-center justify-center mb-4">
                          <Gift className="h-5 w-5 text-[#00458d] mr-2" />
                          <h3 className="font-medium text-[#00458d]">Your Impact</h3>
                        </div>
                        
                        <p className="text-center text-gray-700 dark:text-gray-300">
                          Thank you for your generosity! Your donation helps support our mission and makes a real difference in the lives of those we serve.
                        </p>
                        
                        <div className="mt-4 text-center">
                          <p className="text-sm text-gray-500 dark:text-gray-400">
                            A receipt has been sent to your email.
                          </p>
                        </div>
                      </div>
                    </motion.div>
                  </motion.div>
                </CardContent>
                
                <CardFooter className="flex flex-col space-y-4 bg-gray-50 dark:bg-gray-800/50 p-6 border-t border-gray-100 dark:border-gray-700">
                  <motion.div 
                    variants={containerVariants}
                    initial="hidden"
                    animate="visible"
                    className="flex flex-col sm:flex-row gap-3 w-full"
                  >
                    <motion.div variants={itemVariants} className="w-full">
                      <Link href="/dashboard" className="w-full">
                        <Button className="w-full bg-[#00458d] hover:bg-[#003366] text-white">
                          Back to Dashboard
                        </Button>
                      </Link>
                    </motion.div>
                  </motion.div>
                </CardFooter>
              </>
            ) : (
              <CardContent className="text-center py-16">
                <div className="flex flex-col items-center">
                  <div className="w-20 h-20 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center mb-6">
                    <AlertCircle className="h-10 w-10 text-gray-400" />
                  </div>
                  <h2 className="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-2">No Donation Found</h2>
                  <p className="text-gray-500 dark:text-gray-400">
                    We couldn't find any donation information for the provided reference.
                  </p>
                </div>
              </CardContent>
            )}
          </Card>
        </motion.div>
      </AnimatePresence>
    </div>
  );
}

// Wrap the component with Suspense
export default function ThankYouPage() {
  return (
    <Suspense fallback={
      <div className="container max-w-4xl mx-auto py-12 px-4 min-h-[80vh] flex flex-col justify-center">
        <Card className="shadow-xl border-0 bg-white dark:bg-gray-900">
          <div className="h-2 bg-[#00458d]"></div>
          <CardContent className="flex flex-col items-center justify-center py-16">
            <div className="relative w-20 h-20 mb-6">
              <div className="absolute inset-0 rounded-full bg-blue-50 dark:bg-blue-900/20 flex items-center justify-center">
                <Loader2 className="h-10 w-10 text-[#00458d] animate-spin" />
              </div>
            </div>
            <h2 className="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-2">Loading</h2>
            <p className="text-gray-500 dark:text-gray-400">
              Please wait while we retrieve your donation details...
            </p>
          </CardContent>
        </Card>
      </div>
    }>
      <ThankYouContent />
    </Suspense>
  );
} 