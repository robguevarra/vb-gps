"use client";

import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { XCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";

export default function FailedPaymentPage() {
  const searchParams = useSearchParams();
  const [errorDetails, setErrorDetails] = useState({
    message: "",
    code: "",
  });
  
  useEffect(() => {
    if (searchParams) {
      // Get error details from URL parameters
      const message = searchParams.get("message") || "Your payment could not be processed.";
      const code = searchParams.get("code") || "";
      
      setErrorDetails({
        message,
        code,
      });
    }
  }, [searchParams]);
  
  return (
    <div className="container mx-auto py-10">
      <div className="max-w-md mx-auto">
        <Card className="border-red-100">
          <CardHeader className="text-center">
            <div className="flex justify-center mb-4">
              <XCircle className="h-16 w-16 text-red-500" />
            </div>
            <CardTitle className="text-2xl">Payment Failed</CardTitle>
            <CardDescription>
              We were unable to process your donation.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="bg-red-50 p-4 rounded-md">
              <h3 className="font-medium mb-2 text-red-800">Error Details</h3>
              <p className="text-red-700">{errorDetails.message}</p>
              {errorDetails.code && (
                <p className="text-sm text-red-600 mt-1">Error code: {errorDetails.code}</p>
              )}
            </div>
            
            <div className="text-center text-muted-foreground">
              <p>Please try again or use a different payment method.</p>
              <p className="mt-2">
                If you continue to experience issues, please contact our support team.
              </p>
            </div>
          </CardContent>
          <CardFooter className="flex justify-center gap-4">
            <Button variant="outline" asChild>
              <Link href="/">Return to Home</Link>
            </Button>
            <Button asChild>
              <Link href="/donate">Try Again</Link>
            </Button>
          </CardFooter>
        </Card>
      </div>
    </div>
  );
} 