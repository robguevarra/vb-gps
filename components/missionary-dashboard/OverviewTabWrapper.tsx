"use client";

/**
 * OverviewTabWrapper Component
 * 
 * Client component that wraps the server-side OverviewTab component to provide caching.
 * This component prevents unnecessary reloads of the OverviewTab when navigating back to it.
 * 
 * Implementation:
 * - Uses React's useRef to store the rendered content
 * - Caches the content after first load
 * - Returns cached content on subsequent renders
 * - Uses a loading state to show a skeleton while initial content loads
 * - Implements a refresh mechanism for manual data refresh
 * 
 * @component
 */

import { useRef, useState, useEffect } from "react";
import dynamic from "next/dynamic";
import { useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { RefreshCw } from "lucide-react";
import { DashboardTabSkeleton } from "./DashboardTabSkeleton";

// Dynamically import the OverviewTab to prevent it from being part of the initial JS bundle
const OverviewTab = dynamic(() => import("./OverviewTab"), {
  loading: () => <DashboardTabSkeleton type="overview" />,
  ssr: true
});

interface OverviewTabWrapperProps {
  missionaryId: string;
}

export function OverviewTabWrapper({ missionaryId }: OverviewTabWrapperProps) {
  // Use refs to store the cached content and track if it's been loaded
  const cachedContentRef = useRef<React.ReactNode | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [forceRefresh, setForceRefresh] = useState(false);
  const searchParams = useSearchParams();
  const currentTab = searchParams?.get("tab") || "overview";
  
  // Reset loading state when missionary ID changes
  useEffect(() => {
    if (cachedContentRef.current) {
      setIsLoading(false);
    }
  }, [missionaryId]);
  
  // Handle manual refresh
  const handleRefresh = () => {
    setIsLoading(true);
    setForceRefresh(true);
    
    // Reset after a short delay to trigger re-render
    setTimeout(() => {
      cachedContentRef.current = null;
      setForceRefresh(false);
    }, 100);
  };
  
  // If we have cached content and we're not forcing a refresh, return it
  if (cachedContentRef.current && !forceRefresh && !isLoading) {
    return (
      <div className="space-y-6">
        <div className="flex justify-end">
          <Button 
            variant="outline" 
            size="sm" 
            onClick={handleRefresh}
            className="flex items-center gap-1 text-xs"
          >
            <RefreshCw className="h-3 w-3" />
            Refresh Data
          </Button>
        </div>
        {cachedContentRef.current}
      </div>
    );
  }
  
  // If we don't have cached content or we're forcing a refresh, render the component
  return (
    <div className="space-y-6">
      <div className="flex justify-end">
        <Button 
          variant="outline" 
          size="sm" 
          onClick={handleRefresh}
          className="flex items-center gap-1 text-xs"
          disabled={isLoading}
        >
          <RefreshCw className={`h-3 w-3 ${isLoading ? 'animate-spin' : ''}`} />
          {isLoading ? 'Loading...' : 'Refresh Data'}
        </Button>
      </div>
      
      <OverviewTabContent 
        missionaryId={missionaryId} 
        setCache={(content) => {
          cachedContentRef.current = content;
          setIsLoading(false);
        }} 
      />
    </div>
  );
}

// Internal component to handle setting the cache
function OverviewTabContent({ 
  missionaryId, 
  setCache 
}: { 
  missionaryId: string, 
  setCache: (content: React.ReactNode) => void 
}) {
  // Store the rendered content in the parent's ref after mounting
  useEffect(() => {
    const timer = setTimeout(() => {
      setCache(<OverviewTab missionaryId={missionaryId} />);
    }, 100); // Small delay to ensure component is fully rendered
    
    return () => clearTimeout(timer);
  }, [missionaryId, setCache]);
  
  return <OverviewTab missionaryId={missionaryId} />;
} 