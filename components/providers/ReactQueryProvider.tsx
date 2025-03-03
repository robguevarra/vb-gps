"use client";

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { ReactQueryDevtools } from "@tanstack/react-query-devtools";
import { useState, ReactNode } from "react";

interface ReactQueryProviderProps {
  children: ReactNode;
}

/**
 * ReactQueryProvider Component
 * 
 * Provides React Query context to the application.
 * Creates a new QueryClient instance for each session to avoid shared state between users.
 * Includes React Query Devtools in development mode.
 * 
 * @param children - The child components to be wrapped with the QueryClientProvider
 */
export function ReactQueryProvider({ children }: ReactQueryProviderProps) {
  // Create a new QueryClient instance for each session
  // This ensures that the cache is not shared between users
  const [queryClient] = useState(() => new QueryClient({
    defaultOptions: {
      queries: {
        // Default options for all queries
        staleTime: 5 * 60 * 1000, // 5 minutes
        gcTime: 10 * 60 * 1000, // 10 minutes (formerly cacheTime)
        retry: 1, // Only retry once
        refetchOnWindowFocus: false, // Don't refetch when window gains focus
      },
    },
  }));

  return (
    <QueryClientProvider client={queryClient}>
      {children}
      {/* Only include React Query Devtools in development */}
      {process.env.NODE_ENV === "development" && <ReactQueryDevtools initialIsOpen={false} />}
    </QueryClientProvider>
  );
} 