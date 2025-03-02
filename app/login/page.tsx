import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import LoginForm from '@/components/login-form'
import Image from 'next/image'

export default async function LoginPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (user) {
    redirect('/dashboard')
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-[#f8fafc] to-[#e6f0fa] dark:from-gray-900 dark:to-gray-800 flex flex-col items-center justify-center p-4 sm:p-6 md:p-8">
      <div className="w-full max-w-md">
        {/* Card with subtle shadow and border */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-xl border border-gray-100 dark:border-gray-700 overflow-hidden">
          {/* Logo and header section */}
          <div className="bg-[#00458d] p-6 flex flex-col items-center">
            <div className="relative w-28 h-28 mb-4">
              <Image 
                src="/victorywhite.png" 
                alt="Victory Bulacan Logo" 
                fill
                sizes="(max-width: 768px) 7rem, 7rem"
                className="object-contain"
                priority
              />
            </div>
            <h1 className="text-2xl font-bold text-white text-center">Victory Bulacan</h1>
            <p className="text-blue-100 text-center mt-1">Honor God. Make Disciples.</p>
          </div>
          
          {/* Welcome message and form section */}
          <div className="p-6 sm:p-8">
            <div className="mb-6 text-center">
              <h2 className="text-xl font-semibold text-gray-800 dark:text-gray-100">Welcome to Staff Portal</h2>
              <p className="text-gray-500 dark:text-gray-400 text-sm mt-1">
                Sign in to access your missionary dashboard
              </p>
            </div>
            
            <LoginForm />
            
            <div className="mt-6 text-center text-xs text-gray-500 dark:text-gray-400">
              <p>Need help? Contact your administrator</p>
            </div>
          </div>
        </div>
        
        {/* Footer */}
        <div className="mt-8 text-center text-xs text-gray-500 dark:text-gray-400">
          <p>© {new Date().getFullYear()} Victory Bulacan. All rights reserved.</p>
          <p className="mt-1">Honor God. Make Disciples.</p>
        </div>
      </div>
    </div>
  )
} 