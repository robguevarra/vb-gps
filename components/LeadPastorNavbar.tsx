"use client";

import { useRouter, usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { createClient } from '@/utils/supabase/client';
import { Button } from '@/components/ui/button';
import Image from 'next/image';
import Link from 'next/link';
import { LogOut, PanelLeft, Menu } from 'lucide-react';
import { LeadPastorSidebar } from '@/components/LeadPastorSidebar';
import { motion, AnimatePresence } from 'framer-motion';

export default function LeadPastorNavbar() {
  const router = useRouter();
  const pathname = usePathname();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [userName, setUserName] = useState<string | null>(null);
  const supabase = createClient();

  useEffect(() => {
    const fetchUser = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        // Get user profile for name
        const { data: profileData } = await supabase
          .from('profiles')
          .select('full_name')
          .eq('id', user.id)
          .single();
          
        if (profileData) {
          setUserName(profileData.full_name || user.email || 'Lead Pastor');
        } else {
          setUserName(user.email || 'Lead Pastor');
        }
      }
    };
    fetchUser();
  }, []);

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    router.push('/login');
  };

  // Close mobile menu when sidebar is opened
  useEffect(() => {
    if (sidebarOpen) {
      setMobileMenuOpen(false);
    }
  }, [sidebarOpen]);

  return (
    <>
      <nav className="fixed top-0 left-0 right-0 h-16 z-40 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800 shadow-sm flex items-center justify-between px-4 py-2">
        <div className="flex items-center gap-4">
          {/* Sidebar toggle button for mobile */}
          <Button 
            variant="ghost" 
            size="icon" 
            onClick={() => setSidebarOpen(!sidebarOpen)}
            className="lg:hidden mr-1 text-gray-500 hover:text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-gray-200 dark:hover:bg-gray-800"
          >
            <PanelLeft className={`h-5 w-5 transition-transform duration-200 ${sidebarOpen ? 'rotate-180' : ''}`} />
            <span className="sr-only">Toggle sidebar</span>
          </Button>
          
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
        </div>

        {/* Mobile menu button */}
        <button 
          className="md:hidden p-2 rounded-md text-gray-500 hover:text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-gray-200 dark:hover:bg-gray-800"
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
        >
          <Menu className="h-5 w-5" />
          <span className="sr-only">Toggle menu</span>
        </button>

        {/* Desktop menu */}
        <div className="hidden md:flex items-center gap-4">
          <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300 mr-2">
            <div className="w-2 h-2 rounded-full bg-green-500"></div>
            {userName || 'Lead Pastor'}
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
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.2 }}
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300">
                  <div className="w-2 h-2 rounded-full bg-green-500"></div>
                  {userName || 'Lead Pastor'}
                </div>
              </div>
              
              <div className="border-t border-gray-200 dark:border-gray-800 pt-3">
                <Button 
                  variant="ghost"
                  onClick={handleSignOut}
                  className="w-full justify-start text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800"
                >
                  <LogOut className="h-4 w-4 mr-2" />
                  Sign Out
                </Button>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </nav>

      {/* Pass the sidebar state to the LeadPastorSidebar component */}
      <LeadPastorSidebar 
        mobileMenuOpen={sidebarOpen} 
        setMobileMenuOpen={setSidebarOpen} 
      />
    </>
  );
} 