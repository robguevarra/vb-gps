/**
 * DonorHistoryModalClient Component
 *
 * A modal component for displaying a donor's complete donation history.
 * Uses React Query for efficient data fetching and caching.
 * 
 * @component
 */

"use client";

import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-react";
import { useDonorHistory } from "@/hooks/useDonorHistory";
import { motion } from "framer-motion";

interface DonorHistoryModalClientProps {
  donorName: string;
  missionaryId: string;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export function DonorHistoryModalClient({
  donorName,
  missionaryId,
  open,
  onOpenChange,
}: DonorHistoryModalClientProps) {
  // Use custom hook to fetch donor history
  const { data: donations, isLoading, error } = useDonorHistory({
    donorName,
    missionaryId,
    enabled: open && !!donorName,
  });

  // Animation variants
  const listVariants = {
    hidden: { opacity: 0 },
    visible: { 
      opacity: 1,
      transition: {
        staggerChildren: 0.05
      }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, y: 5 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { duration: 0.2 }
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Giving History for {donorName}</DialogTitle>
        </DialogHeader>
        {isLoading ? (
          <div className="flex justify-center items-center p-4">
            <Loader2 className="animate-spin h-6 w-6 text-primary" />
          </div>
        ) : error ? (
          <p className="text-destructive p-4">{error.message}</p>
        ) : (
          <div className="space-y-4 max-h-[400px] overflow-y-auto">
            {donations && donations.length > 0 ? (
              <motion.div
                initial="hidden"
                animate="visible"
                variants={listVariants}
              >
                {donations.map((donation) => (
                  <motion.div 
                    key={donation.id} 
                    className="p-4 border-b border-border"
                    variants={itemVariants}
                  >
                    <p>
                      <strong>Date:</strong>{" "}
                      {new Date(donation.date).toLocaleDateString()}
                    </p>
                    <p>
                      <strong>Amount:</strong> ₱
                      {donation.amount.toLocaleString()}
                    </p>
                  </motion.div>
                ))}
              </motion.div>
            ) : (
              <p className="p-4 text-muted-foreground">No donation history found for this partner.</p>
            )}
          </div>
        )}
        <div className="mt-4 flex justify-end">
          <Button variant="ghost" onClick={() => onOpenChange(false)}>
            Close
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}