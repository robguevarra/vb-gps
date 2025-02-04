import { createClient } from '@supabase/supabase-js'
import { useRouter } from 'next/navigation'
import { useUser } from '@supabase/auth-helpers-react'
import { z } from 'zod'

export function SurplusRequestForm({
  surplusBalance,
  missionaryId,
  validateMissionary
}: {
  surplusBalance: number
  missionaryId?: string
  validateMissionary?: boolean
}) {
  const supabase = createClient()
  const router = useRouter()
  const user = useUser()

  const handleSubmit = async (values: z.infer<typeof formSchema>) => {
    console.log('[Surplus] Initial missionaryId:', missionaryId);
    console.log('[Surplus] validateMissionary prop:', validateMissionary);

    if (validateMissionary && !missionaryId) {
      console.error('[Surplus] Validation failed - no missionary selected');
      setErrorMessage('Please select a missionary first');
      return;
    }

    const { data: { user: currentUser } } = await supabase.auth.getUser();
    console.log('[Surplus] Current auth user ID:', currentUser?.id);
    
    const targetMissionaryId = missionaryId;
    console.log('[Surplus] Final missionaryId:', targetMissionaryId);

    const { error } = await supabase
      .from('surplus_requests')
      .insert({
        ...values,
        missionary_id: targetMissionaryId
      })

    console.log('[Surplus] Submitting with missionary_id:', targetMissionaryId);

    // ... rest of the code
  }
} 