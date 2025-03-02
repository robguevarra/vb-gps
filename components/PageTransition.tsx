"use client";

import { motion, AnimatePresence } from "framer-motion";
import React, { ReactNode } from "react";
import { usePathname, useSearchParams } from "next/navigation";

interface PageTransitionProps {
  children: ReactNode;
  mode?: "fade" | "slide" | "scale" | "slideUp" | "slideDown" | "elastic" | "none";
}

export function PageTransition({ 
  children, 
  mode = "fade" 
}: PageTransitionProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams?.get("tab") || "overview";
  
  // Create a unique key for the current view
  const viewKey = `${pathname}-${currentTab}`;
  
  // Different animation variants based on mode
  const variants = {
    fade: {
      initial: { opacity: 0 },
      animate: { opacity: 1 },
      exit: { opacity: 0 },
      transition: { duration: 0.4, ease: "easeInOut" }
    },
    slide: {
      initial: { opacity: 0, x: 20 },
      animate: { opacity: 1, x: 0 },
      exit: { opacity: 0, x: -20 },
      transition: { duration: 0.5, ease: [0.25, 1, 0.5, 1] }
    },
    scale: {
      initial: { opacity: 0, scale: 0.95 },
      animate: { opacity: 1, scale: 1 },
      exit: { opacity: 0, scale: 1.05 },
      transition: { duration: 0.4, ease: [0.19, 1, 0.22, 1] }
    },
    slideUp: {
      initial: { opacity: 0, y: 20 },
      animate: { opacity: 1, y: 0 },
      exit: { opacity: 0, y: -20 },
      transition: { duration: 0.4, ease: "easeOut" }
    },
    slideDown: {
      initial: { opacity: 0, y: -20 },
      animate: { opacity: 1, y: 0 },
      exit: { opacity: 0, y: 20 },
      transition: { duration: 0.4, ease: "easeOut" }
    },
    elastic: {
      initial: { opacity: 0, scale: 0.9 },
      animate: { 
        opacity: 1, 
        scale: 1,
        transition: {
          type: "spring",
          stiffness: 300,
          damping: 20
        }
      },
      exit: { 
        opacity: 0, 
        scale: 0.95,
        transition: {
          duration: 0.3,
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
  
  const selectedVariant = variants[mode];
  
  return (
    <AnimatePresence mode="wait">
      <motion.div
        key={viewKey}
        initial={selectedVariant.initial}
        animate={selectedVariant.animate}
        exit={selectedVariant.exit}
        transition={selectedVariant.transition}
        className="w-full"
      >
        {children}
      </motion.div>
    </AnimatePresence>
  );
} 