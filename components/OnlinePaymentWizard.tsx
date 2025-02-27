/**
 * OnlinePaymentWizard Component
 * 
 * A specialized wizard for missionaries to generate Xendit payment links
 * that can be shared with donors for online payments. This component
 * leverages the Xendit integration to create shareable payment URLs.
 * 
 * Key Features:
 * - Simple two-step wizard interface
 * - Donor information collection
 * - Dynamic payment link generation
 * - Payment status tracking
 * - Shareable link copying and distribution
 * 
 * Technical Implementation:
 * - Uses Xendit API integration via backend endpoints
 * - Implements real-time validation
 * - Provides a streamlined UX for payment link generation
 * - Handles payment status tracking
 * 
 * @component
 */

"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card"
import { Checkbox } from "@/components/ui/checkbox"
import { ArrowLeft, Copy, Loader2, Link as LinkIcon, CheckCircle, Share2, AlertCircle } from "lucide-react"
import { toast } from "@/hooks/use-toast"
import { Progress } from "@/components/ui/progress"
import { z } from "zod"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { Textarea } from "@/components/ui/textarea"

// Validation schema for the payment form
const paymentFormSchema = z.object({
  donor: z.object({
    name: z.string().min(1, { message: "Name is required" }),
    email: z.string().email({ message: "Valid email is required" }),
    phone: z.string().optional(),
  }),
  amount: z.coerce
    .number()
    .positive({ message: "Amount must be greater than 0" })
    .min(100, { message: "Minimum donation amount is 100" }),
  notes: z.string().optional(),
  isAnonymous: z.boolean().default(false),
})

type PaymentFormData = z.infer<typeof paymentFormSchema>

interface OnlinePaymentWizardProps {
  /** ID of the missionary generating the payment link */
  missionaryId: string;
  /** Name of the missionary (for display purposes) */
  missionaryName: string;
  /** Optional title for the wizard */
  title?: string;
  /** Optional callback function to be called after successful link generation */
  onSuccess?: () => void;
  /** Optional callback function to be called after link generation failure */
  onError?: (error: string) => void;
}

export function OnlinePaymentWizard({ 
  missionaryId, 
  missionaryName,
  title = "Generate Payment Link",
  onSuccess,
  onError
}: OnlinePaymentWizardProps) {
  // State Management
  const [step, setStep] = useState<1 | 2>(1)
  const [loading, setLoading] = useState(false)
  const [paymentLink, setPaymentLink] = useState<string | null>(null)
  const [linkCopied, setLinkCopied] = useState(false)
  const [error, setError] = useState<string | null>(null)
  
  // React Hook Form setup
  const {
    register,
    handleSubmit,
    watch,
    setValue,
    reset,
    formState: { errors, isValid },
  } = useForm<PaymentFormData>({
    resolver: zodResolver(paymentFormSchema),
    defaultValues: {
      amount: 500,
      isAnonymous: false,
      donor: {
        name: "",
        email: "",
        phone: "",
      },
    },
  })
  
  // Watch form values for dynamic updates
  const isAnonymous = watch("isAnonymous")
  const amount = watch("amount")
  
  /**
   * Handles the submission of the form to generate a payment link
   * @param data Form data with donor info and payment details
   */
  const onSubmit = async (data: PaymentFormData) => {
    setLoading(true)
    setError(null)
    
    try {
      // Call the API endpoint to create an invoice
      const response = await fetch("/api/xendit/create-invoice", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          donationType: "missionary",
          recipientId: missionaryId,
          ...data,
        }),
      })
      
      const result = await response.json()
      
      if (!response.ok) {
        throw new Error(result.error || "Failed to generate payment link")
      }
      
      // Set the payment link for display
      setPaymentLink(result.invoiceUrl)
      setStep(2)
      
      // Call success callback if provided
      if (onSuccess) {
        onSuccess()
      }
      
      toast({
        title: "Payment link generated",
        description: "You can now share this link with your donor",
      })
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : "Failed to generate payment link"
      setError(errorMessage)
      
      // Call error callback if provided
      if (onError) {
        onError(errorMessage)
      }
      
      toast({
        title: "Error",
        description: errorMessage,
        variant: "destructive",
      })
    } finally {
      setLoading(false)
    }
  }
  
  /**
   * Copies the payment link to clipboard
   */
  const copyToClipboard = async () => {
    if (!paymentLink) return
    
    try {
      await navigator.clipboard.writeText(paymentLink)
      setLinkCopied(true)
      
      toast({
        title: "Link copied",
        description: "Payment link copied to clipboard",
      })
      
      // Reset the copied state after a delay
      setTimeout(() => {
        setLinkCopied(false)
      }, 3000)
    } catch (error) {
      toast({
        title: "Copy failed",
        description: "Could not copy to clipboard. Please copy the link manually.",
        variant: "destructive",
      })
    }
  }
  
  /**
   * Shares the payment link using the Web Share API if available
   */
  const shareLink = async () => {
    if (!paymentLink) return
    
    // Check if the Web Share API is available
    if (navigator.share) {
      try {
        await navigator.share({
          title: `Donation for ${missionaryName}`,
          text: `Please use this link to complete your donation to ${missionaryName}`,
          url: paymentLink,
        })
        
        toast({
          title: "Link shared",
          description: "Payment link shared successfully",
        })
      } catch (error) {
        // User cancelled or share failed
        if (error instanceof Error && error.name !== "AbortError") {
          toast({
            title: "Share failed",
            description: "Could not share the payment link",
            variant: "destructive",
          })
        }
      }
    } else {
      // Fallback if Web Share API is not available
      copyToClipboard()
    }
  }
  
  /**
   * Resets the form and goes back to step 1
   */
  const handleReset = () => {
    setStep(1)
    setPaymentLink(null)
    reset({
      amount: 500,
      isAnonymous: false,
      donor: {
        name: "",
        email: "",
        phone: "",
      },
    })
  }
  
  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle className="text-2xl font-bold text-center">{title}</CardTitle>
        {step === 1 && (
          <CardDescription className="text-center">
            Generate a payment link to share with your donor
          </CardDescription>
        )}
      </CardHeader>
      <CardContent className="space-y-6">
        <Progress value={step === 1 ? 50 : 100} className="w-full" />
        
        <p className="text-center text-muted-foreground">
          {step === 1 ? "Enter donor information" : "Payment link generated"}
        </p>
        
        {step === 1 && (
          <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Donor Information</CardTitle>
                <CardDescription>
                  Enter the details of the donor making the payment
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
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
              </CardContent>
            </Card>
            
            <Card>
              <CardHeader>
                <CardTitle>Donation Details</CardTitle>
                <CardDescription>
                  Enter the donation amount and any notes
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
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
              </CardContent>
              <CardFooter>
                <Button
                  type="submit"
                  className="w-full"
                  size="lg"
                  disabled={loading || !isValid}
                >
                  {loading ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      Generating Link...
                    </>
                  ) : (
                    `Generate Payment Link for ₱${amount || 0}`
                  )}
                </Button>
              </CardFooter>
            </Card>
            
            {error && (
              <div className="bg-destructive/15 border border-destructive text-destructive px-4 py-3 rounded-md">
                <div className="flex items-start">
                  <AlertCircle className="h-5 w-5 mr-2 mt-0.5" />
                  <div>
                    <p className="font-medium">Error generating payment link</p>
                    <p className="text-sm">{error}</p>
                  </div>
                </div>
              </div>
            )}
          </form>
        )}
        
        {step === 2 && paymentLink && (
          <div className="space-y-6">
            <Card className="bg-primary/5 border-dashed">
              <CardContent className="pt-6 space-y-4">
                <div className="flex items-center justify-center mb-4">
                  <div className="bg-primary-foreground p-3 rounded-full">
                    <LinkIcon className="h-8 w-8 text-primary" />
                  </div>
                </div>
                
                <div className="text-center">
                  <h3 className="font-semibold text-lg">Payment Link Generated</h3>
                  <p className="text-sm text-muted-foreground mt-1">
                    Share this link with your donor to complete the payment
                  </p>
                </div>
                
                <div className="relative mt-4">
                  <Input
                    readOnly
                    value={paymentLink}
                    className="pr-10 font-mono text-sm"
                    onClick={(e) => e.currentTarget.select()}
                  />
                  <Button
                    size="sm"
                    variant="ghost"
                    className="absolute right-0 top-0 h-full"
                    onClick={copyToClipboard}
                  >
                    {linkCopied ? (
                      <CheckCircle className="h-4 w-4 text-green-500" />
                    ) : (
                      <Copy className="h-4 w-4" />
                    )}
                  </Button>
                </div>
                
                <div className="flex gap-2 mt-4">
                  <Button
                    variant="outline"
                    className="flex-1"
                    onClick={copyToClipboard}
                  >
                    <Copy className="mr-2 h-4 w-4" />
                    Copy Link
                  </Button>
                  
                  <Button
                    className="flex-1"
                    onClick={shareLink}
                  >
                    <Share2 className="mr-2 h-4 w-4" />
                    Share Link
                  </Button>
                </div>
                
                <div className="text-center mt-4">
                  <p className="text-sm text-muted-foreground">
                    This link will expire in 24 hours
                  </p>
                </div>
              </CardContent>
            </Card>
            
            <Card className="bg-muted">
              <CardContent className="p-4">
                <div className="space-y-2">
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Donor:</span>
                    <span className="font-medium">{watch("donor.name")}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Amount:</span>
                    <span className="font-medium">₱{watch("amount")?.toLocaleString()}</span>
                  </div>
                  {watch("notes") && (
                    <div className="pt-2 mt-2 border-t border-border">
                      <span className="text-sm text-muted-foreground">Notes:</span>
                      <p className="text-sm mt-1">{watch("notes")}</p>
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>
            
            <Button
              variant="outline"
              className="w-full"
              onClick={handleReset}
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Generate Another Payment Link
            </Button>
          </div>
        )}
      </CardContent>
    </Card>
  )
} 