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
 * 6. Adding visual loading indicators for better feedback
 * 7. Providing truly instant UI feedback regardless of data loading
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
  
  // Reference to store the overview tab content
  const overviewTabRef = useRef<HTMLDivElement | null>(null);
  const overviewTabContentRef = useRef<string | null>(null);
  
  // Update active tab when currentTab changes (e.g. from URL)
  useEffect(() => {
    setActiveTab(currentTab);
    setLoadingTab(null);
    setClickedTab(null);
    
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
          setLoadingTab(null);
          setClickedTab(null);
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
    <Tabs value={activeTab} onValueChange={handleTabChange} className="w-full">
      <TabsList className="w-full md:w-auto flex overflow-x-auto">
        {tabs.map((tab) => (
          <TabsTrigger
            key={tab.id}
            value={tab.id}
            onMouseEnter={() => prefetchTab(tab.id)}
            onFocus={() => prefetchTab(tab.id)}
            disabled={isNavigating && tab.id !== clickedTab} // Only disable non-clicked tabs
            className={`relative min-w-[100px] flex items-center justify-center gap-2 transition-all ${clickedTab === tab.id ? 'opacity-100' : isNavigating ? 'opacity-50' : 'opacity-100'}`}
          >
            {tab.label}
            {loadingTab === tab.id && (
              <Loader2 className="h-3 w-3 animate-spin inline-block ml-1" />
            )}
            {/* Active tab indicator with animation */}
            {activeTab === tab.id && (
              <span 
                className="absolute bottom-0 left-0 w-full h-[3px] bg-primary rounded-t-full" 
                style={{
                  animation: "tabIndicatorIn 0.2s ease forwards"
                }}
              />
            )}
          </TabsTrigger>
        ))}
      </TabsList>
      
      <style jsx global>{`
        @keyframes tabIndicatorIn {
          from { transform: scaleX(0.5); opacity: 0.5; }
          to { transform: scaleX(1); opacity: 1; }
        }
        
        /* Add a subtle pulse animation for the clicked tab */
        @keyframes tabPulse {
          0% { background-color: transparent; }
          50% { background-color: hsl(var(--primary) / 0.1); }
          100% { background-color: transparent; }
        }
      `}</style>
    </Tabs>
  );
} 