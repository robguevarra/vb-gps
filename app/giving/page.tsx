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
import { Loader2 } from "lucide-react";

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
});

type DonationFormData = z.infer<typeof donationFormSchema>;

// Type for missionaries and churches
type Recipient = {
  id: string;
  name: string;
  type: "missionary" | "church";
  description?: string;
};

export default function GivingPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [recipients, setRecipients] = useState<Recipient[]>([]);
  const [activeTab, setActiveTab] = useState<"missionary" | "church">("missionary");
  
  // React Hook Form setup
  const {
    register,
    handleSubmit,
    watch,
    setValue,
    reset,
    formState: { errors },
  } = useForm<DonationFormData>({
    resolver: zodResolver(donationFormSchema),
    defaultValues: {
      donationType: "missionary",
      amount: 500,
      isAnonymous: false,
    },
  });
  
  // Watch form values for dynamic updates
  const donationType = watch("donationType");
  const isAnonymous = watch("isAnonymous");
  
  // Initialize Supabase client
  const supabase = createClient();
  
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
  
  // Submit donation form
  const onSubmit = async (data: DonationFormData) => {
    setIsLoading(true);
    setError(null);
    
    try {
      // Call the API endpoint to create an invoice
      const response = await fetch("/api/xendit/create-invoice", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      });
      
      const result = await response.json();
      
      if (!response.ok) {
        throw new Error(result.error || "Failed to process donation");
      }
      
      // Redirect to Xendit payment page
      window.location.href = result.invoiceUrl;
    } catch (error) {
      console.error("Error creating donation:", error);
      setError(error instanceof Error ? error.message : "Failed to process donation. Please try again.");
    } finally {
      setIsLoading(false);
    }
  };
  
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
        
        <form onSubmit={handleSubmit(onSubmit)}>
          <Card>
            <CardHeader>
              <CardTitle>Select Donation Type</CardTitle>
              <CardDescription>
                Choose whether you want to donate to a missionary or a church
              </CardDescription>
            </CardHeader>
            <CardContent>
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
                
                <div className="mt-6 space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="amount">Donation Amount (PHP)</Label>
                    <Input
                      id="amount"
                      type="number"
                      className="text-lg"
                      placeholder="500"
                      min="100"
                      {...register("amount")}
                    />
                    {errors.amount && (
                      <p className="text-sm text-destructive mt-1">
                        {errors.amount.message}
                      </p>
                    )}
                  </div>
                  
                  <div className="space-y-2">
                    <Label htmlFor="notes">Notes (Optional)</Label>
                    <Textarea
                      id="notes"
                      placeholder="Any special instructions or message"
                      {...register("notes")}
                    />
                  </div>
                  
                  <div className="flex items-center space-x-2">
                    <Checkbox
                      id="isAnonymous"
                      checked={isAnonymous}
                      onCheckedChange={(checked) => 
                        setValue("isAnonymous", checked as boolean)
                      }
                    />
                    <Label htmlFor="isAnonymous">
                      Make this donation anonymous
                    </Label>
                  </div>
                </div>
              </Tabs>
            </CardContent>
            
            <CardHeader>
              <CardTitle>Your Information</CardTitle>
              <CardDescription>
                Please enter your contact details
                {isAnonymous && " (your details will not be shared with the recipient)"}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="donor.name">Full Name</Label>
                  <Input
                    id="donor.name"
                    placeholder="Juan Dela Cruz"
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
                    placeholder="juan@example.com"
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
                    placeholder="+63 9XX XXX XXXX"
                    {...register("donor.phone")}
                  />
                </div>
              </div>
            </CardContent>
            
            <CardFooter className="flex flex-col space-y-4">
              <Button
                type="submit"
                className="w-full"
                size="lg"
                disabled={isLoading}
              >
                {isLoading ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Processing...
                  </>
                ) : (
                  `Donate ${watch("amount") ? `₱${watch("amount")}` : ""}`
                )}
              </Button>
              
              <p className="text-center text-sm text-muted-foreground">
                By donating, you agree to our terms and conditions.
                Your payment will be processed securely by Xendit.
              </p>
            </CardFooter>
          </Card>
        </form>
      </div>
    </div>
  );
} 