import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';

export default async function HomePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/login');
  }

  return (
    <div>
      <h1>Welcome to the Missionary Staff Portal</h1>
      {/* Add more content or components here as needed */}
    </div>
  );
} 