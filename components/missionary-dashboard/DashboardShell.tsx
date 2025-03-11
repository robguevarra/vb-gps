/**
 * DashboardShell Component
 * 
 * This component serves as the outer shell of the dashboard, providing the static UI elements
 * that can be rendered immediately while the dynamic content streams in.
 * 
 * Features:
 * - Renders immediately without waiting for data-fetching components
 * - Provides a consistent layout structure across all dashboard tabs
 * - Improves perceived performance by showing the UI shell first
 * - Maintains the sidebar offset and header across all dashboard views
 * - Includes streaming markers for performance testing
 * 
 * @component
 */

import { AnimatedHeader } from "@/components/AnimatedHeader";
import { ReactNode } from "react";

interface DashboardShellProps {
  /** The full name of the user */
  fullName: string;
  /** The user's role (formatted for display) */
  role: string;
  /** The name of the user's church */
  churchName: string;
  /** The title of the current dashboard tab */
  title: string;
  /** The subtitle of the current dashboard tab */
  subtitle: string;
  /** The user ID for keying the component */
  userId: string;
  /** The children components to render inside the shell */
  children: ReactNode;
}

export function DashboardShell({
  fullName,
  role,
  churchName,
  title,
  subtitle,
  userId,
  children
}: DashboardShellProps) {
  return (
    <div 
      className="relative min-h-screen bg-gray-50 dark:bg-gray-900" 
      key={userId}
      data-streaming-marker="ui-shell"
    >
      {/* Main Content - No need for sidebar offset on mobile */}
      <div className="lg:ml-64 px-4 sm:px-6 lg:px-8 py-8">
        <AnimatedHeader 
          fullName={fullName}
          role={role}
          churchName={churchName}
          title={title}
          subtitle={subtitle}
        />
        
        {/* Children content (tab content) */}
        <div data-streaming-marker="dashboard-structure">
          {children}
        </div>
      </div>
    </div>
  );
} 