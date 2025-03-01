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
  ChevronRight
} from "lucide-react";
import { createClient } from "@/utils/supabase/client";
import { useState, useEffect } from "react";
import { cn } from "@/lib/utils";
import { ScrollArea } from "@/components/ui/scroll-area";

interface SidebarProps {
  isCampusDirector?: boolean;
}

export function Sidebar({ isCampusDirector = false }: SidebarProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams?.get("tab") || "overview";
  const supabase = createClient();
  const [userRole, setUserRole] = useState("");
  const [isOpen, setIsOpen] = useState(false);

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
        setUserRole(profile?.role || "");
      }
    };
    fetchUser();
  }, [supabase]);

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
    ...(isCampusDirector ? [{ 
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
    ...(isCampusDirector ? [{ 
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

  return (
    <>
      {/* Mobile: collapsible sidebar via a Sheet */}
      <Sheet open={isOpen} onOpenChange={setIsOpen}>
        <SheetTrigger asChild>
          <Button 
            variant="outline" 
            size="icon" 
            className="lg:hidden fixed bottom-4 right-4 z-50 h-12 w-12 rounded-full shadow-lg border-2 bg-background"
          >
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="w-[85vw] sm:w-80 p-0">
          <SheetHeader className="p-4 border-b">
            <SheetTitle className="text-lg">Missionary Dashboard</SheetTitle>
            <SheetDescription className="text-sm">
              Access your missionary tools and reports
            </SheetDescription>
          </SheetHeader>
          <ScrollArea className="h-[calc(100vh-5rem)]">
            <nav className="flex flex-col p-3 space-y-1">
              {navItems.map((item) => {
                const newParams = getUpdatedParams(item.href);
                const isActive = currentTab === item.href.split("=")[1];
                
                return (
                  <Link
                    key={item.name}
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
                );
              })}
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
          z-50
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
