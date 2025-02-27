"use client";

import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { CheckCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";

export default function PaymentSuccessPage() {
  const searchParams = useSearchParams();
  const [loading, setLoading] = useState(true);
  const [donation, setDonation] = useState<any>(null);
  const [error, setError] = useState<string | null>(null);
  
  // Get the invoice ID from URL parameters
  const invoiceId = searchParams?.get("id") || null;
  
  useEffect(() => {
    if (!invoiceId) {
      setError("Invalid payment information");
      setLoading(false);
      return;
    }
    
    async function fetchPaymentDetails() {
      try {
        const response = await fetch(`/api/xendit/invoice-status/${invoiceId}`);
        
        if (!response.ok) {
          throw new Error("Failed to fetch payment details");
        }
        
        const data = await response.json();
        
        if (!data.paid) {
          setError("This payment is not marked as completed");
        } else {
          setDonation(data);
        }
      } catch (error) {
        console.error("Error fetching payment details:", error);
        setError("Failed to load payment details. Please contact support.");
      } finally {
        setLoading(false);
      }
    }
    
    fetchPaymentDetails();
  }, [invoiceId]);
  
  return (
    <div className="container max-w-3xl mx-auto py-20 px-4">
      <Card className="shadow-lg">
        <CardHeader className="text-center pb-2">
          <div className="mx-auto mb-4 bg-green-100 w-20 h-20 rounded-full flex items-center justify-center">
            <CheckCircle className="h-12 w-12 text-green-600" />
          </div>
          <CardTitle className="text-3xl font-bold text-green-600">
            Thank You!
          </CardTitle>
          <p className="text-xl mt-2">Your donation was successful</p>
        </CardHeader>
        <CardContent className="text-center">
          {loading ? (
            <div className="flex justify-center py-8">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
            </div>
          ) : error ? (
            <div className="bg-destructive/15 border border-destructive text-destructive p-4 rounded-md my-4">
              <p>{error}</p>
              <p className="text-sm mt-2">
                If you believe this is an error, please contact our support team.
              </p>
            </div>
          ) : donation ? (
            <div className="space-y-6 py-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-left">
                <div>
                  <p className="text-sm text-muted-foreground">Reference Number</p>
                  <p className="font-medium">{donation.transactionDetails.reference_id}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Amount</p>
                  <p className="font-medium text-xl">
                    ₱{parseFloat(donation.transactionDetails.amount).toLocaleString('en-PH', {
                      minimumFractionDigits: 2,
                      maximumFractionDigits: 2
                    })}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Date</p>
                  <p className="font-medium">
                    {new Date(donation.transactionDetails.paid_at).toLocaleString('en-PH')}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Payment Method</p>
                  <p className="font-medium">
                    {donation.transactionDetails.payment_method || 'Online Payment'}
                  </p>
                </div>
              </div>
              
              {donation.donations && donation.donations.length > 0 && (
                <div className="pt-4 border-t">
                  <p className="font-medium mb-2 text-left">Donation Details:</p>
                  <ul className="space-y-2 text-left">
                    {donation.donations.map((item: any, index: number) => (
                      <li key={index} className="bg-muted p-3 rounded-md">
                        <div className="flex justify-between items-center">
                          <span>
                            {item.missionary?.full_name || item.local_church?.name || 'Recipient'}
                          </span>
                          <span className="font-medium">
                            ₱{parseFloat(item.amount).toLocaleString('en-PH', {
                              minimumFractionDigits: 2,
                              maximumFractionDigits: 2
                            })}
                          </span>
                        </div>
                      </li>
                    ))}
                  </ul>
                </div>
              )}
              
              <div className="mt-6 pt-4 border-t text-center">
                <p className="text-sm text-muted-foreground">
                  A receipt has been sent to your email.
                </p>
                <p className="text-sm text-muted-foreground mt-1">
                  Thank you for your generosity and support!
                </p>
              </div>
            </div>
          ) : (
            <p>No payment information found.</p>
          )}
        </CardContent>
        <CardFooter className="flex flex-col space-y-4">
          <div className="flex flex-col space-y-2 w-full">
            <Link href="/giving" className="w-full">
              <Button variant="outline" className="w-full">
                Make Another Donation
              </Button>
            </Link>
            <Link href="/" className="w-full">
              <Button className="w-full">
                Back to Home
              </Button>
            </Link>
          </div>
        </CardFooter>
      </Card>
    </div>
  );
} 