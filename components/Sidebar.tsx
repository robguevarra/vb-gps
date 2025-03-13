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

// Main Sidebar component
export function Sidebar({ 
  isCampusDirector = false,
  mobileMenuOpen = false,
  setMobileMenuOpen
}: SidebarProps) {
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();
  
  // Get active tab from URL or default to overview
  const [activeTab, setActiveTab] = useState<string>(searchParams?.get("tab") || "overview");
  const [loadingTab, setLoadingTab] = useState<string | null>(null);
  
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
    
    // Close mobile menu if applicable
    if (setMobileMenuOpen) {
      setMobileMenuOpen(false);
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

  // Animation variants for list items
  const listItemVariants = {
    hidden: { opacity: 0, x: -5 },
    visible: (i: number) => ({
      opacity: 1,
      x: 0,
      transition: {
        delay: i * 0.03,
        duration: 0.15
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
        </motion.li>
      ));
  };

  // Desktop sidebar
  const DesktopSidebar = () => (
    <div className="hidden lg:fixed lg:inset-y-0 lg:z-10 lg:flex lg:w-72 lg:flex-col">
      <div className="flex grow flex-col gap-y-5 overflow-y-auto border-r border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-900 px-6">
        <div className="flex h-16 shrink-0 items-center">
          <h2 className="text-lg font-semibold">Staff Portal</h2>
        </div>
        <nav className="flex flex-1 flex-col">
          <ScrollArea className="h-[calc(100vh-4rem)]">
            <ul className="flex flex-1 flex-col gap-y-1">
              {renderNavItems()}
            </ul>
          </ScrollArea>
        </nav>
      </div>
    </div>
  );

  // Mobile sidebar
  const MobileSidebar = () => (
    <Sheet open={mobileMenuOpen} onOpenChange={setMobileMenuOpen}>
      <SheetContent side="left" className="w-72 sm:max-w-sm">
        <div className="flex h-16 shrink-0 items-center">
          <h2 className="text-lg font-semibold">Staff Portal</h2>
          <Button 
            variant="ghost" 
            size="icon" 
            className="ml-auto" 
            onClick={() => setMobileMenuOpen?.(false)}
          >
            <X className="h-5 w-5" />
          </Button>
        </div>
        <nav className="flex flex-1 flex-col mt-4">
          <ul className="flex flex-1 flex-col gap-y-1">
            {renderNavItems()}
          </ul>
        </nav>
      </SheetContent>
    </Sheet>
  );

  return (
    <>
      <DesktopSidebar />
      {setMobileMenuOpen && <MobileSidebar />}
    </>
  );
}
