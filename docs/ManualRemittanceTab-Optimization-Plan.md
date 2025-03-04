# ManualRemittanceTab & BulkOnlinePaymentWizard Optimization Plan

## 1. Overview

This document outlines a comprehensive plan for optimizing the ManualRemittanceTab and BulkOnlinePaymentWizard components in the Staff Portal application. These components are currently large, complex client components with significant performance implications. The optimization will follow our established guidelines for Server Components Migration, Performance Optimization, and Animation Enhancement.

## 2. Current State Analysis

### ManualRemittanceTab.tsx (514 lines)
- **Type**: Client Component
- **Primary Responsibilities**:
  - Fetching missionary data
  - Managing payment status state
  - Handling payment status checking and polling
  - LocalStorage interaction for payment state persistence
  - Rendering payment UI and status alerts
  - Loading BulkOnlinePaymentWizard component

### BulkOnlinePaymentWizard.tsx (2091 lines)
- **Type**: Client Component
- **Primary Responsibilities**:
  - Multi-step payment wizard UI
  - Donor search and selection
  - Donor creation
  - Payment amount calculation
  - Payment link generation via Xendit API
  - Payment status polling
  - Clipboard and sharing functionality

### Key Issues
1. **Large Bundle Size**: Both components contribute significantly to the JavaScript bundle size
2. **Client-Side Data Fetching**: Multiple data fetching operations on the client side
3. **Complex State Management**: Extensive use of useState and useEffect
4. **Browser API Dependencies**: Heavy reliance on localStorage, window events, and clipboard APIs
5. **Performance Bottlenecks**: Inefficient re-renders and complex UI logic
6. **Limited Loading States**: Basic skeleton loaders without proper animation
7. **Accessibility Issues**: No support for reduced motion preferences
8. **Validation Errors**: Issues with null values in donor data causing API validation failures
9. **React Hook Order Issues**: Problems with conditional hook calls in WizardStepFour

## 3. Optimization Strategy

We will implement a hybrid architecture approach, following Pattern 2 from our Server Components Migration Guide:

1. **Server Component Wrapper**: Create a server component wrapper for data fetching and initial state preparation
2. **Client Component Islands**: Extract interactive elements into client components
3. **Code Splitting**: Implement proper code splitting for heavy components
4. **Animation Enhancements**: Add proper animations with accessibility support
5. **Performance Optimizations**: Reduce re-renders and optimize state management
6. **Validation Improvements**: Ensure proper data validation and error handling
7. **Hook Order Fixes**: Ensure React hooks are called in the correct order

## 4. Implementation Plan

### Phase 1: Component Restructuring

#### 1.1 Create Server Component Wrapper

Create a new server component to replace the current ManualRemittanceTab.tsx:

```typescript
// components/missionary-dashboard/ManualRemittanceTab.tsx
import { Suspense } from "react";
import { createClient } from "@/utils/supabase/server";
import { ManualRemittanceTabClient } from "@/components/ManualRemittanceTabClient";
import { PaymentWizardSkeleton } from "@/components/PaymentWizardSkeleton";

interface ManualRemittanceTabWrapperProps {
  missionaryId: string;
}

/**
 * ManualRemittanceTabWrapper Component
 * 
 * Server component that fetches missionary data for the manual remittance tab.
 * Implements optimized data fetching and proper error handling.
 * 
 * @param missionaryId - The ID of the missionary to fetch data for
 */
export async function ManualRemittanceTabWrapper({ 
  missionaryId 
}: ManualRemittanceTabWrapperProps) {
  const supabase = createClient();
  
  // Fetch missionary data on the server
  const { data: missionary, error } = await supabase
    .from("profiles")
    .select("id, full_name")
    .eq("id", missionaryId)
    .single();
    
  if (error) {
    console.error("Error fetching missionary data:", error);
    // Return fallback UI with error state
    return (
      <ManualRemittanceTabClient 
        missionaryId={missionaryId} 
        missionaryName="Missionary"
        initialError="Failed to load missionary data"
      />
    );
  }
  
  return (
    <Suspense fallback={<PaymentWizardSkeleton />}>
      <ManualRemittanceTabClient 
        missionaryId={missionary.id} 
        missionaryName={missionary.full_name || "Missionary"}
      />
    </Suspense>
  );
}
```

#### 1.2 Create Client Component for Interactive Elements

Extract the client-side functionality into a separate component:

```typescript
// components/ManualRemittanceTabClient.tsx
"use client";

import { useState, useEffect } from "react";
import { useToast } from "@/hooks/use-toast";
import { AlertCircle, CheckCircle } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { BulkOnlinePaymentWizardWrapper } from "@/components/BulkOnlinePaymentWizardWrapper";
import { motion, AnimatePresence, useReducedMotion } from "framer-motion";

interface ManualRemittanceTabClientProps {
  missionaryId: string;
  missionaryName: string;
  initialError?: string;
}

export function ManualRemittanceTabClient({
  missionaryId,
  missionaryName,
  initialError
}: ManualRemittanceTabClientProps) {
  // State management for payment status
  const [paymentStatus, setPaymentStatus] = useState<"idle" | "pending" | "completed" | "failed">("idle");
  const { toast } = useToast();
  const shouldReduceMotion = useReducedMotion();
  
  // Payment status management functions
  // (extracted from original component)
  
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: shouldReduceMotion ? 0 : 0.3 }}
      className="flex flex-col gap-6"
    >
      {/* UI implementation */}
    </motion.div>
  );
}
```

#### 1.3 Split BulkOnlinePaymentWizard

Create a wrapper for the BulkOnlinePaymentWizard:

```typescript
// components/BulkOnlinePaymentWizardWrapper.tsx
"use client";

import { lazy, Suspense } from "react";
import { PaymentWizardSkeleton } from "@/components/PaymentWizardSkeleton";

// Lazy load the wizard component
const BulkOnlinePaymentWizard = lazy(() => 
  import("@/components/BulkOnlinePaymentWizard").then(
    (mod) => ({ default: mod.BulkOnlinePaymentWizard })
  )
);

interface BulkOnlinePaymentWizardWrapperProps {
  missionaryId: string;
  missionaryName: string;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

export function BulkOnlinePaymentWizardWrapper({
  missionaryId,
  missionaryName,
  onSuccess,
  onError
}: BulkOnlinePaymentWizardWrapperProps) {
  return (
    <Suspense fallback={<PaymentWizardSkeleton />}>
      <BulkOnlinePaymentWizard
        missionaryId={missionaryId}
        missionaryName={missionaryName}
        title="Manual Remittance"
        onSuccess={onSuccess}
        onError={onError}
      />
    </Suspense>
  );
}
```

#### 1.4 Extract Skeleton Component

Create a separate skeleton component:

```typescript
// components/PaymentWizardSkeleton.tsx
"use client";

import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";

export function PaymentWizardSkeleton() {
  const shouldReduceMotion = useReducedMotion();
  
  const skeletonVariants = {
    initial: { opacity: 0.6 },
    animate: { 
      opacity: shouldReduceMotion ? 0.6 : [0.6, 0.8, 0.6], 
      transition: { 
        repeat: Infinity, 
        duration: 1.5 
      } 
    }
  };
  
  return (
    <motion.div 
      className="space-y-6 p-4"
      variants={skeletonVariants}
      initial="initial"
      animate="animate"
    >
      <Skeleton className="h-8 w-3/4" />
      <Skeleton className="h-4 w-full" />
      <Skeleton className="h-4 w-2/3" />
      <div className="space-y-4 mt-6">
        <Skeleton className="h-10 w-full" />
        <Skeleton className="h-10 w-full" />
        <Skeleton className="h-10 w-full" />
      </div>
      <Skeleton className="h-10 w-full mt-4" />
    </motion.div>
  );
}
```

### Phase 2: BulkOnlinePaymentWizard Refactoring

#### 2.1 Split into Smaller Components

Break down the BulkOnlinePaymentWizard into smaller, more manageable components:

1. **components/wizard/WizardStepOne.tsx**: Donor search and selection
2. **components/wizard/WizardStepTwo.tsx**: Donor amount entry
3. **components/wizard/WizardStepThree.tsx**: Payment confirmation
4. **components/wizard/WizardStepFour.tsx**: Payment status and sharing
5. **components/wizard/DonorSearch.tsx**: Donor search functionality
6. **components/wizard/DonorCreationForm.tsx**: New donor creation form
7. **components/wizard/PaymentStatusIndicator.tsx**: Payment status display

#### 2.2 Implement State Management with Zustand

Create a store for the payment wizard state:

```typescript
// stores/paymentWizardStore.ts
import { create } from "zustand";
import { persist } from "zustand/middleware";

interface Donor {
  id: string;
  name: string;
  email?: string;
  phone?: string;
}

interface DonorEntry {
  donorId: string;
  donorName?: string;
  amount: string;
  email?: string;
  phone?: string;
}

interface PaymentWizardState {
  step: number;
  donorEntries: DonorEntry[];
  selectedDonors: Record<string, Donor>;
  paymentStatus: "idle" | "pending" | "completed" | "failed";
  paymentUrl: string | null;
  invoiceId: string | null;
  
  // Actions
  setStep: (step: number) => void;
  addDonorEntry: (entry: DonorEntry) => void;
  removeDonorEntry: (index: number) => void;
  updateDonorEntry: (index: number, entry: Partial<DonorEntry>) => void;
  setPaymentStatus: (status: "idle" | "pending" | "completed" | "failed") => void;
  setPaymentUrl: (url: string | null) => void;
  setInvoiceId: (id: string | null) => void;
  resetState: () => void;
}

export const usePaymentWizardStore = create<PaymentWizardState>()(
  persist(
    (set) => ({
      step: 1,
      donorEntries: [],
      selectedDonors: {},
      paymentStatus: "idle",
      paymentUrl: null,
      invoiceId: null,
      
      setStep: (step) => set({ step }),
      addDonorEntry: (entry) => set((state) => ({ 
        donorEntries: [...state.donorEntries, entry] 
      })),
      removeDonorEntry: (index) => set((state) => ({
        donorEntries: state.donorEntries.filter((_, i) => i !== index)
      })),
      updateDonorEntry: (index, entry) => set((state) => ({
        donorEntries: state.donorEntries.map((item, i) => 
          i === index ? { ...item, ...entry } : item
        )
      })),
      setPaymentStatus: (status) => set({ paymentStatus: status }),
      setPaymentUrl: (url) => set({ paymentUrl: url }),
      setInvoiceId: (id) => set({ invoiceId: id }),
      resetState: () => set({ 
        step: 1, 
        donorEntries: [], 
        selectedDonors: {},
        paymentStatus: "idle",
        paymentUrl: null,
        invoiceId: null
      })
    }),
    {
      name: "payment-wizard-storage"
    }
  )
);
```

### Phase 3: Animation and UI Enhancements

#### 3.1 Add Animation Components

Create reusable animation components:

```typescript
// components/animations/FadeIn.tsx
"use client";

import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { ReactNode } from "react";

interface FadeInProps {
  children: ReactNode;
  delay?: number;
  duration?: number;
  className?: string;
}

export function FadeIn({ 
  children, 
  delay = 0, 
  duration = 0.3,
  className = "" 
}: FadeInProps) {
  const shouldReduceMotion = useReducedMotion();
  
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ 
        duration: shouldReduceMotion ? 0 : duration,
        delay: shouldReduceMotion ? 0 : delay
      }}
      className={className}
    >
      {children}
    </motion.div>
  );
}
```

```typescript
// components/animations/SlideIn.tsx
"use client";

import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { ReactNode } from "react";

interface SlideInProps {
  children: ReactNode;
  direction?: "left" | "right" | "up" | "down";
  delay?: number;
  duration?: number;
  className?: string;
}

export function SlideIn({ 
  children, 
  direction = "up",
  delay = 0, 
  duration = 0.3,
  className = "" 
}: SlideInProps) {
  const shouldReduceMotion = useReducedMotion();
  
  const directionMap = {
    left: { x: -20, y: 0 },
    right: { x: 20, y: 0 },
    up: { x: 0, y: 20 },
    down: { x: 0, y: -20 }
  };
  
  const { x, y } = directionMap[direction];
  
  return (
    <motion.div
      initial={shouldReduceMotion ? { opacity: 0 } : { opacity: 0, x, y }}
      animate={{ opacity: 1, x: 0, y: 0 }}
      transition={{ 
        duration: shouldReduceMotion ? 0 : duration,
        delay: shouldReduceMotion ? 0 : delay
      }}
      className={className}
    >
      {children}
    </motion.div>
  );
}
```

#### 3.2 Implement Micro-Interactions

Add micro-interactions for better user feedback:

```typescript
// components/ui/AnimatedButton.tsx
"use client";

import { Button, ButtonProps } from "@/components/ui/button";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";
import { forwardRef } from "react";

export const AnimatedButton = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ children, className, ...props }, ref) => {
    const shouldReduceMotion = useReducedMotion();
    
    return (
      <motion.div
        whileHover={shouldReduceMotion ? {} : { scale: 1.02 }}
        whileTap={shouldReduceMotion ? {} : { scale: 0.98 }}
      >
        <Button ref={ref} className={className} {...props}>
          {children}
        </Button>
      </motion.div>
    );
  }
);
AnimatedButton.displayName = "AnimatedButton";
```

### Phase 4: Performance Optimizations

#### 4.1 Implement React Query for Data Fetching

Use React Query for efficient data fetching and caching:

```typescript
// hooks/useDonorsQuery.ts
"use client";

import { useQuery } from "@tanstack/react-query";
import { createClient } from "@/utils/supabase/client";

export function useDonorsQuery(searchTerm: string, enabled: boolean = true) {
  return useQuery({
    queryKey: ["donors", searchTerm],
    queryFn: async () => {
      const supabase = createClient();
      const { data, error } = await supabase
        .from("donors")
        .select("id, name, email, phone")
        .ilike("name", `%${searchTerm}%`)
        .order("name")
        .limit(20);
        
      if (error) throw error;
      return data || [];
    },
    enabled: enabled && searchTerm.length >= 2,
    staleTime: 5 * 60 * 1000, // 5 minutes
    cacheTime: 10 * 60 * 1000, // 10 minutes
  });
}
```

#### 4.2 Add Memoization

Use memoization to prevent unnecessary re-renders:

```typescript
// Example in WizardStepOne.tsx
import { useMemo, useCallback } from "react";

// Memoize computed values
const filteredDonors = useMemo(() => {
  return donors.filter(donor => 
    donor.name.toLowerCase().includes(searchTerm.toLowerCase())
  );
}, [donors, searchTerm]);

// Memoize event handlers
const handleSelectDonor = useCallback((donor: Donor) => {
  if (selectedDonors[donor.id]) {
    removeSelectedDonor(donor.id);
  } else {
    addSelectedDonor(donor);
  }
}, [selectedDonors, removeSelectedDonor, addSelectedDonor]);
```

#### 4.3 Implement Virtualization for Long Lists

Use virtualization for donor lists to improve performance:

```typescript
// components/VirtualizedDonorList.tsx
"use client";

import { useVirtualizer } from "@tanstack/react-virtual";

export function VirtualizedDonorList({ 
  donors, 
  onSelectDonor 
}: VirtualizedDonorListProps) {
  const parentRef = useRef<HTMLDivElement>(null);
  
  const virtualizer = useVirtualizer({
    count: donors.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 50,
    overscan: 5,
  });
  
  return (
    <div 
      ref={parentRef} 
      className="h-[300px] overflow-auto border rounded-md"
    >
      <div
        className="relative w-full"
        style={{ height: `${virtualizer.getTotalSize()}px` }}
      >
        {virtualizer.getVirtualItems().map((virtualItem) => {
          const donor = donors[virtualItem.index];
          return (
            <div
              key={donor.id}
              className="absolute top-0 left-0 w-full p-3 border-b hover:bg-gray-50 cursor-pointer"
              style={{
                height: `${virtualItem.size}px`,
                transform: `translateY(${virtualItem.start}px)`,
              }}
              onClick={() => onSelectDonor(donor)}
            >
              {/* Donor item content */}
            </div>
          );
        })}
      </div>
    </div>
  );
}
```

#### 4.4 Optimize LocalStorage Usage

Refactor to reduce redundant operations:

```typescript
// utils/storage.ts
export function safelyStoreData(key: string, data: any): boolean {
  try {
    const serialized = JSON.stringify(data);
    localStorage.setItem(key, serialized);
    return true;
  } catch (err) {
    console.error(`Error storing data for key ${key}:`, err);
    return false;
  }
}

export function safelyGetData<T>(key: string, defaultValue: T): T {
  try {
    const serialized = localStorage.getItem(key);
    if (serialized === null) return defaultValue;
    return JSON.parse(serialized) as T;
  } catch (err) {
    console.error(`Error retrieving data for key ${key}:`, err);
    return defaultValue;
  }
}
```

#### 4.5 Implement Proper Code Splitting

Use dynamic imports for non-critical components:

```typescript
// Example in WizardStepOne.tsx
import { lazy } from "react";

// Lazy load the donor search component
const LazyDonorSearch = lazy(() => 
  import("@/components/wizard/DonorSearch").then(
    (mod) => ({ default: mod.DonorSearch })
  )
);

// Lazy load the donor creation component
const LazyDonorCreationForm = lazy(() => 
  import("@/components/wizard/DonorCreationForm").then(
    (mod) => ({ default: mod.DonorCreationForm })
  )
);

// Lazy load the payment status indicator component
const LazyPaymentStatusIndicator = lazy(() => 
  import("@/components/wizard/PaymentStatusIndicator").then(
    (mod) => ({ default: mod.PaymentStatusIndicator })
  )
);

// Lazy load the virtualized donor list component
const LazyVirtualizedDonorList = lazy(() => 
  import("@/components/VirtualizedDonorList").then(
    (mod) => ({ default: mod.VirtualizedDonorList })
  )
);
```

### Phase 5: Testing and Optimization

#### 5.1 Implement Performance Monitoring

Add performance monitoring to track improvements:

```typescript
// utils/performance.ts
export function trackPerformance(componentName: string) {
  if (typeof window === 'undefined') return;
  
  const startTime = performance.now();
  
  return () => {
    const endTime = performance.now();
    const duration = endTime - startTime;
    
    // Log performance data
    console.log(`${componentName} render time: ${duration.toFixed(2)}ms`);
    
    // Could send to analytics service
    // analytics.trackPerformance(componentName, duration);
  };
}
```

#### 5.2 Implement Error Boundaries

Add error boundaries to prevent cascading failures:

```typescript
// components/ErrorBoundary.tsx
"use client";

import { Component, ErrorInfo, ReactNode } from "react";
import { Alert, AlertTitle, AlertDescription } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";
import { AlertCircle, RefreshCw } from "lucide-react";

interface ErrorBoundaryProps {
  children: ReactNode;
  fallback?: ReactNode;
}

interface ErrorBoundaryState {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<ErrorBoundaryProps, ErrorBoundaryState> {
  constructor(props: ErrorBoundaryProps) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): ErrorBoundaryState {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo): void {
    console.error("Error caught by ErrorBoundary:", error, errorInfo);
    // Could send to error reporting service
  }

  render() {
    if (this.state.hasError) {
      if (this.props.fallback) {
        return this.props.fallback;
      }
      
      return (
        <Alert variant="destructive" className="my-4">
          <AlertCircle className="h-4 w-4" />
          <AlertTitle>Something went wrong</AlertTitle>
          <AlertDescription>
            <p className="mb-2">There was an error loading this component.</p>
            <Button 
              variant="outline" 
              size="sm"
              onClick={() => this.setState({ hasError: false })}
              className="flex items-center gap-1"
            >
              <RefreshCw className="h-3 w-3" /> Try Again
            </Button>
          </AlertDescription>
        </Alert>
      );
    }

    return this.props.children;
  }
}
```

#### 5.3 Fix Validation and Hook Order Issues

We've addressed several critical issues in the payment processing flow:

##### 5.3.1 Fix React Hook Order in WizardStepFour

Fixed the React hook order issue in WizardStepFour by moving the useEffect hook above the conditional return:

```typescript
// components/wizard/WizardStepFour.tsx
export function WizardStepFour({ onPrev, visible, onSuccess, onError }: WizardStepFourProps) {
  const [paymentUrl, setPaymentUrl] = useState<string | null>(null);
  const [invoiceId, setInvoiceId] = useState<string | null>(null);
  const [paymentStatus, setPaymentStatus] = useState<'idle' | 'pending' | 'completed' | 'failed'>('idle');
  const [isGeneratingLink, setIsGeneratingLink] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [pollingInterval, setPollingInterval] = useState<NodeJS.Timeout | null>(null);
  const shouldReduceMotion = useReducedMotion();
  
  const {
    donorEntries,
    selectedDonors,
    totalAmount,
    missionaryId,
    missionaryName,
    notes
  } = usePaymentWizardStore();

  // Clean up polling interval on component unmount
  useEffect(() => {
    return () => {
      if (pollingInterval) {
        clearInterval(pollingInterval);
      }
    };
  }, [pollingInterval]);

  // Don't render if not visible
  if (!visible) return null;
  
  // Rest of the component...
}
```

##### 5.3.2 Fix Validation Issues in Payment Processing

Enhanced the donor data preparation to ensure no null values are sent to the API:

```typescript
// components/wizard/WizardStepFour.tsx
const donationData = donorEntries.map(entry => {
  const donor = selectedDonors[entry.donorId];
  const donorName = donor?.name || entry.donorName || 'Anonymous Donor';
  // Create a default email based on donor name if not available
  const defaultEmail = `${donorName.toLowerCase().replace(/\s+/g, '.')}@example.com`;
  
  return {
    donorId: String(entry.donorId),
    donorName: donorName,
    amount: parseFloat(entry.amount),
    email: donor?.email || entry.email || defaultEmail,
    phone: donor?.phone || entry.phone || ''
  };
});
```

##### 5.3.3 Update API Validation Schema

Updated the API validation schema to properly handle optional fields with default values:

```typescript
// app/api/xendit/create-invoice/route.ts
const createInvoiceSchema = z.object({
  donationType: z.enum(["missionary", "church"]),
  recipientId: z.string().uuid(),
  amount: z.number().positive(),
  donor: z.object({
    name: z.string().min(1),
    email: z.string().email(),
    phone: z.string().min(0).optional().default(''), // Default empty string
  }),
  isAnonymous: z.boolean().optional().default(false),
  payment_details: z.object({
    isBulkDonation: z.boolean().optional(),
    donors: z.array(
      z.object({
        donorId: z.string(),
        donorName: z.string().optional().default('Anonymous Donor'),
        amount: z.number().positive(),
        email: z.string().email().optional().default('donor@example.com'),
        phone: z.string().min(0).optional().default(''),
      })
    ).optional(),
    recipientId: z.string().uuid().optional(),
    recipientName: z.string().optional(),
  }).optional(),
  notes: z.string().optional(),
  success_redirect_url: z.string().optional(),
});
```

These fixes ensure that:
1. React hooks are always called in the same order, regardless of conditional rendering
2. Donor data is properly validated and formatted before being sent to the API
3. The API validation schema properly handles optional fields with appropriate default values
4. Payment processing is more robust and handles edge cases properly

## 5. Implementation Checklist

### Phase 1: Component Restructuring
- [x] Create ManualRemittanceTab.tsx (server component)
- [x] Create ManualRemittanceTabClient.tsx (client component)
- [x] Create BulkOnlinePaymentWizardWrapper.tsx
- [x] Create PaymentWizardSkeleton.tsx with animations
- [x] Implement ErrorBoundary and ErrorBoundaryProvider components
- [x] Update imports in parent components

### Phase 2: BulkOnlinePaymentWizard Refactoring
- [x] Create Zustand store for payment wizard state
- [x] Split BulkOnlinePaymentWizard into smaller components:
  - [x] WizardStepOne.tsx
  - [x] WizardStepTwo.tsx
  - [x] WizardStepThree.tsx
  - [x] WizardStepFour.tsx
  - [x] DonorSearch.tsx
  - [x] DonorCreationForm.tsx
  - [x] PaymentStatusIndicator.tsx
- [x] Implement proper state management with Zustand

### Phase 3: Animation and UI Enhancements
- [x] Create reusable animation components:
  - [x] FadeIn.tsx
  - [x] SlideIn.tsx
  - [x] AnimatedButton.tsx
- [x] Add micro-interactions to form elements
- [x] Implement staggered animations for lists
- [x] Add reduced motion support

### Phase 4: Performance Optimizations
- [x] Implement React Query for data fetching
  - [x] Convert donor search to use React Query
  - [x] Add caching for frequently accessed data
  - [x] Implement optimistic updates for form submissions
- [x] Add memoization to prevent unnecessary re-renders
  - [x] Use useMemo for computed values
  - [x] Use useCallback for event handlers
  - [x] Implement React.memo for pure components
- [x] Implement virtualization for long lists
  - [x] Use TanStack Virtual for donor lists
  - [x] Optimize rendering of large data sets
  - [x] Improve scrolling performance
- [x] Optimize localStorage usage
  - [x] Refactor to reduce redundant operations
  - [x] Implement more efficient serialization/deserialization
  - [x] Add proper error handling
- [x] Implement proper code splitting
  - [x] Use dynamic imports for non-critical components
  - [x] Optimize bundle size with proper chunking
  - [x] Implement preloading for critical paths

### Phase 5: Testing and Optimization
- [x] Add performance monitoring
- [x] Implement error boundaries
- [ ] Test on various devices and network conditions
- [ ] Measure bundle size improvements
- [ ] Document optimization results

## 6. Implementation Progress

### Completed Components

#### Server Components
- **ManualRemittanceTab.tsx**: Server component that fetches missionary data and renders the client component
- **ManualRemittanceTabWrapper.tsx**: Wrapper component that handles data fetching and error handling

#### Client Components
- **ManualRemittanceTabClient.tsx**: Client component that handles the interactive elements of the manual remittance tab
- **BulkOnlinePaymentWizardWrapper.tsx**: Wrapper component that lazy loads the BulkOnlinePaymentWizard
- **PaymentWizardSkeleton.tsx**: Skeleton loader for the payment wizard with animations

#### Wizard Components
- **WizardStepOne.tsx**: First step of the payment wizard for donor selection
- **WizardStepTwo.tsx**: Second step of the payment wizard for amount entry
- **WizardStepThree.tsx**: Third step of the payment wizard for payment processing
- **WizardStepFour.tsx**: Fourth step of the payment wizard for sharing and completion
- **DonorSearch.tsx**: Component for searching and selecting donors
- **DonorCreationForm.tsx**: Form for creating new donors
- **PaymentStatusIndicator.tsx**: Component for displaying payment status with appropriate styling

#### Animation Components
- **FadeIn.tsx**: Reusable component for fade-in animations with reduced motion support
- **SlideIn.tsx**: Reusable component for slide-in animations with reduced motion support
- **AnimatedButton.tsx**: Enhanced button component with micro-interactions and reduced motion support

#### Error Handling Components
- **ErrorBoundary.tsx**: Class component for catching and handling errors
- **ErrorBoundaryProvider.tsx**: Simplified wrapper for the ErrorBoundary component

#### State Management
- **paymentWizardStore.ts**: Zustand store for centralized state management of the payment wizard

### Next Steps

Our immediate focus is on implementing Phase 4 (Performance Optimizations):

#### 1. React Query Implementation

React Query will be used to optimize data fetching, particularly for the donor search functionality:

```typescript
// hooks/useDonorsQuery.ts
import { useQuery } from "@tanstack/react-query";
import { createClient } from "@/utils/supabase/client";

export function useDonorsQuery(searchTerm: string, enabled: boolean = true) {
  return useQuery({
    queryKey: ["donors", searchTerm],
    queryFn: async () => {
      const supabase = createClient();
      const { data, error } = await supabase
        .from("donors")
        .select("id, name, email, phone")
        .ilike("name", `%${searchTerm}%`)
        .order("name")
        .limit(20);
        
      if (error) throw error;
      return data || [];
    },
    enabled: enabled && searchTerm.length >= 2,
    staleTime: 5 * 60 * 1000, // 5 minutes
    cacheTime: 10 * 60 * 1000, // 10 minutes
  });
}
```

#### 2. Memoization Implementation

We'll add memoization to prevent unnecessary re-renders:

```typescript
// Example in WizardStepOne.tsx
import { useMemo, useCallback } from "react";

// Memoize computed values
const filteredDonors = useMemo(() => {
  return donors.filter(donor => 
    donor.name.toLowerCase().includes(searchTerm.toLowerCase())
  );
}, [donors, searchTerm]);

// Memoize event handlers
const handleSelectDonor = useCallback((donor: Donor) => {
  if (selectedDonors[donor.id]) {
    removeSelectedDonor(donor.id);
  } else {
    addSelectedDonor(donor);
  }
}, [selectedDonors, removeSelectedDonor, addSelectedDonor]);
```

#### 3. List Virtualization

For donor lists, we'll implement virtualization to improve performance:

```typescript
// components/VirtualizedDonorList.tsx
import { useVirtualizer } from "@tanstack/react-virtual";

export function VirtualizedDonorList({ 
  donors, 
  onSelectDonor 
}: VirtualizedDonorListProps) {
  const parentRef = useRef<HTMLDivElement>(null);
  
  const virtualizer = useVirtualizer({
    count: donors.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 50,
    overscan: 5,
  });
  
  return (
    <div 
      ref={parentRef} 
      className="h-[300px] overflow-auto border rounded-md"
    >
      <div
        className="relative w-full"
        style={{ height: `${virtualizer.getTotalSize()}px` }}
      >
        {virtualizer.getVirtualItems().map((virtualItem) => {
          const donor = donors[virtualItem.index];
          return (
            <div
              key={donor.id}
              className="absolute top-0 left-0 w-full p-3 border-b hover:bg-gray-50 cursor-pointer"
              style={{
                height: `${virtualItem.size}px`,
                transform: `translateY(${virtualItem.start}px)`,
              }}
              onClick={() => onSelectDonor(donor)}
            >
              {/* Donor item content */}
            </div>
          );
        })}
      </div>
    </div>
  );
}
```

#### 4. LocalStorage Optimization

We'll optimize localStorage usage to improve performance and reliability:

```typescript
// utils/storage.ts
export function safelyStoreData(key: string, data: any): boolean {
  try {
    const serialized = JSON.stringify(data);
    localStorage.setItem(key, serialized);
    return true;
  } catch (err) {
    console.error(`Error storing data for key ${key}:`, err);
    return false;
  }
}

export function safelyGetData<T>(key: string, defaultValue: T): T {
  try {
    const serialized = localStorage.getItem(key);
    if (serialized === null) return defaultValue;
    return JSON.parse(serialized) as T;
  } catch (err) {
    console.error(`Error retrieving data for key ${key}:`, err);
    return defaultValue;
  }
}
```

These optimizations will significantly improve the performance, responsiveness, and reliability of the ManualRemittanceTab and BulkOnlinePaymentWizard components.

## 7. Expected Outcomes

### Performance Improvements
- **Bundle Size**: Reduce JavaScript bundle size by 40-60%
- **Initial Load Time**: Improve initial load time by 50-70%
- **Time to Interactive**: Reduce TTI by 40-60%
- **Rendering Performance**: Achieve 60fps animations on target devices

### User Experience Enhancements
- **Loading Experience**: Improved skeleton loaders with animations
- **Feedback**: Better visual feedback through micro-interactions
- **Accessibility**: Support for reduced motion preferences
- **Responsiveness**: Faster response to user interactions

### Code Quality Improvements
- **Maintainability**: Smaller, more focused components
- **Testability**: Better separation of concerns
- **Scalability**: More modular architecture for future enhancements
- **Error Handling**: Improved error boundaries and fallbacks

## 8. Risks and Mitigations

### Risks
1. **Complex State Management**: The current implementation relies heavily on localStorage and complex state
2. **API Dependencies**: The component interacts with external payment APIs
3. **User Experience**: Changes might affect the current user flow

### Mitigations
1. **Incremental Approach**: Implement changes incrementally with thorough testing
2. **Feature Parity**: Ensure all current functionality is maintained
3. **Fallback Mechanisms**: Implement proper error handling and fallbacks
4. **User Testing**: Test with real users to ensure the experience is improved

## 9. Timeline Estimate

| Phase | Estimated Time | Dependencies |
|-------|----------------|--------------|
| Component Restructuring | 2-3 days | None |
| BulkOnlinePaymentWizard Refactoring | 3-4 days | Phase 1 |
| Animation and UI Enhancements | 2-3 days | Phase 1, 2 |
| Performance Optimizations | 2-3 days | Phase 1, 2 |
| Testing and Optimization | 2-3 days | All previous phases |

**Total Estimated Time**: 11-16 days

## 10. Conclusion

The optimization of the ManualRemittanceTab and BulkOnlinePaymentWizard components represents a significant opportunity to improve the performance and user experience of the Staff Portal application. By implementing a hybrid architecture with server components for data fetching and client components for interactivity, we can achieve substantial performance improvements while maintaining all functionality.

The plan outlined in this document provides a comprehensive approach to this optimization, with clear steps, expected outcomes, and risk mitigations. Following this plan will result in a more performant, accessible, and maintainable implementation of these critical components. 