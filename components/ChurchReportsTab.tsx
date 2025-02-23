"use client";

import { createClient } from "@/utils/supabase/client";
import { useEffect, useState } from "react";
import { Profile } from "@/types";
import { MissionariesTable } from "@/components/reports/MissionariesTable";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatNumber } from "@/utils/numbers";
import { useUser } from "@supabase/auth-helpers-react";
import { MissionaryLast6Modal, FullMissionaryReportModal } from "@/components/MissionaryModals";

interface ChurchReportsTabProps {
  churchIds: number[];
}

export function ChurchReportsTab({ churchIds }: ChurchReportsTabProps) {
  const supabase = createClient();
  const [missionaries, setMissionaries] = useState<Profile[]>([]);
  const [donationMap, setDonationMap] = useState<Record<string, Record<string, number>>>({});
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [missionaryFilter, setMissionaryFilter] = useState("");
  const [missionaryPage, setMissionaryPage] = useState(1);
  const [selectedMissionary, setSelectedMissionary] = useState<Profile | null>(null);
  const [showMissionaryModal, setShowMissionaryModal] = useState(false);
  const [showFullReportModal, setShowFullReportModal] = useState(false);
  const pageSize = 10;
  const [donations, setDonations] = useState<any[]>([]);
  const [thirteenMonthKeys, setThirteenMonthKeys] = useState<string[]>([]);

  // Move ratio calculation outside useEffect
  const getCurrentMonthRatio = (m: Profile) => {
    const now = new Date();
    const y = now.getFullYear();
    const mo = now.getMonth();
    const key = `${y}-${String(mo + 1).padStart(2, "0")}`;
    const donated = donationMap[m.id]?.[key] || 0;
    const goal = m.monthly_goal || 0;
    return goal > 0 ? (donated / goal) * 100 : 0;
  };

  const getLastXMonthsRatios = (m: Profile, x: number) => {
    const out: { label: string; ratio: number }[] = [];
    let now = new Date();
    let y = now.getFullYear();
    let mo = now.getMonth();
    
    for (let i = 0; i < x; i++) {
      const label = `${y}-${String(mo + 1).padStart(2, "0")}`;
      const donated = donationMap[m.id]?.[label] || 0;
      const mg = m.monthly_goal || 0;
      const ratio = mg > 0 ? (donated / mg) * 100 : 0;
      out.push({ label, ratio });
      
      mo--;
      if (mo < 0) {
        mo = 11;
        y--;
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

        // Only query if we have church IDs
        if (churchIds.length === 0) {
          setMissionaries([]);
          setIsLoading(false);
          return;
        }

        const { data, error } = await supabase
          .from('profiles')
          .select('*')
          .in('local_church_id', churchIds)
          .neq('id', currentUserId)
          .in('role', ['missionary', 'campus_director']);

        if (error) throw error;
        
        console.log('Fetched missionaries:', data);
        setMissionaries(data || []);

        // Fetch and process donations
        const { data: donationsData } = await supabase
          .from('donor_donations')
          .select('id, missionary_id, donor_id, date, amount, status, source, notes, donors(id, name, email, phone)')
          .in('missionary_id', data?.map(m => m.id) || []);

        const newDonationMap: Record<string, Record<string, number>> = {};
        
        donationsData?.forEach((don) => {
          if (!newDonationMap[don.missionary_id]) {
            newDonationMap[don.missionary_id] = {};
          }
          const dateObj = new Date(don.date);
          const yy = dateObj.getFullYear();
          const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
          const key = `${yy}-${mm}`;
          newDonationMap[don.missionary_id][key] = 
            (newDonationMap[don.missionary_id][key] || 0) + (don.amount || 0);
        });
        
        setDonationMap({...newDonationMap});

        // Add donations fetch
        setDonations(donationsData || []);

        // Generate 13 month keys
        const keyArr: string[] = [];
        const now = new Date();
        let y = now.getFullYear();
        let mo = now.getMonth();
        for (let i = 0; i < 13; i++) {
          const kk = `${y}-${String(mo + 1).padStart(2, "0")}`;
          keyArr.push(kk);
          mo--;
          if (mo < 0) {
            mo = 11;
            y--;
          }
        }
        setThirteenMonthKeys(keyArr.reverse());

      } catch (err: any) {
        console.error('Error loading missionaries:', err);
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };
    loadData();
  }, [churchIds, supabase.auth]);

  // Add modal handlers
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

      {/* Add modals */}
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
        donationMap={donationMap}
        thirteenMonthKeys={thirteenMonthKeys}
        formatNumber={formatNumber}
      />
    </Card>
  );
} 