"use client";

import { createClient } from "@/utils/supabase/client";
import { useEffect, useState } from "react";
import { Profile } from "@/types";
import { MissionariesTable } from "@/components/reports/MissionariesTable";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { formatNumber } from "@/utils/numbers";
import { MissionaryLast6Modal, FullMissionaryReportModal } from "@/components/MissionaryModals";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Users, TrendingUp, Target, AlertTriangle } from "lucide-react";

// Simple Skeleton component for loading states
function Skeleton({ className, ...props }: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      className={`animate-pulse rounded-md bg-muted ${className || ''}`}
      {...props}
    />
  );
}

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

  // Calculate summary metrics
  const calculateSummaryMetrics = () => {
    if (missionaries.length === 0) return null;
    
    // Calculate total monthly goal across all missionaries
    const totalMonthlyGoal = missionaries.reduce((sum, m) => sum + (m.monthly_goal || 0), 0);
    
    // Calculate current month's total donations
    const now = new Date();
    const y = now.getFullYear();
    const mo = now.getMonth();
    const currentMonthKey = `${y}-${String(mo + 1).padStart(2, "0")}`;
    
    let currentMonthTotal = 0;
    missionaries.forEach(m => {
      currentMonthTotal += donationMap[m.id]?.[currentMonthKey] || 0;
    });
    
    // Calculate overall percentage
    const overallPercentage = totalMonthlyGoal > 0 ? (currentMonthTotal / totalMonthlyGoal) * 100 : 0;
    
    // Count missionaries below 80% target
    const belowTargetCount = missionaries.filter(m => getCurrentMonthRatio(m) < 80).length;
    
    return {
      totalMonthlyGoal,
      currentMonthTotal,
      overallPercentage,
      belowTargetCount,
      missionaryCount: missionaries.length
    };
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

  const summaryMetrics = calculateSummaryMetrics();

  return (
    <div className="space-y-6">
      <Card className="border shadow-sm">
        <CardHeader className="pb-2">
          <CardTitle className="text-xl flex items-center gap-2">
            Staff Performance Dashboard
          </CardTitle>
          <CardDescription>
            Comprehensive view of missionary performance across your churches
          </CardDescription>
        </CardHeader>
        
        {isLoading ? (
          <CardContent>
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4">
              {[1, 2, 3, 4].map(i => (
                <div key={i} className="space-y-2">
                  <Skeleton className="h-4 w-1/2" />
                  <Skeleton className="h-8 w-3/4" />
                </div>
              ))}
            </div>
          </CardContent>
        ) : error ? (
          <CardContent>
            <div className="p-4 rounded-lg bg-destructive/10 text-destructive flex items-center gap-2">
              <AlertTriangle className="h-5 w-5" />
              <p>{error}</p>
            </div>
          </CardContent>
        ) : summaryMetrics ? (
          <CardContent>
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4">
              <div className="bg-muted/50 p-4 rounded-lg">
                <div className="flex items-center gap-2 text-muted-foreground mb-1">
                  <Users className="h-4 w-4" />
                  <span className="text-sm font-medium">Total Missionaries</span>
                </div>
                <p className="text-2xl font-bold">{summaryMetrics.missionaryCount}</p>
              </div>
              
              <div className="bg-muted/50 p-4 rounded-lg">
                <div className="flex items-center gap-2 text-muted-foreground mb-1">
                  <Target className="h-4 w-4" />
                  <span className="text-sm font-medium">Monthly Goal</span>
                </div>
                <p className="text-2xl font-bold">₱{formatNumber(summaryMetrics.totalMonthlyGoal)}</p>
              </div>
              
              <div className="bg-muted/50 p-4 rounded-lg">
                <div className="flex items-center gap-2 text-muted-foreground mb-1">
                  <TrendingUp className="h-4 w-4" />
                  <span className="text-sm font-medium">Current Month</span>
                </div>
                <div className="flex items-center gap-2 flex-wrap">
                  <p className="text-2xl font-bold">₱{formatNumber(summaryMetrics.currentMonthTotal)}</p>
                  <Badge variant={summaryMetrics.overallPercentage >= 80 ? "default" : "destructive"}>
                    {formatNumber(summaryMetrics.overallPercentage)}%
                  </Badge>
                </div>
              </div>
              
              <div className="bg-muted/50 p-4 rounded-lg">
                <div className="flex items-center gap-2 text-muted-foreground mb-1">
                  <AlertTriangle className="h-4 w-4" />
                  <span className="text-sm font-medium">Below Target</span>
                </div>
                <div className="flex items-center gap-2">
                  <p className="text-2xl font-bold">{summaryMetrics.belowTargetCount}</p>
                  <Badge variant="outline" className="text-muted-foreground">
                    {summaryMetrics.belowTargetCount > 0 
                      ? `${Math.round((summaryMetrics.belowTargetCount / summaryMetrics.missionaryCount) * 100)}%` 
                      : '0%'}
                  </Badge>
                </div>
              </div>
            </div>
          </CardContent>
        ) : null}
      </Card>

      <Tabs defaultValue="missionaries" className="space-y-4">
        <TabsList className="w-full sm:w-auto flex">
          <TabsTrigger value="missionaries" className="flex-1 sm:flex-initial">
            Missionary Performance
          </TabsTrigger>
          <TabsTrigger value="trends" className="flex-1 sm:flex-initial">
            Trends & Analysis
          </TabsTrigger>
        </TabsList>
        
        <TabsContent value="missionaries" className="space-y-4">
          {isLoading ? (
            <div className="space-y-4">
              <Skeleton className="h-8 w-64" />
              <Skeleton className="h-[400px] w-full" />
            </div>
          ) : error ? (
            <div className="p-4 rounded-lg bg-destructive/10 text-destructive">
              {error}
            </div>
          ) : missionaries.length === 0 ? (
            <div className="p-8 text-center border rounded-lg bg-muted/30">
              <Users className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
              <h3 className="text-lg font-medium mb-2">No missionaries found</h3>
              <p className="text-muted-foreground">There are no missionaries assigned to your churches yet.</p>
            </div>
          ) : (
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
        </TabsContent>
        
        <TabsContent value="trends" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Performance Trends</CardTitle>
              <CardDescription>
                This section will show trends and analysis of missionary performance over time.
              </CardDescription>
            </CardHeader>
            <CardContent className="h-[300px] flex items-center justify-center text-muted-foreground">
              Trends analysis coming soon
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

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
    </div>
  );
} 