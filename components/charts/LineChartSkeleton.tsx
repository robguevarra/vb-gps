"use client";

import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";

/**
 * LineChartSkeleton Component
 * 
 * Animated skeleton loader for the LineChart component.
 * Displays while the chart is being loaded dynamically.
 * Supports reduced motion preferences for accessibility.
 */
export function LineChartSkeleton() {
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
      className="space-y-4 h-[300px]"
      variants={skeletonVariants}
      initial="initial"
      animate="animate"
    >
      {/* Chart heading area */}
      <div className="flex items-center justify-between">
        <Skeleton className="h-5 w-1/6" />
        <Skeleton className="h-4 w-1/12" />
      </div>
      
      {/* Y-axis labels */}
      <div className="flex h-[250px] relative mt-8">
        <div className="flex flex-col justify-between h-full">
          <Skeleton className="h-4 w-16" />
          <Skeleton className="h-4 w-12" />
          <Skeleton className="h-4 w-14" />
          <Skeleton className="h-4 w-10" />
          <Skeleton className="h-4 w-16" />
        </div>
        
        {/* Chart area */}
        <div className="ml-4 flex-1 relative">
          {/* X-axis grid lines */}
          <div className="absolute inset-0 flex flex-col justify-between">
            <div className="border-b border-gray-200 border-opacity-20"></div>
            <div className="border-b border-gray-200 border-opacity-20"></div>
            <div className="border-b border-gray-200 border-opacity-20"></div>
            <div className="border-b border-gray-200 border-opacity-20"></div>
            <div className="border-b border-gray-200 border-opacity-20"></div>
          </div>
          
          {/* Line visualization placeholder */}
          <div className="absolute inset-0 flex items-center">
            <div className="w-full h-24 bg-gradient-to-r from-transparent via-blue-200 to-transparent rounded-md opacity-20"></div>
          </div>
          
          {/* X-axis labels */}
          <div className="absolute bottom-[-24px] flex justify-between w-full">
            <Skeleton className="h-4 w-12" />
            <Skeleton className="h-4 w-12" />
            <Skeleton className="h-4 w-12" />
            <Skeleton className="h-4 w-12" />
            <Skeleton className="h-4 w-12" />
          </div>
        </div>
      </div>
    </motion.div>
  );
}