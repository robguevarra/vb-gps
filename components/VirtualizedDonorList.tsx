"use client";

import { useRef, useEffect } from "react";
import { useVirtualizer } from "@tanstack/react-virtual";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { Loader2, Mail, Phone } from "lucide-react";

interface Donor {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

interface VirtualizedDonorListProps {
  donors: Donor[];
  onSelectDonor: (donor: Donor) => void;
  isLoading?: boolean;
  isFetchingNextPage?: boolean;
  hasNextPage?: boolean;
  fetchNextPage?: () => void;
  emptyMessage?: string;
  selectedDonors?: Record<string, Donor>;
}

/**
 * VirtualizedDonorList Component
 * 
 * A virtualized list component for displaying donors with efficient rendering.
 * Only renders the items that are visible in the viewport, improving performance for long lists.
 * Now supports infinite scrolling for large datasets.
 * 
 * @param donors - The list of donors to display
 * @param onSelectDonor - Callback function when a donor is selected
 * @param isLoading - Whether the list is loading
 * @param isFetchingNextPage - Whether the next page is being fetched
 * @param hasNextPage - Whether there are more pages to fetch
 * @param fetchNextPage - Function to fetch the next page
 * @param emptyMessage - Message to display when the list is empty
 */
export function VirtualizedDonorList({ 
  donors, 
  onSelectDonor,
  isLoading = false,
  isFetchingNextPage = false,
  hasNextPage = false,
  fetchNextPage,
  emptyMessage = "No donors found",
  selectedDonors = {}
}: VirtualizedDonorListProps) {
  const parentRef = useRef<HTMLDivElement>(null);
  const shouldReduceMotion = useReducedMotion();
  
  // Set up virtualization
  const virtualizer = useVirtualizer({
    count: donors.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 64, // Consistent height for all items
    overscan: 10 // Increase overscan for smoother scrolling
  });
  
  // Set up infinite loading
  useEffect(() => {
    // Early return if not needed
    if (!hasNextPage || !fetchNextPage || !parentRef.current) return;
    
    const scrollElement = parentRef.current;
    
    // Create an observer for the bottom of the list
    const observer = new IntersectionObserver(
      (entries) => {
        const [entry] = entries;
        // Load more when the sentinel element is visible and we're not already loading
        if (entry.isIntersecting && !isFetchingNextPage) {
          fetchNextPage();
        }
      },
      {
        // Use the parent as the viewport
        root: scrollElement,
        // Start loading when the element is 200px from entering the viewport
        rootMargin: "0px 0px 200px 0px",
        threshold: 0.1
      }
    );
    
    // Create and observe a sentinel element at the bottom of the list
    const sentinel = document.createElement("div");
    sentinel.style.height = "1px";
    sentinel.style.width = "100%";
    scrollElement.appendChild(sentinel);
    observer.observe(sentinel);
    
    // Clean up
    return () => {
      observer.disconnect();
      if (sentinel.parentNode) {
        sentinel.parentNode.removeChild(sentinel);
      }
    };
  }, [hasNextPage, fetchNextPage, isFetchingNextPage, donors.length]);
  
  // Empty state
  if (donors.length === 0 && !isLoading) {
    return (
      <div className="h-[300px] overflow-auto border rounded-md p-4 flex items-center justify-center bg-gray-50 dark:bg-gray-800">
        <div className="text-sm text-muted-foreground">{emptyMessage}</div>
      </div>
    );
  }
  
  // Loading state
  if (isLoading && donors.length === 0) {
    return (
      <div className="h-[300px] overflow-auto border rounded-md p-4 flex items-center justify-center bg-gray-50 dark:bg-gray-800">
        <div className="flex flex-col items-center gap-2">
          <Loader2 className="h-6 w-6 animate-spin text-primary" />
          <div className="text-sm text-muted-foreground">Loading donors...</div>
        </div>
      </div>
    );
  }
  
  return (
    <div 
      ref={parentRef} 
      className="h-[300px] overflow-auto border rounded-md"
    >
      <div
        className="relative w-full"
        style={{ height: `${virtualizer.getTotalSize()}px` }}
      >
        {virtualizer.getVirtualItems().map((virtualItem) => {
          const donor = donors[virtualItem.index];
          const isSelected = donor.id in selectedDonors;
          
          return (
            <motion.div
              key={donor.id}
              className="absolute top-0 left-0 w-full p-3 border-b hover:bg-gray-50 dark:hover:bg-gray-800 cursor-pointer transition-colors"
              style={{
                height: `${virtualItem.size}px`,
                transform: `translateY(${virtualItem.start}px)`,
                willChange: "transform, opacity"
              }}
              onClick={() => onSelectDonor(donor)}
              whileHover={shouldReduceMotion ? {} : { backgroundColor: "rgba(0,0,0,0.05)" }}
              transition={{ duration: 0.1 }}
            >
              <div className="flex justify-between items-center h-full">
                <div className="flex-1 min-w-0">
                  <div className="font-medium text-sm sm:text-base truncate">{donor.name}</div>
                  <div className="flex flex-wrap gap-x-3 gap-y-1 mt-1">
                    {donor.email && (
                      <div className="flex items-center text-xs text-gray-500 truncate">
                        <Mail className="h-3 w-3 mr-1 flex-shrink-0" />
                        <span className="truncate">{donor.email}</span>
                      </div>
                    )}
                    {donor.phone && (
                      <div className="flex items-center text-xs text-gray-500">
                        <Phone className="h-3 w-3 mr-1 flex-shrink-0" />
                        <span>{donor.phone}</span>
                      </div>
                    )}
                  </div>
                </div>
                <div className="ml-2 flex-shrink-0">
                  <div className="w-6 h-6 rounded-full border-2 border-primary-100 flex items-center justify-center">
                    <div className={`w-3 h-3 rounded-full ${
                      isSelected ? "bg-primary" : "bg-transparent"
                    }`} />
                  </div>
                </div>
              </div>
            </motion.div>
          );
        })}
        
        {/* Loading indicator for next page */}
        {isFetchingNextPage && (
          <div 
            className="absolute w-full flex justify-center py-2"
            style={{
              transform: `translateY(${virtualizer.getTotalSize()}px)`
            }}
          >
            <Loader2 className="h-5 w-5 animate-spin text-primary" />
          </div>
        )}
      </div>
    </div>
  );
} 