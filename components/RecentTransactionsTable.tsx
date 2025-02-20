//components/RecentTransactionsTable.tsx
"use client";

import { useState, useEffect } from 'react';

interface Donation {
  id: string | number;
  donor_name: string;
  donor_email?: string;
  donor_phone?: string;
  amount: number;
  date: string;
  notes?: string;
}

interface RecentTransactionsTableProps {
  donations: Donation[];
}

export default function RecentTransactionsTable({ donations }: RecentTransactionsTableProps) {
  const [searchQuery, setSearchQuery] = useState('');


  const filteredDonations = donations.filter(donation =>
    donation.donor_name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div className="space-y-4">
      <div className="flex items-center space-x-2">
        <input
          type="text"
          placeholder="Search by donor name..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="p-2 border rounded-md w-full"
        />
      </div>
      <div className="overflow-x-auto">
        <table className="min-w-full divide-y divide-gray-200">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Donor Name</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Notes</th>
            </tr>
          </thead>
          <tbody className="bg-white divide-y divide-gray-200">
            {filteredDonations.length > 0 ? (
              filteredDonations.map((donation) => (
                <tr key={donation.id}>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{donation.donor_name}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${donation.amount.toLocaleString()}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{new Date(donation.date).toLocaleDateString()}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    {donation.notes && donation.notes.trim() !== '' ? donation.notes : '-'}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan={4} className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                  No transactions found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
