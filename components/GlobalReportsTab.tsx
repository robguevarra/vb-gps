"use client";

import { useState, useEffect } from "react";
import { createClient } from "@/utils/supabase/client";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Separator } from "@/components/ui/separator";
import { Loader2 } from "lucide-react";

// ------------------------------------------------------------------
// TYPES
// ------------------------------------------------------------------
interface Profile {
  id: string;
  full_name: string;
  monthly_goal: number;
  local_church_id: number | null;
  role: string;
}

interface Church {
  id: number;
  name: string;
}

interface Donor {
  id: number;
  name: string;
  email: string;
  phone: string;
}

interface DonorDonation {
  id: number;
  missionary_id: string;
  donor_id: number | null;
  date: string; // e.g. 2025-01-15
  amount: number;
  source: string;  // e.g. 'online' or 'offline'
  status: string;  // e.g. 'completed'
  notes: string | null;
  // We'll nest the Donor record if we selected donors(name, email, phone)
  donors?: Donor | null;
}

// For storing monthly aggregates: [missionary_id][YYYY-MM] = sum
type DonationMap = Record<string, Record<string, number>>;

// ------------------------------------------------------------------
// COMPONENT
// ------------------------------------------------------------------
export default function GlobalReportsTab() {
  const supabase = createClient();

  // Loading / Error
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Raw data
  const [missionaries, setMissionaries] = useState<Profile[]>([]);
  const [churches, setChurches] = useState<Church[]>([]);
  const [donations, setDonations] = useState<DonorDonation[]>([]);

  // Aggregates
  const [totalDonationsThisMonth, setTotalDonationsThisMonth] = useState<number>(0);
  const [currentPercentAllMissionaries, setCurrentPercentAllMissionaries] = useState<number>(0);
  const [lastMonthPercentAllMissionaries, setLastMonthPercentAllMissionaries] = useState<number>(0);
  const [countBelow80LastMonth, setCountBelow80LastMonth] = useState<number>(0);

  // We’ll store a dictionary of monthly sums: donationMap[missionary_id][YYYY-MM] => sum
  const [donationMap, setDonationMap] = useState<DonationMap>({});

  // States for modals
  const [selectedMissionary, setSelectedMissionary] = useState<Profile | null>(null);
  const [showMissionaryModal, setShowMissionaryModal] = useState(false);

  const [selectedChurch, setSelectedChurch] = useState<Church | null>(null);
  const [showChurchModal, setShowChurchModal] = useState(false);

  const [showFullMissionaryReport, setShowFullMissionaryReport] = useState(false);

  useEffect(() => {
    fetchReportData();
  }, []);

  // ------------------------------------------------------------------
  // FETCH DATA
  // ------------------------------------------------------------------
  async function fetchReportData() {
    try {
      setIsLoading(true);
      setError(null);

      // 1) Fetch all missionaries (or campus directors if they are also 'missionaries')
      //    We'll consider both "role = missionary" and "role = campus_director" if you want them included.
      const { data: missionaryData, error: missionaryError } = await supabase
        .from("profiles")
        .select("id, full_name, monthly_goal, local_church_id, role")
        .or("role.eq.missionary,role.eq.campus_director"); 
      if (missionaryError) throw missionaryError;

      // 2) Fetch all churches
      const { data: churchesData, error: churchError } = await supabase
        .from("local_churches")
        .select("id, name")
        .order("name", { ascending: true });
      if (churchError) throw churchError;

      // 3) We'll pull the last 13 months of donor_donations (to handle everything we need).
      const thirteenMonthsAgo = new Date();
      thirteenMonthsAgo.setMonth(thirteenMonthsAgo.getMonth() - 13);
      const { data: donationsData, error: donationsError } = await supabase
        .from("donor_donations")
        .select("id, missionary_id, donor_id, date, amount, status, source, notes, donors(id, name, email, phone)")
        .gte("date", thirteenMonthsAgo.toISOString()); 
      if (donationsError) throw donationsError;

      // Store raw data
      setMissionaries(missionaryData || []);
      setChurches(churchesData || []);
      setDonations(donationsData || []);

      // ----------------------------------------------------------------
      // BUILD donationMap => { missionary_id => { 'YYYY-MM' => sum } }
      // ----------------------------------------------------------------
      const map: DonationMap = {};
      (donationsData || []).forEach((don) => {
        const mId = don.missionary_id;
        if (!map[mId]) map[mId] = {};
        const d = new Date(don.date);
        const yyyy = d.getFullYear();
        const mm = String(d.getMonth() + 1).padStart(2, "0");
        const key = `${yyyy}-${mm}`;
        map[mId][key] = (map[mId][key] || 0) + (don.amount || 0);
      });
      setDonationMap(map);

      // ----------------------------------------------------------------
      // Compute the four top metrics
      // ----------------------------------------------------------------
      // A) total donations for current month
      const now = new Date();
      const curYear = now.getFullYear();
      const curMonth = now.getMonth(); // 0..11
      const currentMonthKey = `${curYear}-${String(curMonth + 1).padStart(2, "0")}`;

      let totalThisMonth = 0;
      missionaries?.forEach((m) => {
        if (map[m.id] && map[m.id][currentMonthKey]) {
          totalThisMonth += map[m.id][currentMonthKey];
        }
      });
      setTotalDonationsThisMonth(totalThisMonth);

      // B) current total % of all missionaries (their current donations vs salary goal)
      //    sum all monthly_goal across the missionaries, compare to totalThisMonth
      let sumOfGoals = 0;
      missionaries?.forEach((m) => {
        sumOfGoals += Number(m.monthly_goal || 0);
      });
      const currentMonthPercent = sumOfGoals > 0 ? (totalThisMonth / sumOfGoals) * 100 : 0;
      setCurrentPercentAllMissionaries(currentMonthPercent);

      // C) last month’s total %
      //    We find lastMonthKey
      let lastMonthYear = curYear;
      let lastMonthValue = curMonth - 1;
      if (lastMonthValue < 0) {
        lastMonthValue = 11; // December
        lastMonthYear = curYear - 1;
      }
      const lastMonthKey = `${lastMonthYear}-${String(lastMonthValue + 1).padStart(2, "0")}`;
      let totalLastMonth = 0;
      missionaries?.forEach((m) => {
        if (map[m.id] && map[m.id][lastMonthKey]) {
          totalLastMonth += map[m.id][lastMonthKey];
        }
      });
      const lastMonthPercent = sumOfGoals > 0 ? (totalLastMonth / sumOfGoals) * 100 : 0;
      setLastMonthPercentAllMissionaries(lastMonthPercent);

      // D) number of missionaries who fell below 80% last month
      //    For each missionary => if lastMonthDonations < 0.8 * monthly_goal => increment
      let below80Count = 0;
      missionaries?.forEach((m) => {
        const mg = Number(m.monthly_goal || 0);
        const donated = map[m.id]?.[lastMonthKey] || 0;
        if (mg > 0) {
          const ratio = donated / mg;
          if (ratio < 0.8) {
            below80Count++;
          }
        }
      });
      setCountBelow80LastMonth(below80Count);

      setIsLoading(false);
    } catch (err: any) {
      setIsLoading(false);
      console.error("Error in fetchReportData:", err);
      setError(err.message || "Unknown error");
    }
  }

  // ------------------------------------------------------------------
  // HELPERS
  // ------------------------------------------------------------------
  function formatNumber(num: number, fractionDigits = 2) {
    return num.toLocaleString(undefined, {
      minimumFractionDigits: fractionDigits,
      maximumFractionDigits: fractionDigits,
    });
  }

  // Returns donations for a given missionary in a given (year, month) 0-based month
  function getDonationForMissionary(mId: string, year: number, monthIndex: number): number {
    const mm = String(monthIndex + 1).padStart(2, "0");
    const key = `${year}-${mm}`;
    return donationMap[mId]?.[key] || 0;
  }

  // For “current month %” for a single missionary
  function getCurrentMonthRatio(m: Profile): number {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth();
    const donated = getDonationForMissionary(m.id, year, month);
    const goal = Number(m.monthly_goal || 0);
    if (goal === 0) return 0;
    return (donated / goal) * 100;
  }

  // For last 3 or 6 months data
  // e.g. getLastXMonthsRatios(m, 6) => array of { label: 'YYYY-MM', ratio: 0..100 }
  function getLastXMonthsRatios(m: Profile, months: number) {
    const result: { label: string; ratio: number }[] = [];
    const now = new Date();
    let year = now.getFullYear();
    let month = now.getMonth(); // 0..11
    for (let i = 0; i < months; i++) {
      const label = `${year}-${String(month + 1).padStart(2, "0")}`;
      const donated = getDonationForMissionary(m.id, year, month);
      const goal = Number(m.monthly_goal || 0);
      const ratio = goal > 0 ? (donated / goal) * 100 : 0;
      result.push({ label, ratio });

      // Move to previous month
      month--;
      if (month < 0) {
        month = 11;
        year--;
      }
    }
    // Reverse so the oldest is first
    return result.reverse();
  }

  // Summation for a church’s missionaries in a given (year, month)
  function getDonationForChurch(cId: number, year: number, monthIndex: number): number {
    let sum = 0;
    missionaries
      .filter((m) => m.local_church_id === cId)
      .forEach((m) => {
        sum += getDonationForMissionary(m.id, year, monthIndex);
      });
    return sum;
  }

  // Church’s total monthly goal => sum of all missionaries in that church
  function getChurchMonthlyGoal(cId: number): number {
    let sum = 0;
    missionaries
      .filter((m) => m.local_church_id === cId)
      .forEach((m) => {
        sum += Number(m.monthly_goal || 0);
      });
    return sum;
  }

  // ------------------------------------------------------------------
  // UI EVENT HANDLERS
  // ------------------------------------------------------------------
  function openMissionaryModal(m: Profile) {
    setSelectedMissionary(m);
    setShowMissionaryModal(true);
  }
  function closeMissionaryModal() {
    setSelectedMissionary(null);
    setShowMissionaryModal(false);
  }

  function openChurchModal(ch: Church) {
    setSelectedChurch(ch);
    setShowChurchModal(true);
  }
  function closeChurchModal() {
    setSelectedChurch(null);
    setShowChurchModal(false);
  }

  function openFullReportModal(m: Profile) {
    setSelectedMissionary(m);
    setShowFullMissionaryReport(true);
  }
  function closeFullReportModal() {
    setSelectedMissionary(null);
    setShowFullMissionaryReport(false);
  }

  // ------------------------------------------------------------------
  // RENDER
  // ------------------------------------------------------------------
  // The top-level 4 cards
  function renderTopCards() {
    return (
      <div className="grid gap-4 md:grid-cols-4">
        {/* 1) total donations for current month */}
        <Card className="border shadow-sm">
          <CardHeader>
            <CardTitle className="text-sm">Total Donations (This Month)</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold">
              ${formatNumber(totalDonationsThisMonth)}
            </p>
          </CardContent>
        </Card>

        {/* 2) current total % of all missionaries */}
        <Card className="border shadow-sm">
          <CardHeader>
            <CardTitle className="text-sm">Current Total %</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold">
              {formatNumber(currentPercentAllMissionaries)}%
            </p>
          </CardContent>
        </Card>

        {/* 3) last month's total % */}
        <Card className="border shadow-sm">
          <CardHeader>
            <CardTitle className="text-sm">Last Month’s Total %</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold">
              {formatNumber(lastMonthPercentAllMissionaries)}%
            </p>
          </CardContent>
        </Card>

        {/* 4) Number of missionaries under 80% last month */}
        <Card className="border shadow-sm">
          <CardHeader>
            <CardTitle className="text-sm">Below 80% Last Month</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold">
              {countBelow80LastMonth}
            </p>
          </CardContent>
        </Card>
      </div>
    );
  }

  // A table of all missionaries with their current-month %
  function renderMissionariesTable() {
    return (
      <div className="mt-8">
        <h2 className="text-xl font-semibold mb-2">All Missionaries</h2>
        <div className="overflow-x-auto border rounded-md">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-gray-50 dark:bg-gray-800">
              <tr>
                <th className="px-4 py-2 border-b">Name</th>
                <th className="px-4 py-2 border-b">Role</th>
                <th className="px-4 py-2 border-b">Monthly Goal</th>
                <th className="px-4 py-2 border-b">Current %</th>
                <th className="px-4 py-2 border-b">Actions</th>
              </tr>
            </thead>
            <tbody>
              {missionaries.map((m) => {
                const ratio = getCurrentMonthRatio(m);
                return (
                  <tr key={m.id}>
                    <td className="px-4 py-2 border-b">{m.full_name}</td>
                    <td className="px-4 py-2 border-b">{m.role}</td>
                    <td className="px-4 py-2 border-b">${m.monthly_goal}</td>
                    <td className="px-4 py-2 border-b">
                      {formatNumber(ratio)}%
                    </td>
                    <td className="px-4 py-2 border-b">
                      <div className="flex gap-2">
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => openMissionaryModal(m)}
                        >
                          Last 6 Months
                        </Button>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => openFullReportModal(m)}
                        >
                          Full Report
                        </Button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    );
  }

  // A table of all churches with their current-month %
  function renderChurchesTable() {
    return (
      <div className="mt-8">
        <h2 className="text-xl font-semibold mb-2">All Churches</h2>
        <div className="overflow-x-auto border rounded-md">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-gray-50 dark:bg-gray-800">
              <tr>
                <th className="px-4 py-2 border-b">Church</th>
                <th className="px-4 py-2 border-b">Monthly Goal (Sum)</th>
                <th className="px-4 py-2 border-b">Current %</th>
                <th className="px-4 py-2 border-b">Actions</th>
              </tr>
            </thead>
            <tbody>
              {churches.map((ch) => {
                const now = new Date();
                const cyear = now.getFullYear();
                const cmonth = now.getMonth();
                const donation = getDonationForChurch(ch.id, cyear, cmonth);
                const goal = getChurchMonthlyGoal(ch.id);
                const ratio = goal > 0 ? (donation / goal) * 100 : 0;

                return (
                  <tr key={ch.id}>
                    <td className="px-4 py-2 border-b">{ch.name}</td>
                    <td className="px-4 py-2 border-b">${formatNumber(goal)}</td>
                    <td className="px-4 py-2 border-b">{formatNumber(ratio)}%</td>
                    <td className="px-4 py-2 border-b">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => openChurchModal(ch)}
                      >
                        View Details
                      </Button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    );
  }

  // ------------------------------------------------------------------
  // MISSIONARY DETAIL MODAL (Last 6 Months %)
  // ------------------------------------------------------------------
  function renderMissionaryModal() {
    if (!selectedMissionary) return null;
    const last6 = getLastXMonthsRatios(selectedMissionary, 6);

    return (
      <Dialog open={showMissionaryModal} onOpenChange={closeMissionaryModal}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>
              Last 6 Months for {selectedMissionary.full_name}
            </DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <table className="min-w-full text-left text-sm border">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 border-b">Month</th>
                  <th className="px-4 py-2 border-b">% of Goal</th>
                </tr>
              </thead>
              <tbody>
                {last6.map((item) => (
                  <tr key={item.label}>
                    <td className="px-4 py-2 border-b">{item.label}</td>
                    <td className="px-4 py-2 border-b">
                      {formatNumber(item.ratio)}%
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </DialogContent>
      </Dialog>
    );
  }

  // ------------------------------------------------------------------
  // CHURCH DETAIL MODAL (Last 3 months + current month for each missionary)
  // ------------------------------------------------------------------
  function renderChurchModal() {
    if (!selectedChurch) return null;

    // Identify all missionaries that belong to this church
    const churchMissionaries = missionaries.filter(
      (m) => m.local_church_id === selectedChurch.id
    );

    // We'll look at the last 3 months + current => 4 columns total
    // Build an array of {year, monthIndex, label} for these 4
    const now = new Date();
    const set: { year: number; month: number; label: string }[] = [];
    for (let i = 0; i < 4; i++) {
      const y = now.getFullYear();
      const mo = now.getMonth() - i; // go back i months
      const d = new Date(y, mo, 1);
      const label = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}`;
      set.push({ year: d.getFullYear(), month: d.getMonth(), label });
    }
    set.reverse(); // oldest first

    return (
      <Dialog open={showChurchModal} onOpenChange={closeChurchModal}>
        <DialogContent className="max-w-4xl">
          <DialogHeader>
            <DialogTitle>
              {selectedChurch.name} - Last 3 Months + Current
            </DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <table className="min-w-full text-left text-sm border">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 border-b">Missionary</th>
                  {set.map((col) => (
                    <th key={col.label} className="px-4 py-2 border-b">
                      {col.label}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {churchMissionaries.map((m) => {
                  return (
                    <tr key={m.id}>
                      <td className="px-4 py-2 border-b">{m.full_name}</td>
                      {set.map((col) => {
                        const donated = getDonationForMissionary(m.id, col.year, col.month);
                        const goal = m.monthly_goal || 0;
                        const ratio = goal > 0 ? (donated / goal) * 100 : 0;
                        const below80 = ratio < 80;
                        return (
                          <td
                            key={col.label}
                            className={`px-4 py-2 border-b ${
                              below80 ? "text-red-600 font-semibold" : ""
                            }`}
                          >
                            {formatNumber(ratio)}%
                          </td>
                        );
                      })}
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </DialogContent>
      </Dialog>
    );
  }

  // ------------------------------------------------------------------
  // FULL MISSIONARY REPORT MODAL
  // Shows 1) All partners (donors) who gave in the last 13 months
  //        2) Last 13 months donation history
  // ------------------------------------------------------------------
  function renderFullMissionaryReport() {
    if (!selectedMissionary) return null;

    // Filter all donations for this missionary
    const missionaryDonations = donations.filter(
      (d) => d.missionary_id === selectedMissionary.id
    );

    // Build a monthly timeline for last 13 months
    const timeline: { label: string; total: number }[] = [];
    const now = new Date();
    let year = now.getFullYear();
    let month = now.getMonth();
    for (let i = 0; i < 13; i++) {
      const key = `${year}-${String(month + 1).padStart(2, "0")}`;
      // sum from donationMap
      const donated = donationMap[selectedMissionary.id]?.[key] || 0;
      timeline.push({ label: key, total: donated });

      // move to previous month
      month--;
      if (month < 0) {
        month = 11;
        year--;
      }
    }
    timeline.reverse(); // oldest first

    // Gather partner (donor) info: group by donor_id
    // We'll show each donor's total in that 13-month range
    const donorSums: Record<number, number> = {};
    missionaryDonations.forEach((don) => {
      if (!don.donor_id) return;
      if (!donorSums[don.donor_id]) donorSums[don.donor_id] = 0;
      donorSums[don.donor_id] += don.amount;
    });
    // Build an array to display
    const partnerList = Object.keys(donorSums).map((donorIdStr) => {
      const donorId = Number(donorIdStr);
      const donation = donorSums[donorId];
      // find the donor in the donation
      // many donation rows might have the same donor, so let's find the first that matches
      const row = missionaryDonations.find((r) => r.donor_id === donorId);
      const donor = row?.donors;
      return {
        donorId,
        name: donor?.name || "Unknown",
        email: donor?.email || "",
        phone: donor?.phone || "",
        total: donation,
      };
    });

    return (
      <Dialog
        open={showFullMissionaryReport}
        onOpenChange={closeFullReportModal}
        className="overflow-auto"
      >
        <DialogContent className="max-w-4xl">
          <DialogHeader>
            <DialogTitle>
              Full Report - {selectedMissionary.full_name}
            </DialogTitle>
          </DialogHeader>
          <div className="space-y-6">
            {/* PART A: Partners */}
            <div>
              <h3 className="text-lg font-semibold mb-2">Partners (Last 13 Months)</h3>
              {partnerList.length === 0 ? (
                <p className="text-sm text-gray-500">No donor data found.</p>
              ) : (
                <div className="overflow-x-auto border rounded-md">
                  <table className="min-w-full text-left text-sm">
                    <thead className="bg-gray-50">
                      <tr>
                        <th className="px-4 py-2 border-b">Name</th>
                        <th className="px-4 py-2 border-b">Email</th>
                        <th className="px-4 py-2 border-b">Phone</th>
                        <th className="px-4 py-2 border-b">Total Given</th>
                      </tr>
                    </thead>
                    <tbody>
                      {partnerList.map((p) => (
                        <tr key={p.donorId}>
                          <td className="px-4 py-2 border-b">{p.name}</td>
                          <td className="px-4 py-2 border-b">{p.email}</td>
                          <td className="px-4 py-2 border-b">{p.phone}</td>
                          <td className="px-4 py-2 border-b">
                            ${formatNumber(p.total)}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>

            <Separator />

            {/* PART B: 13-month timeline */}
            <div>
              <h3 className="text-lg font-semibold mb-2">Last 13 Months Donation History</h3>
              <div className="overflow-x-auto border rounded-md">
                <table className="min-w-full text-left text-sm">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-4 py-2 border-b">Month</th>
                      <th className="px-4 py-2 border-b">Donation</th>
                    </tr>
                  </thead>
                  <tbody>
                    {timeline.map((t) => (
                      <tr key={t.label}>
                        <td className="px-4 py-2 border-b">{t.label}</td>
                        <td className="px-4 py-2 border-b">
                          ${formatNumber(t.total)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>

          </div>
        </DialogContent>
      </Dialog>
    );
  }

  // ------------------------------------------------------------------
  // MAIN RENDER
  // ------------------------------------------------------------------
  return (
    <Card className="border shadow-sm">
      <CardHeader>
        <CardTitle>Comprehensive Global Reports</CardTitle>
      </CardHeader>
      <CardContent>
        {isLoading && (
          <div className="flex items-center gap-2 text-sm text-gray-500 mb-4">
            <Loader2 className="w-4 h-4 animate-spin" />
            Loading data...
          </div>
        )}
        {error && (
          <p className="text-sm text-red-600 mb-4">Error: {error}</p>
        )}

        {!isLoading && !error && (
          <>
            {/* TOP 4 CARDS */}
            {renderTopCards()}

            <Separator className="my-6" />

            {/* TABLE OF MISSIONARIES */}
            {renderMissionariesTable()}

            {/* TABLE OF CHURCHES */}
            {renderChurchesTable()}
          </>
        )}
      </CardContent>

      {/* MODALS */}
      {renderMissionaryModal()}
      {renderChurchModal()}
      {renderFullMissionaryReport()}
    </Card>
  );
}
