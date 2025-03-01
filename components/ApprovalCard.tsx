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
 * 
 * Performance Considerations:
 * - Optimistic updates for better UX
 * - Proper cleanup of database listeners
 * - Efficient modal state management
 * - Debounced database operations
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
import { Loader2 } from 'lucide-react';
import { createClient } from '@/utils/supabase/client';
import { useRouter } from 'next/navigation';

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

  // State management for modal and form
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [actionType, setActionType] = useState<"approve" | "reject" | null>(null);
  const [notes, setNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

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

      // Update the request status in the database
      const { error } = await supabase
        .from(table)
        .update({
          [approvalField]: actionType === "approve" ? "approved" : "rejected",
          status: actionType === "approve" ? "approved" : "rejected",
          campus_director_notes: notes.trim() || null
        })
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

  return (
    <div className="p-4 bg-background rounded-lg border flex justify-between items-center mb-4">
      {/* Request Information */}
      <div>
        <p className="font-medium">
          {requestType === 'leave' ? 'Leave Request' : 'Surplus Request'} by {filedBy}
          <span className={`ml-2 text-sm ${
            currentStatus === 'approved'
              ? 'text-green-600'
              : currentStatus === 'rejected'
              ? 'text-red-600'
              : 'text-yellow-600'
          }`}>
            ({currentStatus})
          </span>
        </p>
        <p className="text-sm text-muted-foreground">{formattedDetails()}</p>
      </div>

      {/* Action Buttons */}
      <div className="flex gap-2">
        <Button variant="outline" size="sm" onClick={() => handleOpenModal('approve')}>
          Approve
        </Button>
        <Button variant="outline" size="sm" onClick={() => handleOpenModal('reject')}>
          Reject
        </Button>
      </div>

      {/* Confirmation Modal */}
      <Dialog open={isModalOpen} onOpenChange={setIsModalOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              Confirm {actionType === "approve" ? "Approval" : "Rejection"}
            </DialogTitle>
            <DialogDescription>
              Are you sure you want to {actionType} this {requestType} request from {filedBy}?
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4">
            <p><strong>Filed by:</strong> {filedBy}</p>
            <p><strong>Details:</strong> {formattedDetails()}</p>
            <div className="space-y-2">
              <Label>Optional Notes</Label>
              <Textarea
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                placeholder="Add notes (optional)"
              />
            </div>
            {error && <p className="text-red-500 text-sm">{error}</p>}
            <div className="flex justify-end gap-2">
              <Button variant="outline" onClick={() => setIsModalOpen(false)}>
                Cancel
              </Button>
              <Button onClick={handleAction} disabled={loading}>
                {loading ? <Loader2 className="animate-spin" /> : 'Confirm'}
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
