// hooks/useReportsData.ts

import { useState, useEffect } from "react";
import { createClient } from "@/utils/supabase/client";
import { ReportsData, Profile, Church, DonorDonation, DonationMap } from "@/types/reports";
import { generateThirteenMonthKeys, getLastMonthKey } from "@/utils/reports";

// Add type definitions at the top of the file
interface Donor {
  id: number;
  name: string;
  email: string;
  phone: string;
}

interface DonorDonationWithDonor {
  donor_id: number;
  donors: {
    id: number;
    name: string | null;
    email: string | null;
    phone: string | null;
  } | null;
}

export const useReportsData = () => {
  const supabase = createClient();
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [data, setData] = useState<ReportsData>({
    missionaries: [],
    churches: [],
    donations: [],
    donationMap: {},
    thirteenMonthKeys: [],
    totalDonationsThisMonth: 0,
    currentPercentAllMissionaries: 0,
    lastMonthPercentAllMissionaries: 0,
    countBelow80LastMonth: 0,
    enrichedDonors: []
  });

  const loadData = async () => {
    try {
      setIsLoading(true);
      setError(null);

      // Define thirteenMonthsAgo at the start
      const thirteenMonthsAgo = new Date();
      thirteenMonthsAgo.setMonth(thirteenMonthsAgo.getMonth() - 13);

      // 1) Get missionaries and churches first (these are smaller datasets)
      const [missionaryResult, churchResult] = await Promise.all([
        supabase
          .from("profiles")
          .select("id, full_name, monthly_goal, local_church_id, role, surplus_balance, created_at")
          .or("role.eq.missionary,role.eq.campus_director"),
        supabase
          .from("local_churches")
          .select("id, name")
          .order("name")
      ]);

      if (missionaryResult.error) throw missionaryResult.error;
      if (churchResult.error) throw churchResult.error;

     

      // 2) Get all unique donors with detailed logging
      console.log('\n=== Fetching Donors ===');
      
      let uniqueDonors: Donor[] = [];
      let donorsMap: Map<number, Donor>;

      // First verify the donors table structure
      const { data: donorsTableInfo, error: tableError } = await supabase
        .from('donors')
        .select('*')
        .limit(1);

      console.log('\n=== Donors Table Check ===');
      console.log('Donors table info:', {
        exists: !!donorsTableInfo,
        error: tableError ? {
          message: tableError.message,
          code: tableError.code,
          details: tableError.details
        } : null,
        sample: donorsTableInfo
      });

      // If donors table exists, proceed with the original logic
      const { data: fetchedDonors, error: donorsError } = await supabase
        .from('donors')
        .select('id, name, email, phone');

      console.log('\n=== Donors Fetch Results ===');
      console.log('Fetched donors:', {
        success: !!fetchedDonors,
        count: fetchedDonors?.length || 0,
        error: donorsError ? {
          message: donorsError.message,
          code: donorsError.code,
          details: donorsError.details
        } : null,
        sampleDonor: fetchedDonors?.[0]
      });

      if (donorsError) {
        console.error('Failed to fetch donors:', donorsError);
        throw donorsError;
      }

      uniqueDonors = (fetchedDonors || []).map(d => ({
        id: d.id,
        name: d.name || '',
        email: d.email || '',
        phone: d.phone || ''
      }));

      // Create donors map
      donorsMap = new Map(uniqueDonors.map(d => [d.id, d]));

      // Get ALL donations
      const { data: allDonations, error: donationsError } = await supabase
        .from("donor_donations")
        .select(`
          id,
          missionary_id,
          donor_id,
          date,
          amount,
          status,
          source,
          notes
        `)
        .eq('status', 'completed')
        .order('date', { ascending: false });

      if (donationsError) throw donationsError;

      console.log('3. Donations data:', {
        count: allDonations?.length,
        recentDonations: allDonations?.filter(d => new Date(d.date) >= thirteenMonthsAgo).length
      });

      // Process donations with donor info
      const enrichedDonations = allDonations.map(don => {
        const donorInfo = don.donor_id ? donorsMap.get(don.donor_id) : null;
        return {
          ...don,
          donors: donorInfo
        };
      }) as DonorDonation[];

      // Create a map of recent donations by donor
      const donorDonationsMap = new Map<number, number>();

      console.log('\n=== Processing Recent Donations ===');
      console.log('Processing donations from:', thirteenMonthsAgo.toISOString());
      console.log('Total donations to process:', enrichedDonations.length);

      enrichedDonations.forEach(don => {
        if (don.donor_id) {
          const donDate = new Date(don.date);
          if (donDate >= thirteenMonthsAgo) {
            donorDonationsMap.set(
              don.donor_id, 
              (donorDonationsMap.get(don.donor_id) || 0) + don.amount
            );
          }
        }
      });

      console.log('\n=== Donor Maps Status ===');
      console.log('Unique donors found:', uniqueDonors.length);
      console.log('Donors with recent donations:', donorDonationsMap.size);
      console.log('Sample donor IDs with amounts:', Array.from(donorDonationsMap.entries()).slice(0, 3));

      // Enrich all donors with their recent donation totals
      const enrichedDonors = uniqueDonors.map(donor => ({
        ...donor,
        totalGiven: donorDonationsMap.get(donor.id) || 0
      }));

      console.log('4. Final enriched data:', {
        totalDonors: uniqueDonors.length,
        donorsWithRecentDonations: Array.from(donorDonationsMap.keys()).length,
        enrichedDonorsCount: enrichedDonors.length,
        donorsWithNonZeroTotal: enrichedDonors.filter(d => d.totalGiven > 0).length
      });

      // 4) Get stats from materialized view for current and last month
      const now = new Date();
      const currentMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
      const lastMonthKey = getLastMonthKey();

      console.log('\n=== Monthly Stats Query ===');
      console.log('Current Month:', currentMonth);
      console.log('Last Month:', lastMonthKey);

      const { data: monthlyStats, error: statsError } = await supabase
        .from('missionary_monthly_stats')
        .select('*')
        .in('month', [currentMonth, lastMonthKey]);

      if (statsError) throw statsError;

      console.log('\n=== Monthly Stats Results ===');
      console.log('Raw monthly stats:', monthlyStats);
      console.log('Total stats records:', monthlyStats?.length || 0);

      // Process monthly stats
      const currentMonthStats = monthlyStats?.filter(s => s.month === currentMonth) || [];
      const lastMonthStats = monthlyStats?.filter(s => s.month === lastMonthKey) || [];

      console.log('\n=== Filtered Stats ===');
      console.log('Current month records:', currentMonthStats.length);
      console.log('Current month stats:', currentMonthStats);
      console.log('Last month records:', lastMonthStats.length);
      console.log('Last month stats:', lastMonthStats);

      // Calculate top metrics from materialized view
      const totalDonationsThisMonth = currentMonthStats.reduce((sum, stat) => sum + (stat.total_donations || 0), 0);
      const totalMonthlyGoals = currentMonthStats.reduce((sum, stat) => sum + (stat.monthly_goal || 0), 0);
      const currentPercentage = totalMonthlyGoals > 0 ? (totalDonationsThisMonth / totalMonthlyGoals) * 100 : 0;

      const totalLastMonth = lastMonthStats.reduce((sum, stat) => sum + (stat.total_donations || 0), 0);
      const lastMonthPercentage = totalMonthlyGoals > 0 ? (totalLastMonth / totalMonthlyGoals) * 100 : 0;
      
      console.log('\n=== Top Metrics ===');
      console.log('Total donations this month:', totalDonationsThisMonth);
      console.log('Total monthly goals:', totalMonthlyGoals);
      console.log('Current percentage:', currentPercentage);
      console.log('Total last month:', totalLastMonth);
      console.log('Last month percentage:', lastMonthPercentage);

      // Count missionaries below 80% last month
      console.log('\n=== Below 80% Calculation ===');
      console.log('Last month stats to process:', lastMonthStats);
      
      const below80Count = lastMonthStats.filter(stat => {
        const isBelow80 = stat.goal_percentage < 80;
        console.log(`Missionary ${stat.missionary_id}:`);
        console.log('- Monthly goal:', stat.monthly_goal);
        console.log('- Total donations:', stat.total_donations);
        console.log('- Goal percentage:', stat.goal_percentage);
        console.log('- Below 80%:', isBelow80);
        return isBelow80;
      }).length;

      console.log('Total missionaries below 80%:', below80Count);

      console.log('\n=== Current Month Percentage Calculation ===');
      const completedDonations = allDonations.filter(don => don.status === 'completed');
      
      // Basic stats
      console.log('\n=== Stats ===');
      console.log(`Missionaries: ${missionaryResult.data?.length}`);
      console.log(`Current Month: ${currentMonth}`);
      console.log(`Total donations this month: ${totalDonationsThisMonth}`);
      console.log(`Current percentage: ${currentPercentage}%`);
      console.log(`Below 80%: ${below80Count}`);

      // Build donation map from historical donations
      const dMap: DonationMap = {};
      completedDonations.forEach((don) => {
        if (!dMap[don.missionary_id]) {
          dMap[don.missionary_id] = {};
        }
        const dateObj = new Date(don.date);
        const yy = dateObj.getFullYear();
        const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
        const key = `${yy}-${mm}`;
        dMap[don.missionary_id][key] = (dMap[don.missionary_id][key] || 0) + (don.amount || 0);
      });

      // Add current month data from materialized view
      currentMonthStats.forEach((stat) => {
        if (!dMap[stat.missionary_id]) {
          dMap[stat.missionary_id] = {};
        }
        dMap[stat.missionary_id][currentMonth] = stat.total_donations || 0;
      });

      // Log only missionaries with donations this month
      console.log('\n=== Current Month Donations ===');
      Object.entries(dMap).forEach(([missionaryId, monthData]) => {
        const currentMonthAmount = monthData[currentMonth] || 0;
        if (currentMonthAmount > 0) {
          const missionary = missionaryResult.data?.find(m => m.id === missionaryId);
          if (missionary) {
            console.log(`${missionary.full_name}: ${currentMonthAmount} (${(currentMonthAmount / missionary.monthly_goal) * 100}%)`);
          }
        }
      });

      console.log('\n=== Final Data ===');
      console.log('Setting data with:');
      console.log('- Missionaries:', missionaryResult.data?.length);
      console.log('- Churches:', churchResult.data?.length);
      console.log('- Donations:', enrichedDonations.length);
      console.log('- Below 80% count:', below80Count);
      console.log('- Enriched Donors:', enrichedDonors.length);
      console.log('Sample enriched donors before setState:', enrichedDonors.slice(0, 3));

      // Verify enrichedDonors has the expected shape
      if (enrichedDonors.length > 0) {
        console.log('First enriched donor structure:', JSON.stringify(enrichedDonors[0], null, 2));
      }

      // Create the data object and verify its structure
      const newData: ReportsData = {
        missionaries: missionaryResult.data || [],
        churches: churchResult.data || [],
        donations: enrichedDonations,
        donationMap: dMap,
        thirteenMonthKeys: generateThirteenMonthKeys(),
        totalDonationsThisMonth,
        currentPercentAllMissionaries: currentPercentage,
        lastMonthPercentAllMissionaries: lastMonthPercentage,
        countBelow80LastMonth: below80Count,
        enrichedDonors
      };

      console.log('\n=== State Update Details ===');
      console.log('Enriched donors before update:', {
        length: enrichedDonors.length,
        sample: enrichedDonors.slice(0, 2)
      });
      console.log('New data enriched donors:', {
        length: newData.enrichedDonors.length,
        sample: newData.enrichedDonors.slice(0, 2)
      });

      setData(prevData => {
        console.log('State Update:', {
          prevState: {
            enrichedDonorsLength: prevData.enrichedDonors.length,
            donationsLength: prevData.donations.length,
            samplePrevDonor: prevData.enrichedDonors[0]
          },
          newState: {
            enrichedDonorsLength: newData.enrichedDonors.length,
            donationsLength: newData.donations.length,
            sampleNewDonor: newData.enrichedDonors[0]
          }
        });
        return newData;
      });

      setIsLoading(false);
    } catch (err: any) {
      console.error("loadData error:", err);
      setError(err.message || "Unknown error");
      setIsLoading(false);
    }
  };

  useEffect(() => {
    console.log('useEffect triggered');
    loadData();
  }, []); // Keep dependency array empty as this should only run once

  return { isLoading, error, data, loadData };
}; 