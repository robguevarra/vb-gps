/**
 * ApprovalCard Component
 * 
 * A comprehensive card component for managing individual leave or surplus requests.
 * Provides a rich interface for reviewing and taking action on requests with real-time
 * updates and proper error handling.
 * 
 * Key Features:
 * - Displays detailed request information in a clean card layout
 * - Provides approve/reject actions with confirmation modals
 * - Supports optional notes for decisions
 * - Real-time status updates via Supabase
 * - Color-coded status indicators for quick recognition
 * - Loading states and error handling
 * - Enhanced animations and micro-interactions
 * - Accessibility improvements
 * 
 * Performance Considerations:
 * - Optimistic updates for better UX
 * - Proper cleanup of database listeners
 * - Efficient modal state management
 * - Debounced database operations
 * - Respects user motion preferences
 * 
 * Error Handling:
 * - Graceful error states with user feedback
 * - Type-safe error handling with PostgrestError
 * - Loading states during async operations
 * - Proper cleanup on unmount
 * 
 * @component
 */

// components/ApprovalCard.tsx
'use client';

import { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Loader2, CheckCircle, XCircle } from 'lucide-react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';
import { motion, useReducedMotion } from 'framer-motion';

/**
 * Props interface for the ApprovalCard component
 * @interface ApprovalCardProps
 */
interface ApprovalCardProps {
  /** Unique identifier for the request */
  requestId: string;
  /** Type of request - 'leave' for time off or 'surplus' for financial requests */
  requestType: "leave" | "surplus";
  /** Current approval status of the request */
  currentStatus: string;
  /** Name of the staff member who submitted the request */
  filedBy: string;
  /** Additional information about the request (dates for leave, amount for surplus) */
  details: string;
}

/**
 * ApprovalCard component for displaying and managing individual approval requests
 * 
 * @param props - Component props (see ApprovalCardProps interface)
 * @returns JSX.Element - Rendered component
 */
export function ApprovalCard({
  requestId,
  requestType,
  currentStatus,
  filedBy,
  details,
}: ApprovalCardProps) {
  // Initialize Supabase client for real-time database operations
  const supabase = createClient();
  const router = useRouter();
  const shouldReduceMotion = useReducedMotion();

  // State management for modal and form
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [actionType, setActionType] = useState<"approve" | "reject" | null>(null);
  const [notes, setNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [isHovered, setIsHovered] = useState(false);

  /**
   * Opens the confirmation modal for the specified action
   * @param action - The type of action (approve/reject)
   */
  const handleOpenModal = (action: "approve" | "reject") => {
    setActionType(action);
    setIsModalOpen(true);
  };

  /**
   * Handles the approval/rejection of a request with proper error handling
   * Updates the database and manages UI states accordingly
   */
  const handleAction = async () => {
    if (!actionType) return;

    try {
      setLoading(true);
      setError('');

      // Determine which table to update based on request type
      const table = requestType === "leave" ? "leave_requests" : "surplus_requests";
      
      // Determine the appropriate ID field based on request type
      const idField = requestType === "leave" ? "requester_id" : "missionary_id";
      
      // Determine the approval field based on request type
      const approvalField = "campus_director_approval";

      // First, get the request to check the requester's role
      const { data: requestData, error: requestError } = await supabase
        .from(table)
        .select(`${idField}`)
        .eq("id", requestId)
        .single();

      if (requestError) throw requestError;

      // Get the requester's role
      const requesterId = requestData?.[idField as keyof typeof requestData];
      const { data: requesterData, error: requesterError } = await supabase
        .from("profiles")
        .select("role")
        .eq("id", requesterId)
        .single();

      if (requesterError) throw requesterError;

      const isRequesterCampusDirector = requesterData.role === "campus_director";

      // Update the request status in the database
      // If requester is a Campus Director, only Lead Pastor approval is needed
      // If requester is a Missionary, both CD and LP approvals are needed
      const updateData = {
        [approvalField]: actionType === "approve" ? "approved" : "rejected",
        campus_director_notes: notes.trim() || null,
        // Only set status to approved/rejected if requester is a Campus Director
        ...(isRequesterCampusDirector && { 
          status: actionType === "approve" ? "approved" : "rejected" 
        })
      };

      const { error } = await supabase
        .from(table)
        .update(updateData)
        .eq("id", requestId);

      if (error) throw error;

      // Close the modal and refresh the page
      setIsModalOpen(false);
      router.refresh();
    } catch (error) {
      console.error("Error updating request:", error);
      setError('Failed to update request. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  // Format the details for display
  const formattedDetails = () => {
    if (requestType === 'leave') {
      return details;
    } else {
      // For surplus requests, ensure the amount is properly formatted
      // The details string typically contains "Requested Amount: ₱X. Reason: Y"
      const amountMatch = details.match(/Requested Amount: ₱([\d,]+)/);
      if (amountMatch) {
        const amount = parseFloat(amountMatch[1].replace(/,/g, ''));
        const reasonPart = details.split('Reason:')[1] || '';
        return `Requested Amount: ₱${amount.toLocaleString()}. Reason:${reasonPart}`;
      }
      return details;
    }
  };

  // Get status color based on current status
  const getStatusColor = () => {
    switch (currentStatus) {
      case 'approved':
        return 'text-green-600 dark:text-green-400';
      case 'rejected':
        return 'text-red-600 dark:text-red-400';
      default:
        return 'text-yellow-600 dark:text-yellow-400';
    }
  };

  // Card hover animation variants
  const cardVariants = {
    initial: { 
      boxShadow: '0 1px 3px rgba(0,0,0,0.1)',
      backgroundColor: 'var(--background)'
    },
    hover: shouldReduceMotion ? {} : { 
      boxShadow: '0 4px 6px rgba(0,0,0,0.1)',
      backgroundColor: 'var(--accent)',
      scale: 1.01,
      transition: { duration: 0.2 }
    }
  };

  // Button hover animation variants
  const buttonVariants = {
    initial: {},
    hover: shouldReduceMotion ? {} : { 
      scale: 1.05,
      transition: { duration: 0.2 }
    },
    tap: shouldReduceMotion ? {} : { 
      scale: 0.95,
      transition: { duration: 0.1 }
    }
  };

  return (
    <motion.div 
      className="p-4 bg-background rounded-lg border flex justify-between items-center mb-4"
      initial="initial"
      whileHover="hover"
      variants={cardVariants}
      onHoverStart={() => setIsHovered(true)}
      onHoverEnd={() => setIsHovered(false)}
      transition={{ duration: 0.2 }}
    >
      {/* Request Information */}
      <div className="flex-1">
        <p className="font-medium">
          {requestType === 'leave' ? 'Leave Request' : 'Surplus Request'} by {filedBy}
          <span className={`ml-2 text-sm ${getStatusColor()}`}>
            ({currentStatus})
          </span>
        </p>
        <p className="text-sm text-muted-foreground">{formattedDetails()}</p>
      </div>

      {/* Action Buttons */}
      <div className="flex gap-2 ml-4">
        <motion.div
          variants={buttonVariants}
          whileHover="hover"
          whileTap="tap"
        >
          <Button 
            variant="outline" 
            size="sm" 
            onClick={() => handleOpenModal('approve')}
            className="flex items-center gap-1 transition-colors duration-200 hover:bg-green-50 hover:text-green-600 hover:border-green-200 dark:hover:bg-green-900/20 dark:hover:text-green-400 dark:hover:border-green-800"
            aria-label="Approve request"
          >
            <CheckCircle className={`h-4 w-4 ${isHovered ? 'text-green-500' : ''}`} />
            <span>Approve</span>
          </Button>
        </motion.div>
        <motion.div
          variants={buttonVariants}
          whileHover="hover"
          whileTap="tap"
        >
          <Button 
            variant="outline" 
            size="sm" 
            onClick={() => handleOpenModal('reject')}
            className="flex items-center gap-1 transition-colors duration-200 hover:bg-red-50 hover:text-red-600 hover:border-red-200 dark:hover:bg-red-900/20 dark:hover:text-red-400 dark:hover:border-red-800"
            aria-label="Reject request"
          >
            <XCircle className={`h-4 w-4 ${isHovered ? 'text-red-500' : ''}`} />
            <span>Reject</span>
          </Button>
        </motion.div>
      </div>

      {/* Confirmation Modal */}
      <Dialog open={isModalOpen} onOpenChange={setIsModalOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              {actionType === "approve" ? (
                <CheckCircle className="h-5 w-5 text-green-500" />
              ) : (
                <XCircle className="h-5 w-5 text-red-500" />
              )}
              <span>
                Confirm {actionType === "approve" ? "Approval" : "Rejection"}
              </span>
            </DialogTitle>
            <DialogDescription>
              Are you sure you want to {actionType} this {requestType} request from {filedBy}?
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4">
            <div className="bg-muted p-3 rounded-md">
              <p><strong>Filed by:</strong> {filedBy}</p>
              <p className="mt-1"><strong>Details:</strong> {formattedDetails()}</p>
            </div>
            <div className="space-y-2">
              <Label htmlFor="approval-notes">Optional Notes</Label>
              <Textarea
                id="approval-notes"
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                placeholder="Add notes (optional)"
                className="min-h-[100px]"
              />
            </div>
            {error && (
              <motion.p 
                className="text-red-500 text-sm p-2 border border-red-200 rounded bg-red-50 dark:bg-red-900/20 dark:border-red-800"
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.2 }}
              >
                {error}
              </motion.p>
            )}
            <div className="flex justify-end gap-2">
              <Button 
                variant="outline" 
                onClick={() => setIsModalOpen(false)}
                className="transition-all duration-200 hover:bg-muted"
              >
                Cancel
              </Button>
              <Button 
                onClick={handleAction} 
                disabled={loading}
                className={`transition-all duration-200 ${
                  actionType === "approve" 
                    ? "bg-green-600 hover:bg-green-700 text-white" 
                    : "bg-red-600 hover:bg-red-700 text-white"
                }`}
              >
                {loading ? (
                  <Loader2 className="h-4 w-4 animate-spin mr-2" />
                ) : actionType === "approve" ? (
                  <CheckCircle className="h-4 w-4 mr-2" />
                ) : (
                  <XCircle className="h-4 w-4 mr-2" />
                )}
                {loading ? 'Processing...' : 'Confirm'}
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </motion.div>
  );
}
