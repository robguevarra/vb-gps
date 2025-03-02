// components/Sidebar.tsx
"use client";

import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
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
  ArrowLeft
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
  const currentTab = searchParams?.get("tab") || "overview";
  const supabase = createClient();
  const [userRole, setUserRole] = useState("");
  const [isSuperAdmin, setIsSuperAdmin] = useState(false);
  
  // Use the prop if provided, otherwise manage state internally
  const [isOpenInternal, setIsOpenInternal] = useState(false);
  const isOpen = mobileMenuOpen !== undefined ? mobileMenuOpen : isOpenInternal;
  const setIsOpen = setMobileMenuOpen || setIsOpenInternal;

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
    ...(showCampusDirectorTabs ? [{ 
      name: "Approvals", 
      href: "?tab=approvals", 
      icon: <CheckSquare className="h-5 w-5" />,
      description: "Manage pending approvals"
    }] : []),
    { 
      name: "My Reports", 
      href: "?tab=reports", 
      icon: <BarChart2 className="h-5 w-5" />,
      description: "View your performance reports"
    },
    ...(showCampusDirectorTabs ? [{ 
      name: "Staff Reports", 
      href: "?tab=staff-reports", 
      icon: <Users className="h-5 w-5" />,
      description: "Monitor staff performance"
    }] : []),
  ];

  // Helper function to handle params
  const getUpdatedParams = (itemHref: string) => {
    const params = new URLSearchParams(searchParams ? searchParams.toString() : "");
    const newParams = new URLSearchParams(itemHref.split("?")[1] || "");
    
    params.forEach((value, key) => {
      if (key !== "tab" && !newParams.has(key)) {
        newParams.set(key, value);
      }
    });
    
    return newParams.toString();
  };

  // Animation variants for mobile menu items
  const itemVariants = {
    hidden: { opacity: 0, x: -20 },
    visible: (i: number) => ({
      opacity: 1,
      x: 0,
      transition: {
        delay: i * 0.05,
        duration: 0.3,
        ease: "easeOut"
      }
    })
  };

  return (
    <>
      {/* Mobile: collapsible sidebar via a Sheet */}
      <Sheet open={isOpen} onOpenChange={setIsOpen}>
        <SheetContent 
          side="left" 
          className="w-[85vw] sm:w-80 p-0 border-r shadow-lg"
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
              <AnimatePresence>
                {navItems.map((item, index) => {
                  const newParams = getUpdatedParams(item.href);
                  const isActive = currentTab === item.href.split("=")[1];
                  
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
                        onClick={() => setIsOpen(false)}
                        className={cn(
                          "flex items-center justify-between px-4 py-3 rounded-lg",
                          "transition-all duration-200",
                          isActive 
                            ? "bg-primary/10 text-primary font-medium" 
                            : "text-muted-foreground hover:bg-accent hover:text-foreground"
                        )}
                      >
                        <div className="flex items-center gap-3">
                          {item.icon}
                          <div>
                            <div className="font-medium">{item.name}</div>
                            <p className="text-xs text-muted-foreground line-clamp-1">
                              {item.description}
                            </p>
                          </div>
                        </div>
                        {isActive && <ChevronRight className="h-4 w-4 text-primary" />}
                      </Link>
                    </motion.div>
                  );
                })}
              </AnimatePresence>
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
            {navItems.map((item) => {
              const newParams = getUpdatedParams(item.href);
              const isActive = currentTab === item.href.split("=")[1];
              
              return (
                <Link
                  key={item.name}
                  href={`${pathname}?${newParams}`}
                  className={cn(
                    "flex items-center justify-between px-4 py-3 rounded-lg",
                    "transition-all duration-200",
                    isActive 
                      ? "bg-primary/10 text-primary font-medium" 
                      : "text-muted-foreground hover:bg-accent hover:text-foreground"
                  )}
                >
                  <div className="flex items-center gap-3">
                    {item.icon}
                    <span>{item.name}</span>
                  </div>
                  {isActive && <ChevronRight className="h-4 w-4 text-primary" />}
                </Link>
              );
            })}
          </nav>
        </ScrollArea>
      </div>
    </>
  );
}

// Export the Sidebar component wrapped in Suspense
export function Sidebar(props: SidebarProps) {
  return (
    <Suspense fallback={
      <div className="hidden lg:flex lg:flex-col lg:fixed lg:top-16 lg:left-0 lg:w-64 lg:h-[calc(100vh-4rem)] lg:overflow-y-auto lg:bg-white lg:dark:bg-gray-900 border-r border-gray-200 dark:border-gray-700 z-30">
        <div className="p-4 border-b">
          <h3 className="text-lg font-semibold">Loading...</h3>
        </div>
        <div className="flex justify-center items-center h-32">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
        </div>
      </div>
    }>
      <SidebarContent {...props} />
    </Suspense>
  );
}
