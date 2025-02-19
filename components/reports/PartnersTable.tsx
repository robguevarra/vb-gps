import React from "react";
import { Button } from "@/components/ui/button";

interface PartnerRow {
  id: number;
  name: string;
  email: string;
  phone: string;
  totalGiven: number;
}

interface PartnersTableProps {
  partners: PartnerRow[];
  partnerFilter: string;
  setPartnerFilter: (val: string) => void;
  partnerPage: number;
  setPartnerPage: (page: number) => void;
  pageSize: number;
  openPartnerModal: (p: PartnerRow) => void;
  formatNumber: (num: number) => string;
}

export function PartnersTable({
  partners,
  partnerFilter,
  setPartnerFilter,
  partnerPage,
  setPartnerPage,
  pageSize,
  openPartnerModal,
  formatNumber,
}: PartnersTableProps) {
  // Filter + paginate
  const filtered = partners.filter((p) => {
    const txt = (p.name + p.email + p.phone).toLowerCase();
    return txt.includes(partnerFilter.toLowerCase());
  });
  const totalPages = Math.ceil(filtered.length / pageSize);
  const startIdx = (partnerPage - 1) * pageSize;
  const endIdx = startIdx + pageSize;
  const pageData = filtered.slice(startIdx, endIdx);

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold mb-2">All Partners</h2>
      <div className="flex items-center gap-2 mb-2">
        <input
          type="text"
          className="border px-2 py-1 text-sm rounded"
          placeholder="Filter by name or email..."
          value={partnerFilter}
          onChange={(e) => {
            setPartnerFilter(e.target.value);
            setPartnerPage(1);
          }}
        />
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

      {/* Pagination */}
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