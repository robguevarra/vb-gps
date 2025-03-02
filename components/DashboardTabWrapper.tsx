"use client";

import React, { ReactNode, useEffect, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";

interface DashboardTabWrapperProps {
  children: ReactNode;
  title?: string;
  subtitle?: string;
}

export function DashboardTabWrapper({
  children,
  title,
  subtitle
}: DashboardTabWrapperProps) {
  const [isVisible, setIsVisible] = useState(false);
  
  useEffect(() => {
    // Small delay to ensure smooth animation
    const timer = setTimeout(() => {
      setIsVisible(true);
    }, 100);
    
    return () => clearTimeout(timer);
  }, []);

  // Animation variants for the container
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        when: "beforeChildren",
        staggerChildren: 0.12,
        duration: 0.4,
        ease: [0.25, 0.1, 0.25, 1.0]
      }
    },
    exit: {
      opacity: 0,
      transition: {
        when: "afterChildren",
        staggerChildren: 0.05,
        staggerDirection: -1,
        duration: 0.3
      }
    }
  };

  // Animation variants for the title
  const titleVariants = {
    hidden: { opacity: 0, y: -15 },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        type: "spring",
        stiffness: 300,
        damping: 25,
        duration: 0.5
      }
    },
    exit: {
      opacity: 0,
      y: -10,
      transition: {
        duration: 0.2
      }
    }
  };

  // Animation variants for the content
  const contentVariants = {
    hidden: { 
      opacity: 0, 
      y: 30,
      scale: 0.98
    },
    visible: {
      opacity: 1,
      y: 0,
      scale: 1,
      transition: {
        type: "spring",
        stiffness: 200,
        damping: 20,
        duration: 0.6,
        delay: 0.1
      }
    },
    exit: {
      opacity: 0,
      y: 20,
      transition: {
        duration: 0.3
      }
    }
  };

  return (
    <AnimatePresence mode="wait">
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
            transformOrigin: "center top"
          }}
        >
          <div className="relative z-10">
            {children}
          </div>
          
          {/* Subtle background effect */}
          <motion.div 
            className="absolute inset-0 bg-gradient-to-b from-transparent to-background/5 rounded-lg pointer-events-none"
            initial={{ opacity: 0 }}
            animate={{ 
              opacity: 0.5,
              transition: { delay: 0.3, duration: 0.8 }
            }}
          />
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
} 