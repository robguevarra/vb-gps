'use client';

/**
 * LeaveRequestModalWrapper Component
 * 
 * A client component wrapper for the LeaveRequestModal.
 * This wrapper is necessary to isolate client-side functionality
 * while allowing the parent OverviewTab to be a server component.
 * 
 * @component
 */

import { LeaveRequestModal } from "@/components/LeaveRequestModal";

interface LeaveRequestModalWrapperProps {
  missionaryId: string;
}

export function LeaveRequestModalWrapper({ missionaryId }: LeaveRequestModalWrapperProps) {
  return (
    <LeaveRequestModal
      missionaryId={missionaryId}
      validateMissionary={false}
    />
  );
} 