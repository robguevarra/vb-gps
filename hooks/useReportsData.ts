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

      const thirteenMonthsAgo = new Date();
      thirteenMonthsAgo.setMonth(thirteenMonthsAgo.getMonth() - 13);

      // Fetch missionaries and churches
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

      // Fetch donors
      const { data: fetchedDonors, error: donorsError } = await supabase
        .from('donors')
        .select('id, name, email, phone');

      if (donorsError) throw donorsError;

      const uniqueDonors = (fetchedDonors || []).map(d => ({
        id: d.id,
        name: d.name || '',
        email: d.email || '',
        phone: d.phone || ''
      }));

      // Create donors map for quick lookup
      const donorsMap = new Map(uniqueDonors.map(d => [d.id, d]));

      // Fetch all donations
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

      // Process donations with donor info
      const enrichedDonations = allDonations.map(don => ({
        ...don,
        donors: don.donor_id ? donorsMap.get(don.donor_id) : null
      })) as DonorDonation[];

      // Calculate recent donation totals by donor
      const donorDonationsMap = new Map<number, number>();
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

      // Enrich donors with their total donations
      const enrichedDonors = uniqueDonors.map(donor => ({
        ...donor,
        totalGiven: donorDonationsMap.get(donor.id) || 0
      }));

      // Get monthly stats
      const now = new Date();
      const currentMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
      const lastMonthKey = getLastMonthKey();

      const { data: monthlyStats, error: statsError } = await supabase
        .from('missionary_monthly_stats')
        .select('*')
        .in('month', [currentMonth, lastMonthKey]);

      if (statsError) throw statsError;

      // Process monthly stats
      const currentMonthStats = monthlyStats?.filter(s => s.month === currentMonth) || [];
      const lastMonthStats = monthlyStats?.filter(s => s.month === lastMonthKey) || [];

      // Calculate metrics
      const totalDonationsThisMonth = currentMonthStats.reduce((sum, stat) => sum + (stat.total_donations || 0), 0);
      const totalMonthlyGoals = currentMonthStats.reduce((sum, stat) => sum + (stat.monthly_goal || 0), 0);
      const currentPercentage = totalMonthlyGoals > 0 ? (totalDonationsThisMonth / totalMonthlyGoals) * 100 : 0;

      const totalLastMonth = lastMonthStats.reduce((sum, stat) => sum + (stat.total_donations || 0), 0);
      const lastMonthPercentage = totalMonthlyGoals > 0 ? (totalLastMonth / totalMonthlyGoals) * 100 : 0;

      // Count missionaries below 80%
      const below80Count = lastMonthStats.filter(stat => stat.goal_percentage < 80).length;

      // Build donation map
      const dMap: DonationMap = {};
      enrichedDonations
        .filter(don => don.status === 'completed')
        .forEach((don) => {
          if (!dMap[don.missionary_id]) {
            dMap[don.missionary_id] = {};
          }
          const dateObj = new Date(don.date);
          const yy = dateObj.getFullYear();
          const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
          const key = `${yy}-${mm}`;
          dMap[don.missionary_id][key] = (dMap[don.missionary_id][key] || 0) + (don.amount || 0);
        });

      // Add current month data
      currentMonthStats.forEach((stat) => {
        if (!dMap[stat.missionary_id]) {
          dMap[stat.missionary_id] = {};
        }
        dMap[stat.missionary_id][currentMonth] = stat.total_donations || 0;
      });

      setData({
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
      });

      setIsLoading(false);
    } catch (err: any) {
      console.error("loadData error:", err);
      setError(err.message || "Unknown error");
      setIsLoading(false);
    }
  };

  useEffect(() => {
    loadData();
  }, []);

  return { isLoading, error, data, loadData };
}; 