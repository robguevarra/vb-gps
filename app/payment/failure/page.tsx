"use client";

import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { XCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";

export default function PaymentFailurePage() {
  const searchParams = useSearchParams();
  const [error, setError] = useState<string>("Your payment could not be processed");
  
  // Get error details from URL parameters
  const errorCode = searchParams?.get("error_code") || null;
  const errorMessage = searchParams?.get("error_message") || null;
  const invoiceId = searchParams?.get("id") || null;
  
  useEffect(() => {
    if (errorMessage) {
      setError(errorMessage);
    } else if (errorCode) {
      // Map error codes to user-friendly messages
      const errorMessages: Record<string, string> = {
        "INVALID_CARD_DETAILS": "The card details you provided are invalid.",
        "INSUFFICIENT_BALANCE": "The card has insufficient balance.",
        "CARD_DECLINED": "The card was declined by the issuing bank.",
        "EXPIRED_CARD": "The card has expired.",
        "3DS_AUTHENTICATION_FAILED": "3D Secure authentication failed.",
        "PROCESSING_ERROR": "There was an error processing your payment.",
      };
      
      setError(errorMessages[errorCode] || "Your payment could not be processed");
    }
  }, [errorCode, errorMessage]);
  
  return (
    <div className="container max-w-3xl mx-auto py-20 px-4">
      <Card className="shadow-lg">
        <CardHeader className="text-center pb-2">
          <div className="mx-auto mb-4 bg-red-100 w-20 h-20 rounded-full flex items-center justify-center">
            <XCircle className="h-12 w-12 text-red-600" />
          </div>
          <CardTitle className="text-3xl font-bold text-red-600">
            Payment Failed
          </CardTitle>
          <p className="text-xl mt-2">We couldn't process your donation</p>
        </CardHeader>
        <CardContent className="text-center">
          <div className="bg-destructive/15 border border-destructive text-destructive p-4 rounded-md my-4">
            <p className="font-medium">{error}</p>
            <p className="text-sm mt-2">
              No charges have been made to your payment method.
            </p>
          </div>
          
          <div className="mt-8 space-y-4">
            <h3 className="font-semibold text-lg">What would you like to do?</h3>
            
            <div className="space-y-2 text-left">
              <div className="p-3 bg-muted rounded-md">
                <h4 className="font-medium">Try a different payment method</h4>
                <p className="text-sm text-muted-foreground">
                  Go back to the donation page and try using a different payment method or card.
                </p>
              </div>
              
              <div className="p-3 bg-muted rounded-md">
                <h4 className="font-medium">Check with your bank</h4>
                <p className="text-sm text-muted-foreground">
                  Contact your bank to ensure there are no restrictions on your card
                  for online or international transactions.
                </p>
              </div>
              
              <div className="p-3 bg-muted rounded-md">
                <h4 className="font-medium">Try again later</h4>
                <p className="text-sm text-muted-foreground">
                  Sometimes payment issues are temporary. You can try again in a few minutes.
                </p>
              </div>
            </div>
          </div>
          
          {invoiceId && (
            <div className="mt-6 pt-4 border-t text-center">
              <p className="text-sm text-muted-foreground">
                Reference ID: <span className="font-mono">{invoiceId}</span>
              </p>
              <p className="text-sm text-muted-foreground mt-1">
                Please quote this reference if you contact support.
              </p>
            </div>
          )}
        </CardContent>
        <CardFooter className="flex flex-col space-y-4">
          <div className="flex flex-col space-y-2 w-full">
            <Link href="/giving" className="w-full">
              <Button className="w-full">
                Try Again
              </Button>
            </Link>
            <Link href="/" className="w-full">
              <Button variant="outline" className="w-full">
                Back to Home
              </Button>
            </Link>
          </div>
        </CardFooter>
      </Card>
    </div>
  );
} 