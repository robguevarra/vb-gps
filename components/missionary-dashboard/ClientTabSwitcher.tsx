"use client";

/**
 * ClientTabSwitcher Component
 * 
 * A client-side tab switching component that provides instant feedback and caches rendered content.
 * 
 * Features:
 * - Caches rendered tab content for instant switching
 * - Manages loading states for smooth transitions
 * - Dispatches events for coordination with other components
 * - Intelligent preloading of tabs in the background
 * - Skeleton loading states for immediate visual feedback
 * 
 * @component
 */

import { useEffect, useRef, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { AnimatePresence, motion } from "framer-motion";
import { DashboardTabSkeleton } from "./DashboardTabSkeleton";

interface ClientTabSwitcherProps {
  initialTab: string;
  initialContent: React.ReactNode;
  tabs: Record<string, () => Promise<{ default: React.ComponentType<any> }>>;
  missionaryId: string;
}

export default function ClientTabSwitcher({
  initialTab,
  initialContent,
  tabs,
  missionaryId,
}: ClientTabSwitcherProps) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [activeTab, setActiveTab] = useState(initialTab);
  const [clientSideTab, setClientSideTab] = useState(initialTab);
  const [loading, setLoading] = useState(false);
  const [showSkeleton, setShowSkeleton] = useState(false);
  const [renderedTabs, setRenderedTabs] = useState<Record<string, React.ReactNode>>({
    [initialTab]: initialContent,
  });
  
  // Track which tabs have been preloaded to avoid redundant preloading
  const preloadedTabs = useRef<Set<string>>(new Set([initialTab]));
  const preloadingTriggered = useRef(false);
  
  // Intelligent preloading function - only preload tabs once per session
  const triggerPreloading = () => {
    if (preloadingTriggered.current) return;
    preloadingTriggered.current = true;
    
    // Get all tabs that haven't been preloaded yet
    const tabsToPreload = Object.keys(tabs).filter(tab => !preloadedTabs.current.has(tab));
    
    // Stagger preloading to avoid overwhelming the network
    tabsToPreload.forEach((tab, index) => {
      setTimeout(() => {
        console.log(`Preloading tab: ${tab}`);
        preloadTab(tab);
      }, index * 1000); // Stagger by 1 second per tab
    });
  };
  
  // Preload a specific tab
  const preloadTab = async (tab: string) => {
    if (preloadedTabs.current.has(tab)) return;
    
    try {
      const Component = (await tabs[tab]()).default;
      
      // Handle different component types
      let renderedComponent;
      if (tab === 'staff-reports') {
        renderedComponent = <Component churchIds={[]} />;
      } else if (tab === 'approvals') {
        renderedComponent = <Component campusDirectorId={missionaryId} />;
      } else {
        renderedComponent = <Component missionaryId={missionaryId} />;
      }
      
      setRenderedTabs(prev => ({
        ...prev,
        [tab]: renderedComponent,
      }));
      preloadedTabs.current.add(tab);
    } catch (error) {
      console.error(`Error preloading tab ${tab}:`, error);
    }
  };

  // Listen for tab change events from Sidebar
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tab, source } = event.detail;
      
      // Skip if this event was triggered by URL change to avoid double-handling
      if (source === "url") return;
      
      // Update client-side tab immediately for instant feedback
      setClientSideTab(tab);
      
      // Show skeleton immediately for visual feedback
      setShowSkeleton(true);
      setLoading(true);
      
      // If we haven't loaded this tab yet, load it
      if (!renderedTabs[tab]) {
        loadTab(tab);
      } else {
        // For cached tabs, just show a very brief loading state
        // This creates a smoother transition without a noticeable blink
        setTimeout(() => {
          setLoading(false);
          setShowSkeleton(false);
          // Dispatch contentloaded event
          window.dispatchEvent(new CustomEvent("contentloaded"));
        }, 50); // Reduced from 100ms to 50ms for faster response
      }
    };

    window.addEventListener("tabchange", handleTabChange as EventListener);
    return () => {
      window.removeEventListener("tabchange", handleTabChange as EventListener);
    };
  }, [renderedTabs]);

  // Update active tab from URL
  useEffect(() => {
    const tab = searchParams?.get("tab") || initialTab;
    if (tab !== activeTab) {
      // Update state
      setActiveTab(tab);
      setClientSideTab(tab);
      
      // If we haven't rendered this tab yet, show skeleton and load it
      if (!renderedTabs[tab]) {
        setShowSkeleton(true);
        setLoading(true);
        loadTab(tab);
      } else {
        // For already loaded tabs, just dispatch contentloaded event
        // Don't show loading state for URL-based navigation of cached tabs
        window.dispatchEvent(new CustomEvent("contentloaded"));
      }
    }
    
    // Trigger preloading after initial render
    if (!preloadingTriggered.current) {
      setTimeout(triggerPreloading, 3000); // Wait 3 seconds before starting preloading
    }
  }, [searchParams]);

  // Load a tab dynamically
  const loadTab = async (tab: string) => {
    try {
      const Component = (await tabs[tab]()).default;
      
      // Handle different component types
      let renderedComponent;
      if (tab === 'staff-reports') {
        renderedComponent = <Component churchIds={[]} />;
      } else if (tab === 'approvals') {
        renderedComponent = <Component campusDirectorId={missionaryId} />;
      } else {
        renderedComponent = <Component missionaryId={missionaryId} />;
      }
      
      setRenderedTabs(prev => ({
        ...prev,
        [tab]: renderedComponent,
      }));
      
      preloadedTabs.current.add(tab);
      setLoading(false);
      setShowSkeleton(false);
      
      // Dispatch contentloaded event
      window.dispatchEvent(new CustomEvent("contentloaded"));
    } catch (error) {
      console.error(`Error loading tab ${tab}:`, error);
      setLoading(false);
      setShowSkeleton(false);
      
      // Dispatch contentloaded event even on error
      window.dispatchEvent(new CustomEvent("contentloaded"));
    }
  };

  // Handle refresh button click
  const handleRefresh = () => {
    // Clear the cached content for the current tab
    setRenderedTabs(prev => {
      const newRenderedTabs = { ...prev };
      delete newRenderedTabs[activeTab];
      return newRenderedTabs;
    });
    
    // Show skeleton and loading state
    setShowSkeleton(true);
    setLoading(true);
    
    // Load the tab again
    loadTab(activeTab);
  };

  // Get the content to display
  const getContent = () => {
    // If we're showing a skeleton, return that
    if (showSkeleton) {
      return <DashboardTabSkeleton type={getTabType()} />;
    }
    
    // Otherwise return the rendered tab content
    return renderedTabs[clientSideTab] || renderedTabs[activeTab] || <DashboardTabSkeleton type={getTabType()} />;
  };

  // Get the appropriate tab type for the skeleton
  const getTabType = () => {
    // If we have a client-side tab change, use that
    const tabToUse = clientSideTab || activeTab;
    
    switch(tabToUse) {
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
    <AnimatePresence mode="wait">
      <motion.div
        key={clientSideTab}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        transition={{ duration: 0.15 }} // Reduced from 0.2s to 0.15s for faster transitions
        onAnimationComplete={() => {
          // Ensure contentloaded event is dispatched when animation completes
          if (loading) {
            setLoading(false);
            setShowSkeleton(false);
            window.dispatchEvent(new CustomEvent("contentloaded"));
          }
        }}
      >
        {getContent()}
      </motion.div>
    </AnimatePresence>
  );
} 