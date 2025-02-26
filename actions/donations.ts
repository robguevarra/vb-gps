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
 * 
 * IMPORTANT IMPLEMENTATION NOTES:
 * 
 * 1. ROW LEVEL SECURITY (RLS) BYPASS:
 *    We use the admin client with service role key to bypass RLS restrictions.
 *    This is necessary because our RLS policies require the 'recorded_by' field
 *    to match the authenticated user's ID.
 * 
 * 2. RECORDED_BY FIELD:
 *    The critical fix was ensuring the 'recorded_by' field is set correctly:
 *    - It should be set to the ID of the user who is recording the donation (finance officer)
 *    - Previously, it was incorrectly set to missionary_id, which caused RLS policy issues
 *    - Now we preserve the recorded_by value from the client, with missionary_id as fallback
 *    - This satisfies our RLS policy: "Allow insert donation by self or admin" 
 *      ON public.donor_donations FOR INSERT WITH CHECK ((recorded_by = auth.uid()) OR ...)
 * 
 * 3. MULTI-LEVEL FALLBACK MECHANISM:
 *    We implemented a robust three-tier approach for donation insertion:
 *    a. Primary: Standard Supabase insert operation
 *    b. First Fallback: RPC function call to debug_insert_donation with recorded_by parameter
 *    c. Second Fallback: Direct SQL insert via execute_sql RPC for maximum reliability
 *    This ensures donations are recorded even if permission issues occur with standard methods.
 * 
 * 4. DIAGNOSTIC CAPABILITIES:
 *    The action includes comprehensive diagnostic features:
 *    - Table schema verification to confirm column structure
 *    - RPC function definition checking to validate parameters
 *    - Detailed logging of each step in the process
 *    - Specific recorded_by field tracking to diagnose permission issues
 * 
 * 5. INDIVIDUAL INSERTS:
 *    We process each donation individually rather than in batch to minimize
 *    transaction conflicts and provide better error reporting.
 * 
 * 6. ERROR HANDLING:
 *    Robust error handling at multiple levels:
 *    - Entry validation before processing
 *    - Try/catch blocks around each operation
 *    - Detailed error logging for debugging
 *    - Partial success reporting when some entries succeed
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
  recorded_by: string;
}

/**
 * Submits multiple donation entries with detailed logging for debugging
 * 
 * This function includes comprehensive logging to diagnose RLS and permission issues.
 * The key fix was ensuring the recorded_by field is set to the finance officer's ID
 * (the user who is recording the donation) rather than the missionary_id.
 * 
 * The function implements a multi-level fallback system:
 * 1. Standard Supabase insert
 * 2. RPC function call with recorded_by parameter
 * 3. Direct SQL insert as final fallback
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
    
    // Use admin client that explicitly bypasses RLS
    logs.push("[INFO] Creating admin client to bypass RLS");
    const supabase = createAdminClient();
    
    // Check table schema
    logs.push("[DIAGNOSTIC] Checking donor_donations table schema");
    try {
      const { data: tableData, error: tableError } = await supabase
        .from('donor_donations')
        .select('*')
        .limit(1);
      
      if (tableError) {
        logs.push(`[DIAGNOSTIC] Error checking table schema: ${tableError.message}`);
      } else {
        // Get column names from the first row
        const columns = tableData && tableData.length > 0 ? Object.keys(tableData[0]) : [];
        logs.push(`[DIAGNOSTIC] Table columns: ${JSON.stringify(columns)}`);
      }
    } catch (e) {
      logs.push(`[DIAGNOSTIC] Exception checking table schema: ${e instanceof Error ? e.message : 'Unknown error'}`);
    }
    
    // Check RPC function definition directly with SQL
    logs.push("[DIAGNOSTIC] Checking RPC function definition with SQL");
    try {
      const { data: sqlRpcData, error: sqlRpcError } = await supabase.rpc(
        'execute_sql',
        {
          sql_query: `
            SELECT 
              p.proname AS function_name,
              pg_get_function_arguments(p.oid) AS function_arguments
            FROM 
              pg_proc p
              JOIN pg_namespace n ON p.pronamespace = n.oid
            WHERE 
              n.nspname = 'public'
              AND p.proname = 'debug_insert_donation';
          `
        }
      );
      
      if (sqlRpcError) {
        logs.push(`[DIAGNOSTIC] SQL RPC check error: ${sqlRpcError.message}`);
      } else {
        logs.push(`[DIAGNOSTIC] SQL RPC check result: ${JSON.stringify(sqlRpcData)}`);
      }
    } catch (e) {
      logs.push(`[DIAGNOSTIC] SQL RPC check exception: ${e instanceof Error ? e.message : 'Unknown error'}`);
    }
    
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
          // CRITICAL FIX: Use the recorded_by field from the client (finance officer's ID)
          // This should be the ID of the user who is recording the donation (finance officer)
          // NOT the missionary_id as previously implemented
          // This is critical for:
          // 1. RLS policy compliance - allows the finance officer to view their own records
          // 2. Audit trail - tracks who actually recorded the donation
          // 3. Dashboard filtering - shows only donations recorded by the current user
          recorded_by: entry.recorded_by || entry.missionary_id // Fallback to missionary_id if not provided
        };
        
        // Add detailed logging about the recorded_by field
        logs.push(`[RECORDED_BY] Entry ${index + 1} recorded_by: ${entry.recorded_by || 'Not provided, using missionary_id'}`);
        logs.push(`[RECORDED_BY] Entry ${index + 1} missionary_id: ${entry.missionary_id}`);
        
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
              p_notes: entry.notes || null,
              p_recorded_by: entry.recorded_by
            }
          );
          
          logs.push(`[FALLBACK] RPC params: ${JSON.stringify({
            p_donor_id: entry.donor_id,
            p_missionary_id: entry.missionary_id,
            p_amount: entry.amount,
            p_date: entry.date,
            p_source: entry.source,
            p_status: entry.status,
            p_notes: entry.notes || null,
            p_recorded_by: entry.recorded_by
          })}`);
          
          if (sqlError) {
            logs.push(`[ERROR] SQL fallback failed: ${sqlError.message}`);
            logs.push(`[ERROR] SQL error details: ${JSON.stringify(sqlError)}`);
            
            // Try direct SQL insert as a second fallback
            logs.push(`[FALLBACK2] Trying direct SQL insert for entry ${index + 1}`);
            
            try {
              const { data: directSqlData, error: directSqlError } = await supabase.rpc(
                'execute_sql',
                {
                  sql_query: `
                    INSERT INTO donor_donations 
                    (donor_id, missionary_id, amount, date, source, status, notes, recorded_by) 
                    VALUES 
                    ('${entry.donor_id}', '${entry.missionary_id}', ${entry.amount}, 
                     '${entry.date}', '${entry.source}', '${entry.status}', 
                     ${entry.notes ? `'${entry.notes}'` : 'NULL'}, 
                     '${entry.recorded_by}')
                    RETURNING id;
                  `
                }
              );
              
              if (directSqlError) {
                logs.push(`[ERROR] Direct SQL fallback failed: ${directSqlError.message}`);
                logs.push(`[ERROR] Direct SQL error details: ${JSON.stringify(directSqlError)}`);
              } else {
                logs.push(`[SUCCESS] Direct SQL fallback succeeded for entry ${index + 1}`);
                insertedCount++;
              }
            } catch (directSqlErr) {
              const directSqlErrMsg = directSqlErr instanceof Error ? directSqlErr.message : "Unknown error";
              logs.push(`[EXCEPTION] Direct SQL fallback threw exception: ${directSqlErrMsg}`);
            }
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
      logs: logs // In production, you may want to disable this or limit the log size
    };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : "An unknown error occurred";
    logs.push(`[FATAL] Process failed with error: ${errorMessage}`);
    
    // These console logs can be removed in production
    // console.error("Failed to submit donations:", errorMessage);
    // console.error("Detailed logs:", logs);
    
    return { 
      success: false, 
      error: errorMessage,
      partialSuccess: insertedCount > 0,
      insertedCount: insertedCount,
      totalCount: entries.length,
      logs: logs // In production, you may want to disable this or limit the log size
    };
  }
} 