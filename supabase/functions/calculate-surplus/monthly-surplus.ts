import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.cron('Calculate monthly surplus', '0 0 1 * *', async () => {
  // Get current month and year
  const now = new Date()
  const lastMonth = new Date(now.getFullYear(), now.getMonth() - 1, 1)
  
  // Get all missionaries
  const { data: missionaries } = await supabase
    .from('profiles')
    .select('id, monthly_goal, surplus_balance')
    .eq('role', 'missionary')

  if (!missionaries) return

  try {
    for (const missionary of missionaries) {
      // Get donations from previous month
      const { data: donations } = await supabase
        .from('donations')
        .select('amount')
        .eq('missionary_id', missionary.id)
        .gte('date', lastMonth.toISOString())
        .lt('date', now.toISOString())

      const totalDonations = donations?.reduce((sum, d) => sum + d.amount, 0) || 0
      const surplus = totalDonations - missionary.monthly_goal
      
      // Update surplus balance if donations exceed goal
      if (surplus > 0) {
        await supabase
          .from('profiles')
          .update({ surplus_balance: missionary.surplus_balance + surplus })
          .eq('id', missionary.id)
        
        // Create surplus record
        await supabase
          .from('surplus_history')
          .insert({
            missionary_id: missionary.id,
            amount: surplus,
            calculation_month: lastMonth.toISOString()
          })
      }
    }
  } catch (error) {
    console.error('Surplus calculation failed:', error)
  }
}) 