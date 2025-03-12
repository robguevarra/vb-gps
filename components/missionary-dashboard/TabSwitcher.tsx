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
 * 5. Adding visual loading indicators for better feedback
 * 6. Providing truly instant UI feedback regardless of data loading
 * 
 * @component
 */

import { useRouter } from "next/navigation";
import { useCallback, useEffect, useState, useRef } from "react";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { usePathname } from "next/navigation";
import { Loader2 } from "lucide-react";

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
  const [loadingTab, setLoadingTab] = useState<string | null>(null);
  const [clickedTab, setClickedTab] = useState<string | null>(null);
  const navigationTimeoutRef = useRef<NodeJS.Timeout | null>(null);
  
  // Update active tab when currentTab changes (e.g. from URL)
  useEffect(() => {
    // Only update if the tab has actually changed
    if (currentTab !== activeTab) {
      setActiveTab(currentTab);
      
      // Only clear loading state if it matches the current tab
      if (loadingTab === currentTab) {
        setLoadingTab(null);
      }
      
      setClickedTab(null);
    }
  }, [currentTab, activeTab, loadingTab]);

  // Listen for page load completion
  useEffect(() => {
    const handleLoadComplete = () => {
      // Clear loading state after the page has fully loaded
      if (loadingTab === currentTab) {
        // Add a small delay to ensure the UI has settled
        setTimeout(() => {
          setLoadingTab(null);
          setIsNavigating(false);
        }, 200);
      }
    };
    
    // Listen for the load event
    window.addEventListener('load', handleLoadComplete);
    
    // Also listen for custom event that could be dispatched when content is loaded
    window.addEventListener('content-loaded', handleLoadComplete);
    
    return () => {
      window.removeEventListener('load', handleLoadComplete);
      window.removeEventListener('content-loaded', handleLoadComplete);
    };
  }, [loadingTab, currentTab]);

  // Handle tab change
  const handleTabChange = useCallback((value: string) => {
    // If we're already on this tab, do nothing
    if (value === activeTab) return;
    
    // If we're already navigating, don't allow another navigation
    if (isNavigating && value !== clickedTab) return;
    
    // INSTANT FEEDBACK: Set active tab immediately
    setActiveTab(value);
    setClickedTab(value);
    
    // Set navigating state to show loading indicator
    setIsNavigating(true);
    setLoadingTab(value);
    
    // Dispatch a custom event that the ClientTabSwitcher can listen for
    // This allows for coordination between components without prop drilling
    const tabChangeEvent = new CustomEvent('tabchange', { 
      detail: { tab: value, userId } 
    });
    window.dispatchEvent(tabChangeEvent);
    
    // Clear any existing navigation timeout
    if (navigationTimeoutRef.current) {
      clearTimeout(navigationTimeoutRef.current);
    }
    
    // Use setTimeout to ensure the UI updates before navigation
    // This prevents the current page from refreshing before showing the skeleton
    navigationTimeoutRef.current = setTimeout(() => {
      // For all tabs, navigate normally
      const url = `${pathname}?tab=${value}${userId ? `&userId=${userId}` : ''}`;
      router.push(url);
      navigationTimeoutRef.current = null;
    }, 10);
  }, [activeTab, pathname, router, userId, isNavigating, clickedTab]);

  // Prefetch tab data when hovering over a tab
  const prefetchTab = useCallback((tabId: string) => {
    if (tabId !== activeTab) {
      const url = `${pathname}?tab=${tabId}${userId ? `&userId=${userId}` : ''}`;
      router.prefetch(url);
    }
  }, [activeTab, pathname, router, userId]);

  return (
    <Tabs value={activeTab} onValueChange={handleTabChange} className="w-full">
      <TabsList className="w-full md:w-auto flex overflow-x-auto">
        {tabs.map((tab) => {
          const isActive = activeTab === tab.id;
          const isLoading = loadingTab === tab.id;
          
          return (
            <TabsTrigger
              key={tab.id}
              value={tab.id}
              onMouseEnter={() => prefetchTab(tab.id)}
              onFocus={() => prefetchTab(tab.id)}
              disabled={isNavigating && tab.id !== clickedTab} // Only disable non-clicked tabs
              className={`relative min-w-[100px] flex items-center justify-center gap-2 transition-all ${clickedTab === tab.id ? 'opacity-100' : isNavigating ? 'opacity-50' : 'opacity-100'}`}
            >
              {tab.label}
              {isLoading && (
                <Loader2 className="h-3 w-3 animate-spin inline-block ml-1" />
              )}
              {/* Active tab indicator with animation */}
              {isActive && !isLoading && (
                <span 
                  className="absolute bottom-0 left-0 w-full h-[3px] bg-primary rounded-t-full" 
                  style={{
                    animation: "tabIndicatorIn 0.2s ease forwards"
                  }}
                />
              )}
            </TabsTrigger>
          );
        })}
      </TabsList>
      
      <style jsx global>{`
        @keyframes tabIndicatorIn {
          from { transform: scaleX(0.5); opacity: 0.5; }
          to { transform: scaleX(1); opacity: 1; }
        }
      `}</style>
    </Tabs>
  );
} 