# Bundle Size Optimization Implementation Plan

## Overview

This document outlines the implementation plan for code splitting and dynamic imports to reduce JavaScript bundle size and improve performance.

## Setup and Analysis

### 1. Bundle Analyzer Configuration

We've configured the Next.js Bundle Analyzer to identify large chunks:

```ts
// next.config.ts
const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true',
});

export default withBundleAnalyzer(nextConfig);
```

```json
// package.json
"scripts": {
  "analyze": "ANALYZE=true next build"
}
```

### 2. Component Priority List

Based on initial analysis, we've identified these high-impact components for optimization:

1. **ManualRemittanceWizard** - Large multi-step form (850+ lines)
2. **VirtualizedDonorList** - Virtualizes long lists with heavy dependencies
3. **LineChart** - Uses Recharts library 
4. **DonorHistoryModal** - Modal with complex data fetching
5. **OnlinePaymentWizard** - Complex payment flow
6. **FinanceRemittanceWizard** - Large form component

## Implementation Pattern

We'll follow a consistent pattern for all dynamically imported components:

### 1. Wrapper Component Template

```tsx
// ComponentWrapper.tsx
"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { ComponentSkeleton } from "./ComponentSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { ComponentProps } from "./types";
import { trackPerformance } from "@/utils/performance";

// Dynamically import the component
const DynamicComponent = dynamic(
  () => import("./Component").then(mod => mod.Component),
  {
    loading: () => <ComponentSkeleton />,
    ssr: false, // Set to true for components that should render on server
  }
);

// Preload function for the component
const preloadComponent = () => {
  // Start loading the component in the background
  import("./Component");
};

export function ComponentWrapper(props: ComponentProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('ComponentWrapper');
    return endTracking;
  }, []);

  // Preload the component when this wrapper mounts
  useEffect(() => {
    preloadComponent();
  }, []);

  const handleError = (error: Error) => {
    console.error('Component error:', error);
    // Handle error appropriately
  };

  return (
    <ErrorBoundary 
      fallback={<div className="error-fallback">Error loading component</div>}
      onError={handleError}
    >
      <Suspense fallback={<ComponentSkeleton />}>
        <DynamicComponent {...props} />
      </Suspense>
    </ErrorBoundary>
  );
}
```

### 2. Skeleton Component Template

```tsx
// ComponentSkeleton.tsx
"use client";

import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import { useReducedMotion } from "framer-motion";

export function ComponentSkeleton() {
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
      className="space-y-4"
      variants={skeletonVariants}
      initial="initial"
      animate="animate"
    >
      {/* Skeleton structure matching component layout */}
      <Skeleton className="h-8 w-3/4" />
      <Skeleton className="h-4 w-full" />
      {/* Additional skeleton elements */}
    </motion.div>
  );
}
```

## Implementation Schedule

We'll implement the dynamic imports in this order:

1. ManualRemittanceWizard
   - Create ManualRemittanceWizardWrapper
   - Create ManualRemittanceWizardSkeleton
   - Update imports in parent components

2. LineChart
   - Create LineChartWrapper
   - Create LineChartSkeleton
   - Update imports in DonationStats and other components

3. DonorHistoryModal
   - Create DonorHistoryModalWrapper
   - Create DonorHistoryModalSkeleton
   - Update imports in parent components

4. VirtualizedDonorList
   - Create VirtualizedDonorListWrapper
   - Create VirtualizedDonorListSkeleton
   - Update imports in parent components

5. OnlinePaymentWizard
   - Create OnlinePaymentWizardWrapper
   - Create OnlinePaymentWizardSkeleton
   - Update imports in parent components

6. FinanceRemittanceWizard
   - Create FinanceRemittanceWizardWrapper
   - Create FinanceRemittanceWizardSkeleton
   - Update imports in parent components

## Performance Tracking

For each component, we'll track:

1. Bundle size impact
2. Load time improvements 
3. Initial page load metrics

## References

- [Next.js Dynamic Imports](https://nextjs.org/docs/advanced-features/dynamic-import)
- [React Suspense](https://react.dev/reference/react/Suspense)
- [BulkOnlinePaymentWizardWrapper](../components/missionary-dashboard/BulkOnlinePaymentWizardWrapper.tsx) (reference implementation)