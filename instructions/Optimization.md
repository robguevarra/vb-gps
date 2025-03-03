# Staff Portal Performance Optimization Guide
Version 1.0 - May 2024

## Overview
This document provides systematic instructions for optimizing the Staff Portal application's performance. Each optimization should follow these guidelines to ensure consistent improvement across the codebase.

## Performance Metrics Target
- First Contentful Paint (FCP): < 1.5s
- Largest Contentful Paint (LCP): < 2.5s
- Time to Interactive (TTI): < 3.5s
- Total Blocking Time (TBT): < 200ms
- Page Load Time: < 3s

## 1. Component Optimization Protocol

### 1.1 Server Component Conversion
**Criteria for Server Components:**
- Components that don't need client interactivity
- Components primarily focused on data fetching
- Components that don't use browser APIs
- Components that don't use React hooks

**Implementation Steps:**
1. Remove "use client" directive
2. Move data fetching to server-side
3. Implement proper error boundaries
4. Add loading states using Next.js 13+ patterns

**Example Pattern:**
```typescript
// Before
"use client"
export function Component() {
  const [data, setData] = useState()
  useEffect(() => { fetch... }, [])
  return <div>{data}</div>
}

// After
export async function Component() {
  const data = await fetchData()
  return <div>{data}</div>
}
```

### 1.2 Client Component Optimization
**For components that must remain client-side:**
1. Implement proper memoization
2. Use controlled re-rendering patterns
3. Implement proper event delegation
4. Use debouncing/throttling for expensive operations

## 2. Data Fetching Optimization

### 2.1 Caching Implementation
**Required Caching Layers:**
1. Server-side caching
2. Client-side caching
3. Static data generation where applicable

**Implementation Pattern:**
```typescript
// Implement TanStack Query
export function useCachedData() {
  return useQuery({
    queryKey: ['key'],
    queryFn: fetchData,
    staleTime: 60000,
    cacheTime: 3600000
  })
}
```

### 2.2 Data Prefetching Strategy
1. Implement route-based prefetching
2. Use parallel data fetching where possible
3. Implement proper waterfall prevention

## 3. Code Splitting and Lazy Loading

### 3.1 Dynamic Import Implementation
**Components to Split:**
- Large third-party components
- Route-specific components
- Heavy computation components

**Implementation Pattern:**
```typescript
const HeavyComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <LoadingSpinner />,
  ssr: false // when browser-specific
})
```

### 3.2 Route-based Code Splitting
1. Implement proper page boundaries
2. Use proper loading states
3. Implement error boundaries

## 4. State Management Optimization

### 4.1 Global State Implementation
**Using Zustand:**
1. Create atomic stores
2. Implement proper selectors
3. Use proper state persistence

**Pattern:**
```typescript
const useStore = create((set) => ({
  data: null,
  setData: (data) => set({ data })
}))
```

### 4.2 Server State Management
1. Implement proper data mutations
2. Use optimistic updates
3. Implement proper error handling

## 5. Asset Optimization

### 5.1 Image Optimization
1. Use Next.js Image component
2. Implement proper sizing
3. Use WebP format
4. Implement lazy loading

### 5.2 Font Optimization
1. Use proper font loading strategies
2. Implement font subsetting
3. Use system fonts where possible

## 6. Performance Monitoring

### 6.1 Required Metrics
1. Core Web Vitals
2. Custom timing metrics
3. Error tracking
4. Performance budgets

### 6.2 Monitoring Implementation
1. Implement Vercel Analytics
2. Set up custom performance marks
3. Implement error boundaries with logging

## Implementation Process

1. **Analysis Phase**
   - Run performance audit
   - Identify critical paths
   - Document current metrics

2. **Optimization Phase**
   - Follow optimization protocols
   - Implement changes incrementally
   - Test after each change

3. **Validation Phase**
   - Run performance tests
   - Validate metrics
   - Document improvements

## Testing Protocol

### Performance Testing
1. Run Lighthouse audit
2. Test on slow 3G network
3. Test on low-end devices
4. Validate Core Web Vitals

### Validation Checklist
- [ ] Performance metrics meet targets
- [ ] No regression in functionality
- [ ] Error handling works
- [ ] Loading states work properly
- [ ] SEO metrics maintained

## Maintenance Guidelines

1. **Regular Audits**
   - Monthly performance reviews
   - Bundle size monitoring
   - Dependency updates

2. **Documentation**
   - Update performance metrics
   - Document optimization patterns
   - Maintain changelog

## Error Handling

1. **Implementation Requirements**
   - Proper error boundaries
   - Fallback UI components
   - Error logging
   - Recovery mechanisms

2. **Monitoring**
   - Set up error tracking
   - Implement performance monitoring
   - Set up alerting

## Security Considerations

1. **Performance vs Security**
   - Maintain proper authentication
   - Implement proper data validation
   - Use secure data fetching

2. **Optimization Security**
   - Safe third-party imports
   - Secure lazy loading
   - Protected API routes

## Version Control

1. **Branching Strategy**
   - Feature branches for optimizations
   - Performance testing branches
   - Proper merge validation

2. **Documentation**
   - Document performance changes
   - Update metrics in PRs
   - Maintain optimization changelog

## Dashboard-Specific Optimizations

### Missionary Dashboard

#### 1. Server Component Conversion
**Files to Convert:**
1. `app/dashboard/missionary/page.tsx`
   - Already a server component, but needs optimization
   - Current revalidation period (5 minutes) is good
   - Implemented proper error boundaries and loading states
   - Added parallel data fetching with Promise.all

2. `components/missionary-dashboard/OverviewTab.tsx`
   - Already a server component
   - Implemented proper data fetching with error handling
   - Added loading states with skeletons
   - Optimized data processing with Maps
   - Added proper TypeScript types

3. `components/missionary-dashboard/ReportsTab.tsx`
   - Already a server component
   - Needs optimization in data fetching

4. `components/missionary-dashboard/RequestHistoryTab.tsx`
   - Already a server component
   - Needs optimization in data fetching

5. `components/missionary-dashboard/ApprovalsTab.tsx`
   - Already a server component
   - Needs optimization in data fetching

6. `components/missionary-dashboard/ManualRemittanceTab.tsx`
   - Already a server component
   - Needs optimization in data fetching

#### 2. Client Component Optimization
**Files Optimized:**
1. `components/DashboardCards.tsx`
   ```typescript
   // Optimizations implemented:
   - Removed Framer Motion in favor of CSS transitions
   - Implemented proper memoization with useMemo and memo
   - Added loading states with skeletons
   - Optimized re-renders with component splitting
   - Added proper TypeScript types
   
   // Key changes:
   - Separated into DashboardCard and DashboardCardSkeleton components
   - Moved animations to CSS for better performance
   - Implemented proper loading states
   - Added proper error handling
   ```

2. `components/RecentDonations.tsx`
   ```typescript
   // Optimizations implemented:
   - Removed Framer Motion in favor of CSS transitions
   - Implemented proper memoization with useMemo and memo
   - Added loading states with skeletons
   - Optimized re-renders with component splitting
   - Added proper TypeScript types
   
   // Key changes:
   - Separated into DonationItem and EmptyState components
   - Moved animations to CSS for better performance
   - Implemented proper loading states
   - Added proper error handling
   ```

**Files to Optimize:**
1. `components/navbar.tsx`
   - Optimize state management
   - Implement proper memoization
   - Add proper loading states

2. `components/DonationStats.tsx`
   - Optimize chart rendering
   - Implement proper loading states
   - Add proper error handling

3. `components/ChurchReportsTab.tsx`
   - Optimize animations
   - Implement proper loading states
   - Add proper error handling

#### 3. Data Fetching Optimization
**Areas Implemented:**
1. Overview Tab:
   ```typescript
   // Implemented:
   - Parallel data fetching with Promise.all
   - Proper error handling
   - Loading states with skeletons
   - Efficient data processing with Maps
   - Type-safe data handling
   
   // Example:
   const [donationsResult, currentDonorsResult] = await Promise.all([
     supabase.from("donor_donations").select(...),
     supabase.from('donor_donations').select(...)
   ]);
   ```

**Areas to Implement:**
1. Reports Tab:
   ```typescript
   // Need to implement:
   - Data prefetching
   - Incremental loading
   - Proper caching strategy
   ```

2. Request History Tab:
   ```typescript
   // Need to implement:
   - Pagination optimization
   - Data prefetching
   - Proper caching strategy
   ```

3. Approvals Tab:
   ```typescript
   // Need to implement:
   - Real-time updates
   - Optimistic updates
   - Proper error handling
   ```

4. Manual Remittance Tab:
   ```typescript
   // Need to implement:
   - Form validation optimization
   - Data prefetching
   - Proper error handling
   ```

#### 4. Code Splitting and Lazy Loading
**Components Split:**
1. `components/reports/MissionariesTable.tsx`
   - Implement dynamic import
   - Add proper loading states

2. `components/reports/tables/MissionariesTable.tsx`
   - Implement dynamic import
   - Add proper loading states

3. `components/missionary-dashboard/ApprovalsTab.tsx`
   - Implement dynamic import
   - Add proper loading states

4. `components/missionary-dashboard/ManualRemittanceTab.tsx`
   - Implement dynamic import
   - Add proper loading states

#### 5. State Management Optimization
**Areas to Implement:**
1. Global State:
   ```typescript
   // Implement Zustand store for:
   - User preferences
   - UI state
   - Cached data
   ```

2. Server State:
   ```typescript
   // Implement TanStack Query for:
   - Donation data
   - Partner data
   - Reports data
   - Request history
   - Approval data
   ```

#### 6. Performance Monitoring
**Implement:**
1. Core Web Vitals tracking
2. Custom performance marks
3. Error boundaries with logging

#### 7. Specific Component Optimizations

1. **DashboardCards.tsx**
```typescript
// Implemented optimizations:
- Moved animations to CSS
- Implemented proper memoization
- Added skeleton loading states
- Optimized re-renders
- Added proper TypeScript types

// Key changes:
- Removed Framer Motion
- Added CSS transitions
- Implemented proper loading states
- Added proper error handling
```

2. **RecentDonations.tsx**
```typescript
// Implemented optimizations:
- Moved animations to CSS
- Implemented proper memoization
- Added skeleton loading states
- Optimized re-renders
- Added proper TypeScript types

// Key changes:
- Removed Framer Motion
- Added CSS transitions
- Implemented proper loading states
- Added proper error handling
```

3. **MissionariesTable.tsx**
```typescript
// Current issues:
- Heavy animations causing performance issues
- No proper loading states
- Inefficient filtering

// Optimization plan:
- Optimize animations
- Add proper loading states
- Implement debounced search
```

4. **ChurchReportsTab.tsx**
```typescript
// Current issues:
- Heavy animations causing performance issues
- No proper loading states
- Inefficient data processing

// Optimization plan:
- Optimize animations
- Add proper loading states
- Implement proper data processing
```

5. **DonationStats.tsx**
```typescript
// Current issues:
- Heavy chart rendering
- No proper loading states
- Inefficient data processing

// Optimization plan:
- Optimize chart rendering
- Add proper loading states
- Implement proper data processing
```

#### 8. Implementation Priority

1. **High Priority (Immediate Impact)**
   - Convert client components to server components where possible
   - Implement proper data fetching with caching
   - Add proper loading states

2. **Medium Priority (Performance Improvement)**
   - Implement code splitting
   - Optimize animations
   - Add proper error boundaries

3. **Low Priority (Nice to Have)**
   - Implement advanced monitoring
   - Add performance budgets
   - Implement advanced caching strategies

#### 9. Recent Optimizations (May 2024)

1. **DashboardCards Component**
   - Removed Framer Motion in favor of CSS transitions
   - Implemented proper memoization with useMemo and memo
   - Added loading states with skeletons
   - Optimized re-renders with component splitting
   - Added proper TypeScript types

2. **RecentDonations Component**
   - Removed Framer Motion in favor of CSS transitions
   - Implemented proper memoization with useMemo and memo
   - Added loading states with skeletons
   - Optimized re-renders with component splitting
   - Added proper TypeScript types

3. **OverviewTab Component**
   - Implemented parallel data fetching with Promise.all
   - Added proper error handling
   - Added loading states with skeletons
   - Optimized data processing with Maps
   - Added proper TypeScript types

4. **LeaveRequestModal Component**
   - Removed Framer Motion in favor of CSS transitions
   - Implemented proper memoization with useMemo and memo
   - Added loading states with skeletons
   - Optimized re-renders with component splitting
   - Added proper TypeScript types
   - Improved error handling and validation

5. **SurplusRequestModal Component**
   - Removed Framer Motion in favor of CSS transitions
   - Implemented proper memoization with useMemo and memo
   - Added loading states with skeletons
   - Optimized re-renders with component splitting
   - Added proper TypeScript types
   - Improved error handling and validation
   - Added proper balance calculations and validations

#### 10. Next Steps

1. **Form Components**
   - Optimize form validation
   - Add proper loading states
   - Implement proper error handling
   - Add proper TypeScript types

2. **Table Components**
   - Optimize table rendering
   - Add proper loading states
   - Implement proper error handling
   - Add proper TypeScript types

### Lead Pastor Dashboard

#### 1. Server Component Optimization
**Files to Optimize:**
1. `app/dashboard/lead-pastor/page.tsx`
   - Already a server component, but needs optimization
   - Implement proper data fetching patterns
   - Add proper error boundaries
   - Implement proper loading states

2. **Data Fetching Optimization:**
   ```typescript
   // Current issues:
   - Multiple separate Supabase queries
   - No proper caching
   - No parallel data fetching
   
   // Optimization plan:
   - Implement TanStack Query for caching
   - Use parallel data fetching
   - Implement proper error boundaries
   - Add proper loading states
   ```

#### 2. Client Component Optimization
**Files to Optimize:**
1. `app/dashboard/lead-pastor/LeadPastorDashboardClient.tsx`
   - Implement proper memoization
   - Optimize tab switching
   - Add proper loading states

2. `components/LeadPastorApprovalTab.tsx`
   - Optimize filtering and search
   - Implement proper pagination
   - Add proper loading states

3. `components/LeadPastorApprovalCard.tsx`
   - Optimize re-renders
   - Implement proper loading states
   - Add proper error handling

#### 3. Data Management Optimization
**Areas to Implement:**
1. **State Management:**
   ```typescript
   // Implement Zustand store for:
   - Approval state
   - Filter state
   - UI state
   ```

2. **Data Caching:**
   ```typescript
   // Implement TanStack Query for:
   - Leave requests
   - Surplus requests
   - Church data
   ```

#### 4. Performance Optimizations
**Specific Areas:**
1. **Approval Tab:**
   ```typescript
   // Current issues:
   - Heavy filtering operations
   - Unnecessary re-renders
   - No proper loading states
   
   // Optimization plan:
   - Implement virtualized list
   - Add proper memoization
   - Implement debounced search
   ```

2. **Reports Tab:**
   ```typescript
   // Current issues:
   - Heavy data processing
   - No proper loading states
   - Inefficient data fetching
   
   // Optimization plan:
   - Implement data prefetching
   - Add proper loading states
   - Implement incremental loading
   ```

#### 5. Code Splitting and Lazy Loading
**Components to Split:**
1. `components/LeadPastorApprovalTab.tsx`
   - Implement dynamic import
   - Add proper loading states

2. `components/ApprovedRequestsTab.tsx`
   - Implement dynamic import
   - Add proper loading states

#### 6. UI/UX Optimizations
**Areas to Improve:**
1. **Loading States:**
   - Add skeleton loaders
   - Implement proper loading indicators
   - Add proper error states

2. **Animations:**
   - Optimize tab transitions
   - Implement proper loading animations
   - Add proper error animations

#### 7. Implementation Priority

1. **High Priority (Immediate Impact)**
   - Optimize data fetching with proper caching
   - Implement proper loading states
   - Add proper error handling

2. **Medium Priority (Performance Improvement)**
   - Implement code splitting
   - Optimize filtering and search
   - Add proper pagination

3. **Low Priority (Nice to Have)**
   - Implement advanced monitoring
   - Add performance budgets
   - Implement advanced caching strategies
