import { useState, useMemo } from 'react';
import { Button } from "@/components/ui/button";
import { Calendar, Wallet, Search, ArrowUpDown, Filter, X, ChevronDown } from "lucide-react";
import { ApprovalTable } from "@/components/LeadPastorApprovalCard";
import { PaginationControls } from "@/components/PaginationControls";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { format, parseISO, isAfter, isBefore, isWithinInterval } from 'date-fns';
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { DateRangePicker } from "@/components/ui/date-range-picker";
import { cn } from "@/lib/utils";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

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
  const [isSearchOpen, setIsSearchOpen] = useState(false);
  
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
    setIsSearchOpen(false);
  };
  
  // Check if any filters are active
  const hasActiveFilters = searchTerm || dateRange.from || dateRange.to || amountRange.min || amountRange.max;
  
  return (
    <div className="w-full bg-white dark:bg-gray-900 rounded-lg shadow-sm border p-4">
      <div className="flex flex-col space-y-4">
        <div className="flex flex-col sm:flex-row justify-between gap-3 sm:items-center">
          <div className="flex-shrink-0">
            <Tabs value={activeType} onValueChange={(v) => setActiveType(v as 'leave' | 'surplus')}>
              <TabsList className="h-9 w-full sm:w-auto grid grid-cols-2 sm:flex">
                <TabsTrigger value="leave" className="flex gap-1 px-3 text-sm">
                  <Calendar className="h-4 w-4" /> 
                  <span className="hidden sm:inline">Leave Requests</span>
                  <span className="sm:hidden">Leave</span>
                </TabsTrigger>
                <TabsTrigger value="surplus" className="flex gap-1 px-3 text-sm">
                  <Wallet className="h-4 w-4" /> 
                  <span className="hidden sm:inline">Surplus Requests</span>
                  <span className="sm:hidden">Surplus</span>
                </TabsTrigger>
              </TabsList>
            </Tabs>
          </div>
          
          <div className="flex items-center gap-2">
            {isSearchOpen ? (
              <div className="relative flex-1 sm:max-w-[250px]">
                <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search by name or reason..."
                  className="pl-8 pr-8 h-9 text-sm"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  autoFocus
                />
                {searchTerm && (
                  <Button
                    variant="ghost"
                    size="sm"
                    className="absolute right-1 top-1 h-7 w-7 p-0"
                    onClick={() => setSearchTerm('')}
                  >
                    <X className="h-4 w-4" />
                  </Button>
                )}
              </div>
            ) : (
              <Button 
                variant="outline" 
                size="sm" 
                className="h-9"
                onClick={() => setIsSearchOpen(true)}
              >
                <Search className="h-4 w-4 mr-2" />
                <span className="hidden sm:inline">Search</span>
              </Button>
            )}
            
            <Popover>
              <PopoverTrigger asChild>
                <Button variant="outline" size="sm" className="h-9">
                  <Filter className="h-4 w-4 sm:mr-2" />
                  <span className="hidden sm:inline">Filters</span>
                  {hasActiveFilters && (
                    <Badge variant="secondary" className="ml-1 rounded-full px-1 h-5 min-w-5 flex items-center justify-center">
                      !
                    </Badge>
                  )}
                </Button>
              </PopoverTrigger>
              <PopoverContent className="w-[calc(100vw-2rem)] sm:w-80 p-4">
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
            
            <Popover>
              <PopoverTrigger asChild>
                <Button variant="outline" size="sm" className="h-9">
                  <ArrowUpDown className="h-4 w-4 sm:mr-2" />
                  <span className="hidden sm:inline">Sort</span>
                </Button>
              </PopoverTrigger>
              <PopoverContent className="w-56 p-0" align="end">
                <div className="p-2">
                  <div className="font-medium text-sm px-2 py-1.5">Sort by</div>
                  <Button 
                    variant="ghost" 
                    size="sm" 
                    className="w-full justify-start text-sm mb-1"
                    onClick={() => handleSort('date')}
                  >
                    Date
                    {sortField === 'date' && (
                      <Badge variant="secondary" className="ml-auto">
                        {sortOrder === 'asc' ? 'Oldest' : 'Newest'}
                      </Badge>
                    )}
                  </Button>
                  <Button 
                    variant="ghost" 
                    size="sm" 
                    className="w-full justify-start text-sm mb-1"
                    onClick={() => handleSort('requester')}
                  >
                    Requester Name
                    {sortField === 'requester' && (
                      <Badge variant="secondary" className="ml-auto">
                        {sortOrder === 'asc' ? 'A-Z' : 'Z-A'}
                      </Badge>
                    )}
                  </Button>
                  {activeType === 'surplus' && (
                    <Button 
                      variant="ghost" 
                      size="sm" 
                      className="w-full justify-start text-sm"
                      onClick={() => handleSort('amount')}
                    >
                      Amount
                      {sortField === 'amount' && (
                        <Badge variant="secondary" className="ml-auto">
                          {sortOrder === 'asc' ? 'Low-High' : 'High-Low'}
                        </Badge>
                      )}
                    </Button>
                  )}
                </div>
              </PopoverContent>
            </Popover>
          </div>
        </div>
        
        {searchTerm && (
          <div className="flex items-center">
            <Badge variant="secondary" className="px-2 py-1">
              Search results: {filteredAndSortedRequests.length}
            </Badge>
            <Button 
              variant="ghost" 
              size="sm" 
              className="h-7 ml-2 text-xs"
              onClick={() => setSearchTerm('')}
            >
              Clear
            </Button>
          </div>
        )}
        
        {hasActiveFilters && (
          <div className="flex flex-wrap gap-2 items-center">
            <span className="text-sm text-muted-foreground">Active filters:</span>
            {dateRange.from && dateRange.to && (
              <Badge variant="outline" className="flex items-center gap-1 h-7 px-2">
                <Calendar className="h-3 w-3" />
                <span className="text-xs">
                  {format(dateRange.from, 'MMM d')} - {format(dateRange.to, 'MMM d')}
                </span>
                <Button 
                  variant="ghost" 
                  size="sm" 
                  className="h-5 w-5 p-0 ml-1 hover:bg-transparent"
                  onClick={() => setDateRange({ from: undefined, to: undefined })}
                >
                  <X className="h-3 w-3" />
                </Button>
              </Badge>
            )}
            {activeType === 'surplus' && (amountRange.min || amountRange.max) && (
              <Badge variant="outline" className="flex items-center gap-1 h-7 px-2">
                <Wallet className="h-3 w-3" />
                <span className="text-xs">
                  {amountRange.min ? `₱${amountRange.min}` : '₱0'} - 
                  {amountRange.max ? `₱${amountRange.max}` : 'Any'}
                </span>
                <Button 
                  variant="ghost" 
                  size="sm" 
                  className="h-5 w-5 p-0 ml-1 hover:bg-transparent"
                  onClick={() => setAmountRange({ min: '', max: '' })}
                >
                  <X className="h-3 w-3" />
                </Button>
              </Badge>
            )}
            <Button 
              variant="ghost" 
              size="sm" 
              className="h-7 text-xs text-muted-foreground"
              onClick={clearFilters}
            >
              Clear all
            </Button>
          </div>
        )}
        
        <div className="mt-2">
          <ApprovalTable
            requests={filteredAndSortedRequests}
            requestType={activeType}
            approvalStatus="approved"
            currentPage={paginationProps.currentPage}
            totalPages={paginationProps.totalPages}
            onPageChange={paginationProps.onPageChange}
            pageSize={paginationProps.pageSize}
            onPageSizeChange={paginationProps.onPageSizeChange}
          />
        </div>
      </div>
    </div>
  );
} 