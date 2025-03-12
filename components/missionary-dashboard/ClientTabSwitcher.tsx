"use client";

/**
 * ClientTabSwitcher Component
 * 
 * This client component manages tab switching with efficient caching.
 * It stores rendered tab content in memory and reuses it when switching
 * back to a previously visited tab, eliminating the reload delay.
 * 
 * Features:
 * - Client-side tab content caching
 * - Instant tab switching without server requests
 * - Preserves tab state between switches
 * - Provides manual refresh option for each tab
 * - Uses URL parameters for deep linking and sharing
 * - Triggers background preloading of other tabs
 * - Shows loading indicators during content fetching
 * - Provides immediate visual feedback on tab changes
 * 
 * @component
 */

import { useState, useRef, useEffect } from "react";
import { useRouter, usePathname, useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { RefreshCw } from "lucide-react";
import { DashboardTabSkeleton } from "./DashboardTabSkeleton";
import { motion, AnimatePresence } from "framer-motion";

interface TabContent {
  [key: string]: React.ReactNode | null;
}

interface ClientTabSwitcherProps {
  /** The initial tab content to render */
  initialContent: React.ReactNode;
  /** The current tab from URL */
  currentTab: string;
  /** The missionary ID for the dashboard */
  missionaryId: string;
  /** Available tabs for preloading */
  availableTabs?: string[];
}

export function ClientTabSwitcher({ 
  initialContent, 
  currentTab,
  missionaryId,
  availableTabs = []
}: ClientTabSwitcherProps) {
  // Store rendered tab content in a ref to persist between renders
  const tabContentRef = useRef<TabContent>({});
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [activeTab, setActiveTab] = useState(currentTab);
  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  
  // Initialize with the initial content
  useEffect(() => {
    if (!tabContentRef.current[currentTab]) {
      tabContentRef.current[currentTab] = initialContent;
    }
    setActiveTab(currentTab);
    setIsLoading(false);
  }, [currentTab, initialContent]);
  
  // Trigger preloading of other tabs
  useEffect(() => {
    // Skip if we're refreshing
    if (isRefreshing) return;
    
    // Define the tabs to preload (all tabs except the current one)
    const tabsToPreload = availableTabs.filter(tab => tab !== currentTab);
    
    // Stagger the preloading to avoid overwhelming the network
    tabsToPreload.forEach((tab, index) => {
      setTimeout(() => {
        const url = `${pathname}?tab=${tab}&userId=${missionaryId}`;
        router.prefetch(url);
        
        // Log preloading in development mode
        if (process.env.NODE_ENV === 'development') {
          console.log(`Preloaded tab: ${tab}`);
        }
      }, index * 1000); // Stagger by 1 second per tab
    });
  }, [currentTab, missionaryId, pathname, router, availableTabs, isRefreshing]);
  
  // Handle manual refresh
  const handleRefresh = () => {
    setIsRefreshing(true);
    setIsLoading(true);
    
    // Create new search params with refresh timestamp
    const newParams = new URLSearchParams(searchParams?.toString() || "");
    newParams.set("refresh", Date.now().toString());
    
    // Clear the cached content for this tab
    tabContentRef.current[activeTab] = null;
    
    // Navigate to the same tab with refresh parameter
    router.push(`${pathname}?${newParams.toString()}`);
    
    // Reset refreshing state after a delay
    setTimeout(() => {
      setIsRefreshing(false);
    }, 1000);
  };
  
  // Get the appropriate tab type for the skeleton
  const getTabType = () => {
    switch(activeTab) {
      case "overview": return "overview";
      case "history": return "history";
      case "approvals": return "approvals";
      case "manual-remittance": return "manual-remittance";
      case "reports": return "reports";
      case "staff-reports": return "staff-reports";
      default: return "overview";
    }
  };
  
  return (
    <div className="space-y-4">
      <div className="flex justify-end">
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
      
      {/* Show cached content if available, otherwise show initial content */}
      <div data-tab-content={activeTab} className="relative">
        <AnimatePresence mode="wait">
          {isLoading ? (
            <motion.div
              key="loading"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
            >
              <DashboardTabSkeleton type={getTabType()} />
            </motion.div>
          ) : (
            <motion.div
              key={activeTab}
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
            >
              {tabContentRef.current[activeTab] || initialContent}
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
} 