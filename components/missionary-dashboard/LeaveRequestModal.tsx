/**
 * LeaveRequestModal Component
 * 
 * Client component that renders the leave request modal.
 * This component is a thin wrapper around the main LeaveRequestModal
 * that receives data from the server component.
 * 
 * @component
 */

"use client";

import { LeaveRequestModal as BaseLeaveRequestModal } from "@/components/LeaveRequestModal";

interface LeaveRequestModalProps {
  missionaryId: string;
}

export function LeaveRequestModal({ missionaryId }: LeaveRequestModalProps) {
  return (
    <BaseLeaveRequestModal
      missionaryId={missionaryId}
      validateMissionary={false}
    />
  );
} 