"use client";

import { motion, AnimatePresence, useReducedMotion } from "framer-motion";
import React, { ReactNode, useEffect, useState } from "react";
import { usePathname, useSearchParams } from "next/navigation";

interface PageTransitionProps {
  children: ReactNode;
  mode?: "fade" | "slide" | "scale" | "slideUp" | "slideDown" | "elastic" | "none";
}

/**
 * PageTransition Component
 * 
 * Provides smooth transitions between pages or tab content.
 * Implements various animation modes with accessibility considerations.
 * Optimized for performance with shorter durations and better timing.
 * 
 * @param children - The content to be animated
 * @param mode - The animation mode to use (default: "fade")
 */
export function PageTransition({ 
  children, 
  mode = "fade" 
}: PageTransitionProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams?.get("tab") || "overview";
  const shouldReduceMotion = useReducedMotion();
  const [isFirstRender, setIsFirstRender] = useState(true);
  
  // Skip animation on first render for better initial load performance
  useEffect(() => {
    if (isFirstRender) {
      setIsFirstRender(false);
    }
  }, []);
  
  // Create a unique key for the current view
  const viewKey = `${pathname}-${currentTab}`;
  
  // Different animation variants based on mode
  const variants = {
    fade: {
      initial: isFirstRender ? { opacity: 1 } : { opacity: 0 },
      animate: { opacity: 1 },
      exit: { opacity: 0 },
      transition: { duration: shouldReduceMotion ? 0.1 : 0.2, ease: "easeInOut" }
    },
    slide: {
      initial: isFirstRender ? { opacity: 1, x: 0 } : { opacity: 0, x: shouldReduceMotion ? 0 : 20 },
      animate: { opacity: 1, x: 0 },
      exit: { opacity: 0, x: shouldReduceMotion ? 0 : -20 },
      transition: { duration: shouldReduceMotion ? 0.1 : 0.25, ease: [0.25, 1, 0.5, 1] }
    },
    scale: {
      initial: isFirstRender ? { opacity: 1, scale: 1 } : { opacity: 0, scale: shouldReduceMotion ? 1 : 0.95 },
      animate: { opacity: 1, scale: 1 },
      exit: { opacity: 0, scale: shouldReduceMotion ? 1 : 1.05 },
      transition: { duration: shouldReduceMotion ? 0.1 : 0.25, ease: [0.19, 1, 0.22, 1] }
    },
    slideUp: {
      initial: isFirstRender ? { opacity: 1, y: 0 } : { opacity: 0, y: shouldReduceMotion ? 0 : 20 },
      animate: { opacity: 1, y: 0 },
      exit: { opacity: 0, y: shouldReduceMotion ? 0 : -20 },
      transition: { duration: shouldReduceMotion ? 0.1 : 0.25, ease: "easeOut" }
    },
    slideDown: {
      initial: isFirstRender ? { opacity: 1, y: 0 } : { opacity: 0, y: shouldReduceMotion ? 0 : -20 },
      animate: { opacity: 1, y: 0 },
      exit: { opacity: 0, y: shouldReduceMotion ? 0 : 20 },
      transition: { duration: shouldReduceMotion ? 0.1 : 0.25, ease: "easeOut" }
    },
    elastic: {
      initial: isFirstRender ? { opacity: 1, scale: 1 } : { opacity: 0, scale: shouldReduceMotion ? 1 : 0.9 },
      animate: { 
        opacity: 1, 
        scale: 1,
        transition: shouldReduceMotion 
          ? { duration: 0.1 }
          : {
              type: "spring",
              stiffness: 400, // Increased stiffness for faster animation
              damping: 25,    // Increased damping for less oscillation
              mass: 0.8       // Reduced mass for faster movement
            }
      },
      exit: { 
        opacity: 0, 
        scale: shouldReduceMotion ? 1 : 0.95,
        transition: {
          duration: shouldReduceMotion ? 0.1 : 0.15, // Reduced exit duration
          ease: "easeInOut"
        }
      },
      transition: {}
    },
    none: {
      initial: {},
      animate: {},
      exit: {},
      transition: {}
    }
  };
  
  // If user prefers reduced motion and it's not already "none", use fade with minimal animation
  const effectiveMode = shouldReduceMotion && mode !== "none" ? "fade" : mode;
  const selectedVariant = variants[effectiveMode];
  
  return (
    <AnimatePresence mode="sync">
      <motion.div
        key={viewKey}
        initial={selectedVariant.initial}
        animate={selectedVariant.animate}
        exit={selectedVariant.exit}
        transition={selectedVariant.transition}
        className="w-full"
        // Improve performance with will-change for complex animations
        style={
          mode !== "none" && !shouldReduceMotion && !isFirstRender
            ? { willChange: "opacity, transform" }
            : undefined
        }
      >
        {children}
      </motion.div>
    </AnimatePresence>
  );
} 