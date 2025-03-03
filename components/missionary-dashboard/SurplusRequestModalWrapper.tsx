'use client';

/**
 * SurplusRequestModalWrapper Component
 * 
 * A client component wrapper for the SurplusRequestModal.
 * This wrapper is necessary to isolate client-side functionality
 * while allowing the parent OverviewTab to be a server component.
 * 
 * @component
 */

import { SurplusRequestModal } from "@/components/SurplusRequestModal";

interface SurplusRequestModalWrapperProps {
  surplusBalance: number;
  missionaryId: string;
}

export function SurplusRequestModalWrapper({ 
  surplusBalance, 
  missionaryId 
}: SurplusRequestModalWrapperProps) {
  return (
    <SurplusRequestModal
      surplusBalance={surplusBalance}
      missionaryId={missionaryId}
    />
  );
} 