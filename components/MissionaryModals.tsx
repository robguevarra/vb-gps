import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import { Profile } from "@/types";
import { PartnersTable } from "@/components/reports/PartnersTable";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ArrowUpRight, ArrowDownRight, TrendingUp, TrendingDown, Minus, Calendar, Mail, Phone, User } from "lucide-react";

export function MissionaryLast6Modal({
  isOpen,
  onClose,
  missionary,
  getLastXMonthsRatios,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  getLastXMonthsRatios: (m: Profile, x: number) => Array<{ label: string; ratio: number }>;
  formatNumber: (num: number) => string;
}) {
  if (!missionary) return null;
  const data = getLastXMonthsRatios(missionary, 6);
  
  // Calculate trend (is performance improving or declining)
  const calculateTrend = () => {
    if (data.length < 2) return "neutral";
    const firstHalf = data.slice(0, Math.floor(data.length / 2));
    const secondHalf = data.slice(Math.floor(data.length / 2));
    
    const firstHalfAvg = firstHalf.reduce((sum, item) => sum + item.ratio, 0) / firstHalf.length;
    const secondHalfAvg = secondHalf.reduce((sum, item) => sum + item.ratio, 0) / secondHalf.length;
    
    if (secondHalfAvg > firstHalfAvg + 5) return "improving";
    if (secondHalfAvg < firstHalfAvg - 5) return "declining";
    return "stable";
  };
  
  const trend = calculateTrend();
  
  // Calculate average performance
  const avgPerformance = data.reduce((sum, item) => sum + item.ratio, 0) / data.length;
  
  // Format month labels to be more readable
  const formatMonthLabel = (label: string) => {
    const [year, month] = label.split('-');
    const date = new Date(parseInt(year), parseInt(month) - 1);
    return date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' });
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-3xl">
        <DialogHeader>
          <DialogTitle className="text-xl flex items-center gap-2">
            <span>Performance Report: {missionary.full_name}</span>
            {trend === "improving" && <TrendingUp className="h-5 w-5 text-green-500" />}
            {trend === "declining" && <TrendingDown className="h-5 w-5 text-red-500" />}
            {trend === "stable" && <Minus className="h-5 w-5 text-yellow-500" />}
          </DialogTitle>
          <DialogDescription>
            Last 6 months performance relative to monthly goal of ₱{formatNumber(missionary.monthly_goal || 0)}
          </DialogDescription>
        </DialogHeader>
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 my-4">
          <Card>
            <CardContent className="pt-6">
              <div className="text-center">
                <p className="text-sm font-medium text-muted-foreground mb-1">Average Performance</p>
                <div className="flex justify-center">
                  <Badge 
                    variant={avgPerformance >= 80 ? "default" : avgPerformance >= 60 ? "secondary" : "destructive"}
                    className="text-lg px-3 py-1"
                  >
                    {formatNumber(avgPerformance)}%
                  </Badge>
                </div>
              </div>
            </CardContent>
          </Card>
          
          <Card>
            <CardContent className="pt-6">
              <div className="text-center">
                <p className="text-sm font-medium text-muted-foreground mb-1">Trend</p>
                <div className="flex justify-center items-center gap-1.5">
                  {trend === "improving" && (
                    <Badge variant="default" className="bg-green-500 text-white px-3 py-1">
                      <ArrowUpRight className="h-3.5 w-3.5 mr-1" /> Improving
                    </Badge>
                  )}
                  {trend === "declining" && (
                    <Badge variant="destructive" className="px-3 py-1">
                      <ArrowDownRight className="h-3.5 w-3.5 mr-1" /> Declining
                    </Badge>
                  )}
                  {trend === "stable" && (
                    <Badge variant="secondary" className="px-3 py-1">
                      <Minus className="h-3.5 w-3.5 mr-1" /> Stable
                    </Badge>
                  )}
                </div>
              </div>
            </CardContent>
          </Card>
          
          <Card>
            <CardContent className="pt-6">
              <div className="text-center">
                <p className="text-sm font-medium text-muted-foreground mb-1">Latest Month</p>
                <div className="flex justify-center">
                  <Badge 
                    variant={data[data.length-1]?.ratio >= 80 ? "default" : data[data.length-1]?.ratio >= 60 ? "secondary" : "destructive"}
                    className="text-lg px-3 py-1"
                  >
                    {formatNumber(data[data.length-1]?.ratio || 0)}%
                  </Badge>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        <div className="space-y-4">
          {/* Performance chart (visual representation) */}
          <div className="h-[120px] w-full flex items-end gap-1 px-1 border-b pb-1">
            {data.map((r, index) => {
              const height = `${Math.max(5, Math.min(100, r.ratio))}%`;
              const bgColor = r.ratio >= 100 ? "bg-green-500" : 
                             r.ratio >= 80 ? "bg-green-400" : 
                             r.ratio >= 60 ? "bg-yellow-400" : 
                             r.ratio >= 40 ? "bg-orange-400" : "bg-red-500";
              
              return (
                <div key={r.label} className="flex-1 flex flex-col items-center gap-1">
                  <div className="text-xs font-medium">{formatNumber(r.ratio)}%</div>
                  <div className="w-full relative">
                    <div 
                      className={`w-full ${bgColor} rounded-t-sm transition-all duration-500`} 
                      style={{ height }}
                    />
                  </div>
                  <div className="text-xs text-muted-foreground mt-1 rotate-45 origin-left whitespace-nowrap">
                    {formatMonthLabel(r.label)}
                  </div>
                </div>
              );
            })}
          </div>

          {/* Detailed table */}
          <div className="overflow-x-auto border rounded-md">
            <table className="min-w-full text-sm">
              <thead className="bg-muted/50">
                <tr>
                  <th className="px-4 py-3 text-left font-medium text-muted-foreground">Month</th>
                  <th className="px-4 py-3 text-left font-medium text-muted-foreground">% of Goal</th>
                  <th className="px-4 py-3 text-left font-medium text-muted-foreground">Progress</th>
                  <th className="px-4 py-3 text-left font-medium text-muted-foreground">Status</th>
                </tr>
              </thead>
              <tbody>
                {data.map((r) => {
                  const statusColor = r.ratio >= 100 ? "bg-green-500" : 
                                     r.ratio >= 80 ? "bg-green-400" : 
                                     r.ratio >= 60 ? "bg-yellow-400" : 
                                     r.ratio >= 40 ? "bg-orange-400" : "bg-red-500";
                  
                  const badgeVariant = r.ratio >= 100 ? "default" : 
                                      r.ratio >= 80 ? "secondary" : 
                                      r.ratio >= 60 ? "outline" : "destructive";
                  
                  const statusText = r.ratio >= 100 ? "Excellent" : 
                                    r.ratio >= 80 ? "Good" : 
                                    r.ratio >= 60 ? "Average" : 
                                    r.ratio >= 40 ? "Below Target" : "Critical";
                  
                  return (
                    <tr key={r.label} className="border-b">
                      <td className="px-4 py-3 font-medium">{formatMonthLabel(r.label)}</td>
                      <td className="px-4 py-3">{formatNumber(r.ratio)}%</td>
                      <td className="px-4 py-3">
                        <div className="w-32 h-2 bg-muted rounded-full overflow-hidden">
                          <div 
                            className={`h-full ${statusColor}`} 
                            style={{ width: `${Math.min(r.ratio, 100)}%` }}
                          />
                        </div>
                      </td>
                      <td className="px-4 py-3">
                        <Badge variant={badgeVariant}>{statusText}</Badge>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}

export function FullMissionaryReportModal({
  isOpen,
  onClose,
  missionary,
  donations,
  donationMap,
  thirteenMonthKeys,
  formatNumber,
}: {
  isOpen: boolean;
  onClose: () => void;
  missionary: Profile | null;
  donations: any[];
  donationMap: Record<string, Record<string, number>>;
  thirteenMonthKeys: string[];
  formatNumber: (num: number) => string;
}) {
  if (!missionary) return null;

  // Build partner data structure matching GlobalReportsTab's implementation
  const partnerMap: Record<number, { 
    donorId: number;
    donorName: string;
    email: string;
    phone: string;
    monthlySums: Record<string, number>;
  }> = {};

  donations
    .filter(d => d.missionary_id === missionary.id)
    .forEach(dd => {
      if (dd.donor_id && dd.donors) {
        const donorId = dd.donor_id;
        if (!partnerMap[donorId]) {
          partnerMap[donorId] = {
            donorId,
            donorName: dd.donors.name || "Unknown",
            email: dd.donors.email || "",
            phone: dd.donors.phone || "",
            monthlySums: {},
          };
        }
        const date = new Date(dd.date);
        const monthKey = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}`;
        partnerMap[donorId].monthlySums[monthKey] = 
          (partnerMap[donorId].monthlySums[monthKey] || 0) + (dd.amount || 0);
      }
    });

  const partnerRows = Object.values(partnerMap);
  
  // Calculate monthly totals
  const monthlyTotals: Record<string, number> = {};
  thirteenMonthKeys.forEach(key => {
    monthlyTotals[key] = partnerRows.reduce((sum, partner) => sum + (partner.monthlySums[key] || 0), 0);
  });
  
  // Calculate total donations
  const totalDonations = Object.values(monthlyTotals).reduce((sum, val) => sum + val, 0);
  
  // Calculate monthly goal achievement percentages
  const monthlyGoalPercentages = thirteenMonthKeys.map(key => {
    const total = monthlyTotals[key] || 0;
    const goal = missionary.monthly_goal || 0;
    return {
      month: key,
      percentage: goal > 0 ? (total / goal) * 100 : 0
    };
  });
  
  // Format month labels to be more readable
  const formatMonthLabel = (label: string) => {
    const [year, month] = label.split('-');
    const date = new Date(parseInt(year), parseInt(month) - 1);
    return date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' });
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-[95vw] w-full max-h-[90vh] overflow-auto">
        <DialogHeader>
          <DialogTitle className="text-xl">Full Report - {missionary.full_name}</DialogTitle>
          <DialogDescription>
            Comprehensive 13-month donation report with partner details
          </DialogDescription>
        </DialogHeader>

        <Tabs defaultValue="overview" className="mt-4">
          <TabsList className="mb-4">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="partners">Partner Details</TabsTrigger>
          </TabsList>
          
          <TabsContent value="overview" className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <Card>
                <CardContent className="pt-6">
                  <div className="text-center">
                    <p className="text-sm font-medium text-muted-foreground mb-1">Monthly Goal</p>
                    <p className="text-2xl font-bold">₱{formatNumber(missionary.monthly_goal || 0)}</p>
                  </div>
                </CardContent>
              </Card>
              
              <Card>
                <CardContent className="pt-6">
                  <div className="text-center">
                    <p className="text-sm font-medium text-muted-foreground mb-1">Total Donations (13 mo)</p>
                    <p className="text-2xl font-bold">₱{formatNumber(totalDonations)}</p>
                  </div>
                </CardContent>
              </Card>
              
              <Card>
                <CardContent className="pt-6">
                  <div className="text-center">
                    <p className="text-sm font-medium text-muted-foreground mb-1">Active Partners</p>
                    <p className="text-2xl font-bold">{partnerRows.length}</p>
                  </div>
                </CardContent>
              </Card>
            </div>
            
            {/* Monthly performance chart */}
            <Card>
              <CardContent className="pt-6">
                <h3 className="text-lg font-medium mb-4">Monthly Performance</h3>
                <div className="h-[160px] w-full flex items-end gap-1 px-1 border-b pb-1">
                  {monthlyGoalPercentages.map((item, index) => {
                    const height = `${Math.max(5, Math.min(100, item.percentage))}%`;
                    const bgColor = item.percentage >= 100 ? "bg-green-500" : 
                                   item.percentage >= 80 ? "bg-green-400" : 
                                   item.percentage >= 60 ? "bg-yellow-400" : 
                                   item.percentage >= 40 ? "bg-orange-400" : "bg-red-500";
                    
                    return (
                      <div key={item.month} className="flex-1 flex flex-col items-center gap-1">
                        <div className="text-xs font-medium">{formatNumber(item.percentage)}%</div>
                        <div className="w-full relative">
                          <div 
                            className={`w-full ${bgColor} rounded-t-sm transition-all duration-500`} 
                            style={{ height }}
                          />
                        </div>
                        <div className="text-xs text-muted-foreground mt-1 rotate-45 origin-left whitespace-nowrap">
                          {formatMonthLabel(item.month)}
                        </div>
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
            
            {/* Monthly totals table */}
            <Card>
              <CardContent className="pt-6">
                <h3 className="text-lg font-medium mb-4">Monthly Donation Totals</h3>
                <div className="overflow-x-auto">
                  <table className="min-w-full text-sm">
                    <thead className="bg-muted/50">
                      <tr>
                        <th className="px-4 py-3 text-left font-medium text-muted-foreground">Month</th>
                        <th className="px-4 py-3 text-left font-medium text-muted-foreground">Total Donations</th>
                        <th className="px-4 py-3 text-left font-medium text-muted-foreground">% of Goal</th>
                        <th className="px-4 py-3 text-left font-medium text-muted-foreground">Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      {thirteenMonthKeys.map(key => {
                        const total = monthlyTotals[key] || 0;
                        const goal = missionary.monthly_goal || 0;
                        const percentage = goal > 0 ? (total / goal) * 100 : 0;
                        
                        const badgeVariant = percentage >= 100 ? "default" : 
                                           percentage >= 80 ? "secondary" : 
                                           percentage >= 60 ? "outline" : "destructive";
                        
                        const statusText = percentage >= 100 ? "Excellent" : 
                                          percentage >= 80 ? "Good" : 
                                          percentage >= 60 ? "Average" : 
                                          percentage >= 40 ? "Below Target" : "Critical";
                        
                        return (
                          <tr key={key} className="border-b">
                            <td className="px-4 py-3 font-medium">{formatMonthLabel(key)}</td>
                            <td className="px-4 py-3">₱{formatNumber(total)}</td>
                            <td className="px-4 py-3">{formatNumber(percentage)}%</td>
                            <td className="px-4 py-3">
                              <Badge variant={badgeVariant}>{statusText}</Badge>
                            </td>
                          </tr>
                        );
                      })}
                    </tbody>
                  </table>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
          
          <TabsContent value="partners" className="space-y-6">
            <div className="overflow-x-auto border rounded-md">
              <table className="min-w-full text-left text-sm">
                <thead className="bg-muted/50">
                  <tr>
                    <th className="px-4 py-3 text-left font-medium text-muted-foreground sticky left-0 bg-muted/50">
                      <div className="flex items-center gap-1">
                        <User className="h-4 w-4" />
                        <span>Partner</span>
                      </div>
                    </th>
                    <th className="px-4 py-3 text-left font-medium text-muted-foreground">
                      <div className="flex items-center gap-1">
                        <Mail className="h-4 w-4" />
                        <span>Email</span>
                      </div>
                    </th>
                    <th className="px-4 py-3 text-left font-medium text-muted-foreground">
                      <div className="flex items-center gap-1">
                        <Phone className="h-4 w-4" />
                        <span>Phone</span>
                      </div>
                    </th>
                    {thirteenMonthKeys.map((key) => (
                      <th key={key} className="px-4 py-3 text-left font-medium text-muted-foreground">
                        <div className="flex items-center gap-1">
                          <Calendar className="h-4 w-4" />
                          <span>{formatMonthLabel(key)}</span>
                        </div>
                      </th>
                    ))}
                    <th className="px-4 py-3 text-left font-medium text-muted-foreground">Total</th>
                  </tr>
                </thead>
                <tbody>
                  {partnerRows.map((p) => {
                    let rowTotal = 0;
                    return (
                      <tr key={p.donorId} className="border-b hover:bg-muted/30 transition-colors">
                        <td className="px-4 py-3 font-medium sticky left-0 bg-white">{p.donorName}</td>
                        <td className="px-4 py-3 text-muted-foreground">{p.email || "-"}</td>
                        <td className="px-4 py-3 text-muted-foreground">{p.phone || "-"}</td>
                        {thirteenMonthKeys.map((monthKey) => {
                          const val = p.monthlySums[monthKey] || 0;
                          rowTotal += val;
                          return (
                            <td key={monthKey} className="px-4 py-3">
                              {val > 0 ? `₱${formatNumber(val)}` : "-"}
                            </td>
                          );
                        })}
                        <td className="px-4 py-3 font-semibold">
                          ₱{formatNumber(rowTotal)}
                        </td>
                      </tr>
                    );
                  })}

                  {/* Totals row */}
                  <tr className="border-t-2 font-medium bg-muted/20">
                    <td className="px-4 py-3 sticky left-0 bg-muted/20" colSpan={3}>Monthly Totals</td>
                    {thirteenMonthKeys.map((monthKey) => (
                      <td key={monthKey} className="px-4 py-3">
                        ₱{formatNumber(monthlyTotals[monthKey] || 0)}
                      </td>
                    ))}
                    <td className="px-4 py-3">
                      ₱{formatNumber(totalDonations)}
                    </td>
                  </tr>

                  {partnerRows.length === 0 && (
                    <tr>
                      <td
                        className="px-4 py-8 text-center text-muted-foreground"
                        colSpan={thirteenMonthKeys.length + 4}
                      >
                        No partners found for this missionary.
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </TabsContent>
        </Tabs>
      </DialogContent>
    </Dialog>
  );
} 