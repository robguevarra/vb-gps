// components/Navbar.tsx
"use client";

/**
 * Navbar Component
 * 
 * This client component provides the main navigation bar for the application.
 * It coordinates with the sidebar and tab switching system for a seamless experience.
 * 
 * Features:
 * - User authentication status and sign out
 * - Dashboard selection for superadmins
 * - Responsive design with mobile menu
 * - Sidebar toggle integration
 * - Profile information display
 * - Coordination with tab switching events
 * 
 * @component
 */

import { useRouter, usePathname, useSearchParams } from 'next/navigation';
import { useState, useEffect, Suspense } from 'react';
import { createClient } from '@/utils/supabase/client';
import ProfileSelector from '@/components/ProfileSelector';
import { Button } from '@/components/ui/button';
import Image from 'next/image';
import Link from 'next/link';
import { LogOut, ChevronDown, Menu, PanelLeft } from 'lucide-react';
import { 
  DropdownMenu, 
  DropdownMenuContent, 
  DropdownMenuItem, 
  DropdownMenuTrigger 
} from '@/components/ui/dropdown-menu';
import { Sidebar } from '@/components/Sidebar';
import { motion, AnimatePresence } from 'framer-motion';

/**
 * TabStateManager Component
 * 
 * This component handles the tab state management and URL synchronization.
 * It's separated to properly handle the useSearchParams hook which needs
 * to be wrapped in a Suspense boundary.
 */
function TabStateManager({
  onTabChange
}: {
  onTabChange: (tab: string) => void;
}) {
  const searchParams = useSearchParams();
  
  // Update active tab from URL
  useEffect(() => {
    const tabFromUrl = searchParams?.get("tab") || "overview";
    onTabChange(tabFromUrl);
  }, [searchParams, onTabChange]);
  
  return null; // This component doesn't render anything
}

export default function Navbar() {
  const router = useRouter();
  const pathname = usePathname();
  const [selectedDashboard, setSelectedDashboard] = useState("");
  const [userRole, setUserRole] = useState<string | null>(null);
  const supabase = createClient();
  const [missionaries, setMissionaries] = useState<any[]>([]);
  const [isSuperAdmin, setIsSuperAdmin] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [userName, setUserName] = useState<string | null>(null);
  const [isCampusDirector, setIsCampusDirector] = useState(false);
  const [activeTab, setActiveTab] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  // Listen for tab change events
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tab } = event.detail;
      setActiveTab(tab);
      setIsLoading(true);
    };
    
    window.addEventListener('tabchange', handleTabChange as EventListener);
    
    return () => {
      window.removeEventListener('tabchange', handleTabChange as EventListener);
    };
  }, []);
  
  // Listen for content loaded events
  useEffect(() => {
    const handleContentLoaded = (event: CustomEvent) => {
      setIsLoading(false);
    };
    
    window.addEventListener('contentloaded', handleContentLoaded as EventListener);
    return () => {
      window.removeEventListener('contentloaded', handleContentLoaded as EventListener);
    };
  }, []);

  // Handle tab change from URL
  const handleTabChange = (tab: string) => {
    setActiveTab(tab);
  };

  useEffect(() => {
    const fetchUserAndData = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      const role = user?.user_metadata?.role || null;
      setUserRole(role);
      
      // Determine superadmin via email or role
      const superAdmin = user?.email === 'robneil@gmail.com' || role === 'superadmin';
      setIsSuperAdmin(superAdmin);

      if (user) {
        // Get user profile for name and role
        const { data: profileData } = await supabase
          .from('profiles')
          .select('full_name, role')
          .eq('id', user.id)
          .single();
          
        if (profileData) {
          setUserName(profileData.full_name || user.email || 'User');
          setIsCampusDirector(profileData.role === 'campus_director');
        } else {
          setUserName(user.email || 'User');
        }
      }

      if (superAdmin) {
        const { data: missionariesData } = await supabase
          .from('profiles')
          .select('*')
          .neq('role', 'superadmin');
        setMissionaries(missionariesData || []);
      }
    };
    fetchUserAndData();
  }, []);

  const handleChange = (value: string) => {
    setSelectedDashboard(value);
    if (value) {
      router.push(value);
    }
  };

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    router.push('/login');
  };

  const dashboardOptions = [
    { value: "/dashboard/missionary", label: "Missionary Dashboard" },
    { value: "/dashboard/finance", label: "Finance Dashboard" },
    { value: "/dashboard/lead-pastor", label: "Lead Pastor Dashboard" },
    { value: "/dashboard/superadmin", label: "Superadmin Dashboard" }
  ];

  // Handle sidebar toggle
  const handleSidebarToggle = () => {
    const newState = !sidebarOpen;
    setSidebarOpen(newState);
    
    // Dispatch custom event for sidebar components to listen to
    const event = new CustomEvent('sidebarToggle', {
      detail: { open: newState }
    });
    window.dispatchEvent(event);
    
    // Close mobile menu when sidebar is opened
    if (newState) {
      setMobileMenuOpen(false);
    }
  };

  // Determine if user should have access to campus director tabs
  const hasAccessToCampusDirectorTabs = isCampusDirector || isSuperAdmin;

  return (
    <>
      {/* TabStateManager with Suspense boundary */}
      <Suspense fallback={null}>
        <TabStateManager onTabChange={handleTabChange} />
      </Suspense>
      
      <nav className="fixed top-0 left-0 right-0 h-16 z-50 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800 shadow-sm flex items-center justify-between px-4 py-2">
        <div className="flex items-center gap-4">
          {/* Sidebar toggle button for mobile */}
          {pathname?.startsWith('/dashboard/missionary') && (
            <Button 
              variant="ghost" 
              size="icon" 
              onClick={handleSidebarToggle}
              className="lg:hidden mr-1 text-gray-500 hover:text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-gray-200 dark:hover:bg-gray-800"
            >
              <PanelLeft className={`h-5 w-5 transition-transform duration-200 ${sidebarOpen ? 'rotate-180' : ''}`} />
              <span className="sr-only">Toggle sidebar</span>
            </Button>
          )}
          
          <Link href="/dashboard" className="flex items-center gap-2">
            <div className="relative w-8 h-8">
              <Image 
                src="/victorylogo-colored.png" 
                alt="Victory Bulacan Logo" 
                fill
                sizes="(max-width: 768px) 2rem, 2rem"
                className="object-contain"
              />
            </div>
            <div className="text-lg font-bold text-[#00458d] dark:text-white hidden sm:block">
              Victory Bulacan
            </div>
          </Link>
          
          {isSuperAdmin && (
            <div className="hidden md:block ml-4">
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" className="flex items-center gap-1 border-gray-200 dark:border-gray-700">
                    {selectedDashboard ? 
                      dashboardOptions.find(opt => opt.value === selectedDashboard)?.label : 
                      "Select Dashboard"}
                    <ChevronDown className="h-4 w-4 opacity-50" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start" className="w-56">
                  {dashboardOptions.map((option) => (
                    <DropdownMenuItem 
                      key={option.value}
                      onClick={() => handleChange(option.value)}
                      className="cursor-pointer"
                    >
                      {option.label}
                    </DropdownMenuItem>
                  ))}
                </DropdownMenuContent>
              </DropdownMenu>
            </div>
          )}
        </div>

        {/* Mobile menu button - only show when sidebar is closed */}
        <button 
          className="md:hidden p-2 rounded-md text-gray-500 hover:text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-gray-200 dark:hover:bg-gray-800"
          style={{ minHeight: '44px', minWidth: '44px' }} // Increased touch target
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
        >
          <Menu className="h-6 w-6" /> {/* Slightly larger icon */}
          <span className="sr-only">Toggle menu</span>
        </button>

        {/* Desktop menu */}
        <div className="hidden md:flex items-center gap-4">
          {isSuperAdmin && pathname?.startsWith('/dashboard/missionary') && (
            <ProfileSelector 
              missionaries={missionaries}
              userId={
                typeof window !== 'undefined' 
                  ? new URLSearchParams(window.location.search).get('userId') || undefined 
                  : undefined
              }
            />
          )}
          
          <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300 mr-2">
            <div className="w-2 h-2 rounded-full bg-green-500"></div>
            {userName}
          </div>
          
          <Button 
            variant="ghost"
            onClick={handleSignOut}
            className="text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 flex items-center gap-1"
          >
            <LogOut className="h-4 w-4" />
            <span>Sign Out</span>
          </Button>
        </div>

        {/* Mobile menu */}
        <AnimatePresence>
          {mobileMenuOpen && (
            <motion.div 
              className="md:hidden absolute top-16 left-0 right-0 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800 shadow-md p-4 flex flex-col gap-3 z-50"
              style={{ maxHeight: 'calc(100vh - 4rem)', overflowY: 'auto' }} // Ensure it doesn't overflow viewport
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.2 }}
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300">
                  <div className="w-2 h-2 rounded-full bg-green-500"></div>
                  {userName}
                </div>
                <Button 
                  variant="ghost" 
                  size="sm" 
                  className="h-10 w-10 p-0 rounded-full" // Larger touch target
                  onClick={() => setMobileMenuOpen(false)}
                >
                  <span className="sr-only">Close menu</span>
                  ×{/* Add a visible close icon */}
                </Button>
              </div>
              
              {isSuperAdmin && (
                <div className="border-t border-gray-200 dark:border-gray-800 pt-3">
                  <p className="text-xs text-gray-500 dark:text-gray-400 mb-2">Select Dashboard</p>
                  <div className="flex flex-col gap-2">
                    {dashboardOptions.map((option) => (
                      <Button 
                        key={option.value}
                        variant="ghost" 
                        className={`justify-start ${selectedDashboard === option.value ? 'bg-gray-100 dark:bg-gray-800 text-[#00458d] dark:text-blue-400' : ''}`}
                        onClick={() => {
                          handleChange(option.value);
                          setMobileMenuOpen(false);
                        }}
                      >
                        {option.label}
                      </Button>
                    ))}
                  </div>
                </div>
              )}
              
              {isSuperAdmin && pathname?.startsWith('/dashboard/missionary') && (
                <div className="border-t border-gray-200 dark:border-gray-800 pt-3">
                  <p className="text-xs text-gray-500 dark:text-gray-400 mb-2">Select Missionary</p>
                  <ProfileSelector 
                    missionaries={missionaries}
                    userId={
                      typeof window !== 'undefined' 
                        ? new URLSearchParams(window.location.search).get('userId') || undefined 
                        : undefined
                    }
                    onClose={() => setMobileMenuOpen(false)}
                  />
                </div>
              )}
              
              <div className="border-t border-gray-200 dark:border-gray-800 pt-3 mt-2">
                <Button 
                  variant="ghost" 
                  className="w-full justify-start text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20"
                  onClick={() => {
                    handleSignOut();
                    setMobileMenuOpen(false);
                  }}
                >
                  <LogOut className="h-4 w-4 mr-2" />
                  Sign Out
                </Button>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </nav>
    </>
  );
}
