// components/SuperAdminSidebar.tsx
"use client";

import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { Menu } from "lucide-react";
import { Suspense } from "react";

interface SuperAdminSidebarProps {}

const navItems = [
  { name: "Churches", href: "?tab=churches" },
  { name: "Staff", href: "?tab=staff" },
  { name: "Reports", href: "?tab=reports" },
  { name: "Settings", href: "?tab=settings" },
];

function SuperAdminSidebarContent({}: SuperAdminSidebarProps) {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentTab = searchParams?.get("tab") || "churches";

  return (
    <>
      <Sheet>
        <SheetTrigger asChild>
          <Button variant="outline" size="icon" className="lg:hidden">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left">
          <nav className="flex flex-col space-y-2 mt-4">
            {navItems.map((item) => (
              <Link
                key={item.name}
                href={`${pathname}${item.href}`}
                className={`px-3 py-2 rounded-md ${
                  currentTab === item.href.split("=")[1]
                    ? "bg-primary text-primary-foreground"
                    : "hover:bg-muted"
                }`}
              >
                {item.name}
              </Link>
            ))}
          </nav>
        </SheetContent>
      </Sheet>

      <div className="hidden lg:flex lg:flex-col lg:w-64 lg:border-r">
        <div className="p-4">
          <h2 className="text-xl font-bold">Admin Portal</h2>
        </div>
        <nav className="flex flex-col space-y-1 p-2">
          {navItems.map((item) => (
            <Link
              key={item.name}
              href={`${pathname}${item.href}`}
              className={`px-3 py-2 rounded-md ${
                currentTab === item.href.split("=")[1]
                  ? "bg-primary text-primary-foreground"
                  : "hover:bg-muted"
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

// Export the SuperAdminSidebar component wrapped in Suspense
export default function SuperAdminSidebar(props: SuperAdminSidebarProps) {
  return (
    <Suspense fallback={
      <div className="hidden lg:flex lg:flex-col lg:w-64 lg:border-r">
        <div className="p-4">
          <h2 className="text-xl font-bold">Loading...</h2>
        </div>
        <div className="flex justify-center items-center h-32">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
        </div>
      </div>
    }>
      <SuperAdminSidebarContent {...props} />
    </Suspense>
  );
}
