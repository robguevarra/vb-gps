"use client";

import { createClient } from "@/utils/supabase/client";
import { useEffect, useState } from "react";
import { Profile } from "@/types";
import { MissionariesTable } from "@/components/reports/MissionariesTable";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatNumber } from "@/utils/numbers";
import { MissionaryLast6Modal, FullMissionaryReportModal } from "@/components/MissionaryModals";

interface ChurchReportsTabProps {
  churchIds: number[];
}

interface Donor {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

interface Donation {
  id: string;
  missionary_id: string;
  donor_id: string;
  date: string;
  amount: number;
  status: string;
  source: string;
  notes?: string;
  donors: Donor;
}

type DonationMap = Record<string, Record<string, number>>;

export function ChurchReportsTab({ churchIds }: ChurchReportsTabProps) {
  const supabase = createClient();
  const [missionaries, setMissionaries] = useState<Profile[]>([]);
  const [donationMap, setDonationMap] = useState<DonationMap>({});
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [missionaryFilter, setMissionaryFilter] = useState("");
  const [missionaryPage, setMissionaryPage] = useState(1);
  const [selectedMissionary, setSelectedMissionary] = useState<Profile | null>(null);
  const [showMissionaryModal, setShowMissionaryModal] = useState(false);
  const [showFullReportModal, setShowFullReportModal] = useState(false);
  const pageSize = 10;
  const [donations, setDonations] = useState<Donation[]>([]);
  const [thirteenMonthKeys, setThirteenMonthKeys] = useState<string[]>([]);

  const getCurrentMonthRatio = (m: Profile) => {
    const currentDate = new Date();
    const year = currentDate.getFullYear();
    const month = String(currentDate.getMonth() + 1).padStart(2, "0");
    const key = `${year}-${month}`;
    const donated = donationMap[m.id]?.[key] || 0;
    const goal = m.monthly_goal || 0;
    return goal > 0 ? (donated / goal) * 100 : 0;
  };

  const getLastXMonthsRatios = (m: Profile, x: number) => {
    const out: { label: string; ratio: number }[] = [];
    const currentDate = new Date();
    let year = currentDate.getFullYear();
    let month = currentDate.getMonth();
    
    for (let i = 0; i < x; i++) {
      const label = `${year}-${String(month + 1).padStart(2, "0")}`;
      const donated = donationMap[m.id]?.[label] || 0;
      const monthlyGoal = m.monthly_goal || 0;
      const ratio = monthlyGoal > 0 ? (donated / monthlyGoal) * 100 : 0;
      out.push({ label, ratio });
      
      month--;
      if (month < 0) {
        month = 11;
        year--;
      }
    }
    return out.reverse();
  };

  useEffect(() => {
    const loadData = async () => {
      try {
        const { data: { session } } = await supabase.auth.getSession();
        const currentUserId = session?.user?.id;

        if (!currentUserId) {
          throw new Error('User not authenticated');
        }

        if (churchIds.length === 0) {
          setMissionaries([]);
          setIsLoading(false);
          return;
        }

        const { data: missionariesData, error: missionariesError } = await supabase
          .from('profiles')
          .select('*')
          .in('local_church_id', churchIds)
          .neq('id', currentUserId)
          .in('role', ['missionary', 'campus_director']);

        if (missionariesError) throw missionariesError;
        
        console.log('Fetched missionaries:', missionariesData);
        setMissionaries(missionariesData || []);

        const { data: donationsData, error: donationsError } = await supabase
          .from('donor_donations')
          .select('id, missionary_id, donor_id, date, amount, status, source, notes, donors(id, name, email, phone)')
          .in('missionary_id', missionariesData?.map(m => m.id) || []);

        if (donationsError) throw donationsError;

        const newDonationMap: DonationMap = {};
        const typedDonations = (donationsData || []).map(donation => ({
          ...donation,
          donors: Array.isArray(donation.donors) ? donation.donors[0] : donation.donors
        })) as Donation[];
        
        typedDonations.forEach((donation) => {
          if (!newDonationMap[donation.missionary_id]) {
            newDonationMap[donation.missionary_id] = {};
          }
          const donationDate = new Date(donation.date);
          const year = donationDate.getFullYear();
          const month = String(donationDate.getMonth() + 1).padStart(2, "0");
          const key = `${year}-${month}`;
          newDonationMap[donation.missionary_id][key] = 
            (newDonationMap[donation.missionary_id][key] || 0) + (donation.amount || 0);
        });
        
        setDonationMap(newDonationMap);
        setDonations(typedDonations);

        const monthKeys: string[] = [];
        const currentDate = new Date();
        let year = currentDate.getFullYear();
        let month = currentDate.getMonth();
        
        for (let i = 0; i < 13; i++) {
          const key = `${year}-${String(month + 1).padStart(2, "0")}`;
          monthKeys.push(key);
          month--;
          if (month < 0) {
            month = 11;
            year--;
          }
        }
        setThirteenMonthKeys(monthKeys.reverse());

      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : 'An unexpected error occurred';
        console.error('Error loading missionaries:', error);
        setError(errorMessage);
      } finally {
        setIsLoading(false);
      }
    };
    loadData();
  }, [churchIds, supabase]);

  const openMissionaryModal = (m: Profile) => {
    setSelectedMissionary(m);
    setShowMissionaryModal(true);
  };

  const openFullMissionaryReport = (m: Profile) => {
    setSelectedMissionary(m);
    setShowFullReportModal(true);
  };

  return (
    <Card className="border shadow-sm mt-8">
      <CardHeader>
        <CardTitle>Church Missionary Reports</CardTitle>
      </CardHeader>
      <CardContent>
        {isLoading && <p>Loading missionaries...</p>}
        {error && <p className="text-red-500">{error}</p>}
        
        {!isLoading && !error && (
          <MissionariesTable
            missionaries={missionaries}
            missionaryFilter={missionaryFilter}
            setMissionaryFilter={setMissionaryFilter}
            missionaryPage={missionaryPage}
            setMissionaryPage={setMissionaryPage}
            pageSize={pageSize}
            openMissionaryModal={openMissionaryModal}
            openFullMissionaryReport={openFullMissionaryReport}
            getCurrentMonthRatio={getCurrentMonthRatio}
            formatNumber={formatNumber}
          />
        )}
      </CardContent>

      <MissionaryLast6Modal
        isOpen={showMissionaryModal}
        onClose={() => setShowMissionaryModal(false)}
        missionary={selectedMissionary}
        getLastXMonthsRatios={getLastXMonthsRatios}
        formatNumber={formatNumber}
      />

      <FullMissionaryReportModal
        isOpen={showFullReportModal}
        onClose={() => setShowFullReportModal(false)}
        missionary={selectedMissionary}
        donations={donations}
        thirteenMonthKeys={thirteenMonthKeys}
        formatNumber={formatNumber}
      />
    </Card>
  );
} 