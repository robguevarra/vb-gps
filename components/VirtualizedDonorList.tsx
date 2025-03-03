"use client";

import { useVirtualizer } from "@tanstack/react-virtual";
import { useRef } from "react";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";

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
  emptyMessage?: string;
}

/**
 * VirtualizedDonorList Component
 * 
 * A virtualized list component for displaying donors with efficient rendering.
 * Only renders the items that are visible in the viewport, improving performance for long lists.
 * 
 * @param donors - The list of donors to display
 * @param onSelectDonor - Callback function when a donor is selected
 * @param isLoading - Whether the list is loading
 * @param emptyMessage - Message to display when the list is empty
 */
export function VirtualizedDonorList({ 
  donors, 
  onSelectDonor,
  isLoading = false,
  emptyMessage = "No donors found"
}: VirtualizedDonorListProps) {
  const parentRef = useRef<HTMLDivElement>(null);
  const shouldReduceMotion = useReducedMotion();
  
  const virtualizer = useVirtualizer({
    count: donors.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 50,
    overscan: 5
  });
  
  if (isLoading) {
    return (
      <div className="h-[300px] overflow-auto border rounded-md p-4 flex items-center justify-center">
        <div className="text-sm text-muted-foreground">Loading donors...</div>
      </div>
    );
  }
  
  if (donors.length === 0) {
    return (
      <div className="h-[300px] overflow-auto border rounded-md p-4 flex items-center justify-center">
        <div className="text-sm text-muted-foreground">{emptyMessage}</div>
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
          return (
            <motion.div
              key={donor.id}
              className="absolute top-0 left-0 w-full p-3 border-b hover:bg-gray-50 dark:hover:bg-gray-800 cursor-pointer"
              style={{
                height: `${virtualItem.size}px`,
                transform: `translateY(${virtualItem.start}px)`,
                willChange: "transform, opacity"
              }}
              onClick={() => onSelectDonor(donor)}
              whileHover={shouldReduceMotion ? {} : { backgroundColor: "rgba(0,0,0,0.05)" }}
              transition={{ duration: 0.1 }}
            >
              <div className="font-medium">{donor.name}</div>
              {donor.email && (
                <div className="text-sm text-gray-500">{donor.email}</div>
              )}
            </motion.div>
          );
        })}
      </div>
    </div>
  );
} 