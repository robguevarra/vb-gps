/**
 * SurplusRequestModal Component
 * 
 * Client component that renders the surplus request modal.
 * This component is a thin wrapper around the main SurplusRequestModal
 * that receives data from the server component.
 * 
 * @component
 */

"use client";

import { SurplusRequestModal as BaseSurplusRequestModal } from "@/components/SurplusRequestModal";

interface SurplusRequestModalProps {
  surplusBalance: number;
  missionaryId: string;
}

export function SurplusRequestModal({ 
  surplusBalance, 
  missionaryId 
}: SurplusRequestModalProps) {
  return (
    <BaseSurplusRequestModal
      surplusBalance={surplusBalance}
      missionaryId={missionaryId}
    />
  );
} 