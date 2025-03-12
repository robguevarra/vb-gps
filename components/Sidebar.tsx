// components/Sidebar.tsx
"use client";

/**
 * Sidebar Component
 * 
 * This component provides the main navigation for the application.
 * It has been updated to include tab navigation links that were previously
 * duplicated in the TabSwitcher component, consolidating all navigation
 * into a single, consistent interface.
 * 
 * Features:
 * - Responsive design with mobile drawer and desktop sidebar
 * - Role-based navigation items
 * - Visual indicators for active routes
 * - Smooth animations for transitions
 * - Client-side navigation for instant page transitions
 * - Preserves URL parameters for consistent navigation
 * - Provides instant visual feedback on tab changes
 * - Dispatches events to coordinate with other components
 * 
 * @component
 */

import Link from "next/link";
import { usePathname, useSearchParams, useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { 
  Sheet, 
  SheetContent, 
  SheetHeader,
  SheetTitle,
  SheetDescription,
  SheetTrigger,
  SheetClose
} from "@/components/ui/sheet";
import { 
  Menu, 
  Home, 
  History, 
  CreditCard, 
  CheckSquare, 
  BarChart2, 
  Users,
  ChevronRight,
  ArrowLeft,
  PieChart,
  FileText,
  Loader2
} from "lucide-react";
import { createClient } from "@/utils/supabase/client";
import { useState, useEffect, Suspense } from "react";
import { cn } from "@/lib/utils";
import { ScrollArea } from "@/components/ui/scroll-area";
import { motion, AnimatePresence } from "framer-motion";

interface SidebarProps {
  isCampusDirector?: boolean;
  mobileMenuOpen?: boolean;
  setMobileMenuOpen?: (open: boolean) => void;
}

function SidebarContent({ isCampusDirector = false, mobileMenuOpen, setMobileMenuOpen }: SidebarProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const router = useRouter();
  const currentTab = searchParams?.get("tab") || "overview";
  const userId = searchParams?.get("userId");
  const supabase = createClient();
  const [userRole, setUserRole] = useState("");
  const [isSuperAdmin, setIsSuperAdmin] = useState(false);
  const [activeTab, setActiveTab] = useState(currentTab);
  const [loadingTab, setLoadingTab] = useState<string | null>(null);
  
  // Use the prop if provided, otherwise manage state internally
  const [isOpenInternal, setIsOpenInternal] = useState(false);
  const isOpen = mobileMenuOpen !== undefined ? mobileMenuOpen : isOpenInternal;
  const setIsOpen = setMobileMenuOpen || setIsOpenInternal;

  // Update active tab when URL changes
  useEffect(() => {
    setActiveTab(currentTab);
    setLoadingTab(null);
  }, [currentTab]);

  useEffect(() => {
    const fetchUser = async () => {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (user) {
        const { data: profile } = await supabase
          .from("profiles")
          .select("role")
          .eq("id", user.id)
          .single();
        
        const role = profile?.role || "";
        setUserRole(role);
        setIsSuperAdmin(role === "superadmin" || user.email === "robneil@gmail.com");
      }
    };
    fetchUser();
  }, [supabase]);

  // Use either the prop value or the state value for determining campus director status
  const showCampusDirectorTabs = isCampusDirector || userRole === "campus_director" || isSuperAdmin;

  // Enhanced navigation items with icons and descriptions
  const navItems = [
    { 
      name: "Overview", 
      href: "?tab=overview", 
      icon: <Home className="h-5 w-5" />,
      description: "Dashboard summary and key metrics"
    },
    { 
      name: "Request History", 
      href: "?tab=history", 
      icon: <History className="h-5 w-5" />,
      description: "View your past requests"
    },
    { 
      name: "Manual Remittance", 
      href: "?tab=manual-remittance", 
      icon: <CreditCard className="h-5 w-5" />,
      description: "Record manual donations"
    },
    { 
      name: "My Reports", 
      href: "?tab=reports", 
      icon: <BarChart2 className="h-5 w-5" />,
      description: "View your performance reports"
    },
    ...(showCampusDirectorTabs ? [
      { 
        name: "Approvals", 
        href: "?tab=approvals", 
        icon: <CheckSquare className="h-5 w-5" />,
        description: "Manage pending approvals"
      },
      { 
        name: "Staff Reports", 
        href: "?tab=staff-reports", 
        icon: <PieChart className="h-5 w-5" />,
        description: "View staff performance metrics"
      }
    ] : []),
  ];

  // Function to handle client-side navigation with tab switching
  const handleNavigation = (e: React.MouseEvent<HTMLAnchorElement>, href: string) => {
    e.preventDefault();
    
    // Extract the tab parameter from the href
    const tabMatch = href.match(/\?tab=([^&]*)/);
    const newTab = tabMatch ? tabMatch[1] : "overview";
    
    // Set loading state immediately for instant feedback
    setActiveTab(newTab);
    setLoadingTab(newTab);
    
    // Dispatch a custom event that other components can listen for
    const tabChangeEvent = new CustomEvent('tabchange', { 
      detail: { tab: newTab, userId } 
    });
    window.dispatchEvent(tabChangeEvent);
    
    // Construct the new URL with the tab and userId parameters
    const newUrl = `${pathname}?tab=${newTab}${userId ? `&userId=${userId}` : ''}`;
    
    // Use router.push for client-side navigation
    router.push(newUrl);
    
    // Close the mobile menu if it's open
    if (isOpen) {
      setIsOpen(false);
    }
    
    // Reset loading state after a delay
    setTimeout(() => {
      setLoadingTab(null);
    }, 500);
  };

  // Function to get updated search params for navigation
  const getUpdatedParams = (itemHref: string) => {
    // Extract the tab parameter from the href
    const tabMatch = itemHref.match(/\?tab=([^&]*)/);
    const newTab = tabMatch ? tabMatch[1] : "overview";
    
    // Create a new URLSearchParams object
    const newParams = new URLSearchParams(searchParams?.toString() || "");
    
    // Update the tab parameter
    newParams.set("tab", newTab);
    
    return newParams.toString();
  };

  // Animation variants for list items
  const itemVariants = {
    hidden: (i: number) => ({
      opacity: 0,
      y: 10,
      transition: {
        delay: i * 0.05,
      },
    }),
    visible: (i: number) => ({
      opacity: 1,
      y: 0,
      transition: {
        delay: i * 0.05,
      },
    }),
  };

  // Render navigation items for both mobile and desktop
  const renderNavItems = (isMobile = false) => (
    <AnimatePresence>
      {navItems.map((item, index) => {
        const isActive = activeTab === item.href.split("=")[1];
        const isLoading = loadingTab === item.href.split("=")[1];
        const newParams = getUpdatedParams(item.href);

        return (
          <motion.div
            key={item.name}
            custom={index}
            initial="hidden"
            animate="visible"
            variants={itemVariants}
          >
            <Link
              href={`${pathname}?${newParams}`}
              onClick={(e) => handleNavigation(e, item.href)}
              className={cn(
                "flex items-center justify-between px-4 py-3 rounded-lg",
                "transition-all duration-200",
                isMobile ? "min-h-[60px]" : "", // Increased touch target for mobile
                isActive
                  ? "bg-primary/10 text-primary font-medium" 
                  : "text-muted-foreground hover:bg-accent hover:text-foreground"
              )}
            >
              <div className="flex items-center gap-3">
                {item.icon}
                <div>
                  <div className="font-medium flex items-center gap-2">
                    {item.name}
                    {isLoading && (
                      <Loader2 className="h-3 w-3 animate-spin inline-block" />
                    )}
                  </div>
                  {isMobile && (
                    <p className="text-xs text-muted-foreground line-clamp-1">
                      {item.description}
                    </p>
                  )}
                </div>
              </div>
              {isActive && <ChevronRight className="h-4 w-4 text-primary" />}
            </Link>
          </motion.div>
        );
      })}
    </AnimatePresence>
  );

  return (
    <>
      {/* Mobile: collapsible sidebar via a Sheet */}
      <Sheet open={isOpen} onOpenChange={setIsOpen}>
        <SheetTrigger asChild className="lg:hidden fixed top-4 left-4 z-50">
          <Button variant="outline" size="icon" className="rounded-full">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Open sidebar</span>
          </Button>
        </SheetTrigger>
        <SheetContent 
          side="left" 
          className="w-[90vw] max-w-[320px] p-0 border-r shadow-lg"
          // Enhanced animations
          style={{
            transition: "transform 0.3s ease-in-out, opacity 0.3s ease-in-out"
          }}
        >
          <div className="flex items-center justify-between p-4 border-b">
            <SheetHeader className="text-left">
              <SheetTitle className="text-lg">Missionary Dashboard</SheetTitle>
              <SheetDescription className="text-sm">
                Access your missionary tools and reports
              </SheetDescription>
            </SheetHeader>
            <Button
              variant="ghost"
              size="icon" 
              onClick={() => setIsOpen(false)}
              className="h-8 w-8 rounded-full"
            >
              <ArrowLeft className="h-4 w-4" />
              <span className="sr-only">Close sidebar</span>
            </Button>
          </div>
          <ScrollArea className="h-[calc(100vh-5rem)]">
            <nav className="flex flex-col p-3 space-y-1">
              {renderNavItems(true)}
            </nav>
          </ScrollArea>
        </SheetContent>
      </Sheet>

      {/* Desktop: pinned/fixed sidebar */}
      <div
        className="
          hidden
          lg:flex
          lg:flex-col
          lg:fixed
          lg:top-16
          lg:left-0
          lg:w-64
          lg:h-[calc(100vh-4rem)]
          lg:overflow-y-auto
          lg:bg-white
          lg:dark:bg-gray-900
          border-r
          border-gray-200
          dark:border-gray-700
          z-30
        "
      >
        <div className="p-4 border-b">
          <h3 className="text-lg font-semibold">Missionary Dashboard</h3>
        </div>
        <ScrollArea className="h-[calc(100vh-8rem)]">
          <nav className="flex flex-col p-3 space-y-1">
            {renderNavItems(false)}
          </nav>
        </ScrollArea>
      </div>
    </>
  );
}

export function Sidebar(props: SidebarProps) {
  return (
    <Suspense fallback={null}>
      <SidebarContent {...props} />
    </Suspense>
  );
}
