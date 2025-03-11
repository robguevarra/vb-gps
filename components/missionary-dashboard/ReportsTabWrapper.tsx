import { createClient } from "@/utils/supabase/server";
import { Suspense } from "react";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";
import { ReportsTabClient } from "./ReportsTabClient";
import { ReportsTabSkeleton } from "./ReportsTabSkeleton";
import { addMonths, format, startOfMonth, endOfMonth } from "date-fns";

interface ReportsTabWrapperProps {
  missionaryId: string;
}

/**
 * ReportsTabWrapper Component
 * 
 * Server component that fetches and processes donation data for the missionary dashboard reports tab.
 * Implements optimized data fetching with parallel queries, server-side data processing, and proper error handling.
 * 
 * @param missionaryId - The ID of the missionary to fetch data for
 */
export async function ReportsTabWrapper({ missionaryId }: ReportsTabWrapperProps) {
  const supabase = await createClient();

  // Generate column headers for the last 13 months on the server
  const columns = Array.from({ length: 13 }, (_, i) => {
    const date = addMonths(new Date(), -i);
    return {
      key: format(date, "yyyy-MM"),
      label: format(date, "MMM yyyy"),
      start: startOfMonth(date),
      end: endOfMonth(date),
    };
  }).reverse();

  // Fetch donation data in parallel for better performance
  // Using Promise.all to prevent waterfall requests
  const [last13MonthDonationsResult, allTimeDonorsResult] = await Promise.all([
    supabase
      .from("donor_donations")
      .select("id, amount, date, donor_id, donors(id, name)")
      .eq("missionary_id", missionaryId)
      .gte("date", columns[0].start.toISOString())
      .order("date", { ascending: false })
      .throwOnError(),
    supabase
      .from("donor_donations")
      .select("donor_id, amount, date, donors(id, name)")
      .eq("missionary_id", missionaryId)
      .order("date", { ascending: false })
      .throwOnError()
  ]).catch(error => {
    console.error("Error fetching donation data:", error);
    // Return empty results in case of error
    return [{ data: [] }, { data: [] }];
  });

  // Process and type-check the data before passing to client component
  const processedLast13MonthDonations = last13MonthDonationsResult.data?.map(d => ({
    id: Number(d.id),
    amount: Number(d.amount),
    date: String(d.date),
    donor_id: Number(d.donor_id),
    donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
      id: Number(d.donors.id),
      name: String(d.donors.name)
    } : null
  })) || [];

  const processedAllTimeDonors = allTimeDonorsResult.data?.map(d => ({
    donor_id: Number(d.donor_id),
    amount: Number(d.amount),
    date: String(d.date),
    donors: d.donors && typeof d.donors === 'object' && 'id' in d.donors && 'name' in d.donors ? {
      id: Number(d.donors.id),
      name: String(d.donors.name)
    } : null
  })) || [];

  // Server-side data processing - Move pivot table logic here
  // Group by donor and compute monthly totals
  const donorGroups = processedLast13MonthDonations.reduce((acc, donation) => {
    if (!donation.donors) return acc;

    const donorId = donation.donors.id;
    if (!acc[donorId]) {
      acc[donorId] = {
        donor: donation.donors,
        donations: [],
      };
    }
    acc[donorId].donations.push(donation);
    return acc;
  }, {} as Record<number, { donor: NonNullable<(typeof processedLast13MonthDonations)[0]["donors"]>; donations: typeof processedLast13MonthDonations }>);

  // Create pivot rows with monthly totals
  const pivotRows = Object.values(donorGroups).map(({ donor, donations }) => {
    const monthlyTotals = columns.reduce((acc, col) => {
      const start = new Date(col.start);
      const end = new Date(col.end);
      
      acc[col.key] = donations
        .filter((d) => {
          const date = new Date(d.date);
          return date >= start && date <= end;
        })
        .reduce((sum, d) => sum + d.amount, 0);
      return acc;
    }, {} as Record<string, number>);

    return {
      donor,
      monthlyTotals,
    };
  });

  // Process donor history for the "Partner History" tab
  const donorHistory = Object.values(
    processedAllTimeDonors.reduce((acc, donation) => {
      if (!donation.donors) return acc;

      const donorId = donation.donors.id;
      if (!acc[donorId]) {
        acc[donorId] = {
          donor: donation.donors,
          donations: [],
          total: 0,
        };
      }
      acc[donorId].donations.push(donation);
      acc[donorId].total += donation.amount;
      return acc;
    }, {} as Record<number, {
      donor: NonNullable<(typeof processedAllTimeDonors)[0]["donors"]>;
      donations: typeof processedAllTimeDonors;
      total: number;
    }>)
  );

  // Calculate monthly totals for the summary section
  const monthlyTotals = columns.map(col => {
    const total = pivotRows.reduce((sum, row) => sum + (row.monthlyTotals[col.key] || 0), 0);
    const prevMonthIndex = columns.indexOf(col) - 1;
    const prevTotal = prevMonthIndex >= 0 
      ? pivotRows.reduce((sum, row) => sum + (row.monthlyTotals[columns[prevMonthIndex].key] || 0), 0)
      : 0;
    
    return {
      column: col,
      total,
      prevTotal
    };
  });

  // Calculate grand total
  const grandTotal = monthlyTotals.reduce((sum, { total }) => sum + total, 0);
  
  // Count active partners (donors who gave in the last 13 months)
  const activePartners = pivotRows.filter(row => 
    columns.some(col => (row.monthlyTotals[col.key] || 0) > 0)
  ).length;

  return (
    <ErrorBoundaryProvider componentName="Reports Tab">
      <div className="space-y-8">
        <h2 className="text-2xl font-bold tracking-tight">My Reports</h2>
        <p className="text-muted-foreground">
          Track your partner giving patterns and donation history.
        </p>
        <Suspense fallback={<ReportsTabSkeleton />}>
          <ReportsTabClient
            columns={columns}
            pivotRows={pivotRows}
            donorHistory={donorHistory}
            monthlyTotals={monthlyTotals}
            grandTotal={grandTotal}
            activePartners={activePartners}
          />
        </Suspense>
      </div>
    </ErrorBoundaryProvider>
  );
}