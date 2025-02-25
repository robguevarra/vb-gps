"use client";

import { useState } from "react";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { Loader2 } from "lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { ReportsTabs } from "@/components/reports/ReportsTabs";
import { TopMetricsCards } from "@/components/reports/TopMetricsCards";
import { MissionariesTable } from "@/components/reports/tables/MissionariesTable";
import { ChurchesTable } from "@/components/reports/tables/ChurchesTable";
import { PartnersTable } from "@/components/reports/tables/PartnersTable";
import { MissionaryLast6Modal } from "@/components/reports/modals/MissionaryLast6Modal";
import { ChurchDetailsModal } from "@/components/reports/modals/ChurchDetailsModal";
import { FullMissionaryReportModal } from "@/components/reports/modals/FullMissionaryReportModal";
import { PartnerDetailsModal } from "@/components/reports/modals/PartnerDetailsModal";
import { useReportsData } from "@/hooks/useReportsData";
import { Profile, Church, PartnerRow } from "@/types/reports";
import { formatNumber } from "@/utils/reports";

//
// --------------------------- TYPES ---------------------------
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

//
// -------------- COMPONENT -------------------
export default function GlobalReportsTab() {
  // Use the hook for data fetching
  const { isLoading, error, data } = useReportsData();

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

  // Add a new piece of state for the sub-tab:
  const [subTab, setSubTab] = useState<"missionaries" | "churches" | "partners">("missionaries");

  // Build missionary name map
  const missionaryNameMap: Record<string, string> = {};
  data.missionaries.forEach((m) => {
    missionaryNameMap[m.id] = m.full_name;
  });

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
            <TopMetricsCards
              totalDonationsThisMonth={data.totalDonationsThisMonth}
              currentPercentAllMissionaries={data.currentPercentAllMissionaries}
              lastMonthPercentAllMissionaries={data.lastMonthPercentAllMissionaries}
              countBelow80LastMonth={data.countBelow80LastMonth}
              formatNumber={formatNumber}
            />

            <Separator className="my-6" />

            <ReportsTabs currentTab={subTab} setCurrentTab={setSubTab} />

            {subTab === "missionaries" && (
              <MissionariesTable
                missionaries={data.missionaries}
                missionaryFilter={missionaryFilter}
                setMissionaryFilter={setMissionaryFilter}
                missionaryPage={missionaryPage}
                setMissionaryPage={setMissionaryPage}
                pageSize={pageSize}
                openMissionaryModal={(m) => {
                  setSelectedMissionary(m);
                  setShowMissionaryModal(true);
                }}
                openFullMissionaryReport={(m) => {
                  setSelectedMissionary(m);
                  setShowFullMissionaryReport(true);
                }}
                donationMap={data.donationMap}
                formatNumber={formatNumber}
              />
            )}

            {subTab === "churches" && (
              <ChurchesTable
                churches={data.churches}
                missionaries={data.missionaries}
                churchFilter={churchFilter}
                setChurchFilter={setChurchFilter}
                churchPage={churchPage}
                setChurchPage={setChurchPage}
                pageSize={pageSize}
                openChurchModal={(ch) => {
                  setSelectedChurch(ch);
                  setShowChurchModal(true);
                }}
                donationMap={data.donationMap}
                formatNumber={formatNumber}
              />
            )}

            {subTab === "partners" && (
              <PartnersTable
                donations={data.donations}
                missionaries={data.missionaries}
                partnerFilter={partnerFilter}
                setPartnerFilter={setPartnerFilter}
                partnerPage={partnerPage}
                setPartnerPage={setPartnerPage}
                pageSize={pageSize}
                openPartnerModal={(p) => {
                  setSelectedPartner(p);
                  setShowPartnerModal(true);
                }}
                formatNumber={formatNumber}
                enrichedDonors={data.enrichedDonors || []}
              />
            )}

            {/* Modals */}
            <MissionaryLast6Modal
              isOpen={showMissionaryModal}
              onClose={() => setShowMissionaryModal(false)}
              missionary={selectedMissionary}
              donationMap={data.donationMap}
            />

            <ChurchDetailsModal
              isOpen={showChurchModal}
              onClose={() => setShowChurchModal(false)}
              selectedChurch={selectedChurch}
              missionaries={data.missionaries}
              donationMap={data.donationMap}
            />

            <FullMissionaryReportModal
              isOpen={showFullMissionaryReport}
              onClose={() => setShowFullMissionaryReport(false)}
              missionary={selectedMissionary}
              donations={data.donations}
              donationMap={data.donationMap}
              thirteenMonthKeys={data.thirteenMonthKeys}
              partnerPage={partnerPage}
              setPartnerPage={setPartnerPage}
            />

            <PartnerDetailsModal
              isOpen={showPartnerModal}
              onClose={() => setShowPartnerModal(false)}
              partner={selectedPartner}
              donations={data.donations}
              missionaryNameMap={missionaryNameMap}
            />
          </>
        )}
      </CardContent>
    </Card>
  );
}
