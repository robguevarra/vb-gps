"use client";

/**
 * ClientDashboardLayout Component
 * 
 * A persistent layout for the dashboard that includes a fixed sidebar and client-side tab switching.
 * 
 * Features:
 * - Persistent sidebar that remains during tab navigation
 * - Client-side tab switching for instant feedback
 * - URL state maintenance for deep linking
 * - Skeleton loaders during content loading
 * - Optimized animations for smooth transitions
 * 
 * @component
 */

import { useState, useEffect, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { Sidebar } from "@/components/Sidebar";
import { motion, AnimatePresence } from "framer-motion";

interface TabItem {
  id: string;
  label: string;
}

interface ClientDashboardLayoutProps {
  initialContent: React.ReactNode;
  currentTab: string;
  missionaryId: string;
  availableTabs: TabItem[];
  userRole: string;
  churchName: string;
}

/**
 * TabStateManager Component
 * 
 * This component handles the tab state management and URL synchronization.
 * It's separated to properly handle the useSearchParams hook which needs
 * to be wrapped in a Suspense boundary.
 */
function TabStateManager({
  currentTab,
  onTabChange,
  onTitleChange,
}: {
  currentTab: string;
  onTabChange: (tab: string) => void;
  onTitleChange: (title: string, subtitle: string) => void;
}) {
  const searchParams = useSearchParams();
  
  // Update active tab from URL
  useEffect(() => {
    const tab = searchParams?.get("tab") || currentTab;
    onTabChange(tab);
    updateTitleAndSubtitle(tab);
  }, [searchParams, currentTab, onTabChange]);
  
  // Update title and subtitle based on active tab
  const updateTitleAndSubtitle = (tab: string) => {
    let title = "Dashboard";
    let subtitle = "";
    
    switch(tab) {
      case "overview":
        title = "Dashboard Overview";
        break;
      case "history":
        title = "Request History";
        break;
      case "approvals":
        title = "Pending Approvals";
        break;
      case "manual-remittance":
        title = "Manual Remittance";
        break;
      case "reports":
        title = "Reports";
        break;
      case "staff-reports":
        title = "Staff Reports";
        break;
    }
    
    onTitleChange(title, subtitle);
  };
  
  return null; // This component doesn't render anything
}

/**
 * MainContent Component
 * 
 * This component handles the main content rendering and animations.
 * It's separated to improve component organization.
 */
function MainContent({
  activeTab,
  loading,
  setLoading,
  title,
  initialContent
}: {
  activeTab: string;
  loading: boolean;
  setLoading: (loading: boolean) => void;
  title: string;
  initialContent: React.ReactNode;
}) {
  return (
    <main className="flex-1 lg:ml-72">
      <div className="container px-4 py-6 max-w-7xl mx-auto">
        {/* Header with animated title */}
        <AnimatePresence mode="wait">
          <motion.div
            key={activeTab}
            initial={{ opacity: 0, y: -5 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -5 }}
            transition={{ duration: 0.15 }}
            className="mb-6"
          >
            <h1 className="text-2xl font-bold tracking-tight">
              {title}
              {loading && (
                <span className="ml-3 inline-block h-4 w-4 rounded-full border-2 border-t-transparent border-gray-400 animate-spin" />
              )}
            </h1>
          </motion.div>
        </AnimatePresence>
        
        {/* Tab content */}
        <AnimatePresence mode="wait">
          <motion.div
            key={activeTab}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.15 }}
            onAnimationComplete={() => {
              // Ensure contentloaded event is dispatched when animation completes
              if (loading) {
                setLoading(false);
                window.dispatchEvent(new CustomEvent("contentloaded"));
              }
            }}
          >
            {initialContent}
          </motion.div>
        </AnimatePresence>
      </div>
    </main>
  );
}

export function ClientDashboardLayout({
  initialContent,
  currentTab,
  missionaryId,
  availableTabs,
  userRole,
  churchName,
}: ClientDashboardLayoutProps) {
  const router = useRouter();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState(currentTab);
  const [loading, setLoading] = useState(false);
  const [title, setTitle] = useState("Dashboard");
  const [subtitle, setSubtitle] = useState("");
  
  // Listen for tab change events
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tab, source } = event.detail;
      
      // Skip if this event was triggered by this component
      if (source === "dashboard-layout") return;
      
      setActiveTab(tab);
      setLoading(true);
    };
    
    window.addEventListener("tabchange", handleTabChange as EventListener);
    return () => {
      window.removeEventListener("tabchange", handleTabChange as EventListener);
    };
  }, []);
  
  // Listen for content loaded events
  useEffect(() => {
    const handleContentLoaded = () => {
      setLoading(false);
    };
    
    window.addEventListener("contentloaded", handleContentLoaded);
    return () => {
      window.removeEventListener("contentloaded", handleContentLoaded);
    };
  }, []);
  
  // Handle tab change from URL
  const handleTabChange = (tab: string) => {
    setActiveTab(tab);
  };
  
  // Handle title change
  const handleTitleChange = (newTitle: string, newSubtitle: string) => {
    setTitle(newTitle);
    setSubtitle(newSubtitle);
  };
  
  // Determine if user should have access to campus director tabs
  const isCampusDirector = userRole === "campus_director" || userRole === "superadmin";

  // Dispatch contentloaded event when component mounts
  useEffect(() => {
    // Small delay to ensure the event is dispatched after the component is fully rendered
    const timer = setTimeout(() => {
      window.dispatchEvent(new CustomEvent("contentloaded"));
    }, 100);
    
    return () => clearTimeout(timer);
  }, []);

  return (
    <div className="flex min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* TabStateManager with Suspense boundary */}
      <Suspense fallback={null}>
        <TabStateManager
          currentTab={currentTab}
          onTabChange={handleTabChange}
          onTitleChange={handleTitleChange}
        />
      </Suspense>
      
      {/* Sidebar */}
      <Sidebar 
        isCampusDirector={isCampusDirector}
        mobileMenuOpen={mobileMenuOpen}
        setMobileMenuOpen={setMobileMenuOpen}
      />
      
      {/* Main content */}
      <MainContent
        activeTab={activeTab}
        loading={loading}
        setLoading={setLoading}
        title={title}
        initialContent={initialContent}
      />
    </div>
  );
} 