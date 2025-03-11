"use client";

import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

/**
 * DonorHistoryModalSkeleton Component
 * 
 * Animated skeleton loader for the DonorHistoryModal component.
 * Displays while the component is being loaded.
 * Supports reduced motion preferences for accessibility.
 */
export function DonorHistoryModalSkeleton() {
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
    <Dialog open={true}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            <Skeleton className="h-6 w-3/4" />
          </DialogTitle>
        </DialogHeader>
        
        <motion.div 
          className="space-y-4 max-h-[400px] overflow-y-auto"
          variants={skeletonVariants}
          initial="initial"
          animate="animate"
        >
          {Array.from({ length: 5 }).map((_, index) => (
            <div key={index} className="p-4 border-b border-border">
              <div className="space-y-2">
                <Skeleton className="h-4 w-1/3" />
                <Skeleton className="h-4 w-1/4" />
              </div>
            </div>
          ))}
        </motion.div>
        
        <div className="mt-4 flex justify-end">
          <Skeleton className="h-9 w-16" />
        </div>
      </DialogContent>
    </Dialog>
  );
}