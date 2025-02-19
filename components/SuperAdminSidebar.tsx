// components/SuperAdminSidebar.tsx
"use client";

import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { Menu } from "lucide-react";

interface SuperAdminSidebarProps {}

const navItems = [
  { name: "Churches", href: "?tab=churches" },
  { name: "Staff", href: "?tab=staff" },
  { name: "Reports", href: "?tab=reports" },
  { name: "Settings", href: "?tab=settings" },
];

export default function SuperAdminSidebar({}: SuperAdminSidebarProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams.get("tab") || "churches";

  return (
    <>
      {/* Mobile: collapsible sidebar via a Sheet */}
      <Sheet>
        <SheetTrigger asChild>
          <Button variant="outline" size="icon" className="lg:hidden">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="flex flex-col">
          <nav className="grid gap-2 text-lg font-medium p-4">
            {navItems.map((item) => (
              <Link
                key={item.name}
                href={`${pathname}${item.href}`}
                className={`block px-4 py-2 rounded-lg ${
                  currentTab === item.href.split("=")[1]
                    ? "bg-muted text-foreground"
                    : "text-muted-foreground hover:bg-accent"
                }`}
              >
                {item.name}
              </Link>
            ))}
          </nav>
        </SheetContent>
      </Sheet>

      {/* Desktop: pinned sidebar */}
      <div className="hidden lg:flex lg:flex-col lg:fixed lg:top-16 lg:left-0 lg:w-64 lg:h-[calc(100vh-4rem)] lg:overflow-y-auto lg:bg-white lg:dark:bg-gray-900 border-r border-gray-200 dark:border-gray-700">
        <nav className="flex flex-col gap-1 p-4">
          {navItems.map((item) => (
            <Link
              key={item.name}
              href={`${pathname}${item.href}`}
              className={`block px-4 py-2 rounded-lg ${
                currentTab === item.href.split("=")[1]
                  ? "bg-muted font-semibold"
                  : "hover:bg-accent"
              }`}
            >
              {item.name}
            </Link>
          ))}
        </nav>
      </div>
    </>
  );
}
