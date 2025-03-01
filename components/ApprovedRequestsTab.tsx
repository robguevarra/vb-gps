import { useState, useMemo } from 'react';
import { Button } from "@/components/ui/button";
import { Calendar, Wallet, Search, ArrowUpDown, Filter, X } from "lucide-react";
import { ApprovalTable } from "@/components/LeadPastorApprovalCard";
import { PaginationControls } from "@/components/PaginationControls";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { format, parseISO, isAfter, isBefore, isWithinInterval } from 'date-fns';
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { DateRangePicker } from "@/components/ui/date-range-picker";
import { cn } from "@/lib/utils";

interface ApprovalRequest {
  id: string;
  type: string;
  startDate?: string;
  endDate?: string;
  amount?: number;
  reason: string;
  status: string;
  date: string;
  campusDirectorApproval: string;
  campusDirectorNotes?: string;
  leadPastorApproval: string;
  leadPastorNotes?: string;
  requester?: { full_name: string };
}

interface ApprovedRequestsTabProps {
  approvedLeave: ApprovalRequest[];
  approvedSurplus: ApprovalRequest[];
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
  pageSize: number;
  onPageSizeChange: (size: number) => void;
}

type SortField = 'date' | 'requester' | 'amount';
type SortOrder = 'asc' | 'desc';
type DateRange = { from: Date | undefined; to: Date | undefined };

export function ApprovedRequestsTab({
  approvedLeave,
  approvedSurplus,
  ...paginationProps
}: ApprovedRequestsTabProps) {
  const [activeType, setActiveType] = useState<'leave' | 'surplus'>('leave');
  const [searchTerm, setSearchTerm] = useState('');
  const [sortField, setSortField] = useState<SortField>('date');
  const [sortOrder, setSortOrder] = useState<SortOrder>('desc');
  const [dateRange, setDateRange] = useState<DateRange>({ from: undefined, to: undefined });
  const [amountRange, setAmountRange] = useState<{ min: string; max: string }>({ min: '', max: '' });
  
  // Filter and sort the requests
  const filteredAndSortedRequests = useMemo(() => {
    const requests = activeType === 'leave' ? approvedLeave : approvedSurplus;
    
    // Apply filters
    return requests
      .filter(request => {
        // Search filter
        const searchLower = searchTerm.toLowerCase();
        const matchesSearch = 
          !searchTerm || 
          request.requester?.full_name?.toLowerCase().includes(searchLower) ||
          request.reason.toLowerCase().includes(searchLower);
        
        // Date range filter
        let matchesDateRange = true;
        if (dateRange.from && dateRange.to) {
          const requestDate = parseISO(request.date);
          matchesDateRange = isWithinInterval(requestDate, {
            start: dateRange.from,
            end: dateRange.to
          });
        }
        
        // Amount range filter (for surplus requests only)
        let matchesAmountRange = true;
        if (activeType === 'surplus' && (amountRange.min || amountRange.max)) {
          const amount = request.amount || 0;
          if (amountRange.min && Number(amountRange.min) > amount) {
            matchesAmountRange = false;
          }
          if (amountRange.max && Number(amountRange.max) < amount) {
            matchesAmountRange = false;
          }
        }
        
        return matchesSearch && matchesDateRange && matchesAmountRange;
      })
      .sort((a, b) => {
        // Apply sorting
        if (sortField === 'date') {
          return sortOrder === 'asc' 
            ? new Date(a.date).getTime() - new Date(b.date).getTime()
            : new Date(b.date).getTime() - new Date(a.date).getTime();
        }
        
        if (sortField === 'requester') {
          const nameA = a.requester?.full_name || '';
          const nameB = b.requester?.full_name || '';
          return sortOrder === 'asc'
            ? nameA.localeCompare(nameB)
            : nameB.localeCompare(nameA);
        }
        
        if (sortField === 'amount' && activeType === 'surplus') {
          const amountA = a.amount || 0;
          const amountB = b.amount || 0;
          return sortOrder === 'asc'
            ? amountA - amountB
            : amountB - amountA;
        }
        
        return 0;
      });
  }, [activeType, approvedLeave, approvedSurplus, searchTerm, sortField, sortOrder, dateRange, amountRange]);
  
  // Toggle sort order or change sort field
  const handleSort = (field: SortField) => {
    if (sortField === field) {
      setSortOrder(sortOrder === 'asc' ? 'desc' : 'asc');
    } else {
      setSortField(field);
      setSortOrder('desc'); // Default to descending when changing fields
    }
  };
  
  // Clear all filters
  const clearFilters = () => {
    setSearchTerm('');
    setDateRange({ from: undefined, to: undefined });
    setAmountRange({ min: '', max: '' });
    setSortField('date');
    setSortOrder('desc');
  };
  
  // Check if any filters are active
  const hasActiveFilters = searchTerm || dateRange.from || dateRange.to || amountRange.min || amountRange.max;
  
  return (
    <div className="space-y-4">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
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
        
        <div className="flex items-center gap-2">
          <div className="relative w-full sm:w-64">
            <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
            <Input
              placeholder="Search by name or reason..."
              className="pl-8"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
            {searchTerm && (
              <Button
                variant="ghost"
                size="sm"
                className="absolute right-1 top-1.5 h-6 w-6 p-0"
                onClick={() => setSearchTerm('')}
              >
                <X className="h-4 w-4" />
              </Button>
            )}
          </div>
          
          <Popover>
            <PopoverTrigger asChild>
              <Button variant="outline" size="sm" className="gap-1">
                <Filter className="h-4 w-4" />
                <span className="hidden sm:inline">Filters</span>
                {hasActiveFilters && (
                  <Badge variant="secondary" className="ml-1 rounded-full px-1">
                    !
                  </Badge>
                )}
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-80">
              <div className="space-y-4">
                <h4 className="font-medium">Filter Requests</h4>
                
                <div className="space-y-2">
                  <label className="text-sm font-medium">Date Range</label>
                  <DateRangePicker
                    value={dateRange}
                    onChange={setDateRange}
                  />
                </div>
                
                {activeType === 'surplus' && (
                  <div className="space-y-2">
                    <label className="text-sm font-medium">Amount Range</label>
                    <div className="flex gap-2">
                      <Input
                        type="number"
                        placeholder="Min"
                        value={amountRange.min}
                        onChange={(e) => setAmountRange({ ...amountRange, min: e.target.value })}
                        className="w-1/2"
                      />
                      <Input
                        type="number"
                        placeholder="Max"
                        value={amountRange.max}
                        onChange={(e) => setAmountRange({ ...amountRange, max: e.target.value })}
                        className="w-1/2"
                      />
                    </div>
                  </div>
                )}
                
                <div className="flex justify-between">
                  <Button variant="outline" size="sm" onClick={clearFilters}>
                    Clear All
                  </Button>
                  <Button size="sm">Apply Filters</Button>
                </div>
              </div>
            </PopoverContent>
          </Popover>
          
          <Select
            value={`${sortField}-${sortOrder}`}
            onValueChange={(value) => {
              const [field, order] = value.split('-') as [SortField, SortOrder];
              setSortField(field);
              setSortOrder(order);
            }}
          >
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Sort by" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="date-desc">Date (Newest First)</SelectItem>
              <SelectItem value="date-asc">Date (Oldest First)</SelectItem>
              <SelectItem value="requester-asc">Name (A-Z)</SelectItem>
              <SelectItem value="requester-desc">Name (Z-A)</SelectItem>
              {activeType === 'surplus' && (
                <>
                  <SelectItem value="amount-desc">Amount (High-Low)</SelectItem>
                  <SelectItem value="amount-asc">Amount (Low-High)</SelectItem>
                </>
              )}
            </SelectContent>
          </Select>
        </div>
      </div>
      
      {/* Active filters display */}
      {hasActiveFilters && (
        <div className="flex flex-wrap gap-2 items-center">
          <span className="text-sm text-muted-foreground">Active filters:</span>
          {searchTerm && (
            <Badge variant="secondary" className="flex items-center gap-1">
              Search: {searchTerm}
              <Button
                variant="ghost"
                size="sm"
                className="h-4 w-4 p-0 ml-1"
                onClick={() => setSearchTerm('')}
              >
                <X className="h-3 w-3" />
              </Button>
            </Badge>
          )}
          {dateRange.from && dateRange.to && (
            <Badge variant="secondary" className="flex items-center gap-1">
              Date: {format(dateRange.from, 'MMM d')} - {format(dateRange.to, 'MMM d, yyyy')}
              <Button
                variant="ghost"
                size="sm"
                className="h-4 w-4 p-0 ml-1"
                onClick={() => setDateRange({ from: undefined, to: undefined })}
              >
                <X className="h-3 w-3" />
              </Button>
            </Badge>
          )}
          {activeType === 'surplus' && (amountRange.min || amountRange.max) && (
            <Badge variant="secondary" className="flex items-center gap-1">
              Amount: {amountRange.min || '0'} - {amountRange.max || '∞'}
              <Button
                variant="ghost"
                size="sm"
                className="h-4 w-4 p-0 ml-1"
                onClick={() => setAmountRange({ min: '', max: '' })}
              >
                <X className="h-3 w-3" />
              </Button>
            </Badge>
          )}
          <Button
            variant="ghost"
            size="sm"
            className="text-xs h-7"
            onClick={clearFilters}
          >
            Clear all
          </Button>
        </div>
      )}
      
      {/* Results count */}
      <div className="text-sm text-muted-foreground">
        Showing {filteredAndSortedRequests.length} {activeType === 'leave' ? 'leave' : 'surplus'} requests
      </div>

      <ApprovalTable
        requests={filteredAndSortedRequests}
        requestType={activeType}
        approvalStatus="approved"
        {...paginationProps}
      />
    </div>
  );
} 