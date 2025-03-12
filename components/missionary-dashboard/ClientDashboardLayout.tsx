"use client";

/**
 * ClientDashboardLayout Component
 * 
 * This client component provides a persistent layout for the dashboard,
 * including a fixed sidebar that remains in place during tab navigation.
 * It handles all tab switching on the client side for instant feedback.
 * 
 * Features:
 * - Persistent sidebar that doesn't reload between tab changes
 * - Client-side tab switching with instant visual feedback
 * - Maintains URL state for deep linking and sharing
 * - Prefetches tab content for faster navigation
 * - Provides skeleton loaders during content loading
 * - Optimized animations for smooth transitions
 * 
 * @component
 */

import { ReactNode, useState, useEffect } from "react";
import { usePathname, useSearchParams, useRouter } from "next/navigation";
import { Sidebar } from "@/components/Sidebar";
import { DashboardTabSkeleton } from "./DashboardTabSkeleton";
import { motion, AnimatePresence } from "framer-motion";
import { ClientTabSwitcher } from "./ClientTabSwitcher";
import { PageTransition } from "@/components/PageTransition";
import { DashboardTabWrapper } from "@/components/DashboardTabWrapper";

interface ClientDashboardLayoutProps {
  /** The initial tab content from the server */
  initialContent: ReactNode;
  /** The current tab from URL */
  currentTab: string;
  /** The missionary ID */
  missionaryId: string;
  /** Available tabs for navigation */
  availableTabs: { id: string; label: string }[];
  /** Whether the user has campus director access */
  isCampusDirector: boolean;
  /** The user's full name */
  fullName: string;
  /** The user's role */
  role: string;
  /** The user's church name */
  churchName: string;
  /** The title for the current tab */
  title: string;
  /** The subtitle for the current tab */
  subtitle: string;
}

export function ClientDashboardLayout({
  initialContent,
  currentTab,
  missionaryId,
  availableTabs,
  isCampusDirector,
  fullName,
  role,
  churchName,
  title: initialTitle,
  subtitle: initialSubtitle
}: ClientDashboardLayoutProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState(currentTab);
  const [isLoading, setIsLoading] = useState(false);
  const [title, setTitle] = useState(initialTitle);
  const [subtitle, setSubtitle] = useState(initialSubtitle);
  
  // Update title and subtitle when tab changes
  useEffect(() => {
    // Get tab info based on active tab
    const getTabInfo = () => {
      switch(activeTab) {
        case "overview":
          return {
            title: "Dashboard Overview",
            subtitle: "View your key metrics and performance indicators"
          };
        case "history":
          return {
            title: "Request History",
            subtitle: "Track and manage your past requests"
          };
        case "approvals":
          return {
            title: "Pending Approvals",
            subtitle: "Review and manage approval requests"
          };
        case "manual-remittance":
          return {
            title: "Manual Remittance",
            subtitle: "Record donations received outside the system"
          };
        case "reports":
          return {
            title: "My Reports",
            subtitle: "View detailed reports and analytics"
          };
        case "staff-reports":
          return {
            title: "Staff Performance",
            subtitle: "Monitor your team's performance metrics"
          };
        default:
          return {
            title: "Dashboard",
            subtitle: "Welcome to your missionary dashboard"
          };
      }
    };
    
    const { title: newTitle, subtitle: newSubtitle } = getTabInfo();
    setTitle(newTitle);
    setSubtitle(newSubtitle);
  }, [activeTab]);
  
  // Listen for URL changes to update active tab
  useEffect(() => {
    const tabFromUrl = searchParams?.get("tab") || "overview";
    if (tabFromUrl !== activeTab) {
      setActiveTab(tabFromUrl);
    }
  }, [searchParams, activeTab]);
  
  // Listen for tab change events
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tab } = event.detail;
      setActiveTab(tab);
      setIsLoading(true);
    };
    
    window.addEventListener('tabchange', handleTabChange as EventListener);
    
    return () => {
      window.removeEventListener('tabchange', handleTabChange as EventListener);
    };
  }, []);
  
  return (
    <div className="flex min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* Persistent Sidebar */}
      <Sidebar 
        isCampusDirector={isCampusDirector}
        mobileMenuOpen={mobileMenuOpen}
        setMobileMenuOpen={setMobileMenuOpen}
      />
      
      {/* Main Content Area */}
      <div className="flex-1 lg:ml-64">
        <div className="px-4 sm:px-6 lg:px-8 py-8">
          {/* Animated Header */}
          <motion.div
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.3 }}
            className="mb-8"
          >
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
              {title}
            </h1>
            <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
              {subtitle}
            </p>
            <div className="flex items-center mt-4">
              <div className="text-sm text-gray-500 dark:text-gray-400">
                {fullName} • {role} • {churchName}
              </div>
            </div>
          </motion.div>
          
          {/* Tab Content */}
          <PageTransition mode="fade">
            <DashboardTabWrapper>
              <ClientTabSwitcher
                initialContent={initialContent}
                currentTab={activeTab}
                missionaryId={missionaryId}
                availableTabs={availableTabs.map(tab => tab.id)}
              />
            </DashboardTabWrapper>
          </PageTransition>
        </div>
      </div>
    </div>
  );
} 