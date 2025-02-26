/**
 * Server Actions for Donor Management
 * 
 * This module provides server-side actions for donor-related operations.
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
 * Creates a new donor in the database
 * 
 * @param name - The name of the donor to create
 * @returns The newly created donor object or null if creation failed
 */
export async function createDonor(name: string) {
  try {
    if (!name.trim()) {
      throw new Error("Donor name is required")
    }
    
    // Use admin client that explicitly bypasses RLS
    const supabase = createAdminClient()
    
    // First check if donor with this name already exists
    const { data: existingDonors, error: searchError } = await supabase
      .from("donors")
      .select("*")
      .ilike("name", name.trim())
      .limit(1)
      
    if (searchError) {
      console.error("Error searching for existing donors:", searchError)
    }
    
    // If found, return the existing donor instead of creating a duplicate
    if (existingDonors && existingDonors.length > 0) {
      return { donor: existingDonors[0], error: null }
    }
    
    // No existing donor found, create a new one
    // Critical: This operation now bypasses RLS completely
    const { data, error } = await supabase
      .from("donors")
      .insert({ name: name.trim() })
      .select()
      .single()
      
    if (error) {
      console.error("Error creating donor:", error)
      throw new Error(error.message)
    }
    
    // Revalidate the dashboard path to reflect new data
    revalidatePath('/dashboard/missionary')
    
    return { donor: data, error: null }
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : "An unknown error occurred"
    console.error("Failed to create donor:", errorMessage)
    return { donor: null, error: errorMessage }
  }
} 