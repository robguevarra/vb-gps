import React, { useState, useMemo, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { DonorDonation, Profile } from "@/types"; // or adjust your path

interface PartnerRow {
  id: number;
  name: string;
  email: string;
  phone: string;
  totalGiven: number; // total in the current filter
}

interface PartnersTableProps {
  // Remove the old 'partners' array
  donations: DonorDonation[]; 
  missionaries: Profile[];

  // Filtering & pagination
  partnerFilter: string;
  setPartnerFilter: (val: string) => void;
  partnerPage: number;
  setPartnerPage: (page: number) => void;
  pageSize: number;

  // We still need a callback to view partner details
  openPartnerModal: (p: PartnerRow) => void;

  // For formatting currency
  formatNumber: (num: number) => string;
}

export function PartnersTable({
  donations,
  missionaries,
  partnerFilter,
  setPartnerFilter,
  partnerPage,
  setPartnerPage,
  pageSize,
  openPartnerModal,
  formatNumber,
}: PartnersTableProps) {
  // Add an effect to log the incoming data
  useEffect(() => {
    console.log("[PartnersTable] donations:", donations);
    console.log("[PartnersTable] missionaries:", missionaries);
  }, [donations, missionaries]);

  // ---------------- New states for date-range & missionary filters ----------------
  const [fromDate, setFromDate] = useState<string>(
    new Date(2010, 0, 1).toISOString().split('T')[0] // Jan 1, 2010
  );
  const [toDate, setToDate] = useState<string>(
    new Date().toISOString().split('T')[0] // Today
  );
  const [selectedMissionary, setSelectedMissionary] = useState<string>("all");

  // ---------------- Filter donations by range & missionary ----------------
  const filteredDonations = useMemo(() => {
    // Convert fromDate/toDate strings to actual Dates (or undefined)
    const from = fromDate ? new Date(fromDate) : undefined;
    const to = toDate ? new Date(toDate) : undefined;

    return donations.filter((don) => {
      // 1) Check missionary filter
      if (selectedMissionary !== "all" && don.missionary_id !== selectedMissionary) {
        return false;
      }
      // 2) Check date range
      const dDate = new Date(don.date);
      if (from && dDate < from) return false;
      if (to && dDate > to) return false;
      return true;
    });
  }, [donations, fromDate, toDate, selectedMissionary]);

  // Inside the filteredDonations useEffect:
  useEffect(() => {
    console.log('Donations with donor info:', 
      filteredDonations.filter(d => d.donor_id && d.donors).length,
      '/',
      filteredDonations.length
    );
  }, [filteredDonations]);

  // ---------------- Convert filtered donations -> partner rows ----------------
  const partnerRows = useMemo(() => {
    const map: Record<number, PartnerRow> = {};
    
    filteredDonations.forEach((don) => {
      // Add null check for donor relationship
      if (!don.donor_id || !don.donors) return;
      
      const donorId = don.donor_id;
      if (!map[donorId]) {
        map[donorId] = {
          id: donorId,
          name: don.donors.name || 'Unknown',
          email: don.donors.email || '',
          phone: don.donors.phone || '',
          totalGiven: 0,
        };
      }
      map[donorId].totalGiven += don.amount;
    });
    
    return Object.values(map);
  }, [filteredDonations]);

  // ---------------- Final filter: partnerFilter (Name/Email/Phone) ----------------
  const finalPartners = useMemo(() => {
    const lowerFilter = partnerFilter.toLowerCase();
    return partnerRows.filter((p) => {
      const txt = (p.name + p.email + p.phone).toLowerCase();
      return txt.includes(lowerFilter);
    });
  }, [partnerRows, partnerFilter]);

  // ---------------- Pagination ----------------
  const totalPages = Math.ceil(finalPartners.length / pageSize);
  const startIdx = (partnerPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const pageData = finalPartners.slice(startIdx, endIdx);

  // ---------------- Render ----------------
  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold mb-2">All Partners</h2>

      {/* ---------- 1) Date Range Filters ---------- */}
      <div className="flex items-center gap-4 mb-2 flex-wrap">
        <div>
          <label className="block text-sm font-medium mb-1">
            From Date
          </label>
          <input
            type="date"
            className="border px-2 py-1 text-sm rounded"
            value={fromDate}
            onChange={(e) => {
              setFromDate(e.target.value);
              setPartnerPage(1);
            }}
          />
        </div>
        <div>
          <label className="block text-sm font-medium mb-1">
            To Date
          </label>
          <input
            type="date"
            className="border px-2 py-1 text-sm rounded"
            value={toDate}
            onChange={(e) => {
              setToDate(e.target.value);
              setPartnerPage(1);
            }}
          />
        </div>

        {/* ---------- 2) Missionary Filter (dropdown) ---------- */}
        <div>
          <label className="block text-sm font-medium mb-1">
            Filter by Missionary
          </label>
          <select
            className="border px-2 py-1 text-sm rounded"
            value={selectedMissionary}
            onChange={(e) => {
              setSelectedMissionary(e.target.value);
              setPartnerPage(1);
            }}
          >
            <option value="all">All Missionaries</option>
            {missionaries.map((m) => (
              <option key={m.id} value={m.id}>
                {m.full_name}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* ---------- 3) Partner Name/Phone/Email Filter ---------- */}
      <div className="flex items-center gap-2 mb-4">
        <input
          type="text"
          className="border px-2 py-1 text-sm rounded"
          placeholder="Search partner name, email, or phone..."
          value={partnerFilter}
          onChange={(e) => {
            setPartnerFilter(e.target.value);
            setPartnerPage(1);
          }}
        />
      </div>

      {/* ---------- Table ---------- */}
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
            {pageData.map((p) => (
              <tr key={p.id}>
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
                    onClick={() => openPartnerModal(p)}
                  >
                    View Details
                  </Button>
                </td>
              </tr>
            ))}
            {pageData.length === 0 && (
              <tr>
                <td className="px-4 py-2 border-b" colSpan={5}>
                  No matching partners.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* ---------- Pagination ---------- */}
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
          Page {partnerPage} of {Math.max(totalPages, 1)}
        </span>
        <Button
          variant="outline"
          size="sm"
          disabled={partnerPage >= totalPages}
          onClick={() => setPartnerPage(partnerPage + 1)}
        >
          Next
        </Button>
      </div>
    </div>
  );
} 