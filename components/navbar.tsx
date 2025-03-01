// components/Navbar.tsx
"use client";

import { useRouter, usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { createClient } from '@/utils/supabase/client';
import ProfileSelector from '@/components/ProfileSelector';
import { Button } from '@/components/ui/button';
import Image from 'next/image';
import Link from 'next/link';
import { LogOut, ChevronDown, Menu, X } from 'lucide-react';
import { 
  DropdownMenu, 
  DropdownMenuContent, 
  DropdownMenuItem, 
  DropdownMenuTrigger 
} from '@/components/ui/dropdown-menu';

export default function Navbar() {
  const router = useRouter();
  const pathname = usePathname();
  const [selectedDashboard, setSelectedDashboard] = useState("");
  const [userRole, setUserRole] = useState<string | null>(null);
  const supabase = createClient();
  const [missionaries, setMissionaries] = useState<any[]>([]);
  const [isSuperAdmin, setIsSuperAdmin] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [userName, setUserName] = useState<string | null>(null);

  useEffect(() => {
    const fetchUserAndData = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      const role = user?.user_metadata?.role || null;
      setUserRole(role);
      
      // Determine superadmin via email or role
      const superAdmin = user?.email === 'robneil@gmail.com' || role === 'superadmin';
      setIsSuperAdmin(superAdmin);

      if (user) {
        // Get user profile for name
        const { data: profileData } = await supabase
          .from('profiles')
          .select('full_name')
          .eq('id', user.id)
          .single();
          
        if (profileData?.full_name) {
          setUserName(profileData.full_name);
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

  return (
    <nav className="fixed top-0 left-0 right-0 h-16 z-40 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800 shadow-sm flex items-center justify-between px-4 py-2">
      <div className="flex items-center gap-4">
        <Link href="/dashboard" className="flex items-center gap-2">
          <div className="relative w-8 h-8">
            <Image 
              src="/victorylogo-colored.png" 
              alt="Victory Bulacan Logo" 
              fill
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

      {/* Mobile menu button */}
      <button 
        className="md:hidden p-2 rounded-md text-gray-500 hover:text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-gray-200 dark:hover:bg-gray-800"
        onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
      >
        {mobileMenuOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
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
      {mobileMenuOpen && (
        <div className="md:hidden absolute top-16 left-0 right-0 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800 shadow-md p-4 flex flex-col gap-3 z-50">
          <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300 p-2">
            <div className="w-2 h-2 rounded-full bg-green-500"></div>
            {userName}
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
              />
            </div>
          )}
          
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
        </div>
      )}
    </nav>
  );
}
