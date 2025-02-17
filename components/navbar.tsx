"use client";

import { useRouter, usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { createClient } from '@/utils/supabase/client';
import ProfileSelector from '@/components/ProfileSelector'
import { Button } from '@/components/ui/button'

export default function Navbar() {
  const router = useRouter();
  const pathname = usePathname();
  const [selectedDashboard, setSelectedDashboard] = useState("");
  const [userRole, setUserRole] = useState<string | null>(null);
  const supabase = createClient();
  const [missionaries, setMissionaries] = useState<any[]>([])
  const [isSuperAdmin, setIsSuperAdmin] = useState(false)

  useEffect(() => {
    const fetchUserAndData = async () => {
      const { data: { user } } = await supabase.auth.getUser()
      const role = user?.user_metadata?.role || null
      setUserRole(role)
      
      // Check both email and role for superadmin status
      const superAdmin = user?.email === 'robneil@gmail.com' || role === 'superadmin'
      setIsSuperAdmin(superAdmin)

      if (superAdmin) {
        const { data: missionariesData } = await supabase
          .from('profiles')
          .select('*')
          .neq('role', 'superadmin')
        setMissionaries(missionariesData || [])
      }
    }
    fetchUserAndData()
  }, [])

  const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const value = e.target.value;
    setSelectedDashboard(value);
    if (value) {
      router.push(value);
    }
  };

  const handleSignOut = async () => {
    await supabase.auth.signOut()
    router.push('/login')
    // Force full page reload to clear any state
    window.location.href = '/login'
  }

  return (
    <nav className="fixed top-0 left-0 right-0 h-16 z-40 bg-background shadow flex items-center px-4 py-2">
      <div className="flex items-center gap-8">
        <div className="text-xl font-bold text-gray-800 dark:text-gray-200">
          Staff Portal
        </div>
        
        {/* Dashboard selector for superadmin */}
        {isSuperAdmin && (
          <div className="hidden md:block">
            <select
              value={selectedDashboard}
              onChange={handleChange}
              className="p-2 rounded border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-800 text-gray-800 dark:text-gray-200"
            >
              <option value="">Select Dashboard</option>
              <option value="/dashboard/missionary">Missionary Dashboard</option>
              <option value="/dashboard/finance">Finance Dashboard</option>
              <option value="/dashboard/campus-director">Campus Director Dashboard</option>
              <option value="/dashboard/lead-pastor">Lead Pastor Dashboard</option>
              <option value="/dashboard/superadmin">Superadmin Dashboard</option>
            </select>
          </div>
        )}
      </div>

      <div className="flex items-center gap-4">
        {/* Profile selector for superadmin */}
        {isSuperAdmin && pathname?.startsWith('/dashboard/missionary') && (
          <div className="hidden md:block">
            <ProfileSelector 
              missionaries={missionaries}
              userId={typeof window !== 'undefined' 
                ? new URLSearchParams(window.location.search).get('userId') || undefined 
                : undefined}
            />
          </div>
        )}

        {/* Sign Out button */}
        <Button 
          variant="ghost"
          onClick={handleSignOut}
          className="text-gray-800 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-gray-800"
        >
          Sign Out
        </Button>
      </div>
    </nav>
  );
} 