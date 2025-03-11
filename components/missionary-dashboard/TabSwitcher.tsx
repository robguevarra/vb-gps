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
 * 5. Caching the overview tab for instant access
 * 
 * @component
 */

import { useRouter } from "next/navigation";
import { useCallback, useEffect, useState, useRef } from "react";
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
  
  // Reference to store the overview tab content
  const overviewTabRef = useRef<HTMLDivElement | null>(null);
  const overviewTabContentRef = useRef<string | null>(null);
  
  // Update active tab when currentTab changes (e.g. from URL)
  useEffect(() => {
    setActiveTab(currentTab);
    
    // If we're on the overview tab, store its content for quick access
    if (currentTab === 'overview' && !overviewTabContentRef.current) {
      const overviewContent = document.querySelector('[data-tab-content="overview"]');
      if (overviewContent) {
        overviewTabContentRef.current = overviewContent.innerHTML;
      }
    }
  }, [currentTab]);

  // Handle tab change
  const handleTabChange = useCallback((value: string) => {
    // If we're already on this tab, do nothing
    if (value === activeTab) return;
    
    // Set navigating state to show immediate feedback
    setIsNavigating(true);
    setActiveTab(value);
    
    // Special case for overview tab - use cached content if available
    if (value === 'overview' && overviewTabContentRef.current) {
      // Use cached content for overview tab
      const tabContentElement = document.querySelector('[data-tab-content]');
      if (tabContentElement) {
        // Save current scroll position
        const scrollPosition = window.scrollY;
        
        // Update URL without full navigation
        window.history.pushState({}, '', `${pathname}?tab=overview${userId ? `&userId=${userId}` : ''}`);
        
        // Apply cached content
        tabContentElement.innerHTML = overviewTabContentRef.current;
        
        // Restore scroll position
        window.scrollTo(0, scrollPosition);
        
        // Reset navigating state
        setTimeout(() => {
          setIsNavigating(false);
        }, 100);
        
        return;
      }
    }
    
    // For other tabs, navigate normally
    const url = `${pathname}?tab=${value}${userId ? `&userId=${userId}` : ''}`;
    router.push(url);
    
    // Reset navigating state after a short delay
    setTimeout(() => {
      setIsNavigating(false);
    }, 300);
  }, [activeTab, pathname, router, userId, overviewTabContentRef]);

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