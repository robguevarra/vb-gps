"use client";

import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { Menu } from "lucide-react";
import { cn } from "@/lib/utils";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";

export function LeadPastorSidebar() {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams.get("tab") || "approvals";
  const subTab = searchParams.get("subTab") || "pending";

  const navItems = [
    { name: "Pending Approvals", href: "?tab=approvals" },
    { name: "Approved Requests", href: "?tab=approved-requests" },
    { name: "Staff Reports", href: "?tab=reports" },
  ];

  return (
    <>
      {/* Mobile Sidebar */}
      <Sheet>
        <SheetTrigger asChild>
          <Button variant="outline" size="icon" className="lg:hidden">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="w-64">
          <nav className="flex flex-col gap-1">
            {navItems.map((item) => (
              <Link
                key={item.name}
                href={item.href}
                className={cn(
                  "px-4 py-2.5 rounded-lg",
                  currentTab === item.href.split("=")[1]
                    ? "bg-accent font-semibold"
                    : "hover:bg-accent/50"
                )}
              >
                <span>{item.name}</span>
              </Link>
            ))}
          </nav>
        </SheetContent>
      </Sheet>

      {/* Desktop Sidebar */}
      <div className="hidden lg:block fixed left-0 top-16 bottom-0 w-64 border-r bg-background p-4">
        <h3 className="px-4 mb-4 text-lg font-semibold">Pastor Dashboard</h3>
        <ScrollArea className="h-full p-4">
          <nav className="space-y-1">
            {navItems.map((item) => (
              <div key={item.name} className="space-y-2">
                <Link
                  href={item.href}
                  className={cn(
                    "flex items-center justify-between px-3 py-2 rounded-lg",
                    currentTab === item.href.split("=")[1] 
                      ? "bg-accent font-semibold"
                      : "hover:bg-accent/50"
                  )}
                >
                  <span>{item.name}</span>
                </Link>
              </div>
            ))}
          </nav>
        </ScrollArea>
      </div>
    </>
  );
} 