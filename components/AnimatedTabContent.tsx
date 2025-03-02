"use client";

import { motion } from "framer-motion";
import React, { ReactNode } from "react";

interface AnimatedTabContentProps {
  children: ReactNode;
}

export function AnimatedTabContent({ children }: AnimatedTabContentProps) {
  // Animation variants for the container
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        when: "beforeChildren",
        staggerChildren: 0.1,
        duration: 0.3,
        ease: "easeOut"
      }
    }
  };

  // Animation variants for child elements
  const childVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        duration: 0.4,
        ease: "easeOut"
      }
    }
  };

  // Find all direct children and wrap them in motion.div
  const animatedChildren = React.Children.map(children, (child, index) => {
    // Skip null or undefined children
    if (!child) return null;

    // Apply different animation delay based on index
    const delay = index * 0.05;

    return (
      <motion.div
        initial="hidden"
        animate="visible"
        variants={childVariants}
        transition={{ delay }}
        className="w-full"
      >
        {child}
      </motion.div>
    );
  });

  return (
    <motion.div
      initial="hidden"
      animate="visible"
      variants={containerVariants}
      className="w-full"
    >
      {animatedChildren}
    </motion.div>
  );
} 