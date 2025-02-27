import { NextRequest, NextResponse } from "next/server";
import { XenditService } from "@/lib/xendit";

/**
 * Test endpoint for Xendit API
 * This helps diagnose issues with the Xendit integration
 */
export async function GET(req: NextRequest) {
  try {
    // Check if all required environment variables are set
    const envCheck = {
      XENDIT_SECRET_KEY: !!process.env.XENDIT_SECRET_KEY,
      XENDIT_WEBHOOK_SECRET: !!process.env.XENDIT_WEBHOOK_SECRET,
      XENDIT_CALLBACK_URL: !!process.env.XENDIT_CALLBACK_URL,
      XENDIT_SUCCESS_REDIRECT_URL: !!process.env.XENDIT_SUCCESS_REDIRECT_URL,
      XENDIT_FAILURE_REDIRECT_URL: !!process.env.XENDIT_FAILURE_REDIRECT_URL,
    };
    
    // Check for any missing variables
    const missingVars = Object.entries(envCheck)
      .filter(([_, isSet]) => !isSet)
      .map(([name]) => name);
    
    if (missingVars.length > 0) {
      return NextResponse.json({
        success: false,
        message: "Missing environment variables",
        missingVars,
      }, { status: 500 });
    }
    
    // Create an instance of the Xendit service
    const xenditService = new XenditService(
      process.env.XENDIT_SECRET_KEY!,
      process.env.XENDIT_WEBHOOK_SECRET!,
      process.env.XENDIT_CALLBACK_URL!,
      process.env.XENDIT_SUCCESS_REDIRECT_URL!,
      process.env.XENDIT_FAILURE_REDIRECT_URL!
    );
    
    // Try to create a test invoice with minimal parameters
    try {
      const testInvoice = await xenditService.createInvoice({
        externalId: `test_${Date.now()}`,
        amount: 1000, // Usually 1000 (1000 smallest currency units, e.g. 10.00 PHP)
        payerEmail: "test@example.com",
        description: "Test invoice from API test endpoint",
      });
      
      return NextResponse.json({
        success: true,
        message: "Successfully connected to Xendit API",
        invoiceId: testInvoice.id,
        invoiceUrl: testInvoice.invoice_url,
      });
    } catch (invoiceError) {
      // If we get here, the API connection worked but invoice creation failed
      return NextResponse.json({
        success: false,
        message: "Connected to Xendit API but failed to create test invoice",
        error: invoiceError instanceof Error ? {
          name: invoiceError.name,
          message: invoiceError.message,
          // Include additional details if it's our custom XenditError
          ...(invoiceError.name === 'XenditError' && {
            statusCode: (invoiceError as any).statusCode,
            xenditErrorCode: (invoiceError as any).xenditErrorCode,
            xenditResponse: (invoiceError as any).xenditResponse,
          }),
        } : String(invoiceError),
      }, { status: 500 });
    }
  } catch (error) {
    return NextResponse.json({
      success: false,
      message: "Failed to test Xendit API",
      error: error instanceof Error ? error.message : String(error),
    }, { status: 500 });
  }
} 