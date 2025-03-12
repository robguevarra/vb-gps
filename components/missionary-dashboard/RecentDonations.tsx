/**
 * RecentDonations Component
 * 
 * Client component that displays recent donation transactions.
 * This component is a thin wrapper around RecentDonationsClient that
 * receives data from the server component.
 * 
 * @component
 */

"use client";

import { RecentDonationsClient } from "@/components/RecentDonationsClient";

interface Donation {
  id: string | number;
  donor_name: string;
  date: string;
  amount: number;
}

interface RecentDonationsProps {
  donations: Donation[];
  missionaryId: string;
}

export function RecentDonations({ donations, missionaryId }: RecentDonationsProps) {
  return (
    <RecentDonationsClient
      donations={donations}
      missionaryId={missionaryId}
    />
  );
} 