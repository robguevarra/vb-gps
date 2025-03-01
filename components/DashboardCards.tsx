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
 * 
 * @component
 */

//components/DashboardCards.tsx

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { cn } from "@/lib/utils"
import { TrendingUp, Wallet, Users, UserPlus } from "lucide-react"

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

  return (
    <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
      {cards.map((card) => (
        <Card 
          key={card.title}
          className="group relative overflow-hidden transition-all hover:shadow-lg"
        >
          <div className="p-6">
            {/* Card Header with Icon and Progress */}
            <div className="flex items-center justify-between">
              <card.icon className="h-8 w-8 text-muted-foreground/80" />
              {card.progress !== undefined && (
                <span className={cn(
                  "text-lg font-semibold",
                  card.variant === "blue" ? "text-blue-600" :
                  card.variant === "emerald" ? "text-emerald-600" :
                  card.variant === "indigo" ? "text-indigo-600" :
                  "text-teal-600"
                )}>
                  {card.progress.toFixed(1)}%
                </span>
              )}
            </div>
            
            {/* Card Content with Title and Value */}
            <div className="mt-4 space-y-1">
              <h3 className="text-sm font-medium text-muted-foreground">
                {card.title}
              </h3>
              <p className="text-2xl font-bold tracking-tight">
                {card.isCurrency 
                  ? `₱${(card.value ?? 0).toLocaleString()}` 
                  : (card.value ?? 0).toLocaleString()}
              </p>
            </div>

            {/* Progress Bar (only for Monthly Goal) */}
            {card.progress !== undefined && (
              <div className="mt-4">
                <div className="h-2 overflow-hidden rounded-full bg-accent">
                  <div
                    className={cn(
                      "h-full transition-all duration-500",
                      card.variant === "blue" ? "bg-blue-600" :
                      card.variant === "emerald" ? "bg-emerald-600" :
                      card.variant === "indigo" ? "bg-indigo-600" :
                      "bg-teal-600"
                    )}
                    style={{ width: `${Math.min(card.progress, 100)}%` }}
                  />
                </div>
              </div>
            )}
          </div>
        </Card>
      ))}
    </div>
  )
}

