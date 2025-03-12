// components/Sidebar.tsx
"use client";

/**
 * Sidebar Component
 * 
 * A responsive sidebar navigation component for the dashboard.
 * 
 * Features:
 * - Responsive design with mobile and desktop variants
 * - Role-based navigation items
 * - Client-side navigation for instant page transitions
 * - Visual feedback for active and loading states
 * - Coordination with tab switching system
 * 
 * @component
 */

import { useState, useEffect, Suspense, useRef } from "react";
import { usePathname, useSearchParams, useRouter } from "next/navigation";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Sheet, SheetContent } from "@/components/ui/sheet";
import { 
  ChevronRight, 
  LayoutDashboard, 
  Clock, 
  CheckCircle, 
  FileText, 
  BarChart, 
  Users,
  Loader2,
  X
} from "lucide-react";
import { motion } from "framer-motion";

interface SidebarProps {
  isCampusDirector?: boolean;
  mobileMenuOpen?: boolean;
  setMobileMenuOpen?: (open: boolean) => void;
}

// Main Sidebar component that wraps the content with Suspense
export function Sidebar({ 
  isCampusDirector = false,
  mobileMenuOpen = false,
  setMobileMenuOpen
}: SidebarProps) {
  return (
    <Suspense fallback={<div className="w-64 bg-gray-100 dark:bg-gray-900 h-screen" />}>
      <SidebarContent 
        isCampusDirector={isCampusDirector}
        mobileMenuOpen={mobileMenuOpen}
        setMobileMenuOpen={setMobileMenuOpen}
      />
    </Suspense>
  );
}

// The actual sidebar content
function SidebarContent({ 
  isCampusDirector = false,
  mobileMenuOpen = false,
  setMobileMenuOpen
}: SidebarProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const router = useRouter();
  const [activeTab, setActiveTab] = useState<string>("overview");
  const [loadingTab, setLoadingTab] = useState<string | null>(null);
  const navigationInProgressRef = useRef(false);
  const eventDispatchedRef = useRef(false);
  
  // Update active tab from URL on initial load and when URL changes
  useEffect(() => {
    const tab = searchParams?.get("tab") || "overview";
    setActiveTab(tab);
    // Clear loading state when URL changes to prevent stale loading states
    setLoadingTab(null);
    navigationInProgressRef.current = false;
    eventDispatchedRef.current = false;
  }, [searchParams]);
  
  // Listen for content loaded events to clear loading state
  useEffect(() => {
    const handleContentLoaded = () => {
      setLoadingTab(null);
      navigationInProgressRef.current = false;
      eventDispatchedRef.current = false;
    };
    
    window.addEventListener("contentloaded", handleContentLoaded);
    return () => {
      window.removeEventListener("contentloaded", handleContentLoaded);
    };
  }, []);

  // Handle navigation item click
  const handleNavigation = (tab: string) => {
    // Don't do anything if this tab is already active or navigation is in progress
    if ((tab === activeTab && !loadingTab) || navigationInProgressRef.current) return;
    
    // Set navigation in progress to prevent multiple clicks
    navigationInProgressRef.current = true;
    
    // Set loading state immediately for instant feedback
    setLoadingTab(tab);
    
    // Only dispatch the event if we haven't already for this navigation
    if (!eventDispatchedRef.current) {
      eventDispatchedRef.current = true;
      
      // Dispatch tab change event for other components to react
      const tabChangeEvent = new CustomEvent("tabchange", {
        detail: { tab, source: "sidebar" }
      });
      window.dispatchEvent(tabChangeEvent);
    }
    
    // Update URL with the new tab - use a very small timeout to ensure the UI updates first
    setTimeout(() => {
      const newParams = new URLSearchParams(searchParams?.toString() || "");
      newParams.set("tab", tab);
      
      // Use router.push for client-side navigation
      router.push(`${pathname}?${newParams.toString()}`, { scroll: false });
      
      // Close mobile menu if applicable
      if (setMobileMenuOpen) {
        setMobileMenuOpen(false);
      }
    }, 10);
  };

  // Define navigation items with icons and descriptions
  const navigationItems = [
    {
      name: "Overview",
      tab: "overview",
      icon: <LayoutDashboard className="h-5 w-5" />,
      alwaysVisible: true
    },
    {
      name: "Request History",
      tab: "history",
      icon: <Clock className="h-5 w-5" />,
      alwaysVisible: true
    },
    {
      name: "Manual Remittance",
      tab: "manual-remittance",
      icon: <FileText className="h-5 w-5" />,
      alwaysVisible: true
    },
    {
      name: "Reports",
      tab: "reports",
      icon: <BarChart className="h-5 w-5" />,
      alwaysVisible: true
    },
    {
      name: "Pending Approvals",
      tab: "approvals",
      icon: <CheckCircle className="h-5 w-5" />,
      alwaysVisible: false,
      campusDirectorOnly: true
    },
    {
      name: "Staff Reports",
      tab: "staff-reports",
      icon: <Users className="h-5 w-5" />,
      alwaysVisible: false,
      campusDirectorOnly: true
    }
  ];

  // Animation variants for list items
  const listItemVariants = {
    hidden: { 
      opacity: 0, 
      x: -5 // Reduced from -10 to -5 for subtler animation
    },
    visible: (i: number) => ({
      opacity: 1,
      x: 0,
      transition: {
        delay: i * 0.03, // Reduced from 0.05 to 0.03 for faster animations
        duration: 0.15 // Reduced from 0.2 to 0.15 for faster animations
      }
    })
  };

  // Render navigation items
  const renderNavItems = () => {
    return navigationItems
      .filter(item => item.alwaysVisible || (item.campusDirectorOnly && isCampusDirector))
      .map((item, index) => (
        <motion.li 
          key={item.tab}
          custom={index}
          initial="hidden"
          animate="visible"
          variants={listItemVariants}
          // Prevent re-animation on tab change
          layoutId={`nav-item-${item.tab}`}
        >
          <Button
            variant="ghost"
            className={cn(
              "w-full justify-start gap-3 px-3 py-2 text-left text-sm font-medium",
              activeTab === item.tab 
                ? "bg-gray-100 dark:bg-gray-800 text-[#00458d] dark:text-blue-400" 
                : "text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800/50"
            )}
            onClick={() => handleNavigation(item.tab)}
            disabled={navigationInProgressRef.current}
          >
            {loadingTab === item.tab ? (
              <Loader2 className="h-5 w-5 animate-spin text-blue-500" />
            ) : (
              item.icon
            )}
            <span>{item.name}</span>
            {activeTab === item.tab && !loadingTab && (
              <ChevronRight className="ml-auto h-4 w-4" />
            )}
          </Button>
        </motion.li>
      ));
  };

  // Desktop sidebar
  const DesktopSidebar = () => (
    <div className="hidden lg:flex h-screen fixed left-0 top-16 z-30 w-72 flex-col border-r bg-white dark:bg-gray-900 dark:border-gray-800">
      <ScrollArea className="flex-1 py-4">
        <nav className="grid gap-1 px-2">
          <ul className="space-y-2">
            {renderNavItems()}
          </ul>
        </nav>
      </ScrollArea>
    </div>
  );

  // Mobile sidebar
  const MobileSidebar = () => (
    <Sheet open={mobileMenuOpen} onOpenChange={setMobileMenuOpen}>
      <SheetContent side="left" className="w-72 pt-16 z-20">
        <div className="flex justify-between items-center mb-4 pr-4">
          <h2 className="text-lg font-semibold">Dashboard Navigation</h2>
          <Button 
            variant="ghost" 
            size="icon" 
            onClick={() => setMobileMenuOpen?.(false)}
            className="h-8 w-8"
          >
            <X className="h-4 w-4" />
            <span className="sr-only">Close</span>
          </Button>
        </div>
        <ScrollArea className="h-[calc(100vh-8rem)]">
          <nav className="grid gap-1 px-2">
            <ul className="space-y-2">
              {renderNavItems()}
            </ul>
          </nav>
        </ScrollArea>
      </SheetContent>
    </Sheet>
  );

  return (
    <>
      <DesktopSidebar />
      <MobileSidebar />
    </>
  );
}
