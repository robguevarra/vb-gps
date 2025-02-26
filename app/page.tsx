//app/page.tsx
import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';

export default async function HomePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/login');
  } else {
    redirect('/dashboard');
  }

  return (
    <div>
      <h1>Welcome to the Missionary Staff Portal KEKEKE</h1>
      {/* Add more content or components here as needed */}
    </div>
  );
} 