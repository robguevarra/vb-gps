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

import { useState, useEffect } from "react";
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

export function ClientDashboardLayout({
  initialContent,
  currentTab,
  missionaryId,
  availableTabs,
  userRole,
  churchName,
}: ClientDashboardLayoutProps) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState(currentTab);
  const [loading, setLoading] = useState(false);
  const [title, setTitle] = useState("");
  const [subtitle, setSubtitle] = useState("");
  
  // Update active tab from URL
  useEffect(() => {
    const tab = searchParams?.get("tab") || currentTab;
    setActiveTab(tab);
    updateTitleAndSubtitle(tab);
  }, [searchParams, currentTab]);
  
  // Listen for tab change events
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tab, source } = event.detail;
      
      // Skip if this event was triggered by this component
      if (source === "dashboard-layout") return;
      
      setActiveTab(tab);
      setLoading(true);
      updateTitleAndSubtitle(tab);
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
  
  // Update title and subtitle based on active tab
  const updateTitleAndSubtitle = (tab: string) => {
    switch(tab) {
      case "overview":
        setTitle("Dashboard Overview");
        setSubtitle("");
        break;
      case "history":
        setTitle("Request History");
        setSubtitle("");
        break;
      case "approvals":
        setTitle("Pending Approvals");
        setSubtitle("");
        break;
      case "manual-remittance":
        setTitle("Manual Remittance");
        setSubtitle("");
        break;
      case "reports":
        setTitle("Reports");
        setSubtitle("");
        break;
      case "staff-reports":
        setTitle("Staff Reports");
        setSubtitle("");
        break;
      default:
        setTitle("Dashboard");
        setSubtitle("");
    }
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
      {/* Sidebar */}
      <Sidebar 
        isCampusDirector={isCampusDirector}
        mobileMenuOpen={mobileMenuOpen}
        setMobileMenuOpen={setMobileMenuOpen}
      />
      
      {/* Main content */}
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
    </div>
  );
} 