import { Card, CardContent } from "@/components/ui/card"
import { DollarSign, Target, Clock, PiggyBank } from "lucide-react"

interface DashboardCardsProps {
  monthlyGoal: number
  currentDonations: number
  pendingRequests: number
  surplusBalance: number
}

export default function DashboardCards({
  monthlyGoal,
  currentDonations,
  pendingRequests,
  surplusBalance,
}: DashboardCardsProps) {
  const cards = [
    {
      title: "Monthly Goal",
      value: `$${monthlyGoal.toLocaleString()}`,
      icon: Target,
      description: "Target donation amount",
      color: "text-blue-600 dark:text-blue-400",
      bgColor: "bg-blue-100 dark:bg-blue-900/20",
    },
    {
      title: "Current Donations",
      value: `$${currentDonations.toLocaleString()}`,
      icon: DollarSign,
      description: "Total donations this month",
      color: "text-green-600 dark:text-green-400",
      bgColor: "bg-green-100 dark:bg-green-900/20",
    },
    {
      title: "Pending Requests",
      value: pendingRequests,
      icon: Clock,
      description: "Awaiting approval",
      color: "text-yellow-600 dark:text-yellow-400",
      bgColor: "bg-yellow-100 dark:bg-yellow-900/20",
    },
    {
      title: "Surplus Balance",
      value: `$${surplusBalance.toLocaleString()}`,
      icon: PiggyBank,
      description: "Available for future use",
      color: "text-purple-600 dark:text-purple-400",
      bgColor: "bg-purple-100 dark:bg-purple-900/20",
    },
  ]

  return (
    <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
      {cards.map((card) => (
        <Card key={card.title} className="bg-white dark:bg-gray-800 shadow-lg rounded-xl overflow-hidden">
          <CardContent className="p-6">
            <div className="flex items-center justify-between mb-4">
              <div className={`${card.bgColor} ${card.color} p-3 rounded-full`}>
                <card.icon className="h-6 w-6" />
              </div>
            </div>
            <div className="space-y-1">
              <h3 className={`text-2xl font-bold ${card.color}`}>{card.value}</h3>
              <p className="text-sm font-medium text-gray-500 dark:text-gray-400">{card.title}</p>
              <p className="text-xs text-gray-400 dark:text-gray-500">{card.description}</p>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  )
}

