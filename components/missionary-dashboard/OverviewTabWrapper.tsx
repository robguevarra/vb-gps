"use client";

/**
 * OverviewTabWrapper Component
 * 
 * Client component that provides caching for the OverviewTab navigation.
 * This component doesn't directly wrap the server component, but instead
 * manages the navigation state to prevent unnecessary reloads.
 * 
 * Implementation:
 * - Uses localStorage to track if the Overview tab has been visited
 * - Provides a loading indicator during initial navigation
 * - Adds a refresh button for manual data refresh
 * - Works with the existing tab navigation system
 * 
 * @component
 */

import { useState, useEffect } from "react";
import { useRouter, usePathname, useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { RefreshCw } from "lucide-react";

interface OverviewTabWrapperProps {
  missionaryId: string;
}

// Storage key for tracking tab visits
const OVERVIEW_VISITED_KEY = "overview-tab-visited";

export function OverviewTabWrapper({ missionaryId }: OverviewTabWrapperProps) {
  const [isRefreshing, setIsRefreshing] = useState(false);
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  
  // Handle manual refresh
  const handleRefresh = () => {
    setIsRefreshing(true);
    
    // Clear the visited flag to force a reload
    if (typeof window !== 'undefined') {
      localStorage.removeItem(OVERVIEW_VISITED_KEY);
    }
    
    // Add a timestamp parameter to force a fresh server request
    const newParams = new URLSearchParams(searchParams?.toString() || "");
    newParams.set("refresh", Date.now().toString());
    router.push(`${pathname}?${newParams.toString()}`);
    
    // Reset the refreshing state after a delay
    setTimeout(() => {
      setIsRefreshing(false);
    }, 1000);
  };
  
  // Mark the overview tab as visited when this component mounts
  useEffect(() => {
    if (typeof window !== 'undefined') {
      localStorage.setItem(OVERVIEW_VISITED_KEY, "true");
    }
  }, []);
  
  return (
    <div className="flex justify-end mb-4">
      <Button 
        variant="outline" 
        size="sm" 
        onClick={handleRefresh}
        className="flex items-center gap-1 text-xs"
        disabled={isRefreshing}
      >
        <RefreshCw className={`h-3 w-3 ${isRefreshing ? 'animate-spin' : ''}`} />
        {isRefreshing ? 'Refreshing...' : 'Refresh Data'}
      </Button>
    </div>
  );
} 