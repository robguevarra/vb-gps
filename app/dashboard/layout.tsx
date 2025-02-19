"use client";

import { ReactNode } from "react";
import { usePathname } from "next/navigation";
import Navbar from "@/components/navbar";
import { Sidebar as MissionarySidebar } from "@/components/Sidebar";
import SuperAdminSidebar from "@/components/SuperAdminSidebar";

export default function DashboardLayout({ children }: { children: ReactNode }) {
  const pathname = usePathname();

  // Decide which sidebar to show
  const showMissionarySidebar = pathname.startsWith("/dashboard/missionary");
  const showSuperAdminSidebar = pathname.startsWith("/dashboard/superadmin");
  // If you have a finance or lead pastor sidebar, you could detect them here too.

  return (
    <div className="min-h-screen flex flex-col">
      {/* If you want the Navbar on all dashboard pages, include it here. */}
      <Navbar />
      <div className="flex flex-1">
        {/* Conditionally render whichever sidebar you need */}
        {showMissionarySidebar && <MissionarySidebar />}
        {showSuperAdminSidebar && <SuperAdminSidebar />}

        {/* The main content grows to fill the space */}
        <main className="flex-1 p-4 pt-16">
          {children}
        </main>
      </div>
    </div>
  );
}
