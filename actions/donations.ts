/**
 * Server Actions for Donation Management
 * 
 * This module provides server-side actions for donation-related operations.
 * Using server actions allows us to:
 * 1. Bypass RLS restrictions using the service role key
 * 2. Keep sensitive database logic on the server
 * 3. Maintain security while enabling necessary operations
 * 
 * These actions are used by client components that need to perform
 * operations that might be restricted by RLS policies.
 */

"use server"

import { createAdminClient } from "@/utils/supabase/admin"
import { revalidatePath } from "next/cache"

/**
 * Interface for a donation entry to be submitted
 */
interface DonationEntry {
  donor_id: string;
  amount: number;
  missionary_id: string;
  date: string;
  source: "offline" | "online";
  status: "completed" | "pending";
  notes?: string;
}

/**
 * Submits multiple donation entries with detailed logging for debugging
 * 
 * This function includes comprehensive logging to diagnose RLS and permission issues.
 * 
 * @param entries - Array of donation entries to submit
 * @returns Object containing success status, error messages, and detailed logs
 */
export async function submitDonations(entries: DonationEntry[]) {
  // Create logs array to collect diagnostic information
  const logs: string[] = [];
  let insertedCount = 0;
  
  try {
    logs.push(`[START] Donation submission process with ${entries.length} entries`);
    
    // Validate entries
    if (!entries.length) {
      logs.push("[ERROR] No donation entries provided");
      throw new Error("No donation entries provided");
    }
    
    // Log entry validation
    for (const [index, entry] of entries.entries()) {
      logs.push(`[VALIDATE] Entry ${index + 1}: donor_id=${entry.donor_id}, missionary_id=${entry.missionary_id}, amount=${entry.amount}`);
      
      if (!entry.donor_id) {
        logs.push(`[ERROR] Entry ${index + 1}: Missing donor_id`);
        throw new Error("Donor ID is required for all entries");
      }
      if (!entry.missionary_id) {
        logs.push(`[ERROR] Entry ${index + 1}: Missing missionary_id`);
        throw new Error("Missionary ID is required for all entries");
      }
      if (isNaN(entry.amount) || entry.amount <= 0) {
        logs.push(`[ERROR] Entry ${index + 1}: Invalid amount ${entry.amount}`);
        throw new Error("Valid amount is required for all entries");
      }
    }
    
    logs.push("[INFO] All entries validated successfully");
    
    // Use admin client that explicitly bypasses RLS
    logs.push("[INFO] Creating admin client to bypass RLS");
    const supabase = createAdminClient();
    
    // Try individual inserts with detailed logging
    logs.push("[INFO] Starting individual inserts");
    
    for (const [index, entry] of entries.entries()) {
      try {
        logs.push(`[INSERT] Attempting entry ${index + 1}: donor_id=${entry.donor_id}, amount=${entry.amount}`);
        
        // Format entry for database
        const donationData = {
          donor_id: entry.donor_id,
          missionary_id: entry.missionary_id,
          amount: entry.amount,
          date: entry.date,
          source: entry.source,
          status: entry.status,
          notes: entry.notes || null,
          // Add recorded_by field if needed
          recorded_by: entry.missionary_id // Use missionary_id as recorded_by
        };
        
        // Log the exact data being inserted
        logs.push(`[DATA] Entry ${index + 1} data: ${JSON.stringify(donationData)}`);
        
        // Try to insert the donation
        const result = await supabase
          .from("donor_donations")
          .insert(donationData)
          .select();
        
        if (result.error) {
          logs.push(`[ERROR] Entry ${index + 1} insert failed: ${result.error.message}`);
          logs.push(`[ERROR] Entry ${index + 1} error details: ${JSON.stringify(result.error)}`);
          
          // Try a raw SQL insert as fallback
          logs.push(`[FALLBACK] Trying raw SQL insert for entry ${index + 1}`);
          
          const { data: sqlData, error: sqlError } = await supabase.rpc(
            'debug_insert_donation',
            {
              p_donor_id: entry.donor_id,
              p_missionary_id: entry.missionary_id,
              p_amount: entry.amount,
              p_date: entry.date,
              p_source: entry.source,
              p_status: entry.status,
              p_notes: entry.notes || null
            }
          );
          
          if (sqlError) {
            logs.push(`[ERROR] SQL fallback failed: ${sqlError.message}`);
            logs.push(`[ERROR] SQL error details: ${JSON.stringify(sqlError)}`);
          } else {
            logs.push(`[SUCCESS] SQL fallback succeeded for entry ${index + 1}`);
            insertedCount++;
          }
        } else {
          logs.push(`[SUCCESS] Entry ${index + 1} inserted successfully`);
          insertedCount++;
        }
      } catch (err) {
        const errMsg = err instanceof Error ? err.message : "Unknown error";
        logs.push(`[EXCEPTION] Entry ${index + 1} threw exception: ${errMsg}`);
        logs.push(`[EXCEPTION] Stack trace: ${err instanceof Error ? err.stack : 'No stack trace'}`);
      }
    }
    
    logs.push(`[SUMMARY] Inserted ${insertedCount} of ${entries.length} entries`);
    
    // If none of the donations were inserted successfully, throw an error
    if (insertedCount === 0 && entries.length > 0) {
      logs.push("[FAILURE] Failed to insert any donations");
      throw new Error("Failed to insert any donations");
    }
    
    // Revalidate the dashboard path to reflect new data
    logs.push("[INFO] Revalidating dashboard path");
    revalidatePath('/dashboard/missionary');
    
    logs.push("[END] Donation submission process completed");
    
    return { 
      success: true, 
      error: null,
      partialSuccess: insertedCount < entries.length,
      insertedCount: insertedCount,
      totalCount: entries.length,
      logs: logs
    };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : "An unknown error occurred";
    logs.push(`[FATAL] Process failed with error: ${errorMessage}`);
    console.error("Failed to submit donations:", errorMessage);
    console.error("Detailed logs:", logs);
    
    return { 
      success: false, 
      error: errorMessage,
      partialSuccess: insertedCount > 0,
      insertedCount: insertedCount,
      totalCount: entries.length,
      logs: logs
    };
  }
} 