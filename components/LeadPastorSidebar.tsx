"use client";

import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
import { Sheet, SheetContent, SheetTrigger, SheetHeader, SheetTitle } from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { Menu, ClipboardCheck, CheckCircle, BarChart2, ChevronRight } from "lucide-react";
import { cn } from "@/lib/utils";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { Suspense } from "react";

function LeadPastorSidebarContent() {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams?.get("tab") || "approvals";
  const subTab = searchParams?.get("subTab") || "pending";

  const navItems = [
    { 
      name: "Pending Approvals", 
      href: "?tab=approvals", 
      icon: <ClipboardCheck className="h-5 w-5" />,
      description: "Review and approve pending requests"
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

  return (
    <>
      {/* Mobile Sidebar */}
      <Sheet>
        <SheetTrigger asChild>
          <Button 
            variant="outline" 
            size="icon" 
            className="lg:hidden fixed bottom-4 right-4 z-50 h-12 w-12 rounded-full shadow-lg border-2"
          >
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="w-[85vw] sm:w-80 p-0">
          <SheetHeader className="p-4 border-b">
            <SheetTitle className="text-left">Pastor Dashboard</SheetTitle>
          </SheetHeader>
          <ScrollArea className="h-[calc(100vh-5rem)]">
            <nav className="p-2">
              {navItems.map((item) => {
                const isActive = currentTab === item.href.split("=")[1];
                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    className={cn(
                      "flex items-center gap-3 px-4 py-3 my-1 rounded-lg transition-colors",
                      isActive
                        ? "bg-accent text-accent-foreground font-medium"
                        : "hover:bg-accent/50"
                    )}
                  >
                    <div className={cn(
                      "flex-shrink-0",
                      isActive ? "text-primary" : "text-muted-foreground"
                    )}>
                      {item.icon}
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center justify-between">
                        <span className="truncate">{item.name}</span>
                        {isActive && <ChevronRight className="h-4 w-4 text-muted-foreground" />}
                      </div>
                      <p className="text-xs text-muted-foreground truncate mt-0.5">
                        {item.description}
                      </p>
                    </div>
                  </Link>
                );
              })}
            </nav>
          </ScrollArea>
        </SheetContent>
      </Sheet>

      {/* Desktop Sidebar */}
      <div className="hidden lg:block fixed left-0 top-16 bottom-0 w-64 border-r bg-background">
        <div className="p-4 border-b">
          <h3 className="text-lg font-semibold">Pastor Dashboard</h3>
        </div>
        <ScrollArea className="h-[calc(100vh-8rem)]">
          <nav className="p-3 space-y-1">
            {navItems.map((item) => {
              const isActive = currentTab === item.href.split("=")[1];
              return (
                <Link
                  key={item.name}
                  href={item.href}
                  className={cn(
                    "flex items-center gap-3 px-3 py-2.5 rounded-lg transition-colors",
                    isActive
                      ? "bg-accent text-accent-foreground font-medium"
                      : "hover:bg-accent/50"
                  )}
                >
                  <div className={cn(
                    "flex-shrink-0",
                    isActive ? "text-primary" : "text-muted-foreground"
                  )}>
                    {item.icon}
                  </div>
                  <span className="truncate">{item.name}</span>
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
export function LeadPastorSidebar() {
  return (
    <Suspense fallback={
      <div className="hidden lg:block fixed left-0 top-16 bottom-0 w-64 border-r bg-background">
        <div className="p-4 border-b">
          <h3 className="text-lg font-semibold">Loading...</h3>
        </div>
        <div className="flex justify-center items-center h-32">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
        </div>
      </div>
    }>
      <LeadPastorSidebarContent />
    </Suspense>
  );
} 