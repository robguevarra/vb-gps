import { NextResponse } from "next/server";
import { z } from "zod";
import { XenditService } from "@/lib/xendit";
import { createClient } from "@/utils/supabase/server";
import { v4 as uuidv4 } from "uuid";

// Validation schema for the request body
const recurringPaymentRequestSchema = z.object({
  donationType: z.enum(["missionary", "church"]),
  recipientId: z.string(),
  amount: z.number().positive(),
  donor: z.object({
    name: z.string(),
    email: z.string().email(),
    phone: z.string().optional(),
  }),
  notes: z.string().optional(),
  isAnonymous: z.boolean().default(false),
  paymentType: z.literal("recurring"),
  recurringInterval: z.enum(["MONTH", "WEEK"]),
  // Card token from Xendit.js
  cardToken: z.string(),
  // Card details (for reference only, not used for processing)
  cardholderName: z.string(),
  saveCard: z.boolean().default(false),
});

export async function POST(request: Request) {
  try {
    // Parse and validate the request body
    const body = await request.json();
    const validatedData = recurringPaymentRequestSchema.parse(body);
    
    // Initialize Supabase client
    const supabase = await createClient();
    
    // Generate a unique reference ID for this recurring payment
    const externalId = `recurring-${uuidv4()}`;
    
    // Initialize Xendit service
    const xenditService = new XenditService(
      process.env.XENDIT_API_KEY || "",
      process.env.XENDIT_WEBHOOK_SECRET || "",
      process.env.XENDIT_CALLBACK_URL || "",
      process.env.XENDIT_SUCCESS_URL || "",
      process.env.XENDIT_FAILURE_URL || ""
    );
    
    // In a real implementation, you would use the cardToken to create a recurring payment via Xendit API
    // For example:
    // const recurringPaymentResponse = await xenditService.createRecurringPayment({
    //   token_id: validatedData.cardToken,
    //   external_id: externalId,
    //   amount: validatedData.amount,
    //   currency: "PHP",
    //   interval: validatedData.recurringInterval,
    //   description: validatedData.notes || `${validatedData.recurringInterval.toLowerCase()} donation`,
    // });
    
    // Create a donor record if needed
    let donorId: string;
    
    // Check if donor already exists by email
    const { data: existingDonor } = await supabase
      .from("donors")
      .select("id")
      .eq("email", validatedData.donor.email)
      .single();
    
    if (existingDonor) {
      donorId = existingDonor.id;
    } else {
      // Create a new donor
      const { data: newDonor, error: donorError } = await supabase
        .from("donors")
        .insert({
          name: validatedData.donor.name,
          email: validatedData.donor.email,
          phone: validatedData.donor.phone,
        })
        .select("id")
        .single();
      
      if (donorError) {
        throw new Error(`Failed to create donor: ${donorError.message}`);
      }
      
      donorId = newDonor.id;
    }
    
    // Create a recurring payment record
    const { data: recurringPayment, error: recurringError } = await supabase
      .from("recurring_payments")
      .insert({
        external_id: externalId,
        donor_id: donorId,
        missionary_id: validatedData.donationType === "missionary" ? validatedData.recipientId : null,
        church_id: validatedData.donationType === "church" ? validatedData.recipientId : null,
        amount: validatedData.amount,
        interval: validatedData.recurringInterval,
        status: "ACTIVE",
        start_date: new Date().toISOString(),
        description: validatedData.notes || `${validatedData.recurringInterval.toLowerCase()} donation`,
        is_anonymous: validatedData.isAnonymous,
        payment_method: "CARD",
        currency: "PHP",
      })
      .select("id")
      .single();
    
    if (recurringError) {
      throw new Error(`Failed to create recurring payment: ${recurringError.message}`);
    }
    
    // Create an initial payment transaction record
    const { data: transaction, error: transactionError } = await supabase
      .from("payment_transactions")
      .insert({
        external_id: `${externalId}-initial`,
        amount: validatedData.amount,
        status: "PENDING",
        payment_method: "CARD",
        payment_channel: "CREDIT_CARD",
        currency: "PHP",
        description: validatedData.notes || `Initial ${validatedData.recurringInterval.toLowerCase()} donation`,
        metadata: {
          donationType: validatedData.donationType,
          recipientId: validatedData.recipientId,
          isAnonymous: validatedData.isAnonymous,
          isRecurring: true,
          recurringPaymentId: recurringPayment.id,
        },
      })
      .select("id")
      .single();
    
    if (transactionError) {
      throw new Error(`Failed to create transaction: ${transactionError.message}`);
    }
    
    // Create a donation record for the initial payment
    const { error: donationError } = await supabase
      .from("donor_donations")
      .insert({
        missionary_id: validatedData.donationType === "missionary" ? validatedData.recipientId : null,
        church_id: validatedData.donationType === "church" ? validatedData.recipientId : null,
        donor_id: donorId,
        amount: validatedData.amount,
        date: new Date().toISOString(),
        source: "online",
        status: "pending",
        notes: validatedData.notes,
        is_anonymous: validatedData.isAnonymous,
        transaction_id: transaction.id,
        recurring_payment_id: recurringPayment.id,
      });
    
    if (donationError) {
      throw new Error(`Failed to create donation: ${donationError.message}`);
    }
    
    // In a real implementation, you would now process the initial payment with Xendit
    // For this example, we'll simulate a successful payment
    
    // Update the transaction and donation status to completed
    await supabase
      .from("payment_transactions")
      .update({ status: "COMPLETED" })
      .eq("id", transaction.id);
    
    await supabase
      .from("donor_donations")
      .update({ status: "completed" })
      .eq("transaction_id", transaction.id);
    
    // If the donation is to a missionary, update their balance
    if (validatedData.donationType === "missionary") {
      // In a real implementation, you would update the missionary's balance
      // For hardcoded missionaries, we'll skip this step
      console.log(`Recurring donation of ${validatedData.amount} to missionary ${validatedData.recipientId}`);
    }
    
    // Return success response
    return NextResponse.json({
      success: true,
      message: "Recurring payment set up successfully",
      recurringPaymentId: recurringPayment.id,
      transactionId: transaction.id,
    });
  } catch (error) {
    console.error("Error setting up recurring payment:", error);
    
    // Return error response
    return NextResponse.json(
      {
        success: false,
        error: error instanceof Error ? error.message : "Failed to set up recurring payment",
      },
      { status: 400 }
    );
  }
} 