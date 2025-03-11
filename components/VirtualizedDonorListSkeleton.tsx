"use client";

import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";

/**
 * VirtualizedDonorListSkeleton Component
 * 
 * Animated skeleton loader for the VirtualizedDonorList component.
 * Displays while the component is being loaded.
 * Supports reduced motion preferences for accessibility.
 */
export function VirtualizedDonorListSkeleton() {
  const shouldReduceMotion = useReducedMotion();
  
  const skeletonVariants = {
    initial: { opacity: 0.6 },
    animate: { 
      opacity: shouldReduceMotion ? 0.6 : [0.6, 0.8, 0.6], 
      transition: { 
        repeat: Infinity, 
        duration: 1.5 
      } 
    }
  };
  
  return (
    <motion.div 
      className="border rounded-md overflow-hidden h-[400px]"
      variants={skeletonVariants}
      initial="initial"
      animate="animate"
    >
      {/* Search input skeleton */}
      <div className="p-4 border-b">
        <Skeleton className="h-9 w-full" />
      </div>
      
      {/* Donor list skeleton */}
      <div className="overflow-auto h-[calc(400px-5rem)]">
        {Array.from({ length: 10 }).map((_, index) => (
          <div key={index} className="p-3 border-b flex items-center justify-between">
            <div className="space-y-2">
              <Skeleton className="h-5 w-36" />
              <div className="flex space-x-2">
                <Skeleton className="h-4 w-24" />
                <Skeleton className="h-4 w-24" />
              </div>
            </div>
            <Skeleton className="h-6 w-6 rounded-full" />
          </div>
        ))}
      </div>
      
      {/* Load more skeleton */}
      <div className="p-2 border-t flex justify-center">
        <Skeleton className="h-8 w-24" />
      </div>
    </motion.div>
  );
}