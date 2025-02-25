import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Profile, DonorDonation, PartnerRow } from "@/types/reports";
import { useMemo } from "react";

interface PartnersTableProps {
  donations: DonorDonation[];
  missionaries: Profile[];
  partnerFilter: string;
  setPartnerFilter: (value: string) => void;
  partnerPage: number;
  setPartnerPage: (page: number) => void;
  pageSize: number;
  openPartnerModal: (partner: PartnerRow) => void;
  formatNumber: (num: number, fractionDigits?: number) => string;
  enrichedDonors: Array<{
    id: number;
    name: string;
    email: string;
    phone: string;
    totalGiven: number;
  }>;
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
  enrichedDonors = [],
}: PartnersTableProps) {
  // Get the date 13 months ago for display
  const thirteenMonthsAgo = useMemo(() => {
    const date = new Date();
    date.setMonth(date.getMonth() - 13);
    return date;
  }, []);

  // Debug logging
  console.log('\n=== PartnersTable Debug ===');
  console.log('Donations length:', donations.length);
  console.log('EnrichedDonors length:', enrichedDonors?.length);
  console.log('Sample enrichedDonors:', enrichedDonors?.slice(0, 2));

  // Show loading state if we have no data yet
  if (!enrichedDonors || (enrichedDonors.length === 0 && donations.length > 0)) {
    console.log('Showing loading state because:', {
      enrichedDonorsUndefined: !enrichedDonors,
      enrichedDonorsEmpty: enrichedDonors?.length === 0,
      hasDonations: donations.length > 0
    });
    return (
      <div className="text-center py-8 text-gray-500">
        Loading partner data...
      </div>
    );
  }

  // Convert enriched donors to partner rows and sort by total given
  const partners = useMemo(() => 
    (enrichedDonors || [])
      .map(donor => ({
        id: donor.id,
        name: donor.name || 'Unknown',
        email: donor.email || '',
        phone: donor.phone || '',
        totalGiven: donor.totalGiven,
      }))
      .sort((a, b) => b.totalGiven - a.totalGiven),
    [enrichedDonors]
  );

  // Filter partners based on search
  const filteredPartners = useMemo(() => {
    const searchTerm = partnerFilter.toLowerCase();
    return partners.filter(
      (p) =>
        p.name.toLowerCase().includes(searchTerm) ||
        p.email.toLowerCase().includes(searchTerm) ||
        p.phone.toLowerCase().includes(searchTerm)
    );
  }, [partners, partnerFilter]);

  // Pagination
  const totalPartners = filteredPartners.length;
  const totalPages = Math.ceil(totalPartners / pageSize);
  const startIdx = (partnerPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const pagedPartners = filteredPartners.slice(startIdx, endIdx);

  // Show loading state if no partners but we have donations
  if (donations.length > 0 && partners.length === 0) {
    return (
      <div className="text-center py-8 text-gray-500">
        Processing partner data...
      </div>
    );
  }

  // Show empty state if no partners
  if (partners.length === 0) {
    return (
      <div className="text-center py-8 text-gray-500">
        No partner data available.
      </div>
    );
  }

  const activePartners = partners.filter(p => p.totalGiven > 0);

  return (
    <div className="space-y-4">
      {/* Stats summary */}
      <div className="text-sm text-gray-500">
        Total Partners: {partners.length} | 
        Active Partners (13mo): {activePartners.length} |
        Showing: {startIdx + 1}-{Math.min(endIdx, totalPartners)} |
        Date Range: Last 13 Months (from {thirteenMonthsAgo.toLocaleDateString()})
      </div>

      {/* Search input */}
      <div className="flex items-center gap-2">
        <Input
          type="text"
          placeholder="Search partners by name, email, or phone..."
          value={partnerFilter}
          onChange={(e) => {
            setPartnerFilter(e.target.value);
            setPartnerPage(1); // Reset to first page on search
          }}
          className="max-w-sm"
        />
      </div>

      {/* Partners table */}
      <div className="border rounded-md">
        <table className="min-w-full text-sm">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-2 text-left">Partner Name</th>
              <th className="px-4 py-2 text-left">Email</th>
              <th className="px-4 py-2 text-left">Phone</th>
              <th className="px-4 py-2 text-left">Total Given (13mo)</th>
              <th className="px-4 py-2 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            {pagedPartners.map((p) => (
              <tr key={p.id} className="border-t hover:bg-gray-50">
                <td className="px-4 py-2">{p.name}</td>
                <td className="px-4 py-2">{p.email}</td>
                <td className="px-4 py-2">{p.phone}</td>
                <td className="px-4 py-2">₱{formatNumber(p.totalGiven)}</td>
                <td className="px-4 py-2">
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => openPartnerModal(p)}
                  >
                    View History
                  </Button>
                </td>
              </tr>
            ))}

            {pagedPartners.length === 0 && (
              <tr>
                <td colSpan={5} className="px-4 py-2 text-center text-gray-500">
                  No partners found matching your search.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination controls */}
      {totalPartners > pageSize && (
        <div className="flex items-center gap-2 justify-end">
          <Button
            variant="outline"
            size="sm"
            disabled={partnerPage <= 1}
            onClick={() => setPartnerPage(partnerPage - 1)}
          >
            Previous
          </Button>
          <span className="text-sm">
            Page {partnerPage} of {totalPages}
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
      )}
    </div>
  );
} 