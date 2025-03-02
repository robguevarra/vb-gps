"use client";

import { motion } from "framer-motion";
import React, { ReactNode } from "react";

interface AnimatedCardProps {
  children: ReactNode;
  delay?: number;
  className?: string;
}

export function AnimatedCard({ 
  children, 
  delay = 0, 
  className = "" 
}: AnimatedCardProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 15 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{
        duration: 0.5,
        delay,
        ease: [0.25, 0.1, 0.25, 1.0] // Cubic bezier for a more natural motion
      }}
      whileHover={{ 
        scale: 1.01,
        boxShadow: "0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)",
        transition: { duration: 0.2 }
      }}
      className={className}
    >
      {children}
    </motion.div>
  );
}

// Specialized variant for stat cards
export function AnimatedStatCard({ 
  children, 
  delay = 0, 
  className = "" 
}: AnimatedCardProps) {
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{
        duration: 0.4,
        delay,
        ease: "easeOut"
      }}
      whileHover={{ 
        y: -5,
        transition: { duration: 0.2 }
      }}
      className={className}
    >
      {children}
    </motion.div>
  );
}

// Specialized variant for table rows with staggered animation
export function AnimatedTableRow({ 
  children, 
  delay = 0, 
  className = "" 
}: AnimatedCardProps) {
  return (
    <motion.tr
      initial={{ opacity: 0, x: -10 }}
      animate={{ opacity: 1, x: 0 }}
      transition={{
        duration: 0.3,
        delay,
        ease: "easeOut"
      }}
      whileHover={{ 
        backgroundColor: "rgba(0, 0, 0, 0.02)",
        transition: { duration: 0.1 }
      }}
      className={className}
    >
      {children}
    </motion.tr>
  );
}

// Specialized variant for buttons with subtle pulse effect
export function AnimatedActionButton({ 
  children, 
  delay = 0, 
  className = "" 
}: AnimatedCardProps) {
  return (
    <motion.button
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{
        duration: 0.3,
        delay,
        ease: "easeOut"
      }}
      whileHover={{ 
        scale: 1.05,
        transition: { duration: 0.2 }
      }}
      whileTap={{ scale: 0.95 }}
      className={className}
    >
      {children}
    </motion.button>
  );
} 