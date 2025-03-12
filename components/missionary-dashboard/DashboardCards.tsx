/**
 * DashboardCards Component
 * 
 * Client component that renders dashboard cards with animations.
 * This component is a thin wrapper around DashboardCardClient that
 * receives data from the server component.
 * 
 * @component
 */

"use client";

import { DashboardCardClient } from "@/components/DashboardCardClient";

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

export function DashboardCards({
  monthlyGoal,
  currentDonations,
  currentPartnersCount,
  surplusBalance,
  newPartnersCount,
}: DashboardCardsProps) {
  return (
    <DashboardCardClient
      monthlyGoal={monthlyGoal}
      currentDonations={currentDonations}
      currentPartnersCount={currentPartnersCount}
      surplusBalance={surplusBalance}
      newPartnersCount={newPartnersCount}
    />
  );
} 