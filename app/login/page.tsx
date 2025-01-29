import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import LoginForm from '@/components/login-form'

export default async function LoginPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (user) {
    redirect('/dashboard')
  }

  return (
    <div className="flex min-h-screen items-center justify-center">
      <div className="w-full max-w-md p-8 space-y-4 bg-card rounded-lg border">
        <h1 className="text-2xl font-bold">Staff Portal Login</h1>
        <LoginForm />
      </div>
    </div>
  )
} 