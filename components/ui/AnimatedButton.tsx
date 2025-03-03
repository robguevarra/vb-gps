"use client";

import { Button, ButtonProps } from "@/components/ui/button";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { forwardRef } from "react";

/**
 * AnimatedButton Component
 * 
 * An enhanced button component with micro-interactions for better user feedback.
 * Supports all standard button props plus animation effects with reduced motion support.
 * 
 * @example
 * <AnimatedButton variant="default" onClick={handleClick}>
 *   Click Me
 * </AnimatedButton>
 */
export const AnimatedButton = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ children, className, ...props }, ref) => {
    const shouldReduceMotion = useReducedMotion();
    
    // Skip animations if user prefers reduced motion
    if (shouldReduceMotion) {
      return (
        <Button ref={ref} className={className} {...props}>
          {children}
        </Button>
      );
    }
    
    return (
      <motion.div
        whileHover={{ scale: 1.02 }}
        whileTap={{ scale: 0.98 }}
        transition={{ 
          type: "spring", 
          stiffness: 500, 
          damping: 30 
        }}
      >
        <Button ref={ref} className={className} {...props}>
          {children}
        </Button>
      </motion.div>
    );
  }
);

AnimatedButton.displayName = "AnimatedButton"; 