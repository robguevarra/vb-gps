"use client";

import { useState, useEffect } from "react";
import { createClient } from "@/utils/supabase/client";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { Loader2 } from "lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { ReportsTabs } from "@/components/reports/ReportsTabs";
import { TopMetricsCards } from "@/components/reports/TopMetricsCards";
import { MissionariesTable } from "@/components/reports/MissionariesTable";
import { ChurchesTable } from "@/components/reports/ChurchesTable";
import { PartnersTable } from "@/components/reports/PartnersTable";

//
// --------------------------- TYPES ---------------------------
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
// For "All Partners" table, we create a simpler shape
// (We store totalGiven in the last 13 months, plus donor info)
interface PartnerRow {
  id: number;         // donor.id
  name: string;
  email: string;
  phone: string;
  totalGiven: number; // sum of amounts in last 13 months
}

//
// -------------- COMPONENT -------------------
export default function GlobalReportsTab() {
  const supabase = createClient();

  // Loading / Error
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Raw data sets
  const [missionaries, setMissionaries] = useState<Profile[]>([]);
  const [churches, setChurches] = useState<Church[]>([]);
  const [donations, setDonations] = useState<DonorDonation[]>([]);

  // Aggregates
  const [donationMap, setDonationMap] = useState<DonationMap>({});

  // Top-level metrics
  const [totalDonationsThisMonth, setTotalDonationsThisMonth] = useState(0);
  const [currentPercentAllMissionaries, setCurrentPercentAllMissionaries] = useState(0);
  const [lastMonthPercentAllMissionaries, setLastMonthPercentAllMissionaries] = useState(0);
  const [countBelow80LastMonth, setCountBelow80LastMonth] = useState(0);

  // Partners array
  const [partners, setPartners] = useState<PartnerRow[]>([]);

  // Filtering + pagination for "All Missionaries"
  const [missionaryFilter, setMissionaryFilter] = useState("");
  const [missionaryPage, setMissionaryPage] = useState(1);

  // Filtering + pagination for "All Churches"
  const [churchFilter, setChurchFilter] = useState("");
  const [churchPage, setChurchPage] = useState(1);

  // Filtering + pagination for "All Partners"
  const [partnerFilter, setPartnerFilter] = useState("");
  const [partnerPage, setPartnerPage] = useState(1);

  // The number of rows per page
  const pageSize = 10;

  // Currently selected missionary or church or partner for the modals
  const [selectedMissionary, setSelectedMissionary] = useState<Profile | null>(null);
  const [showMissionaryModal, setShowMissionaryModal] = useState(false);

  const [selectedChurch, setSelectedChurch] = useState<Church | null>(null);
  const [showChurchModal, setShowChurchModal] = useState(false);

  // For "Full Missionary Report"
  const [showFullMissionaryReport, setShowFullMissionaryReport] = useState(false);

  // For "Partner Details"
  const [showPartnerModal, setShowPartnerModal] = useState(false);
  const [selectedPartner, setSelectedPartner] = useState<PartnerRow | null>(null);

  // We'll store a map from missionary_id -> missionary_name for quick lookups
  const [missionaryNameMap, setMissionaryNameMap] = useState<Record<string, string>>({});

  // Add these new states:
  const [thirteenMonthKeys, setThirteenMonthKeys] = useState<string[]>([]);

  // Add a new piece of state for the sub-tab:
  const [subTab, setSubTab] = useState<"missionaries" | "churches" | "partners">("missionaries");

  // On mount, load data
  useEffect(() => {
    loadData();
  }, []);

  // Make sure we log after data is loaded or changed
  useEffect(() => {
    console.log("[GlobalReportsTab] donations:", donations);
    console.log("[GlobalReportsTab] missionaries:", missionaries);
    console.log("[GlobalReportsTab] subTab:", subTab);
  }, [donations, missionaries, subTab]);

  // ----------------------------------------------
  // Load data for last 13 months
  // ----------------------------------------------
  async function loadData() {
    try {
      setIsLoading(true);
      setError(null);

      // 1) Missionaries
      const { data: missionaryData, error: missionaryError } = await supabase
        .from("profiles")
        .select("id, full_name, monthly_goal, local_church_id, role")
        .or("role.eq.missionary,role.eq.campus_director");
      if (missionaryError) throw missionaryError;

      // 2) Churches
      const { data: churchesData, error: churchesError } = await supabase
        .from("local_churches")
        .select("id, name")
        .order("name", { ascending: true });
      if (churchesError) throw churchesError;

      // 3) Donations (last 13 months)
      let allDonations: DonorDonation[] = [];
      let from = 0;
      const pageSize = 1000;

      while (true) {
        const { data, error } = await supabase
          .from("donor_donations")
          .select("id, missionary_id, donor_id, date, amount, status, source, notes, donors(id, name, email, phone)")
          .order("id", { ascending: false })
          .range(from, from + pageSize - 1);

        if (error) throw error;
        if (!data?.length) break;

        allDonations = [...allDonations, ...data];
        from += pageSize;
      }

      setDonations(allDonations);

      // Store raw data
      const mData = missionaryData || [];
      const cData = churchesData || [];

      setMissionaries(mData);
      setChurches(cData);

      // Build a donationMap => missionary_id => { 'YYYY-MM' => sum }
      const dMap: DonationMap = {};
      allDonations.forEach((don) => {
        if (!dMap[don.missionary_id]) {
          dMap[don.missionary_id] = {};
        }
        const dateObj = new Date(don.date);
        const yy = dateObj.getFullYear();
        const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
        const key = `${yy}-${mm}`;
        dMap[don.missionary_id][key] =
          (dMap[don.missionary_id][key] || 0) + (don.amount || 0);
      });
      setDonationMap(dMap);

      // Build missionaryNameMap
      const nameMap: Record<string, string> = {};
      mData.forEach((m) => {
        nameMap[m.id] = m.full_name;
      });
      setMissionaryNameMap(nameMap);

      // Compute top-level metrics
      computeTopMetrics(mData, dMap);

      // Build a "partners" array from donor info
      const partnerMap: Record<number, { name: string; email: string; phone: string; total: number }> = {};
      allDonations.forEach((dd) => {
        if (dd.donor_id && dd.donors) {
          const donorId = dd.donor_id;
          if (!partnerMap[donorId]) {
            partnerMap[donorId] = {
              name: dd.donors.name,
              email: dd.donors.email,
              phone: dd.donors.phone,
              total: 0,
            };
          }
          partnerMap[donorId].total += dd.amount || 0;
        }
      });
      const partnerRows: PartnerRow[] = Object.keys(partnerMap).map((idStr) => {
        const donorId = Number(idStr);
        const rec = partnerMap[donorId];
        return {
          id: donorId,
          name: rec.name,
          email: rec.email,
          phone: rec.phone,
          totalGiven: rec.total,
        };
      });
      setPartners(partnerRows);

      // Build 13-month timeline keys (oldest first)
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
      keyArr.reverse();
      setThirteenMonthKeys(keyArr);

      console.log("Raw donations data:", allDonations);

      setIsLoading(false);
    } catch (err: any) {
      console.error("loadData error:", err);
      setError(err.message || "Unknown error");
      setIsLoading(false);
    }
  }

  // ----------------------------------------------
  // Compute top-level metrics
  // ----------------------------------------------
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

    // B) current total %
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
      totalLastMonth += dMap[m.id]?.[lastMonthKey] || 0;
    });
    let lastMonthPercent = 0;
    if (sumOfGoals > 0) {
      lastMonthPercent = (totalLastMonth / sumOfGoals) * 100;
    }
    setLastMonthPercentAllMissionaries(lastMonthPercent);

    // D) # of missionaries <80% last month
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
  // -------------- Helpers ---------------
  //
  function formatNumber(num: number, fractionDigits = 2) {
    return num.toLocaleString(undefined, {
      minimumFractionDigits: fractionDigits,
      maximumFractionDigits: fractionDigits,
    });
  }

  // Summation for a church's missionaries in a given (year, month)
  function getDonationForChurch(chId: number, year: number, month: number) {
    let total = 0;
    missionaries
      .filter((m) => m.local_church_id === chId)
      .forEach((m) => {
        const key = `${year}-${String(month + 1).padStart(2, "0")}`;
        total += donationMap[m.id]?.[key] || 0;
      });
    return total;
  }
  function getChurchMonthlyGoal(chId: number) {
    let sum = 0;
    missionaries
      .filter((m) => m.local_church_id === chId)
      .forEach((m) => {
        sum += m.monthly_goal || 0;
      });
    return sum;
  }

  // For a single missionary in a given (year, month)
  function getDonationForMissionary(mId: string, year: number, month: number) {
    const key = `${year}-${String(month + 1).padStart(2, "0")}`;
    return donationMap[mId]?.[key] || 0;
  }

  // Current-month ratio for a single missionary
  function getCurrentMonthRatio(m: Profile) {
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

  //
  // -------------- Event Handlers -------------
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
  }
  function closeFullReportModal() {
    setShowFullMissionaryReport(false);
    setSelectedMissionary(null);
  }

  function openPartnerModal(p: PartnerRow) {
    setSelectedPartner(p);
    setShowPartnerModal(true);
  }
  function closePartnerModal() {
    setShowPartnerModal(false);
    setSelectedPartner(null);
  }

  //
  // -------------- Rendering the UI -----------
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
            {/* Keep the top cards, but now it's just one component */}
            <TopMetricsCards
              totalDonationsThisMonth={totalDonationsThisMonth}
              currentPercentAllMissionaries={currentPercentAllMissionaries}
              lastMonthPercentAllMissionaries={lastMonthPercentAllMissionaries}
              countBelow80LastMonth={countBelow80LastMonth}
              formatNumber={formatNumber}
            />

            <Separator className="my-6" />

            {/* Simple sub-tab UI */}
            <ReportsTabs currentTab={subTab} setCurrentTab={setSubTab} />

            {/* Render the sub-component for whichever subTab is active */}
            {subTab === "missionaries" && (
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

            {subTab === "churches" && (
              <ChurchesTable
                churches={churches}
                missionaries={missionaries}
                churchFilter={churchFilter}
                setChurchFilter={setChurchFilter}
                churchPage={churchPage}
                setChurchPage={setChurchPage}
                pageSize={pageSize}
                openChurchModal={openChurchModal}
                getDonationForChurch={getDonationForChurch}
                getChurchMonthlyGoal={getChurchMonthlyGoal}
                formatNumber={formatNumber}
              />
            )}

            {subTab === "partners" && (
              <PartnersTable
                donations={donations}
                missionaries={missionaries}
                partnerFilter={partnerFilter}
                setPartnerFilter={setPartnerFilter}
                partnerPage={partnerPage}
                setPartnerPage={setPartnerPage}
                pageSize={pageSize}
                openPartnerModal={openPartnerModal}
                formatNumber={formatNumber}
              />
            )}
          </>
        )}
      </CardContent>

      {/* Modals */}
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

      <PartnerDetailsModal
        isOpen={showPartnerModal}
        onClose={closePartnerModal}
        partner={selectedPartner}
        donations={donations}
        missionaryNameMap={missionaryNameMap}
        formatNumber={formatNumber}
      />
    </Card>
  );
}

//
// -------------------- SUB-COMPONENTS (Modals) --------------------
//

// 1) MissionaryLast6Modal
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

// 2) ChurchDetailsModal
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

  // We'll show last 3 months + current => 4 columns
  const now = new Date();
  const columns: { label: string; year: number; month: number }[] = [];
  for (let i = 0; i < 4; i++) {
    const dt = new Date(now.getFullYear(), now.getMonth() - i, 1);
    columns.unshift({
      label: `${dt.getFullYear()}-${String(dt.getMonth() + 1).padStart(2, "0")}`,
      year: dt.getFullYear(),
      month: dt.getMonth(),
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
                  <th className="px-4 py-2 border-b" key={c.label}>
                    {c.label}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {relevantMissionaries.map((m) => (
                <tr key={m.id}>
                  <td className="px-4 py-2 border-b">{m.full_name}</td>
                  {columns.map((c) => {
                    const donated = getDonationForMissionary(m.id, c.year, c.month);
                    const mg = m.monthly_goal || 0;
                    const ratio = mg > 0 ? (donated / mg) * 100 : 0;
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
              ))}
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

// 3) FullMissionaryReportModal
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

  // Build partnerMap => donor_id => { 'YYYY-MM' => sum }
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

  // Convert partnerMap into an array of partner rows
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

  // Pagination for partner rows
  const pPageSize = 10;
  const totalPartners = partnerRows.length;
  const totalPartnerPages = Math.ceil(totalPartners / pPageSize);
  const startIdx = (partnerPage - 1) * pPageSize;
  const endIdx = startIdx + pPageSize;
  const pagedPartners = partnerRows.slice(startIdx, endIdx);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-[95vw] w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>Full Report - {missionary.full_name}</DialogTitle>
        </DialogHeader>

        <div className="mt-4 space-y-4">
          <p className="text-sm">
            Below is a table of donor partners (rows) vs. the last 13 months (columns).
          </p>

          <div className="overflow-x-auto border rounded-md">
            <table className="min-w-full text-left text-sm">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 border-b">Partner Name</th>
                  <th className="px-4 py-2 border-b">Email</th>
                  <th className="px-4 py-2 border-b">Phone</th>
                  {thirteenMonthKeys.map((key) => (
                    <th key={key} className="px-4 py-2 border-b">{key}</th>
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
                            ₱{formatNumber(val)}
                          </td>
                        );
                      })}
                      <td className="px-4 py-2 border-b font-semibold">
                        ₱{formatNumber(rowTotal)}
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

          {/* Pagination controls for partners (only if needed) */}
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

// 4) PartnerDetailsModal
function PartnerDetailsModal({
  isOpen,
  onClose,
  partner,
  donations,
  missionaryNameMap,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  partner: PartnerRow | null;
  donations: DonorDonation[];
  missionaryNameMap: Record<string, string>;
  formatNumber: (num: number, fractionDigits?: number) => string;
}) {
  if (!partner) return null;

  // Filter all donation entries for this partner
  const partnerDonations = donations
    .filter((d) => d.donor_id === partner.id)
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-3xl w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>
            Partner History: {partner.name}
          </DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <table className="min-w-full text-left text-sm border">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-2 border-b">Date</th>
                <th className="px-4 py-2 border-b">Missionary</th>
                <th className="px-4 py-2 border-b">Amount (₱)</th>
                <th className="px-4 py-2 border-b">Source</th>
                <th className="px-4 py-2 border-b">Status</th>
                <th className="px-4 py-2 border-b">Notes</th>
              </tr>
            </thead>
            <tbody>
              {partnerDonations.map((don) => {
                const missionaryName = missionaryNameMap[don.missionary_id] || "Unknown";
                return (
                  <tr key={don.id}>
                    <td className="px-4 py-2 border-b">
                      {new Date(don.date).toLocaleDateString()}
                    </td>
                    <td className="px-4 py-2 border-b">{missionaryName}</td>
                    <td className="px-4 py-2 border-b">
                      ₱{formatNumber(don.amount)}
                    </td>
                    <td className="px-4 py-2 border-b">{don.source}</td>
                    <td className="px-4 py-2 border-b">{don.status}</td>
                    <td className="px-4 py-2 border-b">
                      {don.notes || ""}
                    </td>
                  </tr>
                );
              })}
              {partnerDonations.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={6}>
                    No donations found for this partner.
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
