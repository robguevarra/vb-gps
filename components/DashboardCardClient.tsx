"use client";

/**
 * DashboardCardClient Component
 * 
 * Client component that renders dashboard cards with animations.
 * This component is responsible for the visual presentation and animations,
 * while the data fetching is handled by the server component wrapper.
 * 
 * Features:
 * - Staggered card animations
 * - Progress bar animations
 * - Hover effects
 * - Reduced motion support
 * - Responsive grid layout
 * 
 * @component
 */

import { Card, CardContent } from "@/components/ui/card"
import { cn } from "@/lib/utils"
import { TrendingUp, Wallet, Users, UserPlus } from "lucide-react"
import { motion, useReducedMotion } from "framer-motion"
import { useEffect, useState } from "react"

interface DashboardCardClientProps {
  /** Monthly donation goal for the missionary */
  monthlyGoal: number;
  /** Total donations received in the current month */
  currentDonations: number;
  /** Number of active partners (donors who gave this month) */
  currentPartnersCount: number;
  /** Current surplus balance available */
  surplusBalance: number;
  /** Number of new partners this month */
  newPartnersCount: number;
}

// Define the card type to ensure type safety
interface DashboardCard {
  title: string;
  value: number;
  progress?: number;
  variant: "blue" | "emerald" | "indigo" | "teal";
  isCurrency: boolean;
  icon: React.ElementType;
}

export function DashboardCardClient({
  monthlyGoal,
  currentDonations,
  currentPartnersCount,
  surplusBalance,
  newPartnersCount,
}: DashboardCardClientProps) {
  // Check if user prefers reduced motion
  const prefersReducedMotion = useReducedMotion();
  
  // State to track if animation should start
  const [shouldAnimate, setShouldAnimate] = useState(false);
  
  // Start animation after component mounts
  useEffect(() => {
    setShouldAnimate(true);
  }, []);

  // Calculate progress percentage, ensuring we don't divide by zero
  const progressPercentage = monthlyGoal > 0 
    ? (currentDonations / monthlyGoal) * 100 
    : 0;

  // Define card configurations with their respective properties
  const cards: DashboardCard[] = [
    {
      title: "Monthly Goal",
      value: monthlyGoal ?? 0,
      progress: progressPercentage, // Use the safely calculated percentage
      variant: "blue",
      isCurrency: true,
      icon: TrendingUp
    },
    {
      title: "Current Donations",
      value: currentDonations ?? 0,
      variant: "emerald",
      isCurrency: true,
      icon: Wallet
    },
    {
      title: "Active Partners",
      value: currentPartnersCount ?? 0,
      variant: "indigo",
      isCurrency: false,
      icon: Users
    },
    {
      title: "New Partners",
      value: newPartnersCount ?? 0,
      variant: "teal",
      isCurrency: false,
      icon: UserPlus
    },
    {
      title: "Surplus Balance",
      value: surplusBalance ?? 0,
      variant: "teal",
      isCurrency: true,
      icon: Wallet
    }
  ]

  // Animation variants for container
  const containerVariants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: prefersReducedMotion ? 0 : 0.1,
        delayChildren: 0.1
      }
    }
  };

  // Animation variants for individual cards
  const cardVariants = {
    hidden: { 
      opacity: 0, 
      y: prefersReducedMotion ? 0 : 20,
    },
    show: { 
      opacity: 1, 
      y: 0,
      transition: {
        type: prefersReducedMotion ? "tween" : "spring",
        stiffness: 260,
        damping: 20,
        duration: prefersReducedMotion ? 0.2 : undefined
      }
    }
  };

  // Animation variants for progress bar
  const progressVariants = {
    hidden: { width: "0%" },
    show: (progress: number) => ({
      width: `${Math.min(progress, 100)}%`,
      transition: {
        duration: prefersReducedMotion ? 0.5 : 1.2,
        ease: "easeOut",
        delay: prefersReducedMotion ? 0 : 0.3
      }
    })
  };

  // Animation variants for icon
  const iconVariants = {
    hidden: { scale: 0.8, opacity: 0.5 },
    show: { 
      scale: 1, 
      opacity: 1,
      transition: {
        type: prefersReducedMotion ? "tween" : "spring",
        stiffness: 260,
        damping: 20,
        duration: prefersReducedMotion ? 0.2 : undefined
      }
    }
  };

  // Animation variants for value
  const valueVariants = {
    hidden: { opacity: 0, y: prefersReducedMotion ? 0 : 10 },
    show: { 
      opacity: 1, 
      y: 0,
      transition: {
        delay: prefersReducedMotion ? 0 : 0.2,
        duration: 0.4
      }
    }
  };

  return (
    <motion.div 
      className="grid gap-4 md:grid-cols-2 xl:grid-cols-4"
      variants={containerVariants}
      initial="hidden"
      animate={shouldAnimate ? "show" : "hidden"}
      aria-live="polite"
    >
      {cards.map((card, index) => (
        <motion.div
          key={card.title}
          variants={cardVariants}
          whileHover={prefersReducedMotion ? {} : { 
            y: -5,
            transition: { duration: 0.2 }
          }}
          className="h-full"
        >
          <Card className="h-full relative overflow-hidden transition-all hover:shadow-lg border-2 border-transparent hover:border-accent/50 dark:hover:border-accent/30">
            <div className="p-6 h-full flex flex-col">
              {/* Card Header with Icon and Progress */}
              <div className="flex items-center justify-between">
                <motion.div
                  variants={iconVariants}
                  className={cn(
                    "p-2 rounded-full",
                    card.variant === "blue" ? "bg-blue-100 text-blue-600 dark:bg-blue-950 dark:text-blue-400" :
                    card.variant === "emerald" ? "bg-emerald-100 text-emerald-600 dark:bg-emerald-950 dark:text-emerald-400" :
                    card.variant === "indigo" ? "bg-indigo-100 text-indigo-600 dark:bg-indigo-950 dark:text-indigo-400" :
                    "bg-teal-100 text-teal-600 dark:bg-teal-950 dark:text-teal-400"
                  )}
                >
                  <card.icon className="h-6 w-6" />
                </motion.div>
                {card.progress !== undefined && (
                  <motion.span 
                    variants={valueVariants}
                    className={cn(
                      "text-lg font-semibold",
                      card.variant === "blue" ? "text-blue-600 dark:text-blue-400" :
                      card.variant === "emerald" ? "text-emerald-600 dark:text-emerald-400" :
                      card.variant === "indigo" ? "text-indigo-600 dark:text-indigo-400" :
                      "text-teal-600 dark:text-teal-400"
                    )}
                  >
                    {card.progress.toFixed(1)}%
                  </motion.span>
                )}
              </div>
              
              {/* Card Content with Title and Value */}
              <div className="mt-4 space-y-1 flex-grow">
                <h3 className="text-sm font-medium text-muted-foreground">
                  {card.title}
                </h3>
                <motion.p 
                  variants={valueVariants}
                  className="text-2xl font-bold tracking-tight"
                >
                  {card.isCurrency 
                    ? `₱${(card.value ?? 0).toLocaleString()}` 
                    : (card.value ?? 0).toLocaleString()}
                </motion.p>
              </div>

              {/* Progress Bar (only for Monthly Goal) */}
              {card.progress !== undefined && (
                <div className="mt-4">
                  <div className="h-2 bg-muted rounded-full overflow-hidden">
                    <motion.div
                      custom={card.progress}
                      variants={progressVariants}
                      className={cn(
                        "h-full rounded-full",
                        card.progress >= 100 
                          ? "bg-green-500 dark:bg-green-600" 
                          : card.progress >= 75 
                            ? "bg-blue-500 dark:bg-blue-600" 
                            : card.progress >= 50 
                              ? "bg-yellow-500 dark:bg-yellow-600" 
                              : "bg-red-500 dark:bg-red-600"
                      )}
                      style={{ 
                        willChange: "width",
                      }}
                    />
                  </div>
                </div>
              )}
            </div>
          </Card>
        </motion.div>
      ))}
    </motion.div>
  );
} 