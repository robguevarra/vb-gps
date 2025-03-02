"use client";

import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { ScrollArea } from "@/components/ui/scroll-area";
import { TooltipProvider } from "@/components/ui/tooltip";
import { createClient } from "@/utils/supabase/client";
import { 
  LineChart, 
  Line, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer 
} from 'recharts';
import { 
  TrendingUp, 
  TrendingDown, 
  Minus,
  Search,
  Filter,
  ChevronDown
} from "lucide-react";
import { Profile } from "@/types";

interface StaffReportsTabProps {
  churchIds: number[];
  selectedLeadPastorName: string;
}

export function LeadPastorStaffReportsTab({ churchIds, selectedLeadPastorName }: StaffReportsTabProps) {
  // State management
  const [staffFilter, setStaffFilter] = useState("");
  const [staffPage, setStaffPage] = useState(1);
  const [selectedStaff, setSelectedStaff] = useState<Profile | null>(null);
  const [showStaffModal, setShowStaffModal] = useState(false);
  const [showFullReport, setShowFullReport] = useState(false);
  const pageSize = 8;

  // Data states
  const [missionaries, setMissionaries] = useState<Profile[]>([]);
  const [donationMap, setDonationMap] = useState<Record<string, Record<string, number>>>({});
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Data fetching
  useEffect(() => {
    const fetchData = async () => {
      try {
        const supabase = createClient();
        
        // Only query if we have church IDs
        if (churchIds.length === 0) {
          setMissionaries([]);
          setIsLoading(false);
          return;
        }

        // Fetch staff data
        const { data: staffData, error: staffError } = await supabase
          .from('profiles')
          .select('*')
          .in('local_church_id', churchIds)
          .in('role', ['missionary', 'campus_director']);

        if (staffError) throw staffError;
        
        setMissionaries(staffData || []);

        // Fetch donations data
        const { data: donationsData, error: donationsError } = await supabase
          .from('donor_donations')
          .select('id, missionary_id, amount, date')
          .in('missionary_id', staffData?.map(m => m.id) || []);

        if (donationsError) throw donationsError;

        // Process donations into a map
        const newDonationMap: Record<string, Record<string, number>> = {};
        
        donationsData?.forEach((don) => {
          if (!newDonationMap[don.missionary_id]) {
            newDonationMap[don.missionary_id] = {};
          }
          const dateObj = new Date(don.date);
          const yy = dateObj.getFullYear();
          const mm = String(dateObj.getMonth() + 1).padStart(2, "0");
          const key = `${yy}-${mm}`;
          newDonationMap[don.missionary_id][key] = 
            (newDonationMap[don.missionary_id][key] || 0) + (don.amount || 0);
        });
        
        setDonationMap(newDonationMap);
        setIsLoading(false);
      } catch (err) {
        console.error('Error fetching data:', err);
        setError(err instanceof Error ? err.message : 'An error occurred');
        setIsLoading(false);
      }
    };

    fetchData();
  }, [churchIds]);

  // Calculate current month ratio for a staff member
  const getCurrentMonthRatio = (staffId: string): number => {
    const now = new Date();
    const key = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
    const donated = donationMap[staffId]?.[key] || 0;
    const staff = missionaries.find(m => m.id === staffId);
    const goal = staff?.monthly_goal || 0;
    return goal > 0 ? Math.round((donated / goal) * 100) : 0;
  };

  // Calculate stats for QuickStats
  const stats = {
    totalStaff: missionaries.length,
    averagePerformance: Math.round(
      missionaries.reduce((acc, m) => acc + getCurrentMonthRatio(m.id), 0) / 
      (missionaries.length || 1)
    ),
    belowTarget: missionaries.filter(m => getCurrentMonthRatio(m.id) < 80).length,
    topPerformance: Math.max(
      ...missionaries.map(m => getCurrentMonthRatio(m.id)),
      0
    )
  };

  // Quick Stats Cards
  const QuickStats = () => (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
      <Card>
        <CardHeader className="pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Total Staff
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{stats.totalStaff}</div>
          <p className="text-xs text-muted-foreground mt-1">
            Across all assigned churches
          </p>
        </CardContent>
      </Card>
      
      <Card>
        <CardHeader className="pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Average Performance
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{stats.averagePerformance}%</div>
          <p className="text-xs text-muted-foreground mt-1">
            Current month average
          </p>
        </CardContent>
      </Card>
      
      <Card>
        <CardHeader className="pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Below Target
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold text-red-500">{stats.belowTarget}</div>
          <p className="text-xs text-muted-foreground mt-1">
            Staff below 80% goal
          </p>
        </CardContent>
      </Card>
      
      <Card>
        <CardHeader className="pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Top Performer
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold text-green-500">{stats.topPerformance}%</div>
          <p className="text-xs text-muted-foreground mt-1">
            Highest achievement
          </p>
        </CardContent>
      </Card>
    </div>
  );

  // Staff Table with modern styling
  const StaffTable = () => {
    const filteredStaff = missionaries.filter(
      (m) => m.full_name.toLowerCase().includes(staffFilter.toLowerCase())
    );
    
    const totalPages = Math.ceil(filteredStaff.length / pageSize);
    const startIdx = (staffPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const pagedStaff = filteredStaff.slice(startIdx, endIdx);

    return (
      <div className="rounded-lg border bg-card">
        <div className="p-4 flex items-center gap-4">
          <div className="relative flex-1 max-w-sm">
            <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
            <Input
              placeholder="Search staff..."
              value={staffFilter}
              onChange={(e) => setStaffFilter(e.target.value)}
              className="pl-8"
            />
          </div>
          <Button variant="outline" size="sm">
            <Filter className="h-4 w-4 mr-2" />
            Filter
            <ChevronDown className="h-4 w-4 ml-1" />
          </Button>
        </div>

        <div className="relative overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-muted/50">
              <tr>
                <th className="px-4 py-3 text-left">Staff Member</th>
                <th className="px-4 py-3 text-left">Role</th>
                <th className="px-4 py-3 text-left">Monthly Goal</th>
                <th className="px-4 py-3 text-left">Current Month</th>
                <th className="px-4 py-3 text-left">6-Month Trend</th>
                <th className="px-4 py-3 text-left">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y">
              {pagedStaff.map((staff) => {
                const currentRatio = getCurrentMonthRatio(staff.id);
                const trendIndicator = currentRatio >= 80 ? (
                  <TrendingUp className="h-4 w-4 text-green-500" />
                ) : (
                  <TrendingDown className="h-4 w-4 text-red-500" />
                );

                return (
                  <tr key={staff.id} className="hover:bg-muted/50 transition-colors">
                    <td className="px-4 py-3">
                      <div className="font-medium">{staff.full_name}</div>
                    </td>
                    <td className="px-4 py-3">
                      <Badge variant="outline" className="capitalize">
                        {staff.role.replace('_', ' ')}
                      </Badge>
                    </td>
                    <td className="px-4 py-3">₱{staff.monthly_goal?.toLocaleString()}</td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-2">
                        <div className="w-24 h-2 bg-muted rounded-full overflow-hidden">
                          <div 
                            className={`h-full transition-all duration-500 ${
                              currentRatio >= 80 ? 'bg-green-500' : 'bg-red-500'
                            }`}
                            style={{ width: `${Math.min(currentRatio, 100)}%` }}
                          />
                        </div>
                        <span className={currentRatio >= 80 ? 'text-green-500' : 'text-red-500'}>
                          {currentRatio}%
                        </span>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-1">
                        {trendIndicator}
                        <span className="text-sm">Improving</span>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-2">
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => {
                            setSelectedStaff(staff);
                            setShowStaffModal(true);
                          }}
                        >
                          Last 6 Months
                        </Button>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => {
                            setSelectedStaff(staff);
                            setShowFullReport(true);
                          }}
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

        {/* Pagination */}
        <div className="p-4 flex items-center justify-between border-t">
          <p className="text-sm text-muted-foreground">
            Showing {startIdx + 1} to {Math.min(endIdx, filteredStaff.length)} of{" "}
            {filteredStaff.length} results
          </p>
          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="sm"
              disabled={staffPage <= 1}
              onClick={() => setStaffPage(staffPage - 1)}
            >
              Previous
            </Button>
            <Button
              variant="outline"
              size="sm"
              disabled={staffPage >= totalPages}
              onClick={() => setStaffPage(staffPage + 1)}
            >
              Next
            </Button>
          </div>
        </div>
      </div>
    );
  };

  // Performance Details Modal
  const PerformanceModal = () => {
    if (!selectedStaff) return null;

    const performanceData = [
      { month: 'Jan', percentage: 85 },
      { month: 'Feb', percentage: 78 },
      { month: 'Mar', percentage: 92 },
      { month: 'Apr', percentage: 88 },
      { month: 'May', percentage: 95 },
      { month: 'Jun', percentage: 85 },
    ];

    return (
      <Dialog open={showStaffModal} onOpenChange={setShowStaffModal}>
        <DialogContent className="max-w-4xl">
          <DialogHeader>
            <DialogTitle>Performance Report - {selectedStaff.full_name}</DialogTitle>
          </DialogHeader>
          <div className="mt-4 space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="text-base">6-Month Performance Trend</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <LineChart data={performanceData}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="month" />
                      <YAxis />
                      <Tooltip />
                      <Line 
                        type="monotone" 
                        dataKey="percentage" 
                        stroke="#2563eb"
                        strokeWidth={2}
                        dot={{ r: 4 }}
                      />
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <Card>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm">Average Performance</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">87%</div>
                </CardContent>
              </Card>
              
              <Card>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm">Highest Month</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold text-green-500">95%</div>
                  <p className="text-xs text-muted-foreground">May 2024</p>
                </CardContent>
              </Card>
              
              <Card>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm">Lowest Month</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold text-red-500">78%</div>
                  <p className="text-xs text-muted-foreground">February 2024</p>
                </CardContent>
              </Card>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    );
  };

  return (
    <TooltipProvider>
      <div className="space-y-8">
        <div className="flex items-center justify-between">
          <h2 className="text-3xl font-bold tracking-tight">Staff Reports</h2>
        </div>

        {isLoading ? (
          <div className="flex items-center justify-center min-h-[400px]">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
          </div>
        ) : error ? (
          <div className="text-center text-red-500">{error}</div>
        ) : (
          <>
            <QuickStats />
            <StaffTable />
          </>
        )}

        <PerformanceModal />
      </div>
    </TooltipProvider>
  );
}
