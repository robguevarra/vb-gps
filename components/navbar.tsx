'use client';

import Link from 'next/link';
import { createClient } from '@/utils/supabase/client'
import { usePathname } from 'next/navigation';
import { Button } from '@/components/ui/button';
import { useEffect, useState } from 'react';
import { 
  PlusCircle, FilePlus, Download, Settings, Bell, LifeBuoy, BookOpen, Users,
  Target, HandCoins, Clock, PiggyBank 
} from 'lucide-react'

function Navbar() {
  const pathname = usePathname();
  const supabase = createClient();
  const [profile, setProfile] = useState(null);

  const handleSignOut = async () => {
    const { error } = await supabase.auth.signOut();
    if (!error) {
      window.location.href = '/login';
    } else {
      console.error('Error signing out:', error.message);
    }
  };

  useEffect(() => {
    const fetchProfile = async () => {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (user) {
        const { data: profileData } = await supabase
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single();
        setProfile(profileData);
      }
    };

    fetchProfile();
  }, [supabase]);

  return (
    <nav className="bg-background border-b">
      <div className="max-w-7xl mx-auto px-4 py-2 flex justify-between items-center">
        <Link href="/dashboard" className="text-lg font-semibold">
          Dashboard
        </Link>
        <div className="space-x-4">
          <Button variant="ghost" onClick={handleSignOut}>
            Sign Out
          </Button>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;
