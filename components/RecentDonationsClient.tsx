/**
 * RecentDonationsClient Component
 *
 * Client component that displays recent donation transactions with
 * optimized animations and interactions. This is the interactive part
 * of the hybrid architecture pattern.
 *
 * @component
 */

"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatDate } from "@/lib/utils";
import { useState, useCallback } from "react";
import { DonorHistoryModalWrapper } from "./DonorHistoryModalWrapper";
import { Inbox } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";

interface Donation {
  id: string | number;
  donor_name: string;
  date: string;
  amount: number;
}

interface RecentDonationsClientProps {
  donations: Donation[];
  missionaryId: string;
}

export function RecentDonationsClient({ donations, missionaryId }: RecentDonationsClientProps) {
  const [partnerModalOpen, setPartnerModalOpen] = useState(false);
  const [selectedPartner, setSelectedPartner] = useState<string>("");
  const shouldReduceMotion = useReducedMotion();
  
  // Memoize the openModal function to prevent unnecessary rerenders
  const openModal = useCallback((donorName: string) => {
    setSelectedPartner(donorName);
    setPartnerModalOpen(true);
  }, []);

  // Animation variants - simplified and consolidated
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: shouldReduceMotion ? 0 : 0.05,
      }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 10 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { duration: 0.3 }
    }
  };

  return (
    <>
      <Card className="overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-300">
        <CardHeader className="bg-muted/10 px-6 py-4">
          <CardTitle className="text-lg font-semibold">Recent Transactions</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          <div className="divide-y divide-border">
            {donations.length > 0 ? (
              <motion.div
                initial="hidden"
                animate="visible"
                variants={containerVariants}
                className="max-h-[400px] overflow-auto"
              >
                {donations.map((donation) => (
                  <motion.div
                    key={donation.id}
                    variants={itemVariants}
                    className="flex items-center justify-between p-4 hover:bg-muted/20 transition-colors"
                  >
                    <div className="grid gap-1">
                      <div 
                        className="font-medium cursor-pointer hover:text-primary transition-colors"
                        onClick={() => openModal(donation.donor_name)}
                      >
                        {donation.donor_name}
                      </div>
                      <div className="text-sm text-muted-foreground">
                        {formatDate(donation.date)}
                      </div>
                    </div>
                    <div className="font-semibold text-emerald-600">
                      ₱{donation.amount.toLocaleString()}
                    </div>
                  </motion.div>
                ))}
              </motion.div>
            ) : (
              <motion.div 
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.3 }}
                className="p-6 text-center text-muted-foreground"
              >
                <Inbox className="mx-auto h-8 w-8 mb-2" />
                <p>No recent transactions</p>
              </motion.div>
            )}
          </div>
        </CardContent>
      </Card>

      <DonorHistoryModalWrapper
        donorName={selectedPartner}
        missionaryId={missionaryId}
        open={partnerModalOpen}
        onOpenChange={setPartnerModalOpen}
      />
    </>
  );
}