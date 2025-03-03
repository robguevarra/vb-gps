"use client";

import { useQuery } from "@tanstack/react-query";
import { createClient } from "@/utils/supabase/client";

interface Donor {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

interface UseDonorsQueryOptions {
  searchTerm?: string;
  page?: number;
  pageSize?: number;
  enabled?: boolean;
}

/**
 * useDonorsQuery Hook
 * 
 * A custom hook for fetching donors from the database using React Query.
 * Provides efficient data fetching, caching, and pagination.
 * 
 * @param options - Options for the query (searchTerm, page, pageSize, enabled)
 * @returns The query result with donors data, loading state, and error state
 */
export function useDonorsQuery({
  searchTerm = "",
  page = 1,
  pageSize = 10,
  enabled = true
}: UseDonorsQueryOptions = {}) {
  const supabase = createClient();
  
  return useQuery<Donor[]>({
    queryKey: ["donors", searchTerm, page, pageSize],
    queryFn: async () => {
      let query = supabase
        .from("donors")
        .select("id, name, email, phone");
        
      if (searchTerm) {
        query = query.ilike("name", `%${searchTerm}%`);
      }
      
      const { data, error } = await query
        .order("name")
        .range((page - 1) * pageSize, page * pageSize - 1);
        
      if (error) throw error;
      return data || [];
    },
    staleTime: 5 * 60 * 1000, // 5 minutes
    gcTime: 10 * 60 * 1000, // 10 minutes
    enabled: enabled && (searchTerm ? searchTerm.length >= 2 : true)
  });
} 