"use client";

import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { ReactNode } from "react";

interface SlideInProps {
  children: ReactNode;
  direction?: "left" | "right" | "up" | "down";
  delay?: number;
  duration?: number;
  className?: string;
}

/**
 * SlideIn Component
 * 
 * A reusable animation component that slides in its children from a specified direction.
 * Supports reduced motion preferences for accessibility.
 * 
 * @param children - The content to animate
 * @param direction - The direction to slide from (left, right, up, down)
 * @param delay - Optional delay before animation starts (in seconds)
 * @param duration - Optional duration of the animation (in seconds)
 * @param className - Optional CSS class names
 */
export function SlideIn({ 
  children, 
  direction = "up",
  delay = 0, 
  duration = 0.3,
  className = "" 
}: SlideInProps) {
  const shouldReduceMotion = useReducedMotion();
  
  const directionMap = {
    left: { x: -20, y: 0 },
    right: { x: 20, y: 0 },
    up: { x: 0, y: 20 },
    down: { x: 0, y: -20 }
  };
  
  const { x, y } = directionMap[direction];
  
  return (
    <motion.div
      initial={shouldReduceMotion ? { opacity: 0 } : { opacity: 0, x, y }}
      animate={{ opacity: 1, x: 0, y: 0 }}
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