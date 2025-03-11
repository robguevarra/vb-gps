"use client";

/**
 * DashboardCards Component
 * 
 * A responsive grid of cards displaying key metrics for missionaries:
 * - Monthly Goal vs Current Donations (with progress bar)
 * - Current Donations total
 * - Active Partners count
 * - New Partners count
 * 
 * Features:
 * - Responsive grid layout (1 column on mobile, 4 on large screens)
 * - Progress bar for monthly goal tracking
 * - Currency formatting for monetary values
 * - Color-coded indicators
 * - Hover animations
 * - Shows percentages above 100% when donations exceed monthly goal
 * - Enhanced animations with staggered card reveals
 * 
 * @component
 */

//components/DashboardCards.tsx

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { cn } from "@/lib/utils"
import { TrendingUp, Wallet, Users, UserPlus } from "lucide-react"
import { motion } from "framer-motion"
import { useEffect, useState } from "react"

interface DashboardCardsProps {
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

export default function DashboardCards({
  monthlyGoal,
  currentDonations,
  currentPartnersCount,
  surplusBalance,
  newPartnersCount,
}: DashboardCardsProps) {
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
        staggerChildren: 0.1,
        delayChildren: 0.1
      }
    }
  };

  // Animation variants for individual cards
  const cardVariants = {
    hidden: { 
      opacity: 0, 
      y: 20,
    },
    show: { 
      opacity: 1, 
      y: 0,
      transition: {
        type: "spring",
        stiffness: 260,
        damping: 20
      }
    }
  };

  // Animation variants for progress bar
  const progressVariants = {
    hidden: { width: "0%" },
    show: (progress: number) => ({
      width: `${Math.min(progress, 100)}%`,
      transition: {
        duration: 1.2,
        ease: "easeOut",
        delay: 0.3
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
        type: "spring",
        stiffness: 260,
        damping: 20
      }
    }
  };

  // Animation variants for value
  const valueVariants = {
    hidden: { opacity: 0, y: 10 },
    show: { 
      opacity: 1, 
      y: 0,
      transition: {
        delay: 0.2,
        duration: 0.4
      }
    }
  };

  return (
    <motion.div 
      className="grid gap-4 grid-cols-1 sm:grid-cols-2 xl:grid-cols-4" // Updated grid - 1 column on mobile
      variants={containerVariants}
      initial="hidden"
      animate={shouldAnimate ? "show" : "hidden"}
    >
      {cards.map((card, index) => (
        <motion.div
          key={card.title}
          variants={cardVariants}
          whileHover={{ 
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
                    card.variant === "blue" ? "bg-blue-100 text-blue-600" :
                    card.variant === "emerald" ? "bg-emerald-100 text-emerald-600" :
                    card.variant === "indigo" ? "bg-indigo-100 text-indigo-600" :
                    "bg-teal-100 text-teal-600"
                  )}
                >
                  <card.icon className="h-6 w-6" />
                </motion.div>
                {card.progress !== undefined && (
                  <motion.span 
                    variants={valueVariants}
                    className={cn(
                      "text-lg font-semibold",
                      card.variant === "blue" ? "text-blue-600" :
                      card.variant === "emerald" ? "text-emerald-600" :
                      card.variant === "indigo" ? "text-indigo-600" :
                      "text-teal-600"
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
                  className="text-2xl font-bold tracking-tight truncate" // Added truncate for mobile
                >
                  {card.isCurrency 
                    ? `₱${(card.value ?? 0).toLocaleString()}` 
                    : (card.value ?? 0).toLocaleString()}
                </motion.p>
              </div>

              {/* Progress Bar (only for Monthly Goal) */}
              {card.progress !== undefined && (
                <div className="mt-4">
                  <div className="h-2 overflow-hidden rounded-full bg-accent">
                    <motion.div
                      variants={progressVariants}
                      initial="hidden"
                      animate={shouldAnimate ? "show" : "hidden"}
                      custom={card.progress}
                      className={cn(
                        "h-full",
                        card.variant === "blue" ? "bg-blue-600" :
                        card.variant === "emerald" ? "bg-emerald-600" :
                        card.variant === "indigo" ? "bg-indigo-600" :
                        "bg-teal-600"
                      )}
                    />
                  </div>
                </div>
              )}
            </div>
          </Card>
        </motion.div>
      ))}
    </motion.div>
  )
}

