"use client";

/**
 * BackgroundTabPreloader Component
 * 
 * Client component that preloads other tab data in the background after the overview tab is loaded.
 * This component improves the user experience by:
 * 1. Loading the overview tab first for immediate interaction
 * 2. Preloading other tab data in the background
 * 3. Making subsequent tab navigation feel instant
 * 
 * Implementation:
 * - Uses the useEffect hook to trigger preloading after the component mounts
 * - Uses the router.prefetch method to preload other tab routes
 * - Prioritizes tabs based on likelihood of use
 * - Staggers preloading to avoid overwhelming the network
 * 
 * @component
 */

import { useRouter, usePathname } from "next/navigation";
import { useEffect } from "react";

interface BackgroundTabPreloaderProps {
  /** The missionary ID to include in the preloaded URLs */
  missionaryId: string;
}

export function BackgroundTabPreloader({ missionaryId }: BackgroundTabPreloaderProps) {
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    // Define the tabs to preload in order of priority
    const tabsToPreload = [
      "history",        // Most likely to be accessed next
      "manual-remittance", 
      "reports",
      "approvals",      // Campus director specific
      "staff-reports"   // Campus director specific
    ];
    
    // Stagger the preloading to avoid overwhelming the network
    tabsToPreload.forEach((tab, index) => {
      setTimeout(() => {
        const url = `${pathname}?tab=${tab}&userId=${missionaryId}`;
        router.prefetch(url);
        
        // Log preloading in development mode
        if (process.env.NODE_ENV === 'development') {
          console.log(`Preloaded tab: ${tab}`);
        }
      }, index * 1000); // Stagger by 1 second per tab
    });
  }, [missionaryId, pathname, router]);

  // This component doesn't render anything visible
  return null;
} 