// app/dashboard/finance/page.tsx

export const dynamic = "force-dynamic"; // Ensures fresh data on every request

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import DonationModal from "../../../components/DonationModal";
import RecentTransactionsTable from "@/components/RecentTransactionsTable";
import { getUserRole } from "@/utils/getUserRole";

export default async function FinanceDashboard() {
  // Initialize Supabase client
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // If no user is found, redirect to login.
  if (!user) {
    redirect("/login");
  }

  // Retrieve the user's role from the user_roles table.
  const financeRole = await getUserRole(user.id);
  // Allow both finance_officers and superadmins to access this dashboard.
  if (financeRole !== "finance_officer" && financeRole !== "superadmin") {
    redirect("/login");
  }

  // Fetch the finance officer's profile to determine their local_church_id.
  const { data: financeProfile, error: profileError } = await supabase
    .from("profiles")
    .select("local_church_id")
    .eq("id", user.id)
    .single();

  if (profileError) {
    console.error("[FinanceDashboard] Error fetching finance profile:", profileError.message);
    // Optionally handle this error (e.g., show a message or redirect)
  } else {
    console.log("[FinanceDashboard] Finance officer's local_church_id:", financeProfile.local_church_id);
  }

  // Fetch missionary and campus director profiles in the same church.
  const { data: missionaryProfiles, error: missionError } = await supabase
    .from("profiles")
    .select("id, full_name, role")
    .or("role.eq.missionary,role.eq.campus_director")
    .eq("local_church_id", financeProfile?.local_church_id);  // Filtering by local church

  if (missionError) {
    console.error("[FinanceDashboard] Error fetching missionary profiles:", missionError.message);
  } else {
    console.log("[FinanceDashboard] Retrieved missionary profiles:", missionaryProfiles);
  }

  // Fetch offline donor donation transactions recorded by the logged-in user.
  // We're filtering on "recorded_by" to ensure only manual donations recorded by this user are returned.
  const { data: donorDonationsData, error } = await supabase
    .from("donor_donations")
    .select("id, amount, date, notes, donors(name, email, phone)")
    .eq("source", "offline")
    .eq("recorded_by", user.id) // New filter: only show donations recorded by the logged-in user.
    .order("date", { ascending: false });

  if (error) {
    console.error("[FinanceDashboard] Error fetching donations:", error.message);
  } else {
    console.log("[FinanceDashboard] Retrieved donor donations:", donorDonationsData);
  }

  // Format donations data for the Recent Transactions Table.
  const formattedDonations = donorDonationsData?.map((d: any) => ({
    id: d.id,
    donor_name: Array.isArray(d.donors)
      ? (d.donors[0]?.name || "Unknown")
      : (d.donors?.name || "Unknown"),
    donor_email: Array.isArray(d.donors)
      ? (d.donors[0]?.email || "N/A")
      : (d.donors?.email || "N/A"),
    donor_phone: Array.isArray(d.donors)
      ? (d.donors[0]?.phone || "N/A")
      : (d.donors?.phone || "N/A"),
    amount: d.amount,
    date: d.date,
    notes: d.notes || ""
  })) || [];

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold text-foreground">Finance Dashboard</h1>
            <p className="text-lg text-muted-foreground mt-1">Manage manual donation entries</p>
          </div>
          {/* Pass the filtered missionaryProfiles to the DonationModal */}
          <DonationModal missionaries={missionaryProfiles || []} />
        </header>
        <div className="p-6 bg-card rounded-lg shadow">
          <h2 className="text-2xl font-semibold mb-4">Recent Transactions</h2>
          <RecentTransactionsTable donations={formattedDonations} />
        </div>
      </div>
    </div>
  );
}
