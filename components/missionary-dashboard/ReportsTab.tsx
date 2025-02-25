import { createClient } from "@/utils/supabase/server";
import { ReportsTab } from "@/components/ReportsTab";

interface ReportsTabWrapperProps {
  missionaryId: string;
}

export async function ReportsTabWrapper({ missionaryId }: ReportsTabWrapperProps) {
  const supabase = await createClient();

  const [last13MonthDonationsResult, allTimeDonorsResult] = await Promise.all([
    supabase
      .from("donor_donations")
      .select("id, amount, date, donor_id, donors(id, name)")
      .eq("missionary_id", missionaryId)
      .gte("date", new Date(new Date().setMonth(new Date().getMonth() - 13)).toISOString())
      .order("date", { ascending: false }),
    supabase
      .from("donor_donations")
      .select("donor_id, amount, date, donors(id, name)")
      .eq("missionary_id", missionaryId)
      .order("date", { ascending: false })
  ]);

  return (
    <div className="space-y-8">
      <ReportsTab
        missionaryId={missionaryId}
        last13MonthDonations={last13MonthDonationsResult.data?.map(d => ({
          id: Number(d.id),
          amount: Number(d.amount),
          date: String(d.date),
          donor_id: Number(d.donor_id),
          donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
            id: Number(d.donors.id),
            name: String(d.donors.name)
          } : null
        })) || []}
        allTimeDonors={allTimeDonorsResult.data?.map(d => ({
          donor_id: Number(d.donor_id),
          amount: Number(d.amount),
          date: String(d.date),
          donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
            id: Number(d.donors.id),
            name: String(d.donors.name)
          } : null
        })) || []}
      />
    </div>
  );
} 