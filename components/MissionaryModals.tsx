import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import { Profile } from "@/types";
import { PartnersTable } from "@/components/reports/PartnersTable";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ArrowUpRight, ArrowDownRight, TrendingUp, TrendingDown, Minus, Calendar, Mail, Phone, User, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { motion } from "framer-motion";

// Animation variants
const fadeIn = {
  hidden: { opacity: 0 },
  visible: { opacity: 1, transition: { duration: 0.3 } }
};

const slideUp = {
  hidden: { opacity: 0, y: 20 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.4 } }
};

const staggerContainer = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.1
    }
  }
};

const barAnimation = {
  hidden: { height: 0 },
  visible: (height: string) => ({
    height,
    transition: { duration: 0.5, ease: "easeOut" }
  })
};

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
      <DialogContent className="max-w-3xl w-[95vw] sm:w-auto max-h-[90vh] overflow-auto">
        <motion.div
          initial="hidden"
          animate="visible"
          variants={fadeIn}
        >
        <DialogHeader className="relative">
          <DialogTitle className="text-xl flex items-center gap-2">
            <motion.span 
              className="line-clamp-1"
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.3 }}
            >
              Performance: {missionary.full_name}
            </motion.span>
            {trend === "improving" && (
              <motion.div
                initial={{ scale: 0, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ type: "spring", stiffness: 500, damping: 15, delay: 0.2 }}
              >
                <TrendingUp className="h-5 w-5 text-[#00458d] flex-shrink-0" />
              </motion.div>
            )}
            {trend === "declining" && (
              <motion.div
                initial={{ scale: 0, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ type: "spring", stiffness: 500, damping: 15, delay: 0.2 }}
              >
                <TrendingDown className="h-5 w-5 text-gray-500 flex-shrink-0" />
              </motion.div>
            )}
            {trend === "stable" && (
              <motion.div
                initial={{ scale: 0, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ type: "spring", stiffness: 500, damping: 15, delay: 0.2 }}
              >
                <Minus className="h-5 w-5 text-gray-400 flex-shrink-0" />
              </motion.div>
            )}
          </DialogTitle>
          <DialogDescription className="line-clamp-2">
            <motion.span
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.3, delay: 0.1 }}
            >
              Last 6 months performance relative to monthly goal of ₱{formatNumber(missionary.monthly_goal || 0)}
            </motion.span>
          </DialogDescription>
        </DialogHeader>
        
          <motion.div 
            className="grid grid-cols-1 sm:grid-cols-3 gap-4 my-4"
            variants={staggerContainer}
            initial="hidden"
            animate="visible"
          >
            <motion.div variants={slideUp}>
              <motion.div
                whileHover={{ scale: 1.02 }}
                transition={{ type: "spring", stiffness: 400, damping: 17 }}
              >
                <Card className="overflow-hidden border shadow-sm hover:shadow-md transition-all duration-200 bg-gradient-to-br from-background to-muted/20">
                  <CardContent className="p-0">
                    <div className="p-4 border-b border-muted/30">
                      <p className="text-sm font-medium text-muted-foreground text-center">Average Performance</p>
                    </div>
                    <div className="p-5 flex justify-center items-center">
                      <motion.div
                        initial={{ scale: 0.8, opacity: 0 }}
                        animate={{ scale: 1, opacity: 1 }}
                        transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.2 }}
                      >
                        <Badge 
                          variant={avgPerformance >= 80 ? "default" : avgPerformance >= 60 ? "secondary" : "outline"}
                          className="text-lg px-4 py-1.5 shadow-sm"
                        >
                          {formatNumber(avgPerformance)}%
                        </Badge>
                      </motion.div>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            </motion.div>
          
            <motion.div variants={slideUp}>
              <motion.div
                whileHover={{ scale: 1.02 }}
                transition={{ type: "spring", stiffness: 400, damping: 17 }}
              >
                <Card className="overflow-hidden border shadow-sm hover:shadow-md transition-all duration-200 bg-gradient-to-br from-background to-muted/20">
                  <CardContent className="p-0">
                    <div className="p-4 border-b border-muted/30">
                      <p className="text-sm font-medium text-muted-foreground text-center">Trend</p>
                    </div>
                    <div className="p-5 flex justify-center items-center">
                      {trend === "improving" && (
                        <motion.div
                          initial={{ y: 10, opacity: 0 }}
                          animate={{ y: 0, opacity: 1 }}
                          transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.3 }}
                        >
                          <Badge 
                            variant={trend === "improving" ? "default" : trend === "stable" ? "secondary" : "outline"}
                            className="text-lg px-4 py-1.5 shadow-sm"
                          >
                            {trend === "improving" ? (
                              <TrendingUp className="mr-1 h-4 w-4 text-[#00458d]" />
                            ) : trend === "declining" ? (
                              <TrendingDown className="mr-1 h-4 w-4 text-gray-500" />
                            ) : (
                              <Minus className="mr-1 h-4 w-4 text-gray-400" />
                            )}
                            {trend.charAt(0).toUpperCase() + trend.slice(1)}
                          </Badge>
                        </motion.div>
                      )}
                      {trend === "declining" && (
                        <motion.div
                          initial={{ y: 10, opacity: 0 }}
                          animate={{ y: 0, opacity: 1 }}
                          transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.3 }}
                        >
                          <Badge variant="outline" className="px-3 py-1.5 shadow-sm flex items-center gap-1">
                            <ArrowDownRight className="h-3.5 w-3.5" /> 
                            <span>Declining</span>
                          </Badge>
                        </motion.div>
                      )}
                      {trend === "stable" && (
                        <motion.div
                          initial={{ y: 10, opacity: 0 }}
                          animate={{ y: 0, opacity: 1 }}
                          transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.3 }}
                        >
                          <Badge variant="secondary" className="px-3 py-1.5 shadow-sm flex items-center gap-1">
                            <Minus className="h-3.5 w-3.5" /> 
                            <span>Stable</span>
                          </Badge>
                        </motion.div>
                      )}
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            </motion.div>
          
            <motion.div variants={slideUp}>
              <motion.div
                whileHover={{ scale: 1.02 }}
                transition={{ type: "spring", stiffness: 400, damping: 17 }}
              >
                <Card className="overflow-hidden border shadow-sm hover:shadow-md transition-all duration-200 bg-gradient-to-br from-background to-muted/20">
                  <CardContent className="p-0">
                    <div className="p-4 border-b border-muted/30">
                      <p className="text-sm font-medium text-muted-foreground text-center">Latest Month</p>
                    </div>
                    <div className="p-5 flex justify-center items-center">
                      <motion.div
                        initial={{ scale: 0.8, opacity: 0 }}
                        animate={{ scale: 1, opacity: 1 }}
                        transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.4 }}
                      >
                        <Badge 
                          variant={data[data.length-1]?.ratio >= 80 ? "default" : data[data.length-1]?.ratio >= 60 ? "secondary" : "outline"}
                          className="text-lg px-4 py-1.5 shadow-sm"
                        >
                          {formatNumber(data[data.length-1]?.ratio || 0)}%
                        </Badge>
                      </motion.div>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            </motion.div>
          </motion.div>

        <div className="space-y-4">
          {/* Performance chart (visual representation) */}
            <motion.div 
              className="h-[160px] w-full flex items-end gap-1 px-1 border-b pb-1 overflow-x-auto sm:overflow-x-visible"
              variants={staggerContainer}
              initial="hidden"
              animate="visible"
            >
            {data.map((r, index) => {
              const height = `${Math.max(5, Math.min(100, r.ratio))}%`;
              const bgColor = r.ratio >= 100 ? "bg-[#00458d]" : 
                             r.ratio >= 80 ? "bg-[#0056b3]" : 
                             r.ratio >= 60 ? "bg-[#3378be]" : 
                             r.ratio >= 40 ? "bg-[#6699cc]" : "bg-gray-400";
              
              return (
                  <motion.div 
                    key={r.label} 
                    className="flex-1 min-w-[50px] sm:min-w-0 flex flex-col items-center gap-1"
                    variants={slideUp}
                  >
                  <div className="text-xs font-medium">{formatNumber(r.ratio)}%</div>
                  <div className="w-full relative">
                      <motion.div 
                        className={`w-full ${bgColor} rounded-t-sm relative`} 
                        custom={height}
                        variants={barAnimation}
                      >
                        <motion.div 
                          className="absolute inset-0 bg-white/20"
                          animate={{ 
                            x: ["0%", "100%", "0%"],
                          }}
                          transition={{ 
                            duration: 2, 
                            ease: "linear", 
                            repeat: Infinity,
                            repeatType: "loop" 
                          }}
                        />
                      </motion.div>
                  </div>
                    <div className="text-xs text-muted-foreground mt-1 whitespace-nowrap sm:rotate-45 sm:origin-left">
                    {formatMonthLabel(r.label)}
                    </div>
                  </motion.div>
                );
              })}
            </motion.div>

            {/* Detailed table - Mobile view */}
            <motion.div 
              className="md:hidden space-y-3"
              variants={staggerContainer}
              initial="hidden"
              animate="visible"
            >
              {data.map((r, index) => {
                const statusColor = r.ratio >= 100 ? "bg-[#00458d]" : 
                                   r.ratio >= 80 ? "bg-[#0056b3]" : 
                                   r.ratio >= 60 ? "bg-[#3378be]" : 
                                   r.ratio >= 40 ? "bg-[#6699cc]" : "bg-gray-400";
                
                const badgeVariant = r.ratio >= 100 ? "default" : 
                                    r.ratio >= 80 ? "secondary" : 
                                    r.ratio >= 60 ? "outline" : "outline";
                
                const statusText = r.ratio >= 100 ? "Excellent" : 
                                  r.ratio >= 80 ? "Good" : 
                                  r.ratio >= 60 ? "Average" : 
                                  r.ratio >= 40 ? "Below Target" : "Critical";
                
                // Determine background gradient based on performance
                const cardGradient = r.ratio >= 80 
                  ? "bg-gradient-to-br from-[#f0f4f9] to-white dark:from-[#00458d]/10 dark:to-background" 
                  : r.ratio >= 60 
                    ? "bg-gradient-to-br from-[#f5f8fc] to-white dark:from-[#00458d]/5 dark:to-background" 
                    : "bg-gradient-to-br from-[#f8fafd] to-white dark:from-gray-900/10 dark:to-background";
                
                // Determine shimmer effect color based on performance
                const shimmerColor = r.ratio >= 80 
                  ? "before:from-[#f0f4f9]/0 before:via-[#f0f4f9]/30 before:to-[#f0f4f9]/0 dark:before:from-[#00458d]/0 dark:before:via-[#00458d]/10 dark:before:to-[#00458d]/0" 
                  : r.ratio >= 60 
                    ? "before:from-[#f5f8fc]/0 before:via-[#f5f8fc]/30 before:to-[#f5f8fc]/0 dark:before:from-[#00458d]/0 dark:before:via-[#00458d]/5 dark:before:to-[#00458d]/0" 
                    : "before:from-gray-100/0 before:via-gray-100/20 before:to-gray-100/0 dark:before:from-gray-900/0 dark:before:via-gray-900/5 dark:before:to-gray-900/0";
                
                return (
                  <motion.div 
                    key={r.label} 
                    className={`relative overflow-hidden rounded-xl border ${cardGradient} shadow-sm hover:shadow-md transition-all duration-300 before:absolute before:inset-0 before:bg-gradient-to-r ${shimmerColor} before:bg-[length:200%_100%] before:z-0 before:pointer-events-none`}
                    variants={slideUp}
                    whileHover={{ scale: 1.01 }}
                    transition={{ type: "spring", stiffness: 400, damping: 17 }}
                  >
                    <motion.div
                      className="absolute inset-0 z-0 pointer-events-none"
                      animate={{ 
                        backgroundPosition: ["200% 0", "0% 0", "200% 0"],
                      }}
                      transition={{ 
                        duration: 3, 
                        ease: "linear", 
                        repeat: Infinity,
                        repeatType: "loop" 
                      }}
                    />
                    <div className="relative z-10">
                      <div className="p-4 border-b border-muted/30 flex justify-between items-center backdrop-blur-[2px]">
                        <span className="font-medium">{formatMonthLabel(r.label)}</span>
                        <motion.div
                          initial={{ scale: 0.9, opacity: 0 }}
                          animate={{ scale: 1, opacity: 1 }}
                          transition={{ delay: index * 0.05 + 0.2, type: "spring", stiffness: 300, damping: 15 }}
                        >
                          <Badge variant={badgeVariant} className="px-2.5 py-1 shadow-sm">{statusText}</Badge>
                        </motion.div>
                      </div>
                      <div className="p-4 space-y-3">
                        <div className="flex justify-between items-center">
                          <span className="text-sm font-medium">Performance</span>
                          <motion.span 
                            className="text-sm font-bold"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ delay: index * 0.05 + 0.3, duration: 0.3 }}
                          >
                            {formatNumber(r.ratio)}%
                          </motion.span>
                        </div>
                        <div className="h-3 bg-muted/40 rounded-full overflow-hidden">
                          <motion.div 
                            className={`h-full ${statusColor} rounded-full relative`}
                            initial={{ width: 0 }}
                            animate={{ width: `${Math.min(r.ratio, 100)}%` }}
                            transition={{ 
                              duration: 0.8, 
                              ease: [0.34, 1.56, 0.64, 1],
                              delay: index * 0.05 + 0.1
                            }}
                          >
                            <motion.div 
                              className="absolute inset-0 bg-white/20"
                              animate={{ 
                                x: ["0%", "100%", "0%"],
                              }}
                              transition={{ 
                                duration: 2, 
                                ease: "linear", 
                                repeat: Infinity,
                                repeatType: "loop" 
                              }}
                            />
                          </motion.div>
                        </div>
                      </div>
                    </div>
                  </motion.div>
                );
              })}
            </motion.div>

            {/* Detailed table - Desktop view */}
            <motion.div 
              className="hidden md:block overflow-x-auto border rounded-md"
              variants={fadeIn}
              initial="hidden"
              animate="visible"
            >
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
                  const statusColor = r.ratio >= 100 ? "bg-[#00458d]" : 
                                     r.ratio >= 80 ? "bg-[#0056b3]" : 
                                     r.ratio >= 60 ? "bg-[#3378be]" : 
                                     r.ratio >= 40 ? "bg-[#6699cc]" : "bg-gray-400";
                  
                  const badgeVariant = r.ratio >= 100 ? "default" : 
                                      r.ratio >= 80 ? "secondary" : 
                                      r.ratio >= 60 ? "outline" : "outline";
                  
                  const statusText = r.ratio >= 100 ? "Excellent" : 
                                    r.ratio >= 80 ? "Good" : 
                                    r.ratio >= 60 ? "Average" : 
                                    r.ratio >= 40 ? "Below Target" : "Critical";
                  
                  return (
                      <motion.tr 
                        key={r.label} 
                        className="border-b"
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.3 }}
                      >
                      <td className="px-4 py-3 font-medium">{formatMonthLabel(r.label)}</td>
                      <td className="px-4 py-3">{formatNumber(r.ratio)}%</td>
                      <td className="px-4 py-3">
                        <div className="w-32 h-2 bg-muted rounded-full overflow-hidden">
                            <motion.div 
                            className={`h-full ${statusColor}`} 
                              initial={{ width: 0 }}
                              animate={{ width: `${Math.min(r.ratio, 100)}%` }}
                              transition={{ duration: 0.5, ease: "easeOut" }}
                        />
                      </div>
                    </td>
                      <td className="px-4 py-3">
                        <Badge variant={badgeVariant}>{statusText}</Badge>
                      </td>
                      </motion.tr>
                  );
                })}
              </tbody>
            </table>
            </motion.div>
          </div>
        </motion.div>
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
        <motion.div
          initial="hidden"
          animate="visible"
          variants={fadeIn}
        >
        <DialogHeader className="relative">
          <DialogTitle className="text-xl">
            <motion.span
              initial={{ opacity: 0, y: -5 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
            >
              Full Report - {missionary.full_name}
            </motion.span>
          </DialogTitle>
          <DialogDescription>
            <motion.span
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.3, delay: 0.1 }}
            >
              Comprehensive 13-month donation report with partner details
            </motion.span>
          </DialogDescription>
        </DialogHeader>

        <Tabs defaultValue="overview" className="mt-4">
          <TabsList className="w-full sm:w-auto flex">
            <TabsTrigger value="overview" className="flex-1 sm:flex-initial">Overview</TabsTrigger>
            <TabsTrigger value="partners" className="flex-1 sm:flex-initial">Partner Details</TabsTrigger>
          </TabsList>
          
          <TabsContent value="overview" className="space-y-6">
              <motion.div 
                className="grid grid-cols-1 sm:grid-cols-3 gap-4"
                variants={staggerContainer}
                initial="hidden"
                animate="visible"
              >
                <motion.div variants={slideUp}>
                  <motion.div
                    whileHover={{ scale: 1.02 }}
                    transition={{ type: "spring", stiffness: 400, damping: 17 }}
                  >
                    <Card className="overflow-hidden border shadow-sm hover:shadow-md transition-all duration-200 bg-gradient-to-br from-background to-muted/20">
                      <CardContent className="p-0">
                        <div className="p-4 border-b border-muted/30">
                          <p className="text-sm font-medium text-muted-foreground text-center">Monthly Goal</p>
                        </div>
                        <div className="p-5 flex justify-center items-center">
                          <motion.p 
                            className="text-2xl font-bold"
                            initial={{ scale: 0.9, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.2 }}
                          >
                            ₱{formatNumber(missionary.monthly_goal || 0)}
                          </motion.p>
                        </div>
                      </CardContent>
                    </Card>
                  </motion.div>
                </motion.div>
              
                <motion.div variants={slideUp}>
                  <motion.div
                    whileHover={{ scale: 1.02 }}
                    transition={{ type: "spring", stiffness: 400, damping: 17 }}
                  >
                    <Card className="overflow-hidden border shadow-sm hover:shadow-md transition-all duration-200 bg-gradient-to-br from-background to-muted/20">
                      <CardContent className="p-0">
                        <div className="p-4 border-b border-muted/30">
                          <p className="text-sm font-medium text-muted-foreground text-center">Total Donations (13 mo)</p>
                        </div>
                        <div className="p-5 flex justify-center items-center">
                          <motion.p 
                            className="text-2xl font-bold"
                            initial={{ scale: 0.9, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.3 }}
                          >
                            ₱{formatNumber(totalDonations)}
                          </motion.p>
                        </div>
                      </CardContent>
                    </Card>
                  </motion.div>
                </motion.div>
              
                <motion.div variants={slideUp}>
                  <motion.div
                    whileHover={{ scale: 1.02 }}
                    transition={{ type: "spring", stiffness: 400, damping: 17 }}
                  >
                    <Card className="overflow-hidden border shadow-sm hover:shadow-md transition-all duration-200 bg-gradient-to-br from-background to-muted/20">
                      <CardContent className="p-0">
                        <div className="p-4 border-b border-muted/30">
                          <p className="text-sm font-medium text-muted-foreground text-center">Active Partners</p>
                        </div>
                        <div className="p-5 flex justify-center items-center">
                          <motion.p 
                            className="text-2xl font-bold"
                            initial={{ scale: 0.9, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            transition={{ type: "spring", stiffness: 300, damping: 15, delay: 0.4 }}
                          >
                            {partnerRows.length}
                          </motion.p>
                        </div>
                      </CardContent>
                    </Card>
                  </motion.div>
                </motion.div>
              </motion.div>
            
            {/* Monthly performance chart */}
              <motion.div
                variants={fadeIn}
                initial="hidden"
                animate="visible"
              >
            <Card className="overflow-hidden border shadow-sm hover:shadow-md transition-all duration-200">
              <CardContent className="pt-6">
                <h3 className="text-lg font-medium mb-4">Monthly Performance</h3>
                    <div className="h-[180px] w-full flex items-end gap-1 px-1 border-b pb-1 overflow-x-auto sm:overflow-x-visible">
                  {monthlyGoalPercentages.map((item, index) => {
                    const height = `${Math.max(5, Math.min(100, item.percentage))}%`;
                    const bgColor = item.percentage >= 100 ? "bg-[#00458d]" : 
                                   item.percentage >= 80 ? "bg-[#0056b3]" : 
                                   item.percentage >= 60 ? "bg-[#3378be]" : 
                                   item.percentage >= 40 ? "bg-[#6699cc]" : "bg-gray-400";
                    
                    return (
                      <motion.div 
                        key={item.month} 
                        className="flex-1 min-w-[50px] sm:min-w-0 flex flex-col items-center gap-1"
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: index * 0.03, duration: 0.4 }}
                      >
                        <div className="text-xs font-medium">{formatNumber(item.percentage)}%</div>
                        <div className="w-full relative">
                          <motion.div 
                            className={`w-full ${bgColor} rounded-t-sm relative`}
                            initial={{ height: 0 }}
                            animate={{ height }}
                            transition={{ 
                              duration: 0.8, 
                              ease: [0.34, 1.56, 0.64, 1],
                              delay: index * 0.03 + 0.2
                            }}
                          >
                            <motion.div 
                              className="absolute inset-0 bg-white/20"
                              animate={{ 
                                x: ["0%", "100%", "0%"],
                              }}
                              transition={{ 
                                duration: 2, 
                                ease: "linear", 
                                repeat: Infinity,
                                repeatType: "loop" 
                              }}
                            />
                          </motion.div>
                        </div>
                        <div className="text-xs text-muted-foreground mt-1 whitespace-nowrap sm:rotate-45 sm:origin-left">
                          {formatMonthLabel(item.month)}
                        </div>
                      </motion.div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
              </motion.div>
              
              {/* Monthly totals - Mobile view */}
              <motion.div 
                className="md:hidden space-y-4"
                variants={staggerContainer}
                initial="hidden"
                animate="visible"
              >
                <h3 className="text-lg font-semibold">Monthly Donation Totals</h3>
                {thirteenMonthKeys.map((key, index) => {
                  const total = monthlyTotals[key] || 0;
                  const goal = missionary.monthly_goal || 0;
                  const percentage = goal > 0 ? (total / goal) * 100 : 0;
                  
                  const statusColor = percentage >= 100 ? "bg-[#00458d]" : 
                                     percentage >= 80 ? "bg-[#0056b3]" : 
                                     percentage >= 60 ? "bg-[#3378be]" : 
                                     percentage >= 40 ? "bg-[#6699cc]" : "bg-gray-400";
                  
                  const badgeVariant = percentage >= 100 ? "default" : 
                                      percentage >= 80 ? "secondary" : 
                                      percentage >= 60 ? "outline" : "outline";
                  
                  const statusText = percentage >= 100 ? "Excellent" : 
                                    percentage >= 80 ? "Good" : 
                                    percentage >= 60 ? "Average" : 
                                    percentage >= 40 ? "Below Target" : "Critical";
                  
                  // Determine background gradient based on performance
                  const cardGradient = percentage >= 80 
                    ? "bg-gradient-to-br from-[#f0f4f9] to-white dark:from-[#00458d]/10 dark:to-background" 
                    : percentage >= 60 
                      ? "bg-gradient-to-br from-[#f5f8fc] to-white dark:from-[#00458d]/5 dark:to-background" 
                      : "bg-gradient-to-br from-[#f8fafd] to-white dark:from-gray-900/10 dark:to-background";
                  
                  // Determine shimmer effect color based on performance
                  const shimmerColor = percentage >= 80 
                    ? "before:from-[#f0f4f9]/0 before:via-[#f0f4f9]/30 before:to-[#f0f4f9]/0 dark:before:from-[#00458d]/0 dark:before:via-[#00458d]/10 dark:before:to-[#00458d]/0" 
                    : percentage >= 60 
                      ? "before:from-[#f5f8fc]/0 before:via-[#f5f8fc]/30 before:to-[#f5f8fc]/0 dark:before:from-[#00458d]/0 dark:before:via-[#00458d]/5 dark:before:to-[#00458d]/0" 
                    : "before:from-gray-100/0 before:via-gray-100/20 before:to-gray-100/0 dark:before:from-gray-900/0 dark:before:via-gray-900/5 dark:before:to-gray-900/0";
                  
                  return (
                    <motion.div 
                      key={key} 
                      className={`relative overflow-hidden rounded-xl border ${cardGradient} shadow-sm hover:shadow-md transition-all duration-300 before:absolute before:inset-0 before:bg-gradient-to-r ${shimmerColor} before:bg-[length:200%_100%] before:z-0 before:pointer-events-none`}
                      variants={slideUp}
                      whileHover={{ scale: 1.01 }}
                      transition={{ type: "spring", stiffness: 400, damping: 17 }}
                    >
                      <motion.div
                        className="absolute inset-0 z-0 pointer-events-none"
                        animate={{ 
                          backgroundPosition: ["200% 0", "0% 0", "200% 0"],
                        }}
                        transition={{ 
                          duration: 3, 
                          ease: "linear", 
                          repeat: Infinity,
                          repeatType: "loop" 
                        }}
                      />
                      <div className="relative z-10">
                        <div className="p-4 border-b border-muted/30 flex justify-between items-center backdrop-blur-[2px]">
                          <span className="font-medium">{formatMonthLabel(key)}</span>
                          <motion.div
                            initial={{ scale: 0.9, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            transition={{ delay: index * 0.05 + 0.2, type: "spring", stiffness: 300, damping: 15 }}
                          >
                            <Badge variant={badgeVariant} className="px-2.5 py-1 shadow-sm">{statusText}</Badge>
                          </motion.div>
                        </div>
                        <div className="p-4 space-y-4">
                          <div className="flex justify-between items-center">
                            <span className="text-sm font-medium text-muted-foreground">Total</span>
                            <motion.span 
                              className="font-semibold"
                              initial={{ opacity: 0 }}
                              animate={{ opacity: 1 }}
                              transition={{ delay: index * 0.05 + 0.3, duration: 0.3 }}
                            >
                              ₱{formatNumber(total)}
                            </motion.span>
                          </div>
                          <div className="space-y-2">
                            <div className="flex justify-between items-center">
                              <span className="text-xs font-medium text-muted-foreground">Goal Progress</span>
                              <span className={`text-xs font-medium ${percentage >= 80 ? "text-[#00458d] dark:text-[#6699cc]" : percentage >= 60 ? "text-[#0056b3] dark:text-[#3378be]" : "text-gray-600 dark:text-gray-400"}`}>
                                {formatNumber(percentage)}%
                              </span>
                            </div>
                            <div className="h-3 bg-muted/40 rounded-full overflow-hidden">
                              <motion.div 
                                className={`h-full ${statusColor} rounded-full relative`}
                                initial={{ width: 0 }}
                                animate={{ width: `${Math.min(percentage, 100)}%` }}
                                transition={{ 
                                  duration: 0.8, 
                                  ease: [0.34, 1.56, 0.64, 1],
                                  delay: index * 0.05 + 0.1
                                }}
                              >
                                <motion.div 
                                  className="absolute inset-0 bg-white/20"
                                  animate={{ 
                                    x: ["0%", "100%", "0%"],
                                  }}
                                  transition={{ 
                                    duration: 2, 
                                    ease: "linear", 
                                    repeat: Infinity,
                                    repeatType: "loop" 
                                  }}
                                />
                              </motion.div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </motion.div>
                  );
                })}
              </motion.div>

              {/* Monthly totals - Mobile view */}
              <motion.div 
                className="md:hidden space-y-4"
                variants={staggerContainer}
                initial="hidden"
                animate="visible"
              >
                <h3 className="text-lg font-semibold">Monthly Donation Totals</h3>
                {thirteenMonthKeys.map((key, index) => {
                  const total = monthlyTotals[key] || 0;
                  const goal = missionary.monthly_goal || 0;
                  const percentage = goal > 0 ? (total / goal) * 100 : 0;
                  
                  const statusColor = percentage >= 100 ? "bg-[#00458d]" : 
                                     percentage >= 80 ? "bg-[#0056b3]" : 
                                     percentage >= 60 ? "bg-[#3378be]" : 
                                     percentage >= 40 ? "bg-[#6699cc]" : "bg-gray-400";
                  
                  const badgeVariant = percentage >= 100 ? "default" : 
                                      percentage >= 80 ? "secondary" : 
                                      percentage >= 60 ? "outline" : "outline";
                  
                  const statusText = percentage >= 100 ? "Excellent" : 
                                    percentage >= 80 ? "Good" : 
                                    percentage >= 60 ? "Average" : 
                                    percentage >= 40 ? "Below Target" : "Critical";
                  
                  // Determine background gradient based on performance
                  const cardGradient = percentage >= 80 
                    ? "bg-gradient-to-br from-[#f0f4f9] to-white dark:from-[#00458d]/10 dark:to-background" 
                    : percentage >= 60 
                      ? "bg-gradient-to-br from-[#f5f8fc] to-white dark:from-[#00458d]/5 dark:to-background" 
                      : "bg-gradient-to-br from-[#f8fafd] to-white dark:from-gray-900/10 dark:to-background";
                  
                  return (
                    <motion.div 
                      key={key} 
                      className={`border rounded-lg shadow-sm overflow-hidden ${cardGradient}`}
                      variants={slideUp}
                    >
                      <div className="p-4 border-b border-muted/30 flex justify-between items-center">
                        <span className="font-medium">{formatMonthLabel(key)}</span>
                        <Badge variant={badgeVariant} className="px-2.5 py-1">{statusText}</Badge>
                      </div>
                      <div className="p-4 space-y-4">
                        <div className="flex justify-between items-center">
                          <span className="text-sm font-medium text-muted-foreground">Total</span>
                          <span className="font-semibold">₱{formatNumber(total)}</span>
                        </div>
                        <div className="space-y-2">
                          <div className="flex justify-between items-center">
                            <span className="text-xs font-medium text-muted-foreground">Goal Progress</span>
                            <span className={`text-xs font-medium ${percentage >= 80 ? "text-[#00458d] dark:text-[#6699cc]" : percentage >= 60 ? "text-[#0056b3] dark:text-[#3378be]" : "text-gray-600 dark:text-gray-400"}`}>
                              {formatNumber(percentage)}%
                            </span>
                          </div>
                          <div className="h-3 bg-muted/40 rounded-full overflow-hidden">
                            <motion.div 
                              className={`h-full ${statusColor} rounded-full`}
                              initial={{ width: 0 }}
                              animate={{ width: `${Math.min(percentage, 100)}%` }}
                              transition={{ duration: 0.5, ease: "easeOut" }}
                            />
                          </div>
                        </div>
                      </div>
                    </motion.div>
                  );
                })}
              </motion.div>
          </TabsContent>
          
          <TabsContent value="partners" className="space-y-6">
            {/* Mobile partner cards (visible on small screens) */}
              <motion.div 
                className="md:hidden space-y-4"
                variants={staggerContainer}
                initial="hidden"
                animate="visible"
              >
              {partnerRows.length === 0 ? (
                  <motion.div 
                    className="p-8 text-center border rounded-lg bg-muted/30"
                    variants={fadeIn}
                  >
                  <p className="text-muted-foreground">No partners found for this missionary.</p>
                  </motion.div>
              ) : (
                <>
                    {partnerRows.map((p, index) => {
                    let rowTotal = 0;
                    thirteenMonthKeys.forEach(monthKey => {
                      rowTotal += p.monthlySums[monthKey] || 0;
                    });
                    
                    // Get the last 3 months for the mobile view
                    const recentMonths = thirteenMonthKeys.slice(-3);
                    
                    return (
                        <motion.div 
                          key={p.donorId}
                          variants={slideUp}
                        >
                          <motion.div
                            whileHover={{ scale: 1.01, y: -2 }}
                            transition={{ type: "spring", stiffness: 400, damping: 17 }}
                            className="overflow-hidden rounded-xl border shadow-sm hover:shadow-md transition-all duration-200"
                          >
                            <Card className="border-0 bg-transparent">
                              <CardContent className="p-0">
                                <div className="p-4 border-b border-muted/30">
                                  <div className="flex justify-between items-start">
                                    <div>
                                      <h3 className="font-semibold text-base line-clamp-1">{p.donorName}</h3>
                                      {p.email && (
                                        <div className="flex items-center gap-1 text-xs text-muted-foreground mt-1">
                                          <Mail className="h-3 w-3" />
                                          <span className="line-clamp-1">{p.email}</span>
                                        </div>
                                      )}
                                      {p.phone && (
                                        <div className="flex items-center gap-1 text-xs text-muted-foreground mt-1">
                                          <Phone className="h-3 w-3" />
                                          <span>{p.phone}</span>
                                        </div>
                                      )}
                                    </div>
                                    <motion.div
                                      initial={{ scale: 0.9, opacity: 0 }}
                                      animate={{ scale: 1, opacity: 1 }}
                                      transition={{ delay: index * 0.03 + 0.2, type: "spring", stiffness: 300, damping: 15 }}
                                    >
                                      <Badge variant="outline" className="font-medium ml-2 flex-shrink-0 shadow-sm">
                                        ₱{formatNumber(rowTotal)}
                                      </Badge>
                                    </motion.div>
                                  </div>
                                </div>
                                
                                <div className="p-4 space-y-3">
                                  <p className="text-xs font-medium text-muted-foreground">Recent Donations</p>
                                  <div className="space-y-3 pt-1">
                                    {recentMonths.map((monthKey, monthIndex) => {
                                      const val = p.monthlySums[monthKey] || 0;
                                      return (
                                        <motion.div 
                                          key={monthKey} 
                                          className="flex justify-between text-sm items-center"
                                          initial={{ opacity: 0, x: -5 }}
                                          animate={{ opacity: 1, x: 0 }}
                                          transition={{ delay: index * 0.03 + monthIndex * 0.1, duration: 0.3 }}
                                        >
                                          <div className="flex items-center gap-1.5">
                                            <motion.div 
                                              className="h-6 w-6 rounded-full bg-muted/30 flex items-center justify-center flex-shrink-0"
                                              whileHover={{ rotate: 15, scale: 1.1 }}
                                              transition={{ type: "spring", stiffness: 400, damping: 10 }}
                                            >
                                              <Calendar className="h-3 w-3 text-muted-foreground" />
                                            </motion.div>
                                            <span>{formatMonthLabel(monthKey)}</span>
                                          </div>
                                          <span className="font-medium">{val > 0 ? `₱${formatNumber(val)}` : "-"}</span>
                                        </motion.div>
                                      );
                                    })}
                                  </div>
                                </div>
                              </CardContent>
                            </Card>
                          </motion.div>
                        </motion.div>
                    );
                  })}
                  
                    <motion.div 
                      className="p-4 rounded-lg bg-muted/10 border shadow-sm"
                      variants={slideUp}
                      whileHover={{ scale: 1.01 }}
                      transition={{ type: "spring", stiffness: 400, damping: 17 }}
                    >
                      <div className="flex justify-between items-center">
                        <span className="font-medium">Total Donations</span>
                        <motion.span 
                          className="font-bold text-lg"
                          initial={{ scale: 0.9, opacity: 0 }}
                          animate={{ scale: 1, opacity: 1 }}
                          transition={{ delay: 0.3, type: "spring", stiffness: 300, damping: 15 }}
                        >
                          ₱{formatNumber(totalDonations)}
                        </motion.span>
                      </div>
                    </motion.div>
                </>
              )}
              </motion.div>
            
            {/* Desktop partner table (hidden on small screens) */}
              <motion.div 
                className="hidden md:block overflow-x-auto border rounded-md"
                variants={fadeIn}
                initial="hidden"
                animate="visible"
              >
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
                    {partnerRows.map((p, index) => {
                  let rowTotal = 0;
                  return (
                        <motion.tr 
                          key={p.donorId} 
                          className="border-b hover:bg-muted/30 transition-colors"
                          initial={{ opacity: 0, y: 10 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ delay: index * 0.03, duration: 0.3 }}
                        >
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
                        </motion.tr>
                  );
                })}

                  {/* Totals row */}
                    <motion.tr 
                      className="border-t-2 font-medium bg-muted/20"
                      initial={{ opacity: 0 }}
                      animate={{ opacity: 1 }}
                      transition={{ delay: 0.5, duration: 0.3 }}
                    >
                    <td className="px-4 py-3 sticky left-0 bg-muted/20" colSpan={3}>Monthly Totals</td>
                    {thirteenMonthKeys.map((monthKey) => (
                      <td key={monthKey} className="px-4 py-3">
                        ₱{formatNumber(monthlyTotals[monthKey] || 0)}
                      </td>
                    ))}
                    <td className="px-4 py-3">
                      ₱{formatNumber(totalDonations)}
                    </td>
                    </motion.tr>

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
              </motion.div>
          </TabsContent>
        </Tabs>
        </motion.div>
      </DialogContent>
    </Dialog>
  );
} 