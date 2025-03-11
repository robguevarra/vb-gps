"use client";

import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";

/**
 * OnlinePaymentWizardSkeleton Component
 * 
 * Animated skeleton loader for the OnlinePaymentWizard component.
 * Displays while the component is being loaded.
 * Supports reduced motion preferences for accessibility.
 */
export function OnlinePaymentWizardSkeleton() {
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
    <Card className="w-full shadow-sm">
      <CardHeader className="pb-2">
        <CardTitle>
          <Skeleton className="h-7 w-1/2" />
        </CardTitle>
        <div className="mt-2">
          <Progress value={50} className="h-2" />
        </div>
      </CardHeader>
      
      <CardContent>
        <motion.div 
          className="space-y-6"
          variants={skeletonVariants}
          initial="initial"
          animate="animate"
        >
          {/* Step 1: Donor Information */}
          <div className="space-y-4">
            <Skeleton className="h-5 w-1/3" />
            
            <div className="space-y-2">
              <Skeleton className="h-4 w-1/5" />
              <Skeleton className="h-10 w-full" />
            </div>
            
            <div className="space-y-2">
              <Skeleton className="h-4 w-1/4" />
              <Skeleton className="h-10 w-full" />
            </div>
            
            <div className="space-y-2">
              <Skeleton className="h-4 w-1/5" />
              <Skeleton className="h-10 w-full" />
            </div>
          </div>
          
          {/* Step 2: Payment Link */}
          <div className="space-y-4 hidden">
            <Skeleton className="h-5 w-1/3" />
            
            <div className="rounded-md border p-4 space-y-4">
              <div className="flex justify-between">
                <Skeleton className="h-5 w-1/4" />
                <Skeleton className="h-5 w-1/6" />
              </div>
              
              <Skeleton className="h-10 w-full" />
              
              <div className="flex justify-end space-x-2">
                <Skeleton className="h-9 w-24 rounded-md" />
                <Skeleton className="h-9 w-24 rounded-md" />
              </div>
            </div>
          </div>
          
          {/* Button Row */}
          <div className="flex justify-between pt-4">
            <Skeleton className="h-10 w-24 rounded-md" />
            <Skeleton className="h-10 w-24 rounded-md" />
          </div>
        </motion.div>
      </CardContent>
    </Card>
  );
}