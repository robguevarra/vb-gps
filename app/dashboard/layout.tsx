/**
 * Dashboard Layout Component
 * 
 * This component serves as the main layout wrapper for all dashboard pages.
 * It handles the conditional rendering of different sidebars based on the user's role
 * and current route.
 * 
 * Features:
 * - Responsive layout with sidebar and main content
 * - Dynamic sidebar rendering based on user role
 * - Persistent navbar across all dashboard pages
 * 
 * @component
 */
"use client";

import { ReactNode } from "react";
import { usePathname } from "next/navigation";
import Navbar from "@/components/navbar";
import { Sidebar as MissionarySidebar } from "@/components/Sidebar";
import SuperAdminSidebar from "@/components/SuperAdminSidebar";

interface DashboardLayoutProps {
  children: ReactNode;
}

export default function DashboardLayout({ children }: DashboardLayoutProps) {
  // Get current route path for sidebar selection
  const pathname = usePathname() || '';

  // Determine which sidebar to show based on the current route
  const showMissionarySidebar = pathname.startsWith("/dashboard/missionary");
  const showSuperAdminSidebar = pathname.startsWith("/dashboard/superadmin");
  // Note: Additional sidebar conditions can be added here for finance or lead pastor

  return (
    <div className="min-h-screen flex flex-col">
      {/* Global navigation bar - visible on all dashboard pages */}
      <Navbar />
      
      <div className="flex flex-1">
        {/* Conditional sidebar rendering based on user role/route */}
        {showMissionarySidebar && <MissionarySidebar />}
        {showSuperAdminSidebar && <SuperAdminSidebar />}

        {/* Main content area - grows to fill available space */}
        <main className="flex-1 p-4 pt-16">
          {children}
        </main>
      </div>
    </div>
  );
}
