"use client";

import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { CheckCircle2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";

export default function ThankYouPage() {
  const searchParams = useSearchParams();
  const [donationDetails, setDonationDetails] = useState({
    amount: 0,
    recipientName: "",
    isRecurring: false,
    interval: "",
  });
  
  useEffect(() => {
    if (searchParams) {
      // Get donation details from URL parameters
      const amount = searchParams.get("amount") ? parseFloat(searchParams.get("amount") || "0") : 0;
      const recipientName = searchParams.get("recipient") || "";
      const isRecurring = searchParams.get("recurring") === "true";
      const interval = searchParams.get("interval") || "";
      
      setDonationDetails({
        amount,
        recipientName,
        isRecurring,
        interval,
      });
    }
  }, [searchParams]);
  
  return (
    <div className="container mx-auto py-10">
      <div className="max-w-md mx-auto">
        <Card className="border-green-100">
          <CardHeader className="text-center">
            <div className="flex justify-center mb-4">
              <CheckCircle2 className="h-16 w-16 text-green-500" />
            </div>
            <CardTitle className="text-2xl">Thank You for Your Donation!</CardTitle>
            <CardDescription>
              Your {donationDetails.isRecurring ? "recurring" : "one-time"} donation has been processed successfully.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {donationDetails.amount > 0 && (
              <div className="bg-muted p-4 rounded-md">
                <h3 className="font-medium mb-2">Donation Summary</h3>
                <div className="space-y-1 text-sm">
                  {donationDetails.recipientName && (
                    <p><span className="font-medium">Recipient:</span> {donationDetails.recipientName}</p>
                  )}
                  <p><span className="font-medium">Amount:</span> PHP {donationDetails.amount.toLocaleString()}</p>
                  <p>
                    <span className="font-medium">Type:</span> {donationDetails.isRecurring 
                      ? `Recurring (${donationDetails.interval.toLowerCase() === "month" ? "Monthly" : "Weekly"})` 
                      : "One-time"}
                  </p>
                </div>
              </div>
            )}
            
            <div className="text-center text-muted-foreground">
              <p>A receipt has been sent to your email address.</p>
              {donationDetails.isRecurring && (
                <p className="mt-2">
                  Your recurring donation has been set up successfully. The next payment will be processed in {donationDetails.interval.toLowerCase() === "month" ? "one month" : "one week"}.
                </p>
              )}
            </div>
          </CardContent>
          <CardFooter className="flex justify-center">
            <Button asChild>
              <Link href="/">Return to Home</Link>
            </Button>
          </CardFooter>
        </Card>
      </div>
    </div>
  );
} 