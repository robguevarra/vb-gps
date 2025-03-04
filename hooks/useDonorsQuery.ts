"use client";

import { useQuery, useInfiniteQuery } from "@tanstack/react-query";
import { useDebounce } from "@/hooks/useDebounce";

interface Donor {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

interface PaginationMetadata {
  page: number;
  pageSize: number;
  totalCount: number;
  totalPages: number;
  hasMore: boolean;
}

interface DonorsResponse {
  data: Donor[];
  pagination: PaginationMetadata;
}

interface UseDonorsQueryOptions {
  searchTerm?: string;
  pageSize?: number;
  enabled?: boolean;
  debounceMs?: number;
}

/**
 * useDonorsQuery Hook
 * 
 * A custom hook for fetching donors from the database using React Query.
 * Provides efficient data fetching, caching, and pagination.
 * 
 * @param options - Options for the query (searchTerm, pageSize, enabled, debounceMs)
 * @returns The query result with donors data, loading state, and error state
 * 
 * @deprecated Use useDonorsInfiniteQuery for better performance with large datasets
 */
export function useDonorsQuery({
  searchTerm = "",
  pageSize = 20,
  enabled = true,
  debounceMs = 300
}: UseDonorsQueryOptions = {}) {
  // Debounce search term to prevent excessive API calls
  const debouncedSearchTerm = useDebounce(searchTerm, debounceMs);
  
  return useQuery<Donor[]>({
    queryKey: ["donors", debouncedSearchTerm, 1, pageSize],
    queryFn: async () => {
      console.log(`Fetching donors with search term: "${debouncedSearchTerm}", pageSize: ${pageSize}`);
      
      // Use the enhanced API endpoint
      const params = new URLSearchParams({
        term: debouncedSearchTerm,
        page: "1",
        pageSize: pageSize.toString()
      });
      
      const response = await fetch(`/api/donors/search?${params}`);
      
      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        console.error("Error fetching donors:", errorData);
        throw new Error(errorData.error || "Failed to fetch donors");
      }
      
      const { data } = await response.json();
      
      console.log(`Fetched ${data?.length || 0} donors from API`);
      
      return data || [];
    },
    staleTime: 5 * 60 * 1000, // 5 minutes
    gcTime: 10 * 60 * 1000, // 10 minutes
    enabled: enabled && (debouncedSearchTerm ? debouncedSearchTerm.length >= 2 : true)
  });
}

/**
 * useDonorsInfiniteQuery Hook
 * 
 * A custom hook for fetching donors with infinite scrolling support.
 * Optimized for large datasets with proper pagination and debouncing.
 * 
 * @param options - Options for the query (searchTerm, pageSize, enabled, debounceMs)
 * @returns The infinite query result with donors data, loading state, and pagination functions
 */
export function useDonorsInfiniteQuery({
  searchTerm = "",
  pageSize = 20,
  enabled = true,
  debounceMs = 300
}: UseDonorsQueryOptions = {}) {
  // Debounce search term to prevent excessive API calls
  const debouncedSearchTerm = useDebounce(searchTerm, debounceMs);
  
  return useInfiniteQuery<DonorsResponse>({
    queryKey: ["donors", "infinite", debouncedSearchTerm, pageSize],
    queryFn: async ({ pageParam }) => {
      const page = pageParam as number;
      console.log(`Fetching donors page ${page} with search term: "${debouncedSearchTerm}"`);
      
      const params = new URLSearchParams({
        term: debouncedSearchTerm,
        page: page.toString(),
        pageSize: pageSize.toString()
      });
      
      const response = await fetch(`/api/donors/search?${params}`);
      
      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        console.error("Error fetching donors:", errorData);
        throw new Error(errorData.error || "Failed to fetch donors");
      }
      
      const data = await response.json();
      console.log(`Fetched page ${page}: ${data?.data?.length || 0} donors`);
      
      return data;
    },
    initialPageParam: 1,
    getNextPageParam: (lastPage) => {
      const { pagination } = lastPage;
      return pagination.hasMore ? pagination.page + 1 : undefined;
    },
    enabled: enabled && (debouncedSearchTerm ? debouncedSearchTerm.length >= 2 : true),
    staleTime: 5 * 60 * 1000, // 5 minutes
    gcTime: 10 * 60 * 1000, // 10 minutes
  });
} 