/**
 * Dashboard Layout Component
 * 
 * This component serves as the main layout wrapper for all dashboard pages.
 * It provides the global navigation bar and error boundary.
 * The sidebar is now handled by client components for better performance.
 * 
 * Features:
 * - Responsive layout with main content
 * - Persistent navbar across all dashboard pages
 * - Error boundary for graceful error handling
 * 
 * @component
 */
"use client";

import { ReactNode } from "react";
import Navbar from "@/components/navbar";
import { ErrorBoundary } from "@/components/ErrorBoundary";

interface DashboardLayoutProps {
  children: ReactNode;
}

export default function DashboardLayout({ children }: DashboardLayoutProps) {
  return (
    <div className="min-h-screen flex flex-col">
      {/* Global navigation bar - visible on all dashboard pages */}
      <Navbar />
      
      {/* Main content area - grows to fill available space */}
      <main className="flex-1">
        <ErrorBoundary>
          {children}
        </ErrorBoundary>
      </main>
    </div>
  );
}
