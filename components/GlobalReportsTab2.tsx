"use client";

import { useState, useEffect } from "react";
import { createClient } from "@/utils/supabase/client";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { Loader2 } from "lucide-react";

//
// --------------------------- TYPES ---------------------------
//
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
  date: string;   // "YYYY-MM-DD"
  amount: number;
  source: string; // "online" / "offline"
  status: string; // "completed", etc.
  notes: string | null;
  donors?: Donor | null;
}

type DonationMap = Record<string, Record<string, number>>; 
// donationMap[missionary_id][YYYY-MM] = sum

//
// ----------------------- COMPONENT -----------------------
//
export default function GlobalReportsTab() {
  const supabase = createClient();

  // Loading / Error
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Raw data sets
  const [missionaries, setMissionaries] = useState<Profile[]>([]);
  const [churches, setChurches] = useState<Church[]>([]);
  const [donations, setDonations] = useState<DonorDonation[]>([]);

  // DonationMap => for each missionary, sum of amounts by "YYYY-MM"
  const [donationMap, setDonationMap] = useState<DonationMap>({});

  // Top-level metrics
  const [totalDonationsThisMonth, setTotalDonationsThisMonth] = useState(0);
  const [currentPercentAllMissionaries, setCurrentPercentAllMissionaries] = useState(0);
  const [lastMonthPercentAllMissionaries, setLastMonthPercentAllMissionaries] = useState(0);
  const [countBelow80LastMonth, setCountBelow80LastMonth] = useState(0);

  // Filtering + pagination for "All Missionaries"
  const [missionaryFilter, setMissionaryFilter] = useState("");
  const [missionaryPage, setMissionaryPage] = useState(1);

  // Filtering + pagination for "All Churches"
  const [churchFilter, setChurchFilter] = useState("");
  const [churchPage, setChurchPage] = useState(1);

  // The number of rows per page
  const pageSize = 10;

  // Currently selected missionary or church for the modals
  const [selectedMissionary, setSelectedMissionary] = useState<Profile | null>(null);
  const [showMissionaryModal, setShowMissionaryModal] = useState(false);

  const [selectedChurch, setSelectedChurch] = useState<Church | null>(null);
  const [showChurchModal, setShowChurchModal] = useState(false);

  // For "Full Missionary Report"
  const [showFullMissionaryReport, setShowFullMissionaryReport] = useState(false);

  // For the big "partners vs months" table in the Full Missionary Report
  // We'll track the partner page in top-level state to avoid Hook ordering issues
  const [partnerPage, setPartnerPage] = useState(1);

  // We'll also store the 13 month keys (YYYY-MM) once at the top
  const [thirteenMonthKeys, setThirteenMonthKeys] = useState<string[]>([]);

  // ----------------------------------------------
  // On mount, load data
  // ----------------------------------------------
  useEffect(() => {
    loadData();
  }, []);

  // If we switch missionaries in the Full Report, reset partner pagination
  useEffect(() => {
    setPartnerPage(1);
  }, [selectedMissionary]);

  //
  // -------------- LOAD DATA ---------------------
  //
  async function loadData() {
    try {
      setIsLoading(true);
      setError(null);

      // 1) Missionaries
      const { data: missionaryData, error: missionaryError } = await supabase
        .from("profiles")
        .select("id, full_name, monthly_goal, local_church_id, role")
        // If you want both missionaries + campus directors in same list
        .or("role.eq.missionary,role.eq.campus_director");
      if (missionaryError) throw missionaryError;

      // 2) Churches
      const { data: churchesData, error: churchesError } = await supabase
        .from("local_churches")
        .select("id, name")
        .order("name", { ascending: true });
      if (churchesError) throw churchesError;

      // 3) Last 13 months of donor_donations
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

      // donationMap => missionary => { 'YYYY-MM' => sum }
      const dMap: DonationMap = {};
      (donationsData || []).forEach((don) => {
        const mId = don.missionary_id;
        if (!dMap[mId]) dMap[mId] = {};
        const dateObj = new Date(don.date);
        const yy = dateObj.getFullYear();
        const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
        const key = `${yy}-${mm}`;
        dMap[mId][key] = (dMap[mId][key] || 0) + don.amount;
      });
      setDonationMap(dMap);

      // Build 13-month timeline keys
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
      keyArr.reverse(); // oldest first
      setThirteenMonthKeys(keyArr);

      // Compute top-level metrics
      computeTopMetrics(missionaryData || [], dMap);

      setIsLoading(false);
    } catch (err: any) {
      console.error("Error loading data:", err);
      setError(err.message || "Unknown error");
      setIsLoading(false);
    }
  }

  //
  // -------------- COMPUTE METRICS --------------
  //
  function computeTopMetrics(mData: Profile[], dMap: DonationMap) {
    // A) total donations this month
    const now = new Date();
    const cyear = now.getFullYear();
    const cmonth = now.getMonth();
    const currentKey = `${cyear}-${String(cmonth + 1).padStart(2, "0")}`;
    let totalThisMonth = 0;
    let sumOfGoals = 0;
    mData.forEach((m) => {
      const mg = m.monthly_goal || 0;
      sumOfGoals += mg;
      const donated = dMap[m.id]?.[currentKey] || 0;
      totalThisMonth += donated;
    });
    setTotalDonationsThisMonth(totalThisMonth);

    // B) current total % of all missionaries
    let currentMonthPercent = 0;
    if (sumOfGoals > 0) {
      currentMonthPercent = (totalThisMonth / sumOfGoals) * 100;
    }
    setCurrentPercentAllMissionaries(currentMonthPercent);

    // C) last month's total %
    let lastMonthYear = cyear;
    let lastMonthVal = cmonth - 1;
    if (lastMonthVal < 0) {
      lastMonthVal = 11;
      lastMonthYear = cyear - 1;
    }
    const lastMonthKey = `${lastMonthYear}-${String(lastMonthVal + 1).padStart(2, "0")}`;
    let totalLastMonth = 0;
    mData.forEach((m) => {
      const donated = dMap[m.id]?.[lastMonthKey] || 0;
      totalLastMonth += donated;
    });
    let lastMonthPercent = 0;
    if (sumOfGoals > 0) {
      lastMonthPercent = (totalLastMonth / sumOfGoals) * 100;
    }
    setLastMonthPercentAllMissionaries(lastMonthPercent);

    // D) number of missionaries <80% last month
    let below80Count = 0;
    mData.forEach((m) => {
      const mg = m.monthly_goal || 0;
      if (mg <= 0) return;
      const donated = dMap[m.id]?.[lastMonthKey] || 0;
      if (donated / mg < 0.8) {
        below80Count++;
      }
    });
    setCountBelow80LastMonth(below80Count);
  }

  //
  // -------------- HELPERS ---------------
  //
  function formatNumber(num: number, fractionDigits = 2) {
    return num.toLocaleString(undefined, {
      minimumFractionDigits: fractionDigits,
      maximumFractionDigits: fractionDigits,
    });
  }

  // For a single missionary in a given (year, monthIndex)
  function getDonationForMissionary(mId: string, year: number, month: number): number {
    const key = `${year}-${String(month + 1).padStart(2, "0")}`;
    return donationMap[mId]?.[key] || 0;
  }

  // For the current month ratio for a single missionary
  function getCurrentMonthRatio(m: Profile): number {
    const now = new Date();
    const y = now.getFullYear();
    const mo = now.getMonth();
    const donated = getDonationForMissionary(m.id, y, mo);
    const goal = m.monthly_goal || 0;
    if (goal === 0) return 0;
    return (donated / goal) * 100;
  }

  // For "last X months" ratio
  function getLastXMonthsRatios(m: Profile, x: number) {
    const out: { label: string; ratio: number }[] = [];
    let now = new Date();
    let y = now.getFullYear();
    let mo = now.getMonth();
    for (let i = 0; i < x; i++) {
      const label = `${y}-${String(mo + 1).padStart(2, "0")}`;
      const donated = getDonationForMissionary(m.id, y, mo);
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
  }

  // Summation for a church's missionaries in a given (year, month)
  function getDonationForChurch(chId: number, year: number, month: number): number {
    let total = 0;
    missionaries
      .filter((m) => m.local_church_id === chId)
      .forEach((m) => {
        total += getDonationForMissionary(m.id, year, month);
      });
    return total;
  }
  function getChurchMonthlyGoal(chId: number): number {
    let sum = 0;
    missionaries
      .filter((m) => m.local_church_id === chId)
      .forEach((m) => {
        sum += m.monthly_goal || 0;
      });
    return sum;
  }

  //
  // -------------- EVENT HANDLERS -------------
  //
  function openMissionaryModal(m: Profile) {
    setSelectedMissionary(m);
    setShowMissionaryModal(true);
  }
  function closeMissionaryModal() {
    setShowMissionaryModal(false);
    setSelectedMissionary(null);
  }

  function openChurchModal(ch: Church) {
    setSelectedChurch(ch);
    setShowChurchModal(true);
  }
  function closeChurchModal() {
    setShowChurchModal(false);
    setSelectedChurch(null);
  }

  function openFullMissionaryReport(m: Profile) {
    setSelectedMissionary(m);
    setShowFullMissionaryReport(true);
    // partnerPage is reset by the effect above
  }
  function closeFullReportModal() {
    setShowFullMissionaryReport(false);
    setSelectedMissionary(null);
  }

  //
  // -------------- RENDER UI --------------
  //
  function renderTopCards() {
    return (
      <div className="grid gap-4 md:grid-cols-4">
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

  // --------------------- All Missionaries Table ------------------
  const filteredMissionaries = missionaries.filter((m) =>
    m.full_name.toLowerCase().includes(missionaryFilter.toLowerCase())
  );
  const totalMissionaryPages = Math.ceil(filteredMissionaries.length / pageSize);
  const startM = (missionaryPage - 1) * pageSize;
  const endM = startM + pageSize;
  const pagedMissionaries = filteredMissionaries.slice(startM, endM);

  function renderMissionariesTable() {
    return (
      <div className="mt-8">
        <h2 className="text-xl font-semibold mb-2">All Missionaries</h2>

        {/* Filter + input */}
        <div className="flex items-center gap-2 mb-2">
          <input
            type="text"
            className="border px-2 py-1 text-sm rounded"
            placeholder="Filter by name..."
            value={missionaryFilter}
            onChange={(e) => {
              setMissionaryFilter(e.target.value);
              setMissionaryPage(1);
            }}
          />
        </div>

        {/* Table */}
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
              {pagedMissionaries.map((m) => {
                const ratio = getCurrentMonthRatio(m);
                return (
                  <tr key={m.id}>
                    <td className="px-4 py-2 border-b">{m.full_name}</td>
                    <td className="px-4 py-2 border-b">{m.role}</td>
                    <td className="px-4 py-2 border-b">${m.monthly_goal}</td>
                    <td className="px-4 py-2 border-b">{formatNumber(ratio)}%</td>
                    <td className="px-4 py-2 border-b">
                      <div className="flex gap-2">
                        <Button variant="outline" size="sm" onClick={() => openMissionaryModal(m)}>
                          Last 6 Months
                        </Button>
                        <Button variant="outline" size="sm" onClick={() => openFullMissionaryReport(m)}>
                          Full Report
                        </Button>
                      </div>
                    </td>
                  </tr>
                );
              })}

              {pagedMissionaries.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={5}>
                    No results found.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="mt-2 flex items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            disabled={missionaryPage <= 1}
            onClick={() => setMissionaryPage(missionaryPage - 1)}
          >
            Prev
          </Button>
          <span className="text-sm">
            Page {missionaryPage} of {Math.max(totalMissionaryPages, 1)}
          </span>
          <Button
            variant="outline"
            size="sm"
            disabled={missionaryPage >= totalMissionaryPages}
            onClick={() => setMissionaryPage(missionaryPage + 1)}
          >
            Next
          </Button>
        </div>
      </div>
    );
  }

  // --------------------- All Churches Table -----------------------
  const filteredChurches = churches.filter((ch) =>
    ch.name.toLowerCase().includes(churchFilter.toLowerCase())
  );
  const totalChurchPages = Math.ceil(filteredChurches.length / pageSize);
  const startC = (churchPage - 1) * pageSize;
  const endC = startC + pageSize;
  const pagedChurches = filteredChurches.slice(startC, endC);

  function renderChurchesTable() {
    return (
      <div className="mt-8">
        <h2 className="text-xl font-semibold mb-2">All Churches</h2>

        <div className="flex items-center gap-2 mb-2">
          <input
            type="text"
            className="border px-2 py-1 text-sm rounded"
            placeholder="Filter by church name..."
            value={churchFilter}
            onChange={(e) => {
              setChurchFilter(e.target.value);
              setChurchPage(1);
            }}
          />
        </div>

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
              {pagedChurches.map((ch) => {
                const now = new Date();
                const y = now.getFullYear();
                const mo = now.getMonth();
                const donation = getDonationForChurch(ch.id, y, mo);
                const goal = getChurchMonthlyGoal(ch.id);
                const ratio = goal > 0 ? (donation / goal) * 100 : 0;
                return (
                  <tr key={ch.id}>
                    <td className="px-4 py-2 border-b">{ch.name}</td>
                    <td className="px-4 py-2 border-b">${formatNumber(goal)}</td>
                    <td className="px-4 py-2 border-b">{formatNumber(ratio)}%</td>
                    <td className="px-4 py-2 border-b">
                      <Button variant="outline" size="sm" onClick={() => openChurchModal(ch)}>
                        View Details
                      </Button>
                    </td>
                  </tr>
                );
              })}
              {pagedChurches.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={4}>
                    No results found.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        <div className="mt-2 flex items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            disabled={churchPage <= 1}
            onClick={() => setChurchPage(churchPage - 1)}
          >
            Prev
          </Button>
          <span className="text-sm">
            Page {churchPage} of {Math.max(totalChurchPages, 1)}
          </span>
          <Button
            variant="outline"
            size="sm"
            disabled={churchPage >= totalChurchPages}
            onClick={() => setChurchPage(churchPage + 1)}
          >
            Next
          </Button>
        </div>
      </div>
    );
  }

  //
  // --------------- RENDER ------------------
  //
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
            {renderTopCards()}

            <Separator className="my-6" />

            {renderMissionariesTable()}

            {renderChurchesTable()}
          </>
        )}
      </CardContent>

      {/* 
        Child components for the modals, 
        passing them the relevant props to avoid 
        additional Hooks inside sub-rendering 
      */}
      <MissionaryLast6Modal
        isOpen={showMissionaryModal}
        onClose={closeMissionaryModal}
        missionary={selectedMissionary}
        getLastXMonthsRatios={getLastXMonthsRatios}
        formatNumber={formatNumber}
      />

      <ChurchDetailsModal
        isOpen={showChurchModal}
        onClose={closeChurchModal}
        selectedChurch={selectedChurch}
        missionaries={missionaries}
        getDonationForMissionary={getDonationForMissionary}
        formatNumber={formatNumber}
      />

      <FullMissionaryReportModal
        isOpen={showFullMissionaryReport}
        onClose={closeFullReportModal}
        missionary={selectedMissionary}
        donations={donations}
        donationMap={donationMap}
        thirteenMonthKeys={thirteenMonthKeys}
        formatNumber={formatNumber}
        partnerPage={partnerPage}
        setPartnerPage={setPartnerPage}
      />
    </Card>
  );
}

//
// ------------------- SUB-COMPONENTS (Modals) -------------------
//

// ---- 1) MissionaryLast6Modal ----
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";

function MissionaryLast6Modal({
  isOpen,
  onClose,
  missionary,
  getLastXMonthsRatios,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  getLastXMonthsRatios: (m: Profile, x: number) => { label: string; ratio: number }[];
  formatNumber: (num: number, fractionDigits?: number) => string;
}) {
  if (!missionary) return null;

  const data = getLastXMonthsRatios(missionary, 6);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>Last 6 Months: {missionary.full_name}</DialogTitle>
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
              {data.map((r) => (
                <tr key={r.label}>
                  <td className="px-4 py-2 border-b">{r.label}</td>
                  <td className="px-4 py-2 border-b">{formatNumber(r.ratio)}%</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </DialogContent>
    </Dialog>
  );
}

// ---- 2) ChurchDetailsModal ----
function ChurchDetailsModal({
  isOpen,
  onClose,
  selectedChurch,
  missionaries,
  getDonationForMissionary,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  selectedChurch: Church | null;
  missionaries: Profile[];
  getDonationForMissionary: (mId: string, year: number, month: number) => number;
  formatNumber: (num: number, fractionDigits?: number) => string;
}) {
  if (!selectedChurch) return null;

  // We'll show last 3 months + current => total 4 columns
  const now = new Date();
  const columns: { year: number; month: number; label: string }[] = [];
  for (let i = 0; i < 4; i++) {
    const dt = new Date(now.getFullYear(), now.getMonth() - i, 1);
    columns.unshift({
      year: dt.getFullYear(),
      month: dt.getMonth(),
      label: `${dt.getFullYear()}-${String(dt.getMonth() + 1).padStart(2, "0")}`,
    });
  }

  const relevantMissionaries = missionaries.filter(
    (m) => m.local_church_id === selectedChurch.id
  );

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-4xl w-full max-h-[80vh] overflow-auto">
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
                {columns.map((c) => (
                  <th key={c.label} className="px-4 py-2 border-b">{c.label}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {relevantMissionaries.map((m) => {
                return (
                  <tr key={m.id}>
                    <td className="px-4 py-2 border-b">{m.full_name}</td>
                    {columns.map((c) => {
                      const donated = getDonationForMissionary(m.id, c.year, c.month);
                      const ratio = m.monthly_goal
                        ? (donated / m.monthly_goal) * 100
                        : 0;
                      const below80 = ratio < 80;
                      return (
                        <td
                          key={c.label}
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
              {relevantMissionaries.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={columns.length + 1}>
                    No missionaries found for this church.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </DialogContent>
    </Dialog>
  );
}

// ---- 3) FullMissionaryReportModal ----
function FullMissionaryReportModal({
  isOpen,
  onClose,
  missionary,
  donations,
  donationMap,
  thirteenMonthKeys,
  formatNumber,
  partnerPage,
  setPartnerPage,
}: {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  donations: DonorDonation[];
  donationMap: DonationMap;
  thirteenMonthKeys: string[];
  formatNumber: (num: number, fractionDigits?: number) => string;
  partnerPage: number;
  setPartnerPage: (val: number) => void;
}) {
  if (!missionary) return null;

  // Filter all donations for this missionary
  const missionaryDonations = donations.filter(
    (d) => d.missionary_id === missionary.id
  );

  // We want to build partner rows => each row is a single donor
  // For each donor, we sum amounts by YYYY-MM
  const partnerMap: Record<number, Record<string, number>> = {};
  const donorInfoMap: Record<number, Donor> = {};

  missionaryDonations.forEach((don) => {
    if (don.donor_id) {
      if (!partnerMap[don.donor_id]) {
        partnerMap[don.donor_id] = {};
      }
      if (don.donors) {
        donorInfoMap[don.donor_id] = don.donors;
      }
      const dateObj = new Date(don.date);
      const yy = dateObj.getFullYear();
      const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
      const key = `${yy}-${mm}`;
      partnerMap[don.donor_id][key] =
        (partnerMap[don.donor_id][key] || 0) + don.amount;
    }
  });

  // Build an array of partner rows
  type PartnerRow = {
    donorId: number;
    donorName: string;
    email: string;
    phone: string;
    monthlySums: Record<string, number>;
  };
  const partnerRows: PartnerRow[] = Object.keys(partnerMap).map((idStr) => {
    const donorId = Number(idStr);
    const sums = partnerMap[donorId];
    const donor = donorInfoMap[donorId];
    return {
      donorId,
      donorName: donor?.name || "Unknown",
      email: donor?.email || "",
      phone: donor?.phone || "",
      monthlySums: sums,
    };
  });

  // Pagination for partnerRows
  const pPageSize = 10;
  const totalPartners = partnerRows.length;
  const totalPartnerPages = Math.ceil(totalPartners / pPageSize);
  const startIdx = (partnerPage - 1) * pPageSize;
  const endIdx = startIdx + pPageSize;
  const pagedPartners = partnerRows.slice(startIdx, endIdx);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-[95vw] w-full max-h-[80vh] overflow-auto">
        <div className="flex justify-between items-center">
          <DialogTitle>Full Report - {missionary.full_name}</DialogTitle>
        </div>

        <div className="mt-4 space-y-4">
          <p className="text-sm">
            Below is a single table with each partner on the rows,
            and the last 13 months on the columns.
          </p>

          <div className="overflow-x-auto border rounded-md">
            <table className="min-w-full text-left text-sm">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 border-b">Partner Name</th>
                  <th className="px-4 py-2 border-b">Email</th>
                  <th className="px-4 py-2 border-b">Phone</th>
                  {thirteenMonthKeys.map((key) => (
                    <th key={key} className="px-4 py-2 border-b">
                      {key}
                    </th>
                  ))}
                  <th className="px-4 py-2 border-b">Total</th>
                </tr>
              </thead>
              <tbody>
                {pagedPartners.map((p) => {
                  let rowTotal = 0;
                  return (
                    <tr key={p.donorId}>
                      <td className="px-4 py-2 border-b">{p.donorName}</td>
                      <td className="px-4 py-2 border-b">{p.email}</td>
                      <td className="px-4 py-2 border-b">{p.phone}</td>
                      {thirteenMonthKeys.map((monthKey) => {
                        const val = p.monthlySums[monthKey] || 0;
                        rowTotal += val;
                        return (
                          <td key={monthKey} className="px-4 py-2 border-b">
                            {val > 0 ? `$${formatNumber(val)}` : ""}
                          </td>
                        );
                      })}
                      <td className="px-4 py-2 border-b font-bold">
                        ${formatNumber(rowTotal)}
                      </td>
                    </tr>
                  );
                })}
                {pagedPartners.length === 0 && (
                  <tr>
                    <td
                      className="px-4 py-2 border-b"
                      colSpan={thirteenMonthKeys.length + 4}
                    >
                      No partners found.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

          {/* Pagination for partners */}
          {partnerRows.length > pPageSize && (
            <div className="mt-2 flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                disabled={partnerPage <= 1}
                onClick={() => setPartnerPage(partnerPage - 1)}
              >
                Prev
              </Button>
              <span className="text-sm">
                Page {partnerPage} of {Math.max(totalPartnerPages, 1)}
              </span>
              <Button
                variant="outline"
                size="sm"
                disabled={partnerPage >= totalPartnerPages}
                onClick={() => setPartnerPage(partnerPage + 1)}
              >
                Next
              </Button>
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
