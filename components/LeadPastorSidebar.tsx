"use client";

import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
import { 
  Sheet, 
  SheetContent, 
  SheetHeader, 
  SheetTitle,
  SheetDescription
} from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { 
  ClipboardCheck, 
  CheckCircle, 
  BarChart2, 
  ChevronRight,
  ArrowLeft,
  Church
} from "lucide-react";
import { cn } from "@/lib/utils";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { Suspense, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";

interface LeadPastorSidebarProps {
  mobileMenuOpen?: boolean;
  setMobileMenuOpen?: (open: boolean) => void;
}

function LeadPastorSidebarContent({ mobileMenuOpen, setMobileMenuOpen }: LeadPastorSidebarProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams?.get("tab") || "approvals";
  const subTab = searchParams?.get("subTab") || "pending";
  
  // Use the prop if provided, otherwise manage state internally
  const [isOpenInternal, setIsOpenInternal] = useState(false);
  const isOpen = mobileMenuOpen !== undefined ? mobileMenuOpen : isOpenInternal;
  const setIsOpen = setMobileMenuOpen || setIsOpenInternal;

  const navItems = [
    { 
      name: "Pending Approvals", 
      href: "?tab=approvals", 
      icon: <ClipboardCheck className="h-5 w-5" />,
      description: "Review and approve pending requests",
      badge: 3 // Example badge count - replace with actual data
    },
    { 
      name: "Approved Requests", 
      href: "?tab=approved-requests", 
      icon: <CheckCircle className="h-5 w-5" />,
      description: "View previously approved requests"
    },
    { 
      name: "Staff Reports", 
      href: "?tab=reports", 
      icon: <BarChart2 className="h-5 w-5" />,
      description: "View performance reports for your staff"
    },
  ];

  // Animation variants for sidebar items
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
      {/* Mobile Sidebar */}
      <Sheet open={isOpen} onOpenChange={setIsOpen}>
        <SheetContent 
          side="left" 
          className="w-[85vw] sm:w-80 p-0 border-r shadow-lg"
          style={{
            transition: "transform 0.3s ease-in-out, opacity 0.3s ease-in-out"
          }}
        >
          <div className="flex items-center justify-between p-4 border-b">
            <SheetHeader className="text-left">
              <SheetTitle className="text-lg text-[#00458d] dark:text-blue-400">Pastor Dashboard</SheetTitle>
              <SheetDescription className="text-sm">
                Manage approvals and view reports
              </SheetDescription>
            </SheetHeader>
            <Button 
              variant="ghost" 
              size="icon" 
              onClick={() => setIsOpen(false)}
              className="h-8 w-8 rounded-full hover:bg-blue-50 dark:hover:bg-gray-800"
            >
              <ArrowLeft className="h-4 w-4" />
              <span className="sr-only">Close sidebar</span>
            </Button>
          </div>
          <ScrollArea className="h-[calc(100vh-5rem)]">
            <div className="p-4 mb-2 bg-blue-50/50 dark:bg-gray-800/50 mx-3 mt-3 rounded-lg">
              <div className="flex items-center gap-2">
                <Church className="h-4 w-4 text-[#00458d] dark:text-blue-400" />
                <span className="text-sm font-medium">Victory Bulacan</span>
              </div>
              <p className="text-xs text-muted-foreground mt-1">Lead Pastor Dashboard</p>
            </div>
            <nav className="p-3">
              <AnimatePresence>
                {navItems.map((item, index) => {
                  const isActive = currentTab === item.href.split("=")[1];
                  
                  return (
                    <motion.div
                      key={item.name}
                      custom={index}
                      initial="hidden"
                      animate="visible"
                      variants={itemVariants}
                      className="mb-2"
                    >
                      <Link
                        href={item.href}
                        onClick={() => setIsOpen(false)}
                        className={cn(
                          "flex items-center justify-between px-4 py-3 rounded-lg",
                          "transition-all duration-200",
                          isActive 
                            ? "bg-primary/10 text-primary font-medium shadow-sm" 
                            : "text-muted-foreground hover:bg-accent hover:text-foreground"
                        )}
                      >
                        <div className="flex items-center gap-3">
                          <div className={cn(
                            "flex-shrink-0 transition-colors duration-200",
                            isActive ? "text-[#00458d] dark:text-blue-400" : "text-muted-foreground"
                          )}>
                            {item.icon}
                          </div>
                          <div>
                            <div className="font-medium flex items-center gap-2">
                              {item.name}
                              {item.badge && (
                                <Badge 
                                  variant="secondary" 
                                  className="ml-1 h-5 min-w-5 flex items-center justify-center bg-blue-100 text-[#00458d] dark:bg-blue-900 dark:text-blue-200"
                                >
                                  {item.badge}
                                </Badge>
                              )}
                            </div>
                            <p className="text-xs text-muted-foreground line-clamp-1 mt-0.5">
                              {item.description}
                            </p>
                          </div>
                        </div>
                        {isActive && (
                          <motion.div
                            initial={{ scale: 0.8, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            transition={{ duration: 0.2 }}
                          >
                            <ChevronRight className="h-4 w-4 text-[#00458d] dark:text-blue-400" />
                          </motion.div>
                        )}
                      </Link>
                    </motion.div>
                  );
                })}
              </AnimatePresence>
            </nav>
          </ScrollArea>
        </SheetContent>
      </Sheet>

      {/* Desktop Sidebar */}
      <div className="hidden lg:block fixed left-0 top-16 bottom-0 w-64 border-r bg-background shadow-sm z-30">
        <div className="p-4 border-b flex items-center justify-between">
          <h3 className="text-lg font-semibold text-[#00458d] dark:text-blue-400">Pastor Dashboard</h3>
        </div>
        <div className="p-4 mb-2 bg-blue-50/50 dark:bg-gray-800/50 mx-3 mt-3 rounded-lg">
          <div className="flex items-center gap-2">
            <Church className="h-4 w-4 text-[#00458d] dark:text-blue-400" />
            <span className="text-sm font-medium">Victory Bulacan</span>
          </div>
          <p className="text-xs text-muted-foreground mt-1">Lead Pastor Dashboard</p>
        </div>
        <ScrollArea className="h-[calc(100vh-10rem)]">
          <nav className="p-3 space-y-2">
            {navItems.map((item, index) => {
              const isActive = currentTab === item.href.split("=")[1];
              
              return (
                <Link
                  key={item.name}
                  href={item.href}
                  className={cn(
                    "flex items-center justify-between px-3 py-2.5 rounded-lg",
                    "transition-all duration-200",
                    isActive
                      ? "bg-primary/10 text-primary font-medium shadow-sm" 
                      : "text-muted-foreground hover:bg-accent/50 hover:text-foreground"
                  )}
                >
                  <div className="flex items-center gap-3">
                    <div className={cn(
                      "flex-shrink-0 transition-colors duration-200",
                      isActive ? "text-[#00458d] dark:text-blue-400" : "text-muted-foreground"
                    )}>
                      {item.icon}
                    </div>
                    <span className="truncate">{item.name}</span>
                    {item.badge && (
                      <Badge 
                        variant="secondary" 
                        className="ml-1 h-5 min-w-5 flex items-center justify-center bg-blue-100 text-[#00458d] dark:bg-blue-900 dark:text-blue-200"
                      >
                        {item.badge}
                      </Badge>
                    )}
                  </div>
                  {isActive && <ChevronRight className="h-4 w-4 text-[#00458d] dark:text-blue-400" />}
                </Link>
              );
            })}
          </nav>
        </ScrollArea>
      </div>
    </>
  );
}

// Export the LeadPastorSidebar component wrapped in Suspense
export function LeadPastorSidebar({ mobileMenuOpen, setMobileMenuOpen }: LeadPastorSidebarProps) {
  return (
    <Suspense fallback={
      <div className="hidden lg:block fixed left-0 top-16 bottom-0 w-64 border-r bg-background shadow-sm z-30">
        <div className="p-4 border-b">
          <h3 className="text-lg font-semibold text-[#00458d] dark:text-blue-400">Loading...</h3>
        </div>
        <div className="flex justify-center items-center h-32">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-[#00458d] dark:border-blue-400"></div>
        </div>
      </div>
    }>
      <LeadPastorSidebarContent mobileMenuOpen={mobileMenuOpen} setMobileMenuOpen={setMobileMenuOpen} />
    </Suspense>
  );
} 