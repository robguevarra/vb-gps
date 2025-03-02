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

import { ReactNode, useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import Navbar from "@/components/navbar";
import { Sidebar as MissionarySidebar } from "@/components/Sidebar";
import SuperAdminSidebar from "@/components/SuperAdminSidebar";
import { createClient } from "@/utils/supabase/client";

interface DashboardLayoutProps {
  children: ReactNode;
}

export default function DashboardLayout({ children }: DashboardLayoutProps) {
  // Get current route path for sidebar selection
  const pathname = usePathname() || '';
  const [userRole, setUserRole] = useState("");
  const [isCampusDirector, setIsCampusDirector] = useState(false);
  const [isSuperAdmin, setIsSuperAdmin] = useState(false);
  const supabase = createClient();

  // Fetch user role on component mount
  useEffect(() => {
    const fetchUserRole = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      
      if (user) {
        const { data: profile } = await supabase
          .from("profiles")
          .select("role")
          .eq("id", user.id)
          .single();
        
        const role = profile?.role || "";
        setUserRole(role);
        setIsCampusDirector(role === "campus_director");
        setIsSuperAdmin(role === "superadmin" || user.email === "robneil@gmail.com");
      }
    };
    
    fetchUserRole();
  }, [supabase]);

  // Determine which sidebar to show based on the current route
  const showMissionarySidebar = pathname.startsWith("/dashboard/missionary");
  const showSuperAdminSidebar = pathname.startsWith("/dashboard/superadmin");
  
  // For missionary dashboard, the sidebar is now included in the page component
  // to ensure proper tab visibility, so we don't need to render it here
  const shouldRenderMissionarySidebar = false;

  return (
    <div className="min-h-screen flex flex-col">
      {/* Global navigation bar - visible on all dashboard pages */}
      <Navbar />
      
      <div className="flex flex-1">
        {/* Conditional sidebar rendering based on user role/route */}
        {shouldRenderMissionarySidebar && showMissionarySidebar && 
          <MissionarySidebar isCampusDirector={isCampusDirector || isSuperAdmin} />
        }
        {showSuperAdminSidebar && <SuperAdminSidebar />}

        {/* Main content area - grows to fill available space */}
        <main className="flex-1 p-4 pt-16">
          {children}
        </main>
      </div>
    </div>
  );
}
