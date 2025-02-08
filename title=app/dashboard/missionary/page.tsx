// -------------------------------
// Fetch Donation Data (ONLY use donor_donations)
// -------------------------------
const { data: donorDonationsData } = await supabase
  .from('donor_donations')
  .select('id, amount, date, donors(name)')
  .eq('missionary_id', userIdParam || user.id)
  .order('date', { ascending: false });

// Format donor donations with donor name
const formattedDonations = donorDonationsData?.map(record => ({
  id: record.id,
  amount: record.amount,
  date: record.date,
  donor_name: record.donors?.name || 'Unknown'
})) || [];

// Combine and sort (no need to merge with donations table)
const combinedDonations = formattedDonations.sort((a, b) => 
  new Date(b.date).getTime() - new Date(a.date).getTime()
).slice(0, 5);

// Pass to RecentDonations
<RecentDonations
  donations={combinedDonations.map(d => ({
    id: d.id,
    donor_name: d.donor_name,
    amount: d.amount,
    date: new Date(d.date).toLocaleDateString(),
  }))}
  missionaryId={userIdParam || user.id}
/> 