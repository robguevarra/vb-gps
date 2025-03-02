"use client";

import React from "react";
import { motion } from "framer-motion";

interface AnimatedLoaderProps {
  size?: "sm" | "md" | "lg";
  color?: "primary" | "secondary" | "accent" | "muted";
  text?: string;
  className?: string;
}

export function AnimatedLoader({
  size = "md",
  color = "primary",
  text,
  className = ""
}: AnimatedLoaderProps) {
  // Size mappings
  const sizeMap = {
    sm: "h-4 w-4",
    md: "h-8 w-8",
    lg: "h-12 w-12"
  };

  // Color mappings
  const colorMap = {
    primary: "border-primary",
    secondary: "border-secondary",
    accent: "border-accent",
    muted: "border-muted"
  };

  // Animation for the spinner
  const spinnerVariants = {
    animate: {
      rotate: 360,
      transition: {
        repeat: Infinity,
        duration: 1,
        ease: "linear"
      }
    }
  };

  // Animation for the text
  const textVariants = {
    initial: { opacity: 0 },
    animate: {
      opacity: 1,
      transition: {
        delay: 0.3,
        duration: 0.5
      }
    }
  };

  // Animation for the dots
  const dotsVariants = {
    initial: { opacity: 0 },
    animate: {
      opacity: [0, 1, 0],
      transition: {
        repeat: Infinity,
        duration: 1.5,
        times: [0, 0.5, 1],
        ease: "easeInOut"
      }
    }
  };

  return (
    <div className={`flex flex-col items-center justify-center ${className}`}>
      <motion.div
        animate="animate"
        variants={spinnerVariants}
        className={`rounded-full border-2 border-t-transparent ${sizeMap[size]} ${colorMap[color]}`}
      />
      
      {text && (
        <motion.div 
          className="mt-4 flex items-center"
          initial="initial"
          animate="animate"
          variants={textVariants}
        >
          <span className="text-sm text-gray-600 dark:text-gray-400">{text}</span>
          <motion.span
            variants={dotsVariants}
            className="ml-1"
          >
            ...
          </motion.span>
        </motion.div>
      )}
    </div>
  );
}

// Skeleton loader with animation
export function AnimatedSkeleton({
  className = "",
  width = "w-full",
  height = "h-6"
}: {
  className?: string;
  width?: string;
  height?: string;
}) {
  return (
    <motion.div
      className={`bg-gray-200 dark:bg-gray-700 rounded ${width} ${height} ${className}`}
      animate={{
        opacity: [0.5, 0.8, 0.5],
        transition: {
          repeat: Infinity,
          duration: 1.5,
          ease: "easeInOut"
        }
      }}
    />
  );
}

// Card skeleton with animation
export function AnimatedCardSkeleton({
  className = "",
  rows = 3
}: {
  className?: string;
  rows?: number;
}) {
  return (
    <div className={`p-4 rounded-lg border border-gray-200 dark:border-gray-700 ${className}`}>
      <AnimatedSkeleton height="h-6" className="mb-4" width="w-3/4" />
      
      {Array.from({ length: rows }).map((_, i) => (
        <AnimatedSkeleton 
          key={i} 
          height="h-4" 
          className="mb-3" 
          width={`w-${Math.floor(Math.random() * 3) + 8}/12`} 
        />
      ))}
    </div>
  );
} 