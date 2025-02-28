import { NextRequest, NextResponse } from "next/server";
import { XenditService } from "@/lib/xendit";

/**
 * API endpoint to check the status of a Xendit invoice
 * 
 * @route GET /api/xendit/check-invoice
 * @param {string} invoiceId - The Xendit invoice ID to check
 * @returns {object} The invoice status details
 */
export async function GET(req: NextRequest) {
  try {
    // Get the invoice ID from the query parameters
    const url = new URL(req.url);
    const invoiceId = url.searchParams.get("invoiceId");
    
    // Validate the invoice ID
    if (!invoiceId) {
      return NextResponse.json(
        { error: "Missing invoice ID parameter" },
        { status: 400 }
      );
    }
    
    console.log(`Checking invoice status for ID: ${invoiceId}`);
    
    // Initialize the Xendit service
    const xenditService = new XenditService(
      process.env.XENDIT_SECRET_KEY || "",
      process.env.XENDIT_WEBHOOK_SECRET || "",
      process.env.XENDIT_CALLBACK_URL || "",
      process.env.XENDIT_SUCCESS_REDIRECT_URL || "",
      process.env.XENDIT_FAILURE_REDIRECT_URL || ""
    );
    
    // Get the invoice status from Xendit
    const invoiceStatus = await xenditService.getInvoiceStatus(invoiceId);
    
    console.log(`Invoice status response:`, {
      id: invoiceStatus.id,
      status: invoiceStatus.status,
      paid_amount: invoiceStatus.paid_amount,
      payment_method: invoiceStatus.payment_method,
    });
    
    // Return the invoice status
    return NextResponse.json(invoiceStatus);
  } catch (error) {
    console.error("Error checking invoice status:", error);
    
    return NextResponse.json(
      { 
        error: "Failed to check invoice status",
        details: error instanceof Error ? error.message : "Unknown error" 
      },
      { status: 500 }
    );
  }
} 