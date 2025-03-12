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
 * Now with ultra-fast transitions for tab changes.
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
  const [prevTab, setPrevTab] = useState(currentTab);
  const isTabChange = pathname === usePathname() && prevTab !== currentTab;
  
  // Skip animation on first render for better initial load performance
  useEffect(() => {
    if (isFirstRender) {
      setIsFirstRender(false);
    }
    
    // Track tab changes
    if (prevTab !== currentTab) {
      setPrevTab(currentTab);
    }
  }, [isFirstRender, currentTab, prevTab]);
  
  // Create a unique key for the current view
  const viewKey = `${pathname}-${currentTab}`;
  
  // Use ultra-fast transitions for tab changes
  const transitionDuration = isTabChange ? 0.1 : shouldReduceMotion ? 0.1 : 0.2;
  
  // Different animation variants based on mode
  const variants = {
    fade: {
      initial: isFirstRender ? { opacity: 1 } : { opacity: 0 },
      animate: { opacity: 1 },
      exit: { opacity: 0 },
      transition: { duration: transitionDuration, ease: "easeInOut" }
    },
    slide: {
      initial: isFirstRender ? { opacity: 1, x: 0 } : { opacity: 0, x: shouldReduceMotion ? 0 : 10 },
      animate: { opacity: 1, x: 0 },
      exit: { opacity: 0, x: shouldReduceMotion ? 0 : -10 },
      transition: { duration: transitionDuration, ease: [0.25, 1, 0.5, 1] }
    },
    scale: {
      initial: isFirstRender ? { opacity: 1, scale: 1 } : { opacity: 0, scale: shouldReduceMotion ? 1 : 0.98 },
      animate: { opacity: 1, scale: 1 },
      exit: { opacity: 0, scale: shouldReduceMotion ? 1 : 0.98 },
      transition: { duration: transitionDuration, ease: [0.19, 1, 0.22, 1] }
    },
    slideUp: {
      initial: isFirstRender ? { opacity: 1, y: 0 } : { opacity: 0, y: shouldReduceMotion ? 0 : 10 },
      animate: { opacity: 1, y: 0 },
      exit: { opacity: 0, y: shouldReduceMotion ? 0 : -10 },
      transition: { duration: transitionDuration, ease: "easeOut" }
    },
    slideDown: {
      initial: isFirstRender ? { opacity: 1, y: 0 } : { opacity: 0, y: shouldReduceMotion ? 0 : -10 },
      animate: { opacity: 1, y: 0 },
      exit: { opacity: 0, y: shouldReduceMotion ? 0 : 10 },
      transition: { duration: transitionDuration, ease: "easeOut" }
    },
    elastic: {
      initial: isFirstRender ? { opacity: 1, scale: 1 } : { opacity: 0, scale: shouldReduceMotion ? 1 : 0.95 },
      animate: { 
        opacity: 1, 
        scale: 1,
        transition: shouldReduceMotion 
          ? { duration: 0.1 }
          : {
              type: "spring",
              stiffness: 500, // Even higher stiffness for faster animation
              damping: 30,    // Higher damping for less oscillation
              mass: 0.6       // Lower mass for faster movement
            }
      },
      exit: { 
        opacity: 0, 
        scale: shouldReduceMotion ? 1 : 0.98,
        transition: {
          duration: transitionDuration, 
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
  // For tab changes, use an even simpler transition
  let effectiveMode = shouldReduceMotion && mode !== "none" ? "fade" : mode;
  if (isTabChange && !shouldReduceMotion) {
    effectiveMode = "fade"; // Use simple fade for tab changes for better performance
  }
  
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