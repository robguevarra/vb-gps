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
 * - Optimized animations for smooth transitions
 * 
 * @component
 */

import { useState, useEffect } from "react";
import { useSearchParams } from "next/navigation";
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
  const searchParams = useSearchParams();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState(currentTab);
  const [loading, setLoading] = useState(false);
  const [title, setTitle] = useState(getTabTitle(currentTab));
  
  // Update active tab and title when URL changes
  useEffect(() => {
    const tab = searchParams?.get("tab") || currentTab;
    setActiveTab(tab);
    setTitle(getTabTitle(tab));
  }, [searchParams, currentTab]);
  
  // Get title based on active tab
  function getTabTitle(tab: string): string {
    switch(tab) {
      case "overview":
        return "Dashboard Overview";
      case "history":
        return "Request History";
      case "approvals":
        return "Pending Approvals";
      case "manual-remittance":
        return "Manual Remittance";
      case "reports":
        return "Reports";
      case "staff-reports":
        return "Staff Reports";
      default:
        return "Dashboard";
    }
  }
  
  // Determine if user should have access to campus director tabs
  const isCampusDirector = userRole === "campus_director" || userRole === "superadmin";

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
          {initialContent}
        </div>
      </main>
    </div>
  );
} 