"use client";

import { useState, useEffect } from "react";
import { createClient } from "@/utils/supabase/client";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";

// (Optional) If you want charts, install a library like recharts or react-chartjs-2
// import { LineChart, Line, XAxis, YAxis, Tooltip, CartesianGrid } from "recharts";

interface MonthlyTrend {
  month: string; // e.g. "2025-01"
  total: number;
}

export default function GlobalReportsTab() {
  const supabase = createClient();

  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [totalDonations, setTotalDonations] = useState<number>(0);
  const [pendingRequests, setPendingRequests] = useState<number>(0);
  const [monthlyTrends, setMonthlyTrends] = useState<MonthlyTrend[]>([]);

  useEffect(() => {
    fetchReportsData();
  }, []);

  async function fetchReportsData() {
    try {
      setIsLoading(true);

      // 1) Fetch all donor_donations
      const { data: donationsData, error: donationsError } = await supabase
        .from("donor_donations")
        .select("id, amount, date, status, source");

      if (donationsError) {
        throw donationsError;
      }

      // Optionally, you might want to only count "completed" or "successful" donations. 
      // For example, if your table has 'completed' or 'paid' statuses:
      //   .eq('status', 'completed')
      // Just be consistent with whichever statuses indicate valid donations.

      // Sum all amounts
      const sumDonations = donationsData?.reduce((acc: number, row: any) => {
        const amt = Number(row.amount) || 0;
        return acc + amt;
      }, 0) ?? 0;

      // 2) Pending Surplus Requests
      const { data: pendingSurplus, error: surplusError } = await supabase
        .from("surplus_requests")
        .select("id")
        .eq("status", "pending");
      if (surplusError) {
        throw surplusError;
      }

      // 3) Pending Leave Requests
      const { data: pendingLeave, error: leaveError } = await supabase
        .from("leave_requests")
        .select("id")
        .eq("status", "pending");
      if (leaveError) {
        throw leaveError;
      }

      // 4) Build monthly trends from `donationsData` using the `date` field
      const monthlyMap: Record<string, number> = {};
      donationsData?.forEach((donation: any) => {
        const dateObj = new Date(donation.date); // donation.date might already be date or string
        const year = dateObj.getFullYear();
        const month = String(dateObj.getMonth() + 1).padStart(2, "0"); // 01..12
        const key = `${year}-${month}`; // e.g. "2025-02"
        monthlyMap[key] = (monthlyMap[key] || 0) + (Number(donation.amount) || 0);
      });

      // Convert monthlyMap to array, sorted by date
      const monthlyArray: MonthlyTrend[] = Object.keys(monthlyMap)
        .sort() // sorts "2025-01", "2025-02" ...
        .map((k) => ({
          month: k,
          total: monthlyMap[k],
        }));

      // 5) Set state
      setTotalDonations(sumDonations);
      setPendingRequests((pendingSurplus?.length || 0) + (pendingLeave?.length || 0));
      setMonthlyTrends(monthlyArray);
    } catch (err: any) {
      console.error("Error fetching reports data:", err);
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  }

  // -- Render the UI --
  return (
    <Card>
      <CardHeader>
        <CardTitle>Global Donation Reports</CardTitle>
      </CardHeader>
      <CardContent>
        {isLoading && <p className="text-sm text-gray-500 mb-4">Loading...</p>}
        {error && <p className="text-sm text-red-600 mb-4">Error: {error}</p>}

        <div className="grid gap-4 md:grid-cols-3 mb-6">
          <div className="p-4 border rounded-md bg-white dark:bg-gray-800">
            <p className="font-semibold mb-1">Total Donations</p>
            <p className="text-2xl font-bold">
              ${totalDonations.toLocaleString(undefined, { minimumFractionDigits: 2 })}
            </p>
          </div>
          <div className="p-4 border rounded-md bg-white dark:bg-gray-800">
            <p className="font-semibold mb-1">Pending Requests</p>
            <p className="text-2xl font-bold">{pendingRequests}</p>
          </div>
          <div className="p-4 border rounded-md bg-white dark:bg-gray-800">
            <p className="font-semibold mb-1">Churches / Districts</p>
            <p className="text-sm">
              (Manage in <strong>Churches</strong> tab)
            </p>
          </div>
        </div>

        <Separator className="my-4" />

        {/* Monthly Trends Section */}
        <p className="font-semibold text-lg mb-3">Monthly Donation Trends</p>
        {monthlyTrends.length === 0 ? (
          <p className="text-sm text-gray-500">No donation data found.</p>
        ) : (
          <table className="min-w-full text-left border border-gray-200 dark:border-gray-700">
            <thead className="bg-gray-50 dark:bg-gray-700">
              <tr>
                <th className="px-4 py-2 border-b">Month</th>
                <th className="px-4 py-2 border-b">Total Donations</th>
              </tr>
            </thead>
            <tbody>
              {monthlyTrends.map((mt) => (
                <tr key={mt.month}>
                  <td className="px-4 py-2 border-b">{mt.month}</td>
                  <td className="px-4 py-2 border-b">
                    ${mt.total.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}

        {/* 
        If you install a chart library, you can show a line chart or bar chart here:
        
        <LineChart width={600} height={300} data={monthlyTrends}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="month" />
          <YAxis />
          <Tooltip />
          <Line type="monotone" dataKey="total" stroke="#82ca9d" />
        </LineChart>
        */}
      </CardContent>
    </Card>
  );
}
