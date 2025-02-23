"use client";

import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { Menu } from "lucide-react";
import { cn } from "@/lib/utils";

export function LeadPastorSidebar() {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams.get("tab") || "approvals";

  const navItems = [
    { name: "Approvals", href: "?tab=approvals" },
    { name: "Staff Reports", href: "?tab=reports" },
    { name: "Church Profile", href: "?tab=profile" },
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
                href={`${pathname}${item.href}`}
                className={cn(
                  "px-4 py-2.5 rounded-lg",
                  currentTab === item.href.split("=")[1]
                    ? "bg-accent font-semibold"
                    : "hover:bg-accent/50"
                )}
              >
                {item.name}
              </Link>
            ))}
          </nav>
        </SheetContent>
      </Sheet>

      {/* Desktop Sidebar */}
      <div className="hidden lg:block fixed left-0 top-16 bottom-0 w-64 border-r bg-background p-4">
        <h3 className="px-4 mb-4 text-lg font-semibold">Pastor Dashboard</h3>
        <nav className="flex flex-col gap-1">
          {navItems.map((item) => (
            <Link
              key={item.name}
              href={`${pathname}${item.href}`}
              className={cn(
                "px-4 py-2.5 rounded-lg transition-colors",
                currentTab === item.href.split("=")[1]
                  ? "bg-accent font-semibold"
                  : "hover:bg-accent/50"
              )}
            >
              {item.name}
            </Link>
          ))}
        </nav>
      </div>
    </>
  );
} 