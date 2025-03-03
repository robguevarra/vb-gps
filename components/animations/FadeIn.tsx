"use client";

import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { ReactNode } from "react";

interface FadeInProps {
  children: ReactNode;
  delay?: number;
  duration?: number;
  className?: string;
}

/**
 * FadeIn Component
 * 
 * A reusable animation component that fades in its children.
 * Supports reduced motion preferences for accessibility.
 * 
 * @param children - The content to animate
 * @param delay - Optional delay before animation starts (in seconds)
 * @param duration - Optional duration of the animation (in seconds)
 * @param className - Optional CSS class names
 */
export function FadeIn({ 
  children, 
  delay = 0, 
  duration = 0.3,
  className = "" 
}: FadeInProps) {
  const shouldReduceMotion = useReducedMotion();
  
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ 
        duration: shouldReduceMotion ? 0 : duration,
        delay: shouldReduceMotion ? 0 : delay
      }}
      className={className}
    >
      {children}
    </motion.div>
  );
} 