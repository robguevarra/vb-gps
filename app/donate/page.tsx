"use client";

import { useState, useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { createClient } from "@/utils/supabase/client";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Checkbox } from "@/components/ui/checkbox";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Loader2, CreditCard, Calendar, Lock } from "lucide-react";
import { useRouter } from "next/navigation";
import { loadXenditJs, initializeXendit, parseExpiryDate, tokenizeCard } from "@/lib/xendit-client";

// Validation schema for the donation form
const donationFormSchema = z.object({
  donationType: z.enum(["missionary", "church"]),
  recipientId: z.string().uuid(),
  amount: z.coerce
    .number()
    .positive({ message: "Amount must be greater than 0" })
    .min(100, { message: "Minimum donation amount is 100" }),
  donor: z.object({
    name: z.string().min(1, { message: "Name is required" }),
    email: z.string().email({ message: "Valid email is required" }),
    phone: z.string().optional(),
  }),
  notes: z.string().optional(),
  isAnonymous: z.boolean().default(false),
  // Payment details
  paymentType: z.enum(["one-time", "recurring"]),
  recurringInterval: z.enum(["MONTH", "WEEK"]).optional(),
  // Card details
  cardNumber: z.string().min(16, { message: "Valid card number is required" }).max(19),
  cardExpiry: z.string().min(5, { message: "Valid expiry date is required (MM/YY)" }),
  cardCvv: z.string().min(3, { message: "Valid CVV is required" }).max(4),
  cardholderName: z.string().min(1, { message: "Cardholder name is required" }),
  saveCard: z.boolean().default(false),
});

type DonationFormData = z.infer<typeof donationFormSchema>;

// Type for missionaries and churches
type Recipient = {
  id: string;
  name: string;
  type: "missionary" | "church";
  description?: string;
};

export default function DonatePage() {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [recipients, setRecipients] = useState<Recipient[]>([]);
  const [activeTab, setActiveTab] = useState<"missionary" | "church">("missionary");
  const [paymentStep, setPaymentStep] = useState<"details" | "payment">("details");
  const [xenditLoaded, setXenditLoaded] = useState(false);
  const router = useRouter();
  
  // React Hook Form setup
  const {
    register,
    handleSubmit,
    watch,
    setValue,
    reset,
    trigger,
    formState: { errors, isValid },
  } = useForm<DonationFormData>({
    resolver: zodResolver(donationFormSchema),
    defaultValues: {
      donationType: "missionary",
      amount: 500,
      isAnonymous: false,
      paymentType: "one-time",
      saveCard: false,
    },
    mode: "onChange",
  });
  
  // Watch form values for dynamic updates
  const donationType = watch("donationType");
  const isAnonymous = watch("isAnonymous");
  const paymentType = watch("paymentType");
  const amount = watch("amount");
  
  // Initialize Supabase client
  const supabase = createClient();
  
  // Load Xendit.js on component mount
  useEffect(() => {
    async function loadXenditScript() {
      try {
        await loadXenditJs();
        initializeXendit(process.env.NEXT_PUBLIC_XENDIT_PUBLIC_KEY || "");
        setXenditLoaded(true);
      } catch (error) {
        console.error("Failed to load Xendit.js:", error);
        setError("Failed to load payment processor. Please try again later.");
      }
    }
    
    loadXenditScript();
  }, []);
  
  // Fetch missionaries and churches on component mount
  useEffect(() => {
    async function fetchRecipients() {
      try {
        // Fetch missionaries
        const { data: missionaries, error: missionaryError } = await supabase
          .from("profiles")
          .select("id, full_name, bio")
          .eq("role", "missionary");
          
        if (missionaryError) throw missionaryError;
        
        // Fetch churches
        const { data: churches, error: churchError } = await supabase
          .from("local_churches")
          .select("id, name, description");
          
        if (churchError) throw churchError;
        
        // Format the data
        const formattedMissionaries: Recipient[] = missionaries.map(m => ({
          id: m.id,
          name: m.full_name,
          description: m.bio,
          type: "missionary",
        }));
        
        const formattedChurches: Recipient[] = churches.map(c => ({
          id: c.id,
          name: c.name,
          description: c.description,
          type: "church",
        }));
        
        // Combine and set the data
        setRecipients([...formattedMissionaries, ...formattedChurches]);
      } catch (error) {
        console.error("Error fetching recipients:", error);
        setError("Failed to load missionaries and churches. Please try again later.");
      }
    }
    
    fetchRecipients();
  }, [supabase]);
  
  // Handle tab change
  const handleTabChange = (value: string) => {
    setActiveTab(value as "missionary" | "church");
    setValue("donationType", value as "missionary" | "church");
  };
  
  // Format card number with spaces
  const formatCardNumber = (value: string) => {
    const v = value.replace(/\s+/g, "").replace(/[^0-9]/gi, "");
    const matches = v.match(/\d{4,16}/g);
    const match = (matches && matches[0]) || "";
    const parts = [];
    
    for (let i = 0, len = match.length; i < len; i += 4) {
      parts.push(match.substring(i, i + 4));
    }
    
    if (parts.length) {
      return parts.join(" ");
    } else {
      return value;
    }
  };
  
  // Format expiry date
  const formatExpiryDate = (value: string) => {
    const v = value.replace(/\s+/g, "").replace(/[^0-9]/gi, "");
    
    if (v.length >= 2) {
      return `${v.substring(0, 2)}/${v.substring(2, 4)}`;
    }
    
    return v;
  };
  
  // Handle card number input
  const handleCardNumberChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const formattedValue = formatCardNumber(e.target.value);
    e.target.value = formattedValue;
  };
  
  // Handle expiry date input
  const handleExpiryChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const formattedValue = formatExpiryDate(e.target.value);
    e.target.value = formattedValue;
  };
  
  // Continue to payment step
  const continueToPayment = async () => {
    // Validate the first part of the form
    const isValid = await trigger([
      "donationType", 
      "recipientId", 
      "amount", 
      "donor.name", 
      "donor.email", 
      "paymentType",
      "recurringInterval"
    ]);
    
    if (isValid) {
      setPaymentStep("payment");
      window.scrollTo(0, 0);
    }
  };
  
  // Go back to details step
  const backToDetails = () => {
    setPaymentStep("details");
    window.scrollTo(0, 0);
  };
  
  // Submit donation form
  const onSubmit = async (data: DonationFormData) => {
    setIsLoading(true);
    setError(null);
    
    try {
      if (!xenditLoaded) {
        throw new Error("Payment processor not loaded. Please refresh the page and try again.");
      }
      
      // Parse expiry date
      const { month, year } = parseExpiryDate(data.cardExpiry);
      
      try {
        // Tokenize the card
        const tokenResponse = await tokenizeCard(
          data.cardNumber,
          month,
          year,
          data.cardCvv,
          data.saveCard // Use multiple-use token if saveCard is true
        );
        
        // Add the token to the data
        const paymentData = {
          ...data,
          cardToken: tokenResponse.id,
        };
        
        // For one-time payments
        if (data.paymentType === "one-time") {
          // Call the API endpoint to create a direct payment
          const response = await fetch("/api/xendit/direct-payment", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(paymentData),
          });
          
          const result = await response.json();
          
          if (!response.ok) {
            throw new Error(result.error || "Failed to process donation");
          }
          
          // Show success message and redirect
          setSuccess("Payment successful! Thank you for your donation.");
          
          // Get the selected recipient name
          const selectedRecipient = recipients.find(r => r.id === data.recipientId);
          
          // Redirect to thank you page with parameters
          router.push(`/donate/thank-you?amount=${data.amount}&recipient=${encodeURIComponent(selectedRecipient?.name || "")}&recurring=false`);
        } 
        // For recurring payments
        else {
          // Call the API endpoint to create a recurring payment
          const response = await fetch("/api/xendit/recurring-payment", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(paymentData),
          });
          
          const result = await response.json();
          
          if (!response.ok) {
            throw new Error(result.error || "Failed to set up recurring donation");
          }
          
          // Show success message and redirect
          setSuccess("Recurring donation set up successfully! Thank you for your support.");
          
          // Get the selected recipient name
          const selectedRecipient = recipients.find(r => r.id === data.recipientId);
          
          // Redirect to thank you page with parameters
          router.push(`/donate/thank-you?amount=${data.amount}&recipient=${encodeURIComponent(selectedRecipient?.name || "")}&recurring=true&interval=${data.recurringInterval}`);
        }
      } catch (tokenError) {
        console.error("Error tokenizing card:", tokenError);
        
        // Handle specific Xendit tokenization errors
        if (tokenError instanceof Error) {
          // Check for common card errors
          if (tokenError.message.includes("card_number")) {
            throw new Error("Invalid card number. Please check and try again.");
          } else if (tokenError.message.includes("card_exp")) {
            throw new Error("Invalid expiry date. Please check and try again.");
          } else if (tokenError.message.includes("card_cvn")) {
            throw new Error("Invalid CVV/security code. Please check and try again.");
          } else {
            throw new Error(`Card validation failed: ${tokenError.message}`);
          }
        } else {
          throw new Error("Card validation failed. Please check your card details and try again.");
        }
      }
    } catch (error) {
      console.error("Error processing payment:", error);
      const errorMessage = error instanceof Error 
        ? error.message 
        : "Failed to process payment. Please try again.";
      
      setError(errorMessage);
      
      // If it's a payment error, redirect to failed page
      if (errorMessage.includes("payment") || errorMessage.includes("card")) {
        router.push(`/donate/failed?message=${encodeURIComponent(errorMessage)}`);
      }
    } finally {
      setIsLoading(false);
    }
  };
  
  // Get the selected recipient
  const selectedRecipient = recipients.find(r => r.id === watch("recipientId"));
  
  return (
    <div className="container mx-auto py-10">
      <div className="max-w-3xl mx-auto">
        <h1 className="text-3xl font-bold text-center mb-2">Make a Donation</h1>
        <p className="text-center text-muted-foreground mb-8">
          Support our missionaries and churches with your generous donation
        </p>
        
        {error && (
          <div className="bg-destructive/15 border border-destructive text-destructive px-4 py-3 rounded-md mb-6">
            <p>{error}</p>
          </div>
        )}
        
        {success && (
          <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-md mb-6">
            <p>{success}</p>
          </div>
        )}
        
        <form onSubmit={handleSubmit(onSubmit)}>
          {paymentStep === "details" ? (
            <Card>
              <CardHeader>
                <CardTitle>Donation Details</CardTitle>
                <CardDescription>
                  Choose who you want to support and how much you'd like to donate
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Donation Type Tabs */}
                <div className="space-y-2">
                  <Label>Donation Type</Label>
                  <Tabs
                    defaultValue="missionary"
                    value={activeTab}
                    onValueChange={handleTabChange}
                    className="w-full"
                  >
                    <TabsList className="grid grid-cols-2 w-full mb-6">
                      <TabsTrigger value="missionary">Missionary</TabsTrigger>
                      <TabsTrigger value="church">Church</TabsTrigger>
                    </TabsList>
                    
                    <TabsContent value="missionary">
                      <div className="space-y-4">
                        <div className="space-y-2">
                          <Label htmlFor="recipient">Select a Missionary</Label>
                          <Select
                            onValueChange={(value) => setValue("recipientId", value)}
                            defaultValue=""
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Select a missionary" />
                            </SelectTrigger>
                            <SelectContent>
                              {recipients
                                .filter(r => r.type === "missionary")
                                .map(missionary => (
                                  <SelectItem key={missionary.id} value={missionary.id}>
                                    {missionary.name}
                                  </SelectItem>
                                ))}
                            </SelectContent>
                          </Select>
                          {errors.recipientId && (
                            <p className="text-sm text-destructive mt-1">
                              {errors.recipientId.message}
                            </p>
                          )}
                        </div>
                      </div>
                    </TabsContent>
                    
                    <TabsContent value="church">
                      <div className="space-y-4">
                        <div className="space-y-2">
                          <Label htmlFor="recipient">Select a Church</Label>
                          <Select
                            onValueChange={(value) => setValue("recipientId", value)}
                            defaultValue=""
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Select a church" />
                            </SelectTrigger>
                            <SelectContent>
                              {recipients
                                .filter(r => r.type === "church")
                                .map(church => (
                                  <SelectItem key={church.id} value={church.id}>
                                    {church.name}
                                  </SelectItem>
                                ))}
                            </SelectContent>
                          </Select>
                          {errors.recipientId && (
                            <p className="text-sm text-destructive mt-1">
                              {errors.recipientId.message}
                            </p>
                          )}
                        </div>
                      </div>
                    </TabsContent>
                  </Tabs>
                </div>
                
                {/* Donation Amount */}
                <div className="space-y-2">
                  <Label htmlFor="amount">Donation Amount (PHP)</Label>
                  <Input
                    id="amount"
                    type="number"
                    min="100"
                    step="100"
                    {...register("amount")}
                  />
                  {errors.amount && (
                    <p className="text-sm text-destructive mt-1">
                      {errors.amount.message}
                    </p>
                  )}
                </div>
                
                {/* Payment Type */}
                <div className="space-y-2">
                  <Label>Payment Type</Label>
                  <RadioGroup 
                    defaultValue="one-time"
                    value={paymentType}
                    onValueChange={(value) => setValue("paymentType", value as "one-time" | "recurring")}
                    className="flex flex-col space-y-1"
                  >
                    <div className="flex items-center space-x-2">
                      <RadioGroupItem value="one-time" id="one-time" />
                      <Label htmlFor="one-time">One-time Donation</Label>
                    </div>
                    <div className="flex items-center space-x-2">
                      <RadioGroupItem value="recurring" id="recurring" />
                      <Label htmlFor="recurring">Recurring Donation</Label>
                    </div>
                  </RadioGroup>
                </div>
                
                {/* Recurring Interval (only shown for recurring donations) */}
                {paymentType === "recurring" && (
                  <div className="space-y-2">
                    <Label htmlFor="recurringInterval">Recurring Interval</Label>
                    <Select
                      onValueChange={(value) => setValue("recurringInterval", value as "MONTH" | "WEEK")}
                      defaultValue="MONTH"
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select interval" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="WEEK">Weekly</SelectItem>
                        <SelectItem value="MONTH">Monthly</SelectItem>
                      </SelectContent>
                    </Select>
                    {errors.recurringInterval && (
                      <p className="text-sm text-destructive mt-1">
                        {errors.recurringInterval.message}
                      </p>
                    )}
                  </div>
                )}
                
                {/* Donor Information */}
                <div className="space-y-4">
                  <h3 className="text-lg font-medium">Your Information</h3>
                  
                  <div className="space-y-2">
                    <Label htmlFor="donor.name">Full Name</Label>
                    <Input
                      id="donor.name"
                      {...register("donor.name")}
                    />
                    {errors.donor?.name && (
                      <p className="text-sm text-destructive mt-1">
                        {errors.donor.name.message}
                      </p>
                    )}
                  </div>
                  
                  <div className="space-y-2">
                    <Label htmlFor="donor.email">Email Address</Label>
                    <Input
                      id="donor.email"
                      type="email"
                      {...register("donor.email")}
                    />
                    {errors.donor?.email && (
                      <p className="text-sm text-destructive mt-1">
                        {errors.donor.email.message}
                      </p>
                    )}
                  </div>
                  
                  <div className="space-y-2">
                    <Label htmlFor="donor.phone">Phone Number (Optional)</Label>
                    <Input
                      id="donor.phone"
                      {...register("donor.phone")}
                    />
                  </div>
                  
                  <div className="flex items-center space-x-2">
                    <Checkbox
                      id="isAnonymous"
                      checked={isAnonymous}
                      onCheckedChange={(checked) => setValue("isAnonymous", checked === true)}
                    />
                    <Label htmlFor="isAnonymous">Make my donation anonymous</Label>
                  </div>
                </div>
                
                {/* Notes */}
                <div className="space-y-2">
                  <Label htmlFor="notes">Notes (Optional)</Label>
                  <Textarea
                    id="notes"
                    placeholder="Add any additional information or message"
                    {...register("notes")}
                  />
                </div>
              </CardContent>
              <CardFooter className="flex justify-end">
                <Button 
                  type="button" 
                  onClick={continueToPayment}
                  disabled={isLoading}
                >
                  Continue to Payment
                </Button>
              </CardFooter>
            </Card>
          ) : (
            <Card>
              <CardHeader>
                <CardTitle>Payment Information</CardTitle>
                <CardDescription>
                  Enter your card details to complete your {paymentType === "recurring" ? "recurring" : "one-time"} donation
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Donation Summary */}
                <div className="bg-muted p-4 rounded-md">
                  <h3 className="font-medium mb-2">Donation Summary</h3>
                  <div className="space-y-1 text-sm">
                    <p><span className="font-medium">Recipient:</span> {selectedRecipient?.name}</p>
                    <p><span className="font-medium">Amount:</span> PHP {amount.toLocaleString()}</p>
                    <p><span className="font-medium">Type:</span> {paymentType === "recurring" ? `Recurring (${watch("recurringInterval")?.toLowerCase() === "month" ? "Monthly" : "Weekly"})` : "One-time"}</p>
                  </div>
                </div>
                
                {/* Card Details */}
                <div className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="cardholderName">Cardholder Name</Label>
                    <Input
                      id="cardholderName"
                      placeholder="Name on card"
                      {...register("cardholderName")}
                    />
                    {errors.cardholderName && (
                      <p className="text-sm text-destructive mt-1">
                        {errors.cardholderName.message}
                      </p>
                    )}
                  </div>
                  
                  <div className="space-y-2">
                    <Label htmlFor="cardNumber">Card Number</Label>
                    <div className="relative">
                      <Input
                        id="cardNumber"
                        placeholder="1234 5678 9012 3456"
                        maxLength={19}
                        {...register("cardNumber")}
                        onChange={handleCardNumberChange}
                      />
                      <CreditCard className="absolute right-3 top-1/2 transform -translate-y-1/2 text-muted-foreground" size={18} />
                    </div>
                    {errors.cardNumber && (
                      <p className="text-sm text-destructive mt-1">
                        {errors.cardNumber.message}
                      </p>
                    )}
                  </div>
                  
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="cardExpiry">Expiry Date</Label>
                      <div className="relative">
                        <Input
                          id="cardExpiry"
                          placeholder="MM/YY"
                          maxLength={5}
                          {...register("cardExpiry")}
                          onChange={handleExpiryChange}
                        />
                        <Calendar className="absolute right-3 top-1/2 transform -translate-y-1/2 text-muted-foreground" size={18} />
                      </div>
                      {errors.cardExpiry && (
                        <p className="text-sm text-destructive mt-1">
                          {errors.cardExpiry.message}
                        </p>
                      )}
                    </div>
                    
                    <div className="space-y-2">
                      <Label htmlFor="cardCvv">CVV</Label>
                      <div className="relative">
                        <Input
                          id="cardCvv"
                          type="password"
                          placeholder="123"
                          maxLength={4}
                          {...register("cardCvv")}
                        />
                        <Lock className="absolute right-3 top-1/2 transform -translate-y-1/2 text-muted-foreground" size={18} />
                      </div>
                      {errors.cardCvv && (
                        <p className="text-sm text-destructive mt-1">
                          {errors.cardCvv.message}
                        </p>
                      )}
                    </div>
                  </div>
                  
                  {/* Save Card Option */}
                  <div className="flex items-center space-x-2 pt-2">
                    <Checkbox
                      id="saveCard"
                      checked={watch("saveCard")}
                      onCheckedChange={(checked) => setValue("saveCard", checked === true)}
                    />
                    <Label htmlFor="saveCard">Save card for future donations</Label>
                  </div>
                </div>
                
                {/* Security Notice */}
                <div className="text-sm text-muted-foreground">
                  <p className="flex items-center">
                    <Lock className="mr-1" size={14} />
                    Your payment information is secure and encrypted
                  </p>
                </div>
              </CardContent>
              <CardFooter className="flex justify-between">
                <Button 
                  type="button" 
                  variant="outline" 
                  onClick={backToDetails}
                  disabled={isLoading}
                >
                  Back
                </Button>
                <Button 
                  type="submit" 
                  disabled={isLoading || !xenditLoaded}
                >
                  {isLoading ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      Processing...
                    </>
                  ) : (
                    `Complete ${paymentType === "recurring" ? "Recurring" : "One-time"} Donation`
                  )}
                </Button>
              </CardFooter>
            </Card>
          )}
        </form>
      </div>
    </div>
  );
} 