"use client";

import { useState, useEffect } from "react";
import { createClient } from "@/utils/supabase/client";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Separator } from "@/components/ui/separator";
import { Loader2 } from "lucide-react";

// ----------------------------------
// Types
// ----------------------------------
interface Donor {
  id: number;
  name: string | null;
  email: string | null;
  phone: string | null;
}

interface DonorDonation {
  id: number;
  donor_id: number | null;
  missionary_id: string | null;
  amount: number;
  date: string;
  source: string;
  status: string;
  notes?: string | null;
  donors?: Donor | null;
}

interface PartnerRow {
  key: string;         // e.g. "donor_5" or "offline_123"
  donorId: number;     // 0 if offline
  name: string;
  email: string;
  phone: string;
  totalGiven: number;  // sum in date range
}

interface Missionary {
  id: string;
  full_name: string;
}

// ----------------------------------
// PartnersTab
// ----------------------------------
export default function PartnersTab() {
  const supabase = createClient();

  // Loading / Error
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // All donations (no date limit)
  const [donations, setDonations] = useState<DonorDonation[]>([]);

  // We'll store a map of missionary_id => full_name for the detail modal
  const [missionaryMap, setMissionaryMap] = useState<Record<string, string>>({});

  // Table states
  const [partnerFilter, setPartnerFilter] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const pageSize = 10;

  // For the PartnerDetail modal
  const [selectedPartner, setSelectedPartner] = useState<PartnerRow | null>(null);
  const [showPartnerModal, setShowPartnerModal] = useState(false);

  // On mount, load data
  useEffect(() => {
    fetchAllDonations();
  }, []);

  // Also, set default date range
  useEffect(() => {
    if (!startDate) {
      setStartDate("1970-01-01"); // or whatever default
    }
    if (!endDate) {
      const today = new Date().toISOString().split("T")[0];
      setEndDate(today);
    }
  }, [startDate, endDate]);

  async function fetchAllDonations() {
    try {
      setIsLoading(true);

      // 1) Donations (no date limit)
      const { data: donationsData, error: donationsError } = await supabase
        .from("donor_donations")
        .select("*, donors(id, name, email, phone), missionary_id");
      if (donationsError) throw donationsError;

      setDonations(donationsData || []);

      // 2) Missionaries
      const { data: missionariesData, error: missionariesError } = await supabase
        .from("profiles")
        .select("id, full_name")
        .or("role.eq.missionary,role.eq.campus_director");
      if (missionariesError) throw missionariesError;

      const map: Record<string, string> = {};
      (missionariesData || []).forEach((m: any) => {
        map[m.id] = m.full_name;
      });
      setMissionaryMap(map);

      setIsLoading(false);
    } catch (err: any) {
      console.error("Error fetching data in PartnersTab:", err);
      setError(err.message || "Unknown error");
      setIsLoading(false);
    }
  }

  //
  // Build the partner rows for the date range
  //
  function buildPartnerRows(): PartnerRow[] {
    if (!startDate || !endDate) return [];
    const start = new Date(startDate);
    const end = new Date(endDate);

    // If user picks invalid date or start> end, handle gracefully
    if (isNaN(start.getTime()) || isNaN(end.getTime()) || start > end) {
      return [];
    }

    // We'll map key => partial data. Key can be "donor_123" or "offline_donation_555"
    const aggregator: Record<string, { donorId: number; name: string; email: string; phone: string; total: number }> = {};

    donations.forEach((don) => {
      const dDate = new Date(don.date);
      if (dDate < start || dDate > end) return; // skip out-of-range donation

      // If there's no donor_id, we treat it as an offline or anonymous donor
      let key = "";
      let donorId = 0;
      let donorName = "Offline Donor";
      let donorEmail = "";
      let donorPhone = "";

      if (don.donor_id && don.donor_id > 0) {
        // We have a real donor
        key = `donor_${don.donor_id}`;
        donorId = don.donor_id;
        donorName = don.donors?.name || `Donor #${don.donor_id}`;
        donorEmail = don.donors?.email || "";
        donorPhone = don.donors?.phone || "";
      } else {
        // offline
        // We might want to group them all under a single "Offline Donor" 
        // or separate them by donation ID:
        key = `offline_${don.id}`; 
        // If you want ALL offline donations to be combined under one row, do:
        // key = "offline_global";
      }

      if (!aggregator[key]) {
        aggregator[key] = {
          donorId,
          name: donorName,
          email: donorEmail,
          phone: donorPhone,
          total: 0,
        };
      }

      aggregator[key].total += don.amount;
    });

    // Convert aggregator to array
    return Object.keys(aggregator).map((k) => ({
      key: k,
      donorId: aggregator[k].donorId,
      name: aggregator[k].name,
      email: aggregator[k].email,
      phone: aggregator[k].phone,
      totalGiven: aggregator[k].total,
    }));
  }

  // Filter, paginate
  const partnerRows = buildPartnerRows();
  const filtered = partnerRows.filter((p) => {
    const txt = (p.name + p.email + p.phone).toLowerCase();
    return txt.includes(partnerFilter.toLowerCase());
  });

  const totalPages = Math.ceil(filtered.length / pageSize);
  const startIdx = (currentPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const paged = filtered.slice(startIdx, endIdx);

  //
  // Render
  //
  function renderPartnerTable() {
    return (
      <div className="mt-8">
        <div className="flex flex-col md:flex-row gap-2 mb-4">
          <div className="flex items-center gap-2">
            <label className="text-sm text-gray-600">Start:</label>
            <input
              type="date"
              className="border px-2 py-1 text-sm rounded"
              value={startDate}
              onChange={(e) => {
                setStartDate(e.target.value);
                setCurrentPage(1);
              }}
            />
          </div>
          <div className="flex items-center gap-2">
            <label className="text-sm text-gray-600">End:</label>
            <input
              type="date"
              className="border px-2 py-1 text-sm rounded"
              value={endDate}
              onChange={(e) => {
                setEndDate(e.target.value);
                setCurrentPage(1);
              }}
            />
          </div>
          <div className="flex items-center gap-2">
            <label className="text-sm text-gray-600">Filter:</label>
            <input
              type="text"
              className="border px-2 py-1 text-sm rounded"
              placeholder="Name / Email / Phone..."
              value={partnerFilter}
              onChange={(e) => {
                setPartnerFilter(e.target.value);
                setCurrentPage(1);
              }}
            />
          </div>
        </div>

        <div className="overflow-x-auto border rounded-md">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-gray-50 dark:bg-gray-800">
              <tr>
                <th className="px-4 py-2 border-b">Name</th>
                <th className="px-4 py-2 border-b">Email</th>
                <th className="px-4 py-2 border-b">Phone</th>
                <th className="px-4 py-2 border-b">Total Given</th>
                <th className="px-4 py-2 border-b">Actions</th>
              </tr>
            </thead>
            <tbody>
              {paged.map((p) => (
                <tr key={p.key}>
                  <td className="px-4 py-2 border-b">{p.name}</td>
                  <td className="px-4 py-2 border-b">{p.email}</td>
                  <td className="px-4 py-2 border-b">{p.phone}</td>
                  <td className="px-4 py-2 border-b">
                    ${formatNumber(p.totalGiven)}
                  </td>
                  <td className="px-4 py-2 border-b">
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => handlePartnerDetails(p)}
                    >
                      View Details
                    </Button>
                  </td>
                </tr>
              ))}

              {paged.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={5}>
                    No matching partners.
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
            disabled={currentPage <= 1}
            onClick={() => setCurrentPage(currentPage - 1)}
          >
            Prev
          </Button>
          <span className="text-sm">
            Page {currentPage} of {Math.max(totalPages, 1)}
          </span>
          <Button
            variant="outline"
            size="sm"
            disabled={currentPage >= totalPages}
            onClick={() => setCurrentPage(currentPage + 1)}
          >
            Next
          </Button>
        </div>
      </div>
    );
  }

  function handlePartnerDetails(p: PartnerRow) {
    setSelectedPartner(p);
    setShowPartnerModal(true);
  }

  return (
    <Card className="border shadow-sm">
      <CardHeader>
        <CardTitle>All Partners</CardTitle>
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
            <p className="text-sm text-muted-foreground">
              View offline &amp; online donors. If <code>donor_id</code> is null,
              we group them as "Offline Donor" (or separate them by donation).
            </p>

            <Separator className="my-4" />

            {renderPartnerTable()}
          </>
        )}
      </CardContent>

      <PartnerDetailsModal
        isOpen={showPartnerModal}
        onClose={() => setShowPartnerModal(false)}
        partner={selectedPartner}
        donations={donations}
        missionaryMap={missionaryMap}
        formatNumber={formatNumber}
      />
    </Card>
  );
}

// --------------- PartnerDetailsModal ---------------
function PartnerDetailsModal({
  isOpen,
  onClose,
  partner,
  donations,
  missionaryMap,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  partner: PartnerRow | null;
  donations: DonorDonation[];
  missionaryMap: Record<string, string>;
  formatNumber: (num: number, fractionDigits?: number) => string;
}) {
  if (!partner) return null;

  // Gather all donation rows that contributed to this partner "key"
  // If partner.donorId is 0 => means offline. Then we match by "offline_xxx" approach.
  // If partner.key starts with "offline_",
  //   we know we used donation ID in the aggregator.
  //   So we can match them by their donation ID in the aggregator if needed.
  // A simpler approach is to just show all donations with the same 'id' if that’s how you want it.

  // For simplicity, let’s do:
  //   If partner.donorId > 0 => match donor_id
  //   Else => match offline => parse the numeric donation ID from partner.key
  //   Or if you used a single “offline_global,” you’d combine them all. 
  let relevantDonations: DonorDonation[] = [];
  if (partner.donorId > 0) {
    // We have a real donor
    relevantDonations = donations.filter((d) => d.donor_id === partner.donorId);
  } else {
    // offline
    if (partner.key.startsWith("offline_")) {
      const offlineId = partner.key.replace("offline_", "");
      // If we used donation ID in aggregator, we match it:
      const donationId = Number(offlineId);
      relevantDonations = donations.filter((d) => d.id === donationId);
    } else {
      // If you used "offline_global," you'd gather all with donor_id=null. 
      relevantDonations = donations.filter((d) => !d.donor_id);
    }
  }

  // Sort descending by date
  relevantDonations.sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-3xl w-full max-h-[80vh] overflow-auto">
        <DialogHeader>
          <DialogTitle>Partner Details</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <p className="text-sm text-muted-foreground">
            {partner.name} <br />
            Email: {partner.email} <br />
            Phone: {partner.phone}
          </p>
          <table className="min-w-full text-left text-sm border">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-2 border-b">Date</th>
                <th className="px-4 py-2 border-b">Missionary</th>
                <th className="px-4 py-2 border-b">Amount</th>
                <th className="px-4 py-2 border-b">Source</th>
                <th className="px-4 py-2 border-b">Status</th>
                <th className="px-4 py-2 border-b">Notes</th>
              </tr>
            </thead>
            <tbody>
              {relevantDonations.map((don) => {
                const mName = don.missionary_id
                  ? missionaryMap[don.missionary_id] || "Unknown"
                  : "No missionary assigned";
                return (
                  <tr key={don.id}>
                    <td className="px-4 py-2 border-b">
                      {new Date(don.date).toLocaleDateString()}
                    </td>
                    <td className="px-4 py-2 border-b">{mName}</td>
                    <td className="px-4 py-2 border-b">
                      ${formatNumber(don.amount)}
                    </td>
                    <td className="px-4 py-2 border-b">{don.source}</td>
                    <td className="px-4 py-2 border-b">{don.status}</td>
                    <td className="px-4 py-2 border-b">
                      {don.notes || ""}
                    </td>
                  </tr>
                );
              })}
              {relevantDonations.length === 0 && (
                <tr>
                  <td className="px-4 py-2 border-b" colSpan={6}>
                    No donations found.
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

// Utility
function formatNumber(num: number, fractionDigits = 2) {
  return num.toLocaleString(undefined, {
    minimumFractionDigits: fractionDigits,
    maximumFractionDigits: fractionDigits,
  });
}
