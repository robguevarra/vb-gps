"use client";

import React from "react";
import { motion, useReducedMotion } from "framer-motion";

interface AnimatedHeaderProps {
  fullName: string;
  role: string;
  churchName: string;
  title: string;
  subtitle: string;
}

/**
 * AnimatedHeader Component
 * 
 * Displays an animated header with user information and page title.
 * Implements smooth entrance animations with accessibility considerations.
 * 
 * @param fullName - The user's full name
 * @param role - The user's role
 * @param churchName - The user's church name
 * @param title - The page title
 * @param subtitle - The page subtitle
 */
export function AnimatedHeader({
  fullName,
  role,
  churchName,
  title,
  subtitle
}: AnimatedHeaderProps) {
  // Check if user prefers reduced motion
  const shouldReduceMotion = useReducedMotion();

  // Animation variants for the header elements
  const nameVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : -10 },
    visible: { 
      opacity: 1, 
      y: 0, 
      transition: { 
        duration: shouldReduceMotion ? 0.1 : 0.4, 
        ease: [0.25, 0.1, 0.25, 1.0],
        delay: shouldReduceMotion ? 0 : 0.1
      }
    }
  };

  const titleVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 15 },
    visible: { 
      opacity: 1, 
      y: 0, 
      transition: shouldReduceMotion 
        ? { duration: 0.1 }
        : { 
            type: "spring",
            stiffness: 300,
            damping: 25,
            delay: 0.2
          }
    }
  };

  return (
    <header className="mb-8">
      <motion.div
        initial="hidden"
        animate="visible"
        variants={nameVariants}
        style={!shouldReduceMotion ? { willChange: "opacity, transform" } : undefined}
      >
        <h1 className="text-3xl font-semibold text-gray-900 dark:text-gray-100">
          {fullName}
        </h1>
        <div className="flex items-center gap-2 mt-1">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            {role}
          </p>
          <span className="text-sm text-gray-400">•</span>
          <p className="text-sm text-gray-500 dark:text-gray-400">{churchName}</p>
        </div>
      </motion.div>
      
      {/* Animated tab title */}
      <motion.div 
        className="mt-6"
        initial="hidden"
        animate="visible"
        variants={titleVariants}
        style={!shouldReduceMotion ? { willChange: "opacity, transform" } : undefined}
      >
        <h2 className="text-xl font-medium text-gray-800 dark:text-gray-200">
          {title}
        </h2>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          {subtitle}
        </p>
      </motion.div>
    </header>
  );
} 