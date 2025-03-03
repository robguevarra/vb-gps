// app/api/xendit/create-invoicev2/route.ts

import { NextRequest, NextResponse } from "next/server";
import { createClient as createServiceClient } from '@supabase/supabase-js';
import { z } from "zod";

// Schema for request validation - same as create-invoice but with string instead of UUID
const createInvoiceSchema = z.object({
  donationType: z.enum(["missionary", "church"]),
  recipientId: z.string().min(1), // Allow full name or UUID
  amount: z.number().positive(),
  donor: z.object({
    name: z.string().min(1),
    email: z.string().email(),
    phone: z.string().optional(),
  }),
  isAnonymous: z.boolean().optional().default(false),
  payment_details: z.object({
    isBulkDonation: z.boolean().optional(),
    donors: z.array(
      z.object({
        donorId: z.string(),
        donorName: z.string().optional(),
        amount: z.number().positive(),
        email: z.string().email().optional(),
        phone: z.string().optional(),
      })
    ).optional(),
    recipientId: z.string().min(1).optional(), // Allow any string instead of UUID
    recipientName: z.string().optional(),
  }).optional(),
  notes: z.string().optional(),
  // Add optional success_redirect_url field
  success_redirect_url: z.string().optional(),
});

/**
 * Helper function to convert "Last Name, First Name" to "First Name Last Name"
 * and find the corresponding UUID
 */
async function resolveRecipientId(supabase: any, donationType: string, recipientId: string): Promise<string> {
  // Check if it's already a UUID
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  if (uuidRegex.test(recipientId)) {
    console.log(`RecipientId is already a UUID: ${recipientId}`);
    return recipientId;
  }

  console.log(`Resolving recipient name: "${recipientId}"`);
  
  // Handle "Last Name, First Name" format
  let searchName = recipientId;
  if (recipientId.includes(',')) {
    const [lastName, firstName] = recipientId.split(',').map(part => part.trim());
    searchName = `${firstName} ${lastName}`;
    console.log(`Converted "${recipientId}" to "${searchName}"`);
  }
  
  // Look up the UUID based on donation type
  try {
    if (donationType === "missionary") {
      // Try to find missionary by name
      console.log(`Searching for missionary with name: "${searchName}"`);
      
      // First try exact match
      const { data, error } = await supabase
        .from("profiles")
        .select("id, full_name")
        .eq("full_name", searchName);
      
      if (!error && data && data.length > 0) {
        console.log(`Found missionary by exact match: ${data[0].full_name} (${data[0].id})`);
        return data[0].id;
      }
      
      // If no exact match, try case-insensitive search
      console.log(`No exact match found, trying case-insensitive search`);
      const { data: ilikeData, error: ilikeError } = await supabase
        .from("profiles")
        .select("id, full_name")
        .ilike("full_name", searchName);
      
      if (!ilikeError && ilikeData && ilikeData.length > 0) {
        console.log(`Found missionary by case-insensitive search: ${ilikeData[0].full_name} (${ilikeData[0].id})`);
        return ilikeData[0].id;
      }
      
      // If still no match, try partial match
      console.log(`No case-insensitive match found, trying partial match`);
      const { data: partialData, error: partialError } = await supabase
        .from("profiles")
        .select("id, full_name")
        .ilike("full_name", `%${searchName}%`);
      
      if (!partialError && partialData && partialData.length > 0) {
        console.log(`Found missionary by partial match: ${partialData[0].full_name} (${partialData[0].id})`);
        return partialData[0].id;
      }
      
      // If all else fails, try matching just the last name
      const lastName = searchName.split(' ').pop() || '';
      console.log(`No partial match found, trying last name match with: "${lastName}"`);
      const { data: lastNameData, error: lastNameError } = await supabase
        .from("profiles")
        .select("id, full_name")
        .ilike("full_name", `%${lastName}%`);
      
      if (!lastNameError && lastNameData && lastNameData.length > 0) {
        console.log(`Found missionary by last name: ${lastNameData[0].full_name} (${lastNameData[0].id})`);
        return lastNameData[0].id;
      }
      
      // For development purposes, return a hardcoded UUID if no match is found
      console.error(`Could not find missionary matching "${searchName}", using fallback UUID for development`);
      return "aefe15fe-4937-4f55-a6cb-fb8d739c5905"; // Replace with a valid missionary UUID from your database
      
      // In production, uncomment this and remove the hardcoded UUID:
      // throw new Error(`Could not find missionary matching "${recipientId}"`);
    } else {
      // Try to find church by name
      console.log(`Searching for church with name: "${searchName}"`);
      
      // First try exact match
      const { data, error } = await supabase
        .from("local_churches")
        .select("id, name")
        .eq("name", searchName);
      
      if (!error && data && data.length > 0) {
        console.log(`Found church by exact match: ${data[0].name} (${data[0].id})`);
        return data[0].id;
      }
      
      // If no exact match, try case-insensitive search
      console.log(`No exact match found, trying case-insensitive search`);
      const { data: ilikeData, error: ilikeError } = await supabase
        .from("local_churches")
        .select("id, name")
        .ilike("name", searchName);
      
      if (!ilikeError && ilikeData && ilikeData.length > 0) {
        console.log(`Found church by case-insensitive search: ${ilikeData[0].name} (${ilikeData[0].id})`);
        return ilikeData[0].id;
      }
      
      // If still no match, try partial match
      console.log(`No case-insensitive match found, trying partial match`);
      const { data: partialData, error: partialError } = await supabase
        .from("local_churches")
        .select("id, name")
        .ilike("name", `%${searchName}%`);
      
      if (!partialError && partialData && partialData.length > 0) {
        console.log(`Found church by partial match: ${partialData[0].name} (${partialData[0].id})`);
        return partialData[0].id;
      }
      
      // For development purposes, return a hardcoded UUID if no match is found
      console.error(`Could not find church matching "${searchName}", using fallback UUID for development`);
      return "00000000-0000-0000-0000-000000000000"; // Replace with a valid church UUID from your database
      
      // In production, uncomment this and remove the hardcoded UUID:
      // throw new Error(`Could not find church matching "${recipientId}"`);
    }
  } catch (err) {
    console.error("Exception in recipient lookup:", err);
    // For development purposes, return a hardcoded UUID if an exception occurs
    if (donationType === "missionary") {
      return "aefe15fe-4937-4f55-a6cb-fb8d739c5905"; // Replace with a valid missionary UUID
    } else {
      return "00000000-0000-0000-0000-000000000000"; // Replace with a valid church UUID
    }
    
    // In production, uncomment this and remove the hardcoded UUIDs:
    // throw new Error(`Failed to resolve recipient ID: ${err instanceof Error ? err.message : "Unknown error"}`);
  }
}

export async function POST(req: NextRequest) {
  try {
    console.log("create-invoicev2: Received request");
    
    // 1. Parse and validate request body
    const rawBody = await req.text();
    console.log("Raw request body:", rawBody);
    
    let body;
    try {
      body = JSON.parse(rawBody);
    } catch (e) {
      console.error("Failed to parse JSON:", e);
      return NextResponse.json(
        { error: "Invalid JSON", details: "The request body is not valid JSON" },
        { status: 400 }
      );
    }
    
    console.log("Parsed body:", body);
    
    const validationResult = createInvoiceSchema.safeParse(body);
    
    if (!validationResult.success) {
      console.error("Validation error:", validationResult.error.format());
      return NextResponse.json(
        { error: "Invalid request data", details: validationResult.error.format() },
        { status: 400 }
      );
    }
    
    console.log("Validation successful");
    
    // 2. Create a Supabase client with service role
    const supabase = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );
    
    console.log("Supabase client created");
    
    // 3. Extract data from request
    const { 
      donationType, 
      recipientId: originalRecipientId, 
      amount, 
      donor, 
      isAnonymous, 
      payment_details, 
      notes,
      success_redirect_url 
    } = validationResult.data;
    
    try {
      // 4. Resolve the recipient ID to a UUID
      console.log(`Resolving recipientId: ${originalRecipientId}`);
      const resolvedRecipientId = await resolveRecipientId(supabase, donationType, originalRecipientId);
      console.log(`Resolved recipientId: ${resolvedRecipientId}`);
      
      // 5. Create a new request body with the resolved UUID
      const modifiedBody = {
        ...validationResult.data,
        recipientId: resolvedRecipientId
      };
      
      // Also update recipientId in payment_details if it exists
      if (modifiedBody.payment_details?.recipientId) {
        modifiedBody.payment_details.recipientId = resolvedRecipientId;
      }
      
      // Set the success redirect URL to victorybulacan.org/thankyou/ if not provided
      const customSuccessRedirectUrl = success_redirect_url || "https://victorybulacan.org/thankyou/";
      console.log(`Using success redirect URL: ${customSuccessRedirectUrl}`);
      
      // Add the success_redirect_url to the modified body
      modifiedBody.success_redirect_url = customSuccessRedirectUrl;
      
      console.log(`Forwarding request with resolved recipientId: ${resolvedRecipientId}`);
      console.log("Modified body:", JSON.stringify(modifiedBody));
      
      // 6. Forward to the original create-invoice endpoint using a relative URL
      // This ensures it works in any environment (development, production, etc.)
      const targetUrl = `/api/xendit/create-invoice`;
      console.log(`Forwarding to: ${targetUrl}`);
      
      try {
        // Use the Request/Response API to make an internal API call
        const url = new URL(targetUrl, req.url);
        console.log(`Full URL: ${url.toString()}`);
        
        const response = await fetch(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(modifiedBody),
        });
        
        console.log(`Response status: ${response.status}`);
        
        // 7. Return the response from the original endpoint
        const responseText = await response.text();
        console.log(`Response body: ${responseText}`);
        
        let responseData;
        try {
          responseData = JSON.parse(responseText);
        } catch (e) {
          console.error("Failed to parse response JSON:", e);
          return NextResponse.json(
            { error: "Invalid response from create-invoice", details: responseText },
            { status: 500 }
          );
        }
        
        return NextResponse.json(responseData, { status: response.status });
      } catch (fetchError) {
        console.error("Fetch error:", fetchError);
        return NextResponse.json(
          { 
            error: "Failed to forward request", 
            details: fetchError instanceof Error ? fetchError.message : "Unknown fetch error" 
          },
          { status: 500 }
        );
      }
    } catch (error) {
      console.error("Error resolving recipient ID:", error);
      return NextResponse.json(
        { 
          error: "Failed to resolve recipient", 
          details: error instanceof Error ? error.message : "Unknown error" 
        },
        { status: 404 }
      );
    }
  } catch (error) {
    console.error("Unexpected error:", error);
    return NextResponse.json(
      { error: "Server error", details: error instanceof Error ? error.message : "Unknown error" },
      { status: 500 }
    );
  }
}