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
 * Performance Optimizations:
 * 1. Memoized card configurations and calculations
 * 2. CSS-based animations for better performance
 * 3. Proper loading states with skeletons
 * 4. Optimized re-renders with useMemo and useCallback
 * 5. Type-safe data handling
 * 
 * @component
 */

//components/DashboardCards.tsx

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { cn } from "@/lib/utils"
import { TrendingUp, Wallet, Users, UserPlus } from "lucide-react"
import { memo, useMemo, useCallback } from "react"

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
  /** Loading state for the component */
  isLoading?: boolean;
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

/**
 * Skeleton component for loading state
 */
function DashboardCardSkeleton() {
  return (
    <Card className="h-full animate-pulse">
      <div className="p-6 h-full flex flex-col">
        <div className="flex items-center justify-between">
          <div className="h-10 w-10 rounded-full bg-gray-200" />
          <div className="h-6 w-16 bg-gray-200 rounded" />
        </div>
        <div className="mt-4 space-y-2">
          <div className="h-4 w-24 bg-gray-200 rounded" />
          <div className="h-8 w-32 bg-gray-200 rounded" />
        </div>
        <div className="mt-4">
          <div className="h-2 w-full bg-gray-200 rounded" />
        </div>
      </div>
    </Card>
  );
}

/**
 * Individual dashboard card component with memoization
 */
const DashboardCard = memo(function DashboardCard({ 
  card 
}: { 
  card: DashboardCard 
}) {
  const formattedValue = useMemo(() => {
    return card.isCurrency 
      ? `₱${(card.value ?? 0).toLocaleString()}` 
      : (card.value ?? 0).toLocaleString();
  }, [card.value, card.isCurrency]);

  const progressBarStyle = useMemo(() => {
    if (card.progress === undefined) return {};
    return {
      width: `${Math.min(card.progress, 100)}%`,
      transition: 'width 1.2s ease-out'
    };
  }, [card.progress]);

  return (
    <Card className="h-full relative overflow-hidden transition-all hover:shadow-lg border-2 border-transparent hover:border-accent/50 dark:hover:border-accent/30">
      <div className="p-6 h-full flex flex-col">
        {/* Card Header with Icon and Progress */}
        <div className="flex items-center justify-between">
          <div
            className={cn(
              "p-2 rounded-full transition-transform hover:scale-110",
              card.variant === "blue" ? "bg-blue-100 text-blue-600" :
              card.variant === "emerald" ? "bg-emerald-100 text-emerald-600" :
              card.variant === "indigo" ? "bg-indigo-100 text-indigo-600" :
              "bg-teal-100 text-teal-600"
            )}
          >
            <card.icon className="h-6 w-6" />
          </div>
          {card.progress !== undefined && (
            <span 
              className={cn(
                "text-lg font-semibold",
                card.variant === "blue" ? "text-blue-600" :
                card.variant === "emerald" ? "text-emerald-600" :
                card.variant === "indigo" ? "text-indigo-600" :
                "text-teal-600"
              )}
            >
              {card.progress.toFixed(1)}%
            </span>
          )}
        </div>
        
        {/* Card Content with Title and Value */}
        <div className="mt-4 space-y-1 flex-grow">
          <h3 className="text-sm font-medium text-muted-foreground">
            {card.title}
          </h3>
          <p className="text-2xl font-bold tracking-tight">
            {formattedValue}
          </p>
        </div>

        {/* Progress Bar (only for Monthly Goal) */}
        {card.progress !== undefined && (
          <div className="mt-4">
            <div className="h-2 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
              <div
                className={cn(
                  "h-full rounded-full transition-all duration-1000",
                  card.variant === "blue" ? "bg-blue-500" :
                  card.variant === "emerald" ? "bg-emerald-500" :
                  card.variant === "indigo" ? "bg-indigo-500" :
                  "bg-teal-500"
                )}
                style={progressBarStyle}
              />
            </div>
          </div>
        )}
      </div>
    </Card>
  );
});

/**
 * Main DashboardCards component with optimized rendering
 */
export default function DashboardCards({
  monthlyGoal,
  currentDonations,
  currentPartnersCount,
  surplusBalance,
  newPartnersCount,
  isLoading = false,
}: DashboardCardsProps) {
  // Calculate progress percentage, ensuring we don't divide by zero
  const progressPercentage = useMemo(() => 
    monthlyGoal > 0 ? (currentDonations / monthlyGoal) * 100 : 0,
    [monthlyGoal, currentDonations]
  );

  // Define card configurations with their respective properties
  const cards = useMemo<DashboardCard[]>(() => [
    {
      title: "Monthly Goal",
      value: monthlyGoal ?? 0,
      progress: progressPercentage,
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
  ], [monthlyGoal, currentDonations, currentPartnersCount, newPartnersCount, surplusBalance, progressPercentage]);

  if (isLoading) {
    return (
      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        {[...Array(5)].map((_, i) => (
          <DashboardCardSkeleton key={i} />
        ))}
      </div>
    );
  }

  return (
    <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
      {cards.map((card) => (
        <DashboardCard key={card.title} card={card} />
      ))}
    </div>
  );
}

