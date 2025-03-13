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
 * - Client-side navigation for instant feedback
 * - Visual loading states for better UX
 * 
 * @component
 */

import { useState, useEffect } from "react";
import { usePathname, useSearchParams, useRouter } from "next/navigation";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { 
  ChevronRight, 
  LayoutDashboard, 
  Clock, 
  CheckCircle, 
  FileText, 
  BarChart, 
  Users,
  Loader2
} from "lucide-react";

interface SidebarProps {
  isCampusDirector?: boolean;
}

// Main Sidebar component
export function Sidebar({ 
  isCampusDirector = false
}: SidebarProps) {
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();
  
  // Get active tab from URL or default to overview
  const [activeTab, setActiveTab] = useState<string>(searchParams?.get("tab") || "overview");
  const [loadingTab, setLoadingTab] = useState<string | null>(null);
  const [sidebarOpen, setSidebarOpen] = useState(false);
  
  // Listen for sidebar toggle events from navbar
  useEffect(() => {
    const handleSidebarToggle = (event: Event) => {
      if ((event as CustomEvent).detail) {
        setSidebarOpen((event as CustomEvent).detail.open);
      }
    };
    
    window.addEventListener('sidebarToggle', handleSidebarToggle as EventListener);
    return () => {
      window.removeEventListener('sidebarToggle', handleSidebarToggle as EventListener);
    };
  }, []);
  
  // Update active tab when URL changes
  useEffect(() => {
    const tab = searchParams?.get("tab") || "overview";
    setActiveTab(tab);
    
    // Clear loading state if it matches the current tab
    if (loadingTab === tab) {
      setLoadingTab(null);
    }
  }, [searchParams, loadingTab]);

  // Handle navigation item click
  const handleNavigation = (tab: string) => {
    // Don't do anything if this tab is already active
    if (tab === activeTab && !loadingTab) {
      return;
    }
    
    // Set loading state immediately for instant feedback
    setLoadingTab(tab);
    
    // Update URL with the new tab
    const newParams = new URLSearchParams(window.location.search);
    newParams.set("tab", tab);
    
    // Use router.push for client-side navigation
    router.push(`${pathname}?${newParams.toString()}`, { scroll: false });
    
    // Close mobile sidebar by dispatching an event
    if (window.innerWidth < 1024) { // lg breakpoint
      const event = new CustomEvent('sidebarToggle', {
        detail: { open: false }
      });
      window.dispatchEvent(event);
    }
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

  // Render navigation items
  const renderNavItems = () => {
    return navigationItems
      .filter(item => item.alwaysVisible || (item.campusDirectorOnly && isCampusDirector))
      .map((item) => (
        <li key={item.tab}>
          <Button
            variant="ghost"
            className={cn(
              "w-full justify-start gap-3 px-3 py-2 text-left text-sm font-medium",
              activeTab === item.tab 
                ? "bg-gray-100 dark:bg-gray-800 text-[#00458d] dark:text-blue-400" 
                : "text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800/50"
            )}
            onClick={() => handleNavigation(item.tab)}
          >
            {loadingTab === item.tab ? (
              <Loader2 className="h-5 w-5 animate-spin text-blue-500" />
            ) : (
              item.icon
            )}
            <span>{item.name}</span>
            {activeTab === item.tab && (
              <ChevronRight className="ml-auto h-4 w-4" />
            )}
          </Button>
        </li>
      ));
  };

  return (
    <>
      {/* Desktop sidebar - always visible on large screens */}
      <div className="hidden lg:fixed lg:z-10 lg:flex lg:w-72 lg:flex-col top-16 bottom-0"> {/* Simplified positioning */}
        <div className="flex grow flex-col gap-y-5 overflow-y-auto border-r border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-900 px-6">
          <nav className="flex flex-1 flex-col pt-4">
            <ul className="flex flex-1 flex-col gap-y-1">
              {renderNavItems()}
            </ul>
          </nav>
        </div>
      </div>

      {/* Mobile sidebar - controlled by the navbar */}
      <div className={cn(
        "fixed z-30 w-72 bg-white dark:bg-gray-900 shadow-lg transform transition-transform duration-300 ease-in-out lg:hidden top-16 bottom-0 left-0", /* Simplified positioning */
        sidebarOpen ? "translate-x-0" : "-translate-x-full"
      )}>
        <nav className="flex flex-1 flex-col p-4">
          <ul className="flex flex-1 flex-col gap-y-1">
            {renderNavItems()}
          </ul>
        </nav>
      </div>
    </>
  );
}
