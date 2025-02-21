import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { cn } from "@/lib/utils"
import { TrendingUp, Wallet, Users, UserPlus } from "lucide-react"

interface DashboardCardsProps {
  monthlyGoal: number
  currentDonations: number
  currentPartnersCount: number
  surplusBalance: number
  newPartnersCount: number
}

export default function DashboardCards({
  monthlyGoal,
  currentDonations,
  currentPartnersCount,
  surplusBalance,
  newPartnersCount,
}: DashboardCardsProps) {
  const cards = [
    {
      title: "Monthly Goal",
      value: monthlyGoal,
      progress: (currentDonations / monthlyGoal) * 100,
      variant: "blue",
      isCurrency: true,
      icon: TrendingUp
    },
    {
      title: "Current Donations",
      value: currentDonations,
      variant: "emerald",
      isCurrency: true,
      icon: Wallet
    },
    {
      title: "Active Partners",
      value: currentPartnersCount,
      variant: "indigo",
      isCurrency: false,
      icon: Users
    },
    {
      title: "New Partners",
      value: newPartnersCount,
      variant: "teal",
      isCurrency: false,
      icon: UserPlus
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
            <div className="flex items-center justify-between">
              <card.icon className="h-8 w-8 text-muted-foreground/80" />
              {"progress" in card && (
                <span className={cn(
                  "text-lg font-semibold",
                  card.variant === "blue" ? "text-blue-600" :
                  card.variant === "emerald" ? "text-emerald-600" :
                  card.variant === "indigo" ? "text-indigo-600" :
                  "text-teal-600"
                )}>
                  {Math.min(card.progress, 100).toFixed(1)}%
                </span>
              )}
            </div>
            
            <div className="mt-4 space-y-1">
              <h3 className="text-sm font-medium text-muted-foreground">
                {card.title}
              </h3>
              <p className="text-2xl font-bold tracking-tight">
                {card.isCurrency 
                  ? `₱${(card.value || 0).toLocaleString()}` 
                  : (card.value || 0).toLocaleString()}
              </p>
            </div>

            {"progress" in card && (
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
                    style={{ width: `${card.progress}%` }}
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

