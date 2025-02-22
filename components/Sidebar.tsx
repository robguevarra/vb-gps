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
  SheetTrigger 
} from "@/components/ui/sheet";
import { Menu } from "lucide-react";
import { createClient } from "@/utils/supabase/client";
import { useState, useEffect } from "react";

interface SidebarProps {
  isCampusDirector?: boolean;
}

export function Sidebar({ isCampusDirector = false }: SidebarProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams.get("tab") || "overview";
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

  const navItems = [
    { name: "Overview", href: "?tab=overview" },
    { name: "Request History", href: "?tab=history" },
    { name: "Manual Remittance", href: "?tab=manual-remittance" },
    ...(isCampusDirector ? [{ name: "Approvals", href: "?tab=approvals" }] : []),
    { name: "Reports", href: "?tab=reports" },
  ];

  return (
    <>
      {/* Mobile: collapsible sidebar via a Sheet */}
      <Sheet open={isOpen} onOpenChange={setIsOpen}>
        <SheetTrigger asChild className="fixed top-4 right-4 lg:hidden z-50">
          <Button variant="outline" size="icon" className="shrink-0">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="w-[280px] sm:w-[340px]">
          <SheetHeader>
            <SheetTitle>Navigation</SheetTitle>
            <SheetDescription>
              Access different sections of your dashboard
            </SheetDescription>
          </SheetHeader>
          <nav className="flex flex-col gap-2 mt-4">
            {navItems.map((item) => {
              const params = new URLSearchParams(searchParams.toString());
              const newParams = new URLSearchParams(item.href.split("?")[1] || "");
              params.forEach((value, key) => {
                if (key !== "tab" && !newParams.has(key)) {
                  newParams.set(key, value);
                }
              });
              const isActive = currentTab === item.href.split("=")[1];
              
              return (
                <Link
                  key={item.name}
                  href={`${pathname}?${newParams.toString()}`}
                  onClick={() => setIsOpen(false)}
                  className={`
                    flex items-center px-4 py-2.5 rounded-lg
                    transition-all duration-200
                    ${isActive 
                      ? "bg-primary/10 text-primary font-medium" 
                      : "text-muted-foreground hover:bg-accent hover:text-foreground"
                    }
                  `}
                >
                  {item.name}
                </Link>
              );
            })}
          </nav>
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
        <nav className="flex flex-col gap-2 p-6">
          {navItems.map((item) => {
            const params = new URLSearchParams(searchParams.toString());
            const newParams = new URLSearchParams(item.href.split("?")[1] || "");
            params.forEach((value, key) => {
              if (key !== "tab" && !newParams.has(key)) {
                newParams.set(key, value);
              }
            });
            const isActive = currentTab === item.href.split("=")[1];
            
            return (
              <Link
                key={item.name}
                href={`${pathname}?${newParams.toString()}`}
                className={`
                  flex items-center px-4 py-2.5 rounded-lg
                  transition-all duration-200
                  ${isActive 
                    ? "bg-primary/10 text-primary font-medium" 
                    : "text-muted-foreground hover:bg-accent hover:text-foreground"
                  }
                `}
              >
                {item.name}
              </Link>
            );
          })}
        </nav>
      </div>
    </>
  );
}
