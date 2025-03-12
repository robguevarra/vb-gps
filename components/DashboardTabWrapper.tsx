"use client";

import React, { ReactNode, useEffect, useState } from "react";
import { motion, AnimatePresence, useReducedMotion } from "framer-motion";
import { useSearchParams } from "next/navigation";

interface DashboardTabWrapperProps {
  children: ReactNode;
  title?: string;
  subtitle?: string;
}

/**
 * DashboardTabWrapper Component
 * 
 * Provides animated wrapper for dashboard tab content with staggered animations.
 * Implements accessibility considerations and performance optimizations.
 * Now includes data attributes for tab content caching and optimized animations.
 * Ultra-fast transitions for immediate visual feedback.
 * 
 * @param children - The tab content to be animated
 * @param title - Optional title to display above the content
 * @param subtitle - Optional subtitle to display below the title
 */
export function DashboardTabWrapper({
  children,
  title,
  subtitle
}: DashboardTabWrapperProps) {
  const [isVisible, setIsVisible] = useState(false);
  const shouldReduceMotion = useReducedMotion();
  const searchParams = useSearchParams();
  // Default to 'overview' if searchParams is null or tab param is not present
  const currentTab = searchParams ? searchParams.get('tab') || 'overview' : 'overview';
  
  // Listen for tab change events from TabSwitcher
  useEffect(() => {
    const handleTabChange = () => {
      // Reset visibility briefly to trigger animation
      setIsVisible(false);
      
      // Then quickly make it visible again
      requestAnimationFrame(() => {
        setIsVisible(true);
      });
    };
    
    // Add event listener
    window.addEventListener('tabchange', handleTabChange);
    
    // Initial visibility
    const timer = setTimeout(() => {
      setIsVisible(true);
    }, shouldReduceMotion ? 0 : 10); // Ultra-reduced delay for faster response
    
    // Clean up
    return () => {
      clearTimeout(timer);
      window.removeEventListener('tabchange', handleTabChange);
    };
  }, [shouldReduceMotion]);

  // Animation variants for the container - simplified for speed
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        when: "beforeChildren",
        staggerChildren: shouldReduceMotion ? 0 : 0.03, // Minimal stagger time
        duration: shouldReduceMotion ? 0.1 : 0.15, // Ultra-reduced duration
        ease: [0.25, 0.1, 0.25, 1.0]
      }
    },
    exit: {
      opacity: 0,
      transition: {
        when: "afterChildren",
        staggerChildren: shouldReduceMotion ? 0 : 0.02, // Minimal stagger time
        staggerDirection: -1,
        duration: shouldReduceMotion ? 0.1 : 0.1 // Ultra-reduced duration
      }
    }
  };

  // Animation variants for the title - simplified for speed
  const titleVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : -5 }, // Minimal distance
    visible: {
      opacity: 1,
      y: 0,
      transition: shouldReduceMotion 
        ? { duration: 0.1 }
        : {
            type: "spring",
            stiffness: 500, // Higher stiffness
            damping: 35,    // Higher damping
            duration: 0.2   // Reduced duration
          }
    },
    exit: {
      opacity: 0,
      y: shouldReduceMotion ? 0 : -3, // Minimal distance
      transition: {
        duration: shouldReduceMotion ? 0.1 : 0.1 // Ultra-reduced duration
      }
    }
  };

  // Animation variants for the content - simplified for speed
  const contentVariants = {
    hidden: { 
      opacity: 0, 
      y: shouldReduceMotion ? 0 : 5, // Minimal distance
      scale: shouldReduceMotion ? 1 : 0.995 // Minimal scaling for faster animation
    },
    visible: {
      opacity: 1,
      y: 0,
      scale: 1,
      transition: shouldReduceMotion 
        ? { duration: 0.1 }
        : {
            type: "spring",
            stiffness: 400,
            damping: 30,
            duration: 0.2,
            delay: 0.01 // Minimal delay
          }
    },
    exit: {
      opacity: 0,
      y: shouldReduceMotion ? 0 : 3, // Minimal distance
      transition: {
        duration: shouldReduceMotion ? 0.1 : 0.1 // Ultra-reduced duration
      }
    }
  };

  return (
    <AnimatePresence mode="sync">
      <motion.div
        key="dashboard-tab-wrapper"
        initial="hidden"
        animate={isVisible ? "visible" : "hidden"}
        exit="exit"
        variants={containerVariants}
        className="w-full"
      >
        {(title || subtitle) && (
          <motion.div 
            variants={titleVariants}
            className="mb-6"
            style={!shouldReduceMotion ? { willChange: "opacity, transform" } : undefined}
          >
            {title && (
              <h2 className="text-2xl font-semibold text-gray-800 dark:text-gray-100">
                {title}
              </h2>
            )}
            {subtitle && (
              <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
                {subtitle}
              </p>
            )}
          </motion.div>
        )}
        
        <motion.div 
          variants={contentVariants}
          className="w-full relative"
          style={{ 
            transformOrigin: "center top",
            ...(shouldReduceMotion ? {} : { willChange: "opacity, transform" })
          }}
          data-tab-content={currentTab}
        >
          <div className="relative z-10">
            {children}
          </div>
          
          {/* Subtle background effect - only show if reduced motion is not preferred */}
          {!shouldReduceMotion && (
            <motion.div 
              className="absolute inset-0 bg-gradient-to-b from-transparent to-background/5 rounded-lg pointer-events-none"
              initial={{ opacity: 0 }}
              animate={{ 
                opacity: 0.3, // Reduced opacity
                transition: { delay: 0.05, duration: 0.3 } // Reduced delay and duration
              }}
            />
          )}
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
} 