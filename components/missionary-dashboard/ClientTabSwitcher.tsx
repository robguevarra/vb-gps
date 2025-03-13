"use client";

/**
 * ClientTabSwitcher Component
 * 
 * A client-side tab switching component that provides instant feedback and caches rendered content.
 * 
 * Features:
 * - Caches rendered tab content for instant switching
 * - Manages loading states for smooth transitions
 * - Simple URL-based tab switching
 * - Background preloading of tabs for better performance
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
  const [loading, setLoading] = useState(false);
  const [showSkeleton, setShowSkeleton] = useState(false);
  const [renderedTabs, setRenderedTabs] = useState<Record<string, React.ReactNode>>({
    [initialTab]: initialContent,
  });
  
  // Track which tabs have been preloaded
  const preloadedTabs = useRef<Set<string>>(new Set([initialTab]));
  const preloadingTriggered = useRef(false);
  
  // Update active tab from URL
  useEffect(() => {
    const tab = searchParams?.get("tab") || initialTab;
    
    // If tab changed
    if (tab !== activeTab) {
      setActiveTab(tab);
      
      // If we haven't rendered this tab yet, show skeleton and load it
      if (!renderedTabs[tab]) {
        setShowSkeleton(true);
        setLoading(true);
        loadTab(tab);
      } else {
        // For already loaded tabs, just show them immediately
        setLoading(false);
        setShowSkeleton(false);
      }
    }
    
    // Trigger background preloading after initial render
    if (!preloadingTriggered.current) {
      setTimeout(() => {
        preloadingTriggered.current = true;
        triggerPreloading();
      }, 3000); // Wait 3 seconds before starting preloading
    }
  }, [searchParams, initialTab, activeTab, renderedTabs]);
  
  // Preload all tabs in the background
  const triggerPreloading = () => {
    // Get all tabs that haven't been preloaded yet
    const tabsToPreload = Object.keys(tabs).filter(tab => !preloadedTabs.current.has(tab));
    
    // Stagger preloading to avoid overwhelming the network
    tabsToPreload.forEach((tab, index) => {
      setTimeout(() => {
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
    } catch (error) {
      console.error(`Error loading tab ${tab}:`, error);
      setLoading(false);
      setShowSkeleton(false);
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
    if (showSkeleton) {
      return <DashboardTabSkeleton type={activeTab as "overview" | "history" | "approvals" | "manual-remittance" | "reports" | "staff-reports"} />;
    }
    return renderedTabs[activeTab];
  };

  return (
    <div className="relative">
      {/* Refresh button */}
      <button
        onClick={handleRefresh}
        className="absolute right-0 top-0 z-10 p-2 text-gray-500 hover:text-gray-700"
        aria-label="Refresh"
      >
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <path d="M21 2v6h-6"></path>
          <path d="M3 12a9 9 0 0 1 15-6.7L21 8"></path>
          <path d="M3 22v-6h6"></path>
          <path d="M21 12a9 9 0 0 1-15 6.7L3 16"></path>
        </svg>
      </button>
      
      {/* Tab content with animation */}
      <AnimatePresence mode="wait">
        <motion.div
          key={activeTab}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.15 }}
        >
          {getContent()}
        </motion.div>
      </AnimatePresence>
    </div>
  );
} 