"use client";

import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";

/**
 * FinanceRemittanceWizardSkeleton Component
 * 
 * Animated skeleton loader for the FinanceRemittanceWizard component.
 * Displays while the component is being loaded.
 * Supports reduced motion preferences for accessibility.
 */
export function FinanceRemittanceWizardSkeleton() {
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
          <Skeleton className="h-7 w-2/3" />
        </CardTitle>
        <div className="mt-2">
          <Progress value={33} className="h-2" />
        </div>
      </CardHeader>
      
      <CardContent>
        <motion.div 
          className="space-y-6"
          variants={skeletonVariants}
          initial="initial"
          animate="animate"
        >
          {/* Step 1: Missionary Selection */}
          <div className="space-y-4">
            <Skeleton className="h-5 w-1/3" />
            
            <div className="space-y-2">
              <Skeleton className="h-4 w-1/4" />
              <Skeleton className="h-10 w-full" />
            </div>
          </div>
          
          {/* Step 2: Amount */}
          <div className="space-y-4 hidden">
            <Skeleton className="h-5 w-1/3" />
            
            <div className="space-y-2">
              <Skeleton className="h-4 w-1/5" />
              <Skeleton className="h-10 w-full" />
            </div>
            
            <div className="space-y-2">
              <Skeleton className="h-4 w-1/4" />
              <Skeleton className="h-24 w-full" />
            </div>
          </div>
          
          {/* Step 3: Donors */}
          <div className="space-y-4 hidden">
            <Skeleton className="h-5 w-1/3" />
            
            {/* Donor entries */}
            <div className="space-y-4">
              {Array.from({ length: 3 }).map((_, index) => (
                <div key={index} className="border p-4 rounded-md space-y-3">
                  <div className="flex justify-between items-center">
                    <Skeleton className="h-5 w-1/3" />
                    <Skeleton className="h-8 w-8 rounded-full" />
                  </div>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Skeleton className="h-4 w-1/4" />
                      <Skeleton className="h-10 w-full" />
                    </div>
                    <div className="space-y-2">
                      <Skeleton className="h-4 w-1/5" />
                      <Skeleton className="h-10 w-full" />
                    </div>
                  </div>
                </div>
              ))}
            </div>
            
            <div className="flex justify-center">
              <Skeleton className="h-9 w-36 rounded-md" />
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