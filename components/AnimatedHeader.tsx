"use client";

import React from "react";
import { motion } from "framer-motion";

interface AnimatedHeaderProps {
  fullName: string;
  role: string;
  churchName: string;
  title: string;
  subtitle: string;
}

export function AnimatedHeader({
  fullName,
  role,
  churchName,
  title,
  subtitle
}: AnimatedHeaderProps) {
  return (
    <header className="mb-8">
      <motion.div
        initial={{ opacity: 0, y: -10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ 
          duration: 0.5, 
          ease: [0.25, 0.1, 0.25, 1.0],
          delay: 0.1
        }}
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
        initial={{ opacity: 0, y: 15 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ 
          type: "spring",
          stiffness: 300,
          damping: 25,
          delay: 0.3
        }}
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