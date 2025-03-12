/**
 * OverviewTabPage Component
 * 
 * Server component that serves as the entry point for the Overview tab in the missionary dashboard.
 * This component maintains backward compatibility with the existing page structure
 * while implementing the optimized data fetching pattern.
 * 
 * @component
 */

import { OverviewTabWrapper } from "./OverviewTabWrapper";

interface OverviewTabPageProps {
  missionaryId: string;
}

export default function OverviewTabPage({ missionaryId }: OverviewTabPageProps) {
  return <OverviewTabWrapper missionaryId={missionaryId} />;
} 