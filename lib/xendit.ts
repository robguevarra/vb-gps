/**
 * Xendit payment integration service
 * 
 * This service provides methods for interacting with the Xendit API
 * for payment processing, including creating invoices, verifying
 * webhooks, and checking invoice status.
 */

//lib/xendit.ts
import crypto from 'crypto';

// Types for Xendit API
export interface CreateInvoiceParams {
  externalId: string;
  amount: number;
  payerEmail: string;
  payerName?: string;
  description: string;
  successRedirectUrl?: string;
  failureRedirectUrl?: string;
  items?: Array<{
    name: string;
    quantity: number;
    price: number;
    category?: string;
    url?: string;
  }>;
  fees?: Array<{
    type: string;
    value: number;
  }>;
  shouldSendEmail?: boolean;
  currency?: string;
}

export interface XenditInvoice {
  id: string;
  external_id: string;
  user_id: string;
  status: 'PENDING' | 'PAID' | 'SETTLED' | 'EXPIRED' | 'FAILED';
  merchant_name: string;
  merchant_profile_picture_url: string;
  amount: number;
  payer_email: string;
  description: string;
  invoice_url: string;
  expiry_date: string;
  available_banks: Array<{
    bank_code: string;
    collection_type: string;
    bank_account_number: string;
    transfer_amount: number;
    bank_branch: string;
    account_holder_name: string;
  }>;
  available_retail_outlets: Array<{
    retail_outlet_name: string;
    payment_code: string;
    transfer_amount: number;
  }>;
  available_ewallets: Array<{
    ewallet_type: string;
  }>;
  should_exclude_credit_card: boolean;
  should_send_email: boolean;
  created: string;
  updated: string;
  mid_label: string;
  currency: string;
}

export interface XenditInvoiceStatus {
  id: string;
  external_id: string;
  user_id: string;
  status: 'PENDING' | 'PAID' | 'SETTLED' | 'EXPIRED' | 'FAILED';
  merchant_name: string;
  amount: number;
  paid_amount: number;
  bank_code: string;
  payment_method: string;
  paid_at: string;
  payer_email: string;
  description: string;
  created: string;
  updated: string;
}

export class XenditError extends Error {
  public readonly statusCode?: number;
  public readonly xenditErrorCode?: string;
  public readonly xenditResponse?: any;
  
  constructor(message: string, statusCode?: number, xenditErrorCode?: string, xenditResponse?: any) {
    super(message);
    this.name = 'XenditError';
    this.statusCode = statusCode;
    this.xenditErrorCode = xenditErrorCode;
    this.xenditResponse = xenditResponse;
  }
}

/**
 * XenditService handles communication with the Xendit API
 */
export class XenditService {
  private readonly apiUrl = 'https://api.xendit.co';
  
  constructor(
    private apiKey: string,
    private webhookSecret: string,
    private callbackUrl: string,
    private successUrl: string,
    private failureUrl: string
  ) {
    // Validate required parameters
    if (!apiKey) {
      console.error("XenditService: API key is missing");
    }
    if (!callbackUrl) {
      console.error("XenditService: Callback URL is missing");
    }
    if (!successUrl) {
      console.error("XenditService: Success URL is missing");
    }
    if (!failureUrl) {
      console.error("XenditService: Failure URL is missing"); 
    }
  }
  
  /**
   * Creates an invoice using Xendit API
   * 
   * @param params Invoice parameters
   * @returns Invoice details including the payment URL
   */
  async createInvoice(params: CreateInvoiceParams): Promise<XenditInvoice> {
    // Validate required parameters first
    if (!params.externalId) {
      throw new XenditError('externalId is required');
    }
    if (!params.amount || params.amount <= 0) {
      throw new XenditError('amount must be greater than 0');
    }
    if (!params.payerEmail) {
      throw new XenditError('payerEmail is required'); 
    }
    if (!params.description) {
      throw new XenditError('description is required');
    }
    
    // Ensure amount is a number with 2 decimal places
    const amount = parseFloat(params.amount.toFixed(2));
    
    const auth = Buffer.from(`${this.apiKey}:`).toString('base64');
    
    try {
      // Prepare the request payload
      const payload: Record<string, any> = {
        external_id: params.externalId,
        amount: amount,
        payer_email: params.payerEmail,
        description: params.description,
        invoice_duration: 86400, // 24 hours in seconds
        success_redirect_url: params.successRedirectUrl || this.successUrl,
        failure_redirect_url: params.failureRedirectUrl || this.failureUrl,
        callback_url: this.callbackUrl,
        currency: params.currency || 'PHP',
      };
      
      // Log only the success redirect URL for traceability
      console.log(`XenditService: Using success redirect URL: ${payload.success_redirect_url}`);
      
      if (params.payerName) {
        payload.payer_name = params.payerName;
      }
      
      // We're no longer using payment methods or channel preferences
      // Let Xendit use the default payment methods from the dashboard
      console.log("Using default payment methods from Xendit Dashboard");
      
      // Remove explicit payment methods list to allow Xendit to use dashboard configuration
      // This should resolve the inconsistent payment options issue based on other app's implementation
      // payload.payment_methods = [...] - removed this section
      
      // Add shouldSendEmail if specified
      if (params.shouldSendEmail !== undefined) {
        payload.should_send_email = params.shouldSendEmail;
      }
      
      // Only add items if they exist and have the required fields
      if (params.items && params.items.length > 0) {
        // Validate each item
        const validatedItems = params.items.map(item => ({
          name: item.name,
          quantity: item.quantity,
          price: parseFloat(item.price.toFixed(2)), // Format price with 2 decimal places
          category: item.category,
          url: item.url
        }));
        payload.items = validatedItems;
      }
      
      if (params.fees && params.fees.length > 0) {
        payload.fees = params.fees;
      }
      
      console.log("Preparing Xendit API request");
      
      // Make the API request
      const response = await fetch(`${this.apiUrl}/v2/invoices`, {
        method: 'POST',
        headers: {
          'Authorization': `Basic ${auth}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
      });
      
      console.log(`Xendit API response status: ${response.status} ${response.statusText}`);
      
      // Check if the response is JSON
      const contentType = response.headers.get('content-type');
      if (!contentType || !contentType.includes('application/json')) {
        const textResponse = await response.text();
        console.error("Xendit API returned non-JSON response:", textResponse);
        throw new XenditError(
          `Non-JSON response from Xendit API: ${response.status} ${response.statusText}`,
          response.status,
          'NON_JSON_RESPONSE'
        );
      }
      
      // Parse the response
      let data;
      try {
        data = await response.json();
        console.log("Xendit API response data:", JSON.stringify(data).substring(0, 500) + "...");
      } catch (error) {
        console.error("Error parsing Xendit API response:", error);
        throw new XenditError(
          'Failed to parse Xendit API response',
          response.status,
          'PARSE_ERROR'
        );
      }
      
      console.log("Xendit API response processed");
      
      // Handle error responses
      if (!response.ok) {
        console.error("Xendit API Error:", {
          status: response.status,
          statusText: response.statusText,
          error_code: data.error_code || 'unknown',
          error_message: data.message || 'No error message provided'
        });
        
        // Enhanced error handling for payment method errors
        if (data.error_code === 'UNAVAILABLE_PAYMENT_METHOD_ERROR') {
          console.error("Payment method error detected");
          
          // Provide a more helpful error message based on documentation
          const errorMsg = "Some payment methods are not available. Using default payment methods from Xendit Dashboard.";
          throw new XenditError(
            errorMsg,
            response.status,
            data.error_code,
            data
          );
        }
        
        // Handle API key errors
        if (data.error_code === 'API_VALIDATION_ERROR' || data.error_code === 'AUTHENTICATION_ERROR') {
          console.error("API validation or authentication error");
          throw new XenditError(
            data.message || 'API key validation failed',
            response.status,
            data.error_code,
            data
          );
        }
        
        // Handle rate limiting
        if (response.status === 429) {
          console.error("Rate limit exceeded");
          throw new XenditError(
            'Too many requests to payment gateway. Please try again later.',
            response.status,
            'RATE_LIMIT_EXCEEDED',
            data
          );
        }
        
        throw new XenditError(
          data.message || 'Failed to create invoice',
          response.status,
          data.error_code,
          data
        );
      }
      
      return data as XenditInvoice;
    } catch (error) {
      if (error instanceof XenditError) {
        throw error;
      }
      
      console.error("Unexpected error in Xendit createInvoice");
      
      throw new XenditError(
        error instanceof Error ? error.message : 'Unknown error creating invoice'
      );
    }
  }
  
  /**
   * Verifies the webhook signature from Xendit
   * 
   * @param payload The webhook payload (request body)
   * @param headerSignature The signature from the X-Callback-Token header
   * @returns boolean indicating if the signature is valid
   */
  verifyWebhookSignature(payload: any, headerSignature: string): boolean {
    try {
      // If no webhook secret is configured, we can't verify
      if (!this.webhookSecret) {
        console.warn('Webhook secret not configured, skipping signature verification');
        return true;
      }
      
      // If no signature provided, verification fails
      if (!headerSignature) {
        console.error('No signature provided in webhook request');
        return false;
      }
      
      console.log('Verifying webhook signature');
      
      // Xendit callback verification - using their token-based approach
      // In some implementations, Xendit simply expects you to compare the
      // callback token with your configured webhook secret
      if (headerSignature === this.webhookSecret) {
        console.log('Signature verification successful');
        return true;
      }
      
      // Otherwise try the HMAC verification approach
      // Verify the signature using HMAC
      try {
        const stringPayload = typeof payload === 'string' 
          ? payload 
          : JSON.stringify(payload);
          
        const computedSignature = crypto
          .createHmac('sha256', this.webhookSecret)
          .update(stringPayload)
          .digest('hex');
        
        console.log('Attempting alternative signature verification method');
        
        // Simple string comparison (Xendit might not use timing-safe comparison)
        if (computedSignature === headerSignature) {
          console.log('Signature verification successful');
          return true;
        }
      } catch (hmacError) {
        console.error('Error during signature verification');
      }
      
      console.warn('Webhook signature verification failed');
      return false;
    } catch (error) {
      console.error('Error verifying webhook signature');
      return false;
    }
  }
  
  /**
   * Gets the current status of an invoice
   * 
   * @param invoiceId The Xendit invoice ID
   * @returns The invoice status details
   */
  async getInvoiceStatus(invoiceId: string): Promise<XenditInvoiceStatus> {
    const auth = Buffer.from(`${this.apiKey}:`).toString('base64');
    
    try {
      // Make the API request
      const response = await fetch(`${this.apiUrl}/v2/invoices/${invoiceId}`, {
        method: 'GET',
        headers: {
          'Authorization': `Basic ${auth}`,
          'Content-Type': 'application/json',
        },
      });
      
      // Parse the response
      const data = await response.json();
      
      // Handle error responses
      if (!response.ok) {
        throw new XenditError(
          data.message || `Failed to get invoice status`,
          response.status,
          data.error_code,
          data
        );
      }
      
      return data as XenditInvoiceStatus;
    } catch (error) {
      if (error instanceof XenditError) {
        throw error;
      }
      
      throw new XenditError(
        error instanceof Error 
          ? error.message 
          : `Unknown error getting invoice status`
      );
    }
  }
}