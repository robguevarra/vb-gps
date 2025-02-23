import { useState } from 'react';
import { Button } from "@/components/ui/button";
import { Calendar, Wallet } from "lucide-react";
import { ApprovalTable } from "@/components/LeadPastorApprovalCard";
import { PaginationControls } from "@/components/PaginationControls";

interface ApprovedRequestsTabProps {
  approvedLeave: ApprovalRequest[];
  approvedSurplus: ApprovalRequest[];
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
  pageSize: number;
  onPageSizeChange: (size: number) => void;
}

export function ApprovedRequestsTab({
  approvedLeave,
  approvedSurplus,
  ...paginationProps
}: ApprovedRequestsTabProps) {
  const [activeType, setActiveType] = useState<'leave' | 'surplus'>('leave');
  
  return (
    <div className="space-y-4">
      <div className="flex gap-2">
        <Button
          variant={activeType === 'leave' ? 'default' : 'outline'}
          onClick={() => setActiveType('leave')}
        >
          <Calendar className="w-4 h-4 mr-2" />
          Leave Requests
        </Button>
        <Button
          variant={activeType === 'surplus' ? 'default' : 'outline'}
          onClick={() => setActiveType('surplus')}
        >
          <Wallet className="w-4 h-4 mr-2" />
          Surplus Requests
        </Button>
      </div>

      <ApprovalTable
        requests={activeType === 'leave' ? approvedLeave : approvedSurplus}
        requestType={activeType}
        approvalStatus="approved"
        {...paginationProps}
      />
    </div>
  );
} 