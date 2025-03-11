"use client";

/**
 * TabSwitcher Component
 * 
 * Client component that handles tab switching with prefetching for instant navigation.
 * This component improves the user experience by:
 * 1. Using client-side navigation to avoid full page reloads
 * 2. Prefetching tab data when hovering over tabs
 * 3. Showing immediate visual feedback when switching tabs
 * 4. Maintaining tab state between navigations
 * 
 * @component
 */

import { useRouter } from "next/navigation";
import { useCallback, useEffect, useState } from "react";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { usePathname } from "next/navigation";

interface Tab {
  id: string;
  label: string;
}

interface TabSwitcherProps {
  /** The available tabs to display */
  tabs: Tab[];
  /** The currently active tab */
  currentTab: string;
  /** The user ID to include in the URL */
  userId: string;
}

export function TabSwitcher({ tabs, currentTab, userId }: TabSwitcherProps) {
  const router = useRouter();
  const pathname = usePathname();
  const [isNavigating, setIsNavigating] = useState(false);
  const [activeTab, setActiveTab] = useState(currentTab);
  
  // Update active tab when currentTab changes (e.g. from URL)
  useEffect(() => {
    setActiveTab(currentTab);
  }, [currentTab]);

  // Handle tab change
  const handleTabChange = useCallback((value: string) => {
    // Set navigating state to show immediate feedback
    setIsNavigating(true);
    setActiveTab(value);
    
    // Navigate to the new tab
    const url = `${pathname}?tab=${value}${userId ? `&userId=${userId}` : ''}`;
    router.push(url);
    
    // Reset navigating state after a short delay
    setTimeout(() => {
      setIsNavigating(false);
    }, 300);
  }, [pathname, router, userId]);

  // Prefetch tab data when hovering over a tab
  const prefetchTab = useCallback((tabId: string) => {
    if (tabId !== activeTab) {
      const url = `${pathname}?tab=${tabId}${userId ? `&userId=${userId}` : ''}`;
      router.prefetch(url);
    }
  }, [activeTab, pathname, router, userId]);

  return (
    <div className="mb-6">
      <Tabs value={activeTab} onValueChange={handleTabChange} className="w-full">
        <TabsList className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-2">
          {tabs.map((tab) => (
            <TabsTrigger
              key={tab.id}
              value={tab.id}
              onMouseEnter={() => prefetchTab(tab.id)}
              onFocus={() => prefetchTab(tab.id)}
              disabled={isNavigating}
              className={isNavigating && activeTab === tab.id ? "animate-pulse" : ""}
              data-state={activeTab === tab.id ? "active" : "inactive"}
            >
              {tab.label}
            </TabsTrigger>
          ))}
        </TabsList>
      </Tabs>
    </div>
  );
} 