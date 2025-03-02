/**
 * RecentDonations Component
 * 
 * A component that displays recent donation transactions for a missionary.
 * Features a clean card layout with donor information, dates, and amounts.
 * Includes integration with a donor history modal for detailed donor information.
 * 
 * Key Features:
 * - Displays recent transactions in a card layout
 * - Shows donor name, date, and amount for each transaction
 * - Integrates with DonorHistoryModal for detailed donor history
 * - Handles empty states with a clean placeholder
 * - Uses currency formatting for amounts
 * - Enhanced animations with staggered item reveals
 * 
 * @component
 */

"use client"; // <-- add this directive at the top

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { formatDate, formatCurrency } from "@/lib/utils";
import { useState, useEffect } from "react";
import PartnerHistoryModal from "./DonorHistoryModal";
import { Inbox } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";

/**
 * Interface representing a single donation transaction
 */
interface Donation {
  /** Unique identifier for the donation */
  id: string | number;
  /** Name of the donor who made the donation */
  donor_name: string;
  /** Date when the donation was made */
  date: string;
  /** Amount of the donation */
  amount: number;
}

/**
 * Props for the RecentDonations component
 */
interface RecentDonationsProps {
  /** Array of recent donations to display */
  donations: Donation[];
  /** ID of the missionary to filter donations for in the modal */
  missionaryId: string;
}

export default function RecentDonations({ donations, missionaryId }: RecentDonationsProps) {
  // State for managing the donor history modal
  const [partnerModalOpen, setPartnerModalOpen] = useState(false);
  const [selectedPartner, setSelectedPartner] = useState<string>("");
  const [shouldAnimate, setShouldAnimate] = useState(false);
  
  // Start animation after component mounts
  useEffect(() => {
    setShouldAnimate(true);
  }, []);

  /**
   * Opens the partner history modal for a specific partner
   * @param donorName - Name of the partner to show history for
   */
  const openModal = (donorName: string) => {
    setSelectedPartner(donorName);
    setPartnerModalOpen(true);
  };

  // Animation variants for container
  const containerVariants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.05,
        delayChildren: 0.2
      }
    }
  };

  // Animation variants for individual items
  const itemVariants = {
    hidden: { 
      opacity: 0, 
      y: 10,
    },
    show: { 
      opacity: 1, 
      y: 0,
      transition: {
        type: "spring",
        stiffness: 500,
        damping: 30
      }
    }
  };

  // Animation variants for card
  const cardVariants = {
    hidden: { opacity: 0, y: 20 },
    show: { 
      opacity: 1, 
      y: 0,
      transition: {
        type: "spring",
        stiffness: 300,
        damping: 25,
        delay: 0.1
      }
    }
  };

  // Animation variants for empty state
  const emptyStateVariants = {
    hidden: { opacity: 0, scale: 0.9 },
    show: { 
      opacity: 1, 
      scale: 1,
      transition: {
        type: "spring",
        stiffness: 300,
        damping: 25,
        delay: 0.2
      }
    }
  };

  return (
    <>
      <motion.div
        variants={cardVariants}
        initial="hidden"
        animate={shouldAnimate ? "show" : "hidden"}
      >
        <Card className="overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-300">
          <CardHeader className="bg-muted/10 px-6 py-4">
            <CardTitle className="text-lg font-semibold">Recent Transactions</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <div className="divide-y divide-border">
              {donations.length > 0 ? (
                <motion.div
                  variants={containerVariants}
                  initial="hidden"
                  animate={shouldAnimate ? "show" : "hidden"}
                  className="max-h-[400px] overflow-auto"
                >
                  {donations.map((donation) => (
                    <motion.div
                      key={donation.id}
                      variants={itemVariants}
                      whileHover={{ 
                        backgroundColor: "rgba(0,0,0,0.03)",
                        transition: { duration: 0.2 }
                      }}
                      className="flex items-center justify-between p-4 transition-colors"
                    >
                      <div className="grid gap-1">
                        {/* Partner name with click handler for history modal */}
                        <motion.div 
                          className="font-medium cursor-pointer hover:text-primary"
                          onClick={() => openModal(donation.donor_name)}
                          whileHover={{ 
                            scale: 1.02,
                            color: "var(--primary)",
                            transition: { duration: 0.2 }
                          }}
                          whileTap={{ scale: 0.98 }}
                        >
                          {donation.donor_name}
                        </motion.div>
                        <div className="text-sm text-muted-foreground">
                          {formatDate(donation.date)}
                        </div>
                      </div>
                      {/* Amount display with currency formatting */}
                      <motion.div 
                        className="font-semibold text-emerald-600"
                        whileHover={{ scale: 1.05 }}
                        transition={{ type: "spring", stiffness: 400, damping: 10 }}
                      >
                        ₱{donation.amount.toLocaleString()}
                      </motion.div>
                    </motion.div>
                  ))}
                </motion.div>
              ) : (
                // Empty state display
                <motion.div 
                  className="p-6 text-center text-muted-foreground"
                  variants={emptyStateVariants}
                  initial="hidden"
                  animate={shouldAnimate ? "show" : "hidden"}
                >
                  <motion.div
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ 
                      opacity: 1, 
                      y: 0,
                      transition: { delay: 0.3, duration: 0.5 }
                    }}
                  >
                    <Inbox className="mx-auto h-8 w-8 mb-2" />
                    <p>No recent transactions</p>
                  </motion.div>
                </motion.div>
              )}
            </div>
          </CardContent>
        </Card>
      </motion.div>

      {/* Partner History Modal */}
      <PartnerHistoryModal
        donorName={selectedPartner}
        missionaryId={missionaryId}
        open={partnerModalOpen}
        onOpenChange={setPartnerModalOpen}
      />
    </>
  );
}