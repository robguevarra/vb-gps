import { NextResponse } from "next/server";
import { z } from "zod";
import { XenditService } from "@/lib/xendit";
import { createClient } from "@/utils/supabase/server";
import { v4 as uuidv4 } from "uuid";

// Validation schema for the request body
const paymentRequestSchema = z.object({
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
  paymentType: z.literal("one-time"),
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
    const validatedData = paymentRequestSchema.parse(body);
    
    // Initialize Supabase client
    const supabase = await createClient();
    
    // Generate a unique reference ID for this transaction
    const externalId = `donation-${uuidv4()}`;
    
    // Initialize Xendit service
    const xenditService = new XenditService(
      process.env.XENDIT_API_KEY || "",
      process.env.XENDIT_WEBHOOK_SECRET || "",
      process.env.XENDIT_CALLBACK_URL || "",
      process.env.XENDIT_SUCCESS_URL || "",
      process.env.XENDIT_FAILURE_URL || ""
    );
    
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
    
    // In a real implementation, you would use the cardToken to create a charge via Xendit API
    // For example:
    // const chargeResponse = await xenditService.createCharge({
    //   token_id: validatedData.cardToken,
    //   external_id: externalId,
    //   amount: validatedData.amount,
    //   currency: "PHP",
    //   descriptor: "Donation",
    // });
    
    // Create a payment transaction record
    const { data: transaction, error: transactionError } = await supabase
      .from("payment_transactions")
      .insert({
        external_id: externalId,
        amount: validatedData.amount,
        status: "PENDING",
        payment_method: "CARD",
        payment_channel: "CREDIT_CARD",
        currency: "PHP",
        description: validatedData.notes || "Donation",
        metadata: {
          donationType: validatedData.donationType,
          recipientId: validatedData.recipientId,
          isAnonymous: validatedData.isAnonymous,
        },
      })
      .select("id")
      .single();
    
    if (transactionError) {
      throw new Error(`Failed to create transaction: ${transactionError.message}`);
    }
    
    // Create a donation record
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
      });
    
    if (donationError) {
      throw new Error(`Failed to create donation: ${donationError.message}`);
    }
    
    // In a real implementation, you would now process the payment with Xendit
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
      console.log(`Donation of ${validatedData.amount} to missionary ${validatedData.recipientId}`);
    }
    
    // Return success response
    return NextResponse.json({
      success: true,
      message: "Payment processed successfully",
      transactionId: transaction.id,
    });
  } catch (error) {
    console.error("Error processing payment:", error);
    
    // Return error response
    return NextResponse.json(
      {
        success: false,
        error: error instanceof Error ? error.message : "Failed to process payment",
      },
      { status: 400 }
    );
  }
} 