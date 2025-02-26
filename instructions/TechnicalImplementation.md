# Staff Portal - Technical Implementation

## System Architecture

### Authentication & Authorization
- **Technology**: Supabase Auth
- **Implementation**: 
  - Role-based authentication using `user_roles` table
  - Row Level Security (RLS) policies for data access control
  - Session management via Supabase client

### Database Schema

#### Core Tables
1. `profiles`
   ```sql
   profiles (
     id uuid references auth.users(id),
     full_name text,
     role text,
     local_church_id uuid,
     monthly_goal numeric(10,2),
     surplus_balance numeric(10,2),
     created_at timestamptz
   )
   ```

2. `donor_donations`
   ```sql
   donor_donations (
     id bigserial primary key,
     missionary_id uuid references auth.users(id),
     donor_id uuid references donors(id),
     amount numeric(10,2),
     date timestamptz,
     source varchar(20), -- 'online' or 'offline'
     status varchar(20), -- 'completed', 'pending', 'failed'
     recorded_by uuid references auth.users(id),
     created_at timestamptz,
     updated_at timestamptz
   )
   ```

3. `surplus_requests`
   ```sql
   surplus_requests (
     id bigserial primary key,
     missionary_id uuid,
     amount_requested numeric(10,2),
     reason text,
     status varchar(20),
     campus_director_approval varchar(20),
     lead_pastor_approval varchar(20),
     church_cut_percentage numeric(5,2),
     church_cut_amount numeric(10,2),
     net_amount numeric(10,2),
     created_at timestamptz
   )
   ```

### Component Architecture

#### Layout Components
1. **Dashboard Layout** (`app/dashboard/layout.tsx`)
   - Responsive layout with dynamic sidebar
   - Role-based navigation rendering
   - Persistent navbar across dashboard pages
   - Handles route-based sidebar selection

#### Core Components
1. **Dashboard Cards** (`components/DashboardCards.tsx`)
   - Responsive grid of key metrics
   - Features:
     - Monthly goal progress with visual indicator
     - Current donations total
     - Active and new partner counts
     - Color-coded trend indicators
   - Performance optimized with memoization
   - Responsive grid layout (1-4 columns)

2. **Reports System** (`components/reports/`)
   - **Global Reports Tab** (`components/reports/GlobalReportsTab.tsx`)
     - Features:
       - Top-level metrics cards
         - Total donations this month
         - Current total percentage
         - Change from last month
         - Count of missionaries below 80%
       - Tabbed interface for missionaries, churches, and partners
       - Real-time data loading and error handling
       - Responsive layout with clean UI
       - Optimized state management
       - Enhanced error handling

   - **Data Loading Hook** (`hooks/useReportsData.ts`)
     - Features:
       - Centralized data fetching from Supabase
       - Efficient donor data processing
       - Optimized state initialization
       - Robust error handling
       - Calculates key metrics:
         - Monthly donation totals
         - Percentage calculations
         - Below 80% missionary count
         - Partner donation totals
       - Builds donation maps for efficient lookups
       - Real-time data synchronization

   - **Tables**
     - **Missionaries Table** (`components/reports/tables/MissionariesTable.tsx`)
       - Missionary list with monthly goals
       - Current month percentage tracking
       - Quick access to 6-month and full reports
       - Real-time progress updates
     - **Churches Table** (`components/reports/tables/ChurchesTable.tsx`)
       - Church list with aggregated goals
       - Current month percentage for all missionaries
       - Detailed view of missionary performance
     - **Partners Table** (`components/reports/tables/PartnersTable.tsx`)
       - Partner list with 13-month donation history
       - Total giving calculations
       - Detailed donation history access
       - Enhanced donor data display
       - Optimized loading states

   - **Modals**
     - **Missionary Last 6 Modal** (`components/reports/modals/MissionaryLast6Modal.tsx`)
       - 6-month performance history
       - Monthly percentage calculations
     - **Church Details Modal** (`components/reports/modals/ChurchDetailsModal.tsx`)
       - 4-month view of all missionaries
       - Color-coded performance indicators
     - **Full Missionary Report Modal** (`components/reports/modals/FullMissionaryReportModal.tsx`)
       - 13-month partner donation history
       - Detailed partner information
       - Paginated partner list
     - **Partner Details Modal** (`components/reports/modals/PartnerDetailsModal.tsx`)
       - Complete donation history
       - Missionary-specific breakdowns
       - Transaction details

   - **Utilities** (`utils/reports.ts`)
     - Helper functions for:
       - Number formatting
       - Donation calculations
       - Percentage computations
       - Date handling
       - Data aggregation

   - **Types** (`types/reports.ts`)
     - Type definitions for:
       - Profiles (missionaries)
       - Churches
       - Donors and donations
       - Modal states
       - Data structures

3. **Approval System**
   - **Approval Tab** (`components/ApprovalTab.tsx`)
     - Main approval management dashboard for campus directors
     - Features:
       - Separate tabs for pending/approved requests
       - Scrollable request lists with virtualization
       - Real-time status updates via Supabase
       - Animated transitions using Framer Motion
       - Request count badges
     - Performance optimizations:
       - React Server Components where possible
       - Virtualized lists for large datasets
       - Optimized re-renders
       - Lazy-loaded modals

   - **Approval Card** (`components/ApprovalCard.tsx`)
     - Individual request management card
     - Features:
       - Clean card layout with request details
       - Approve/Reject actions with confirmation
       - Optional notes for decisions
       - Real-time status updates
       - Color-coded status indicators
     - Performance optimizations:
       - Optimistic updates
       - Proper cleanup of listeners
       - Efficient modal state
       - Debounced operations

   - **Lead Pastor Approval** (`components/LeadPastorApprovalTab.tsx`)
     - Specialized interface for lead pastor approvals
     - Features:
       - Real-time search with debouncing
       - Advanced filtering options
       - Pagination with custom page size
       - Override capabilities
       - Detailed request information
     - Performance optimizations:
       - Memoized request filtering
       - Debounced search
       - Paginated data display
       - Efficient state management

4. **Donation Management**
   - **Donation Modal** (`components/DonationModal.tsx`)
     - Features:
       - Dialog-based donation entry form
       - Missionary selection
       - Donor search with suggestions
       - Form validation
       - Success feedback
     - Implementation Notes:
       - Sets required 'recorded_by' field to satisfy RLS policies
       - Uses API route for donation submission
       - Handles donor creation and selection
       - Provides real-time validation feedback

   - **Finance Remittance Wizard** (`components/FinanceRemittanceWizard.tsx`)
     - Features:
       - Three-step wizard interface for donation entry
       - Missionary selection in first step
       - Total amount entry in second step
       - Donor distribution with notes in third step
       - Real-time donor search with debouncing
       - New donor creation with validation
       - Amount validation and balancing
     - Implementation Notes:
       - Critical fix: Setting 'recorded_by' field to finance officer's ID
       - Adds notes field for additional donation context
       - Uses server action for donation submission
       - Multi-level fallback system for resilient submission
       - Comprehensive error handling and validation
       - Designed specifically for finance dashboard integration
     - Benefits:
       - Improved user experience for finance officers
       - Enhanced audit trail with proper attribution
       - Better data integrity with validation
       - More contextual information with notes field

   - **Create Donation Form** (`components/create-donation-form.tsx`)
     - Features:
       - Simplified donation entry for church staff
       - Missionary selection
       - Amount and date inputs
       - Optional donor information
       - Form validation
     - State Management:
       ```typescript
       interface CreateDonationFormProps {
         missionaries: Array<{ id: string, full_name: string }>;
         localChurchId: string;
       }
       ```

   - **Recent Donations** (`components/RecentDonations.tsx`)
     - Features:
       - Card-based transaction display
       - Donor name with history modal
       - Date and amount formatting
       - Empty state handling
       - Resilient data handling with fallbacks for missing donors
     - Data Model:
       ```typescript
       interface Donation {
         id: string | number;
         donor_name: string;
         date: string;
         amount: number;
         notes?: string;
       }
       ```

   - **Donor History Modal** (`components/DonorHistoryModal.tsx`)
     - Features:
       - Complete donation history for specific donor
       - Real-time data fetching
       - Loading states
       - Error handling
       - Scrollable transaction list
     - Performance Optimizations:
       - Data fetched only when modal opens
       - Optimistic updates
       - Proper cleanup on close

   - **Manual Remittance Wizard** (`components/ManualRemittanceWizard.tsx`)
     - Features:
       - Multi-step form for recording offline donations
       - Dynamic donor entry with search functionality
       - Real-time validation and error handling
       - Progress tracking with visual indicators
       - Success animations and toast notifications
     - RLS Compliance:
       - Uses server actions to bypass RLS restrictions
       - Sets required 'recorded_by' field to satisfy RLS policies
       - Comprehensive error handling and logging
       - Fallback mechanisms for failed submissions
     - Implementation Notes:
       - Server action in `actions/donations.ts` handles RLS bypass
       - Critical fix: Setting 'recorded_by' field to finance officer's ID (not missionary_id)
       - Detailed logging for troubleshooting permission issues
       - Individual transaction processing for better error isolation

   - **Donation Submission Action** (`actions/donations.ts`)
     - Features:
       - Server-side action that bypasses RLS using admin client
       - Comprehensive validation of donation entries
       - Detailed logging for troubleshooting
       - Individual transaction processing
       - Fallback mechanisms for failed submissions
     - RLS Compliance:
       - Uses admin client with service role key
       - Sets 'recorded_by' field to satisfy RLS policies
       - Handles materialized view refresh errors
     - Implementation Notes:
       - Critical fix: Setting 'recorded_by' field to finance officer's ID (not missionary_id)
       - Detailed logging for troubleshooting permission issues
       - Fallback to RPC for failed submissions
       - Partial success handling for multiple donations

   - **Missionary Dashboard Overview** (`components/missionary-dashboard/OverviewTab.tsx`)
     - Features:
       - Comprehensive dashboard with donation statistics
       - Recent donation list integration
       - Robust data fetching architecture
       - Foreign key relationship handling
       - Fallback mechanisms for data inconsistencies
     - Advanced Query Strategy:
       - Two-step query approach to avoid problematic joins
       - Separate fetching of donations and donor information
       - Manual data linking with TypeScript Maps
       - Fallback donor names for missing records
       - Detailed documentation through code comments
     - Benefits:
       - Resilient to database inconsistencies
       - Graceful handling of missing relationships
       - Improved type safety with TypeScript Maps
       - Enhanced maintainability with comprehensive comments
       - Better debugging capabilities with targeted error handling

### Church Management

#### Core Components

1. **Church List** (`components/ChurchesList.tsx`)
   - Features:
     - Tabular display of all churches
     - Lead pastor assignment display
     - Quick access to church details
     - Integration with edit modal
     - Responsive table layout
   - Data Model:
     ```typescript
     interface Church {
       id: number;
       name: string;
       lead_pastor_id: string | null;
     }
     ```

2. **Church Edit Modal** (`components/EditChurchModal.tsx`)
   - Features:
     - Church name updates
     - Lead pastor assignment
     - Real-time validation
     - Loading states
     - Error handling
     - Optimistic updates
   - State Management:
     ```typescript
     // Component State
     const [name, setName] = useState(church.name);
     const [leadPastorId, setLeadPastorId] = useState(church.lead_pastor_id || "none");
     const [loading, setLoading] = useState(false);
     const [error, setError] = useState("");
     ```

3. **Churches Table** (`components/reports/ChurchesTable.tsx`)
   - Features:
     - Advanced filtering capabilities
     - Pagination controls
     - Monthly goal tracking
     - Donation progress monitoring
     - Church-specific metrics

#### Database Schema
```sql
local_churches (
  id serial primary key,
  name text not null,
  lead_pastor_id uuid references auth.users(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
)
```

#### Integration Points
1. **User Management**
   - Lead pastor assignment
   - Church-user relationships
   - Role-based permissions

2. **Reporting System**
   - Church-specific metrics
   - Donation tracking
   - Goal monitoring
   - Performance analytics

3. **Approval System**
   - Church-based approvals
   - Lead pastor workflows
   - Permission management

### Donation Management

#### Core Components

1. **Donation Modal** (`components/DonationModal.tsx`)
   - Features:
     - Dialog-based donation entry form
     - Missionary selection
     - Donor search with suggestions
     - Form validation
     - Success feedback
   - Implementation Notes:
     - Sets required 'recorded_by' field to satisfy RLS policies
     - Uses API route for donation submission
     - Handles donor creation and selection
     - Provides real-time validation feedback

2. **Finance Remittance Wizard** (`components/FinanceRemittanceWizard.tsx`)
   - Features:
     - Three-step wizard interface for donation entry
     - Missionary selection in first step
     - Total amount entry in second step
     - Donor distribution with notes in third step
     - Real-time donor search with debouncing
     - New donor creation with validation
     - Amount validation and balancing
   - Implementation Notes:
     - Critical fix: Setting 'recorded_by' field to finance officer's ID
     - Adds notes field for additional donation context
     - Uses server action for donation submission
     - Multi-level fallback system for resilient submission
     - Comprehensive error handling and validation
     - Designed specifically for finance dashboard integration
   - Benefits:
     - Improved user experience for finance officers
     - Enhanced audit trail with proper attribution
     - Better data integrity with validation
     - More contextual information with notes field

3. **Create Donation Form** (`components/create-donation-form.tsx`)
   - Features:
     - Simplified donation entry for church staff
     - Missionary selection
     - Amount and date inputs
     - Optional donor information
     - Form validation
   - State Management:
     ```typescript
     interface CreateDonationFormProps {
       missionaries: Array<{ id: string, full_name: string }>;
       localChurchId: string;
     }
     ```

4. **Recent Donations** (`components/RecentDonations.tsx`)
   - Features:
     - Card-based transaction display
     - Donor name with history modal
     - Date and amount formatting
     - Empty state handling
     - Resilient data handling with fallbacks for missing donors
   - Data Model:
     ```typescript
     interface Donation {
       id: string | number;
       donor_name: string;
       date: string;
       amount: number;
       notes?: string;
     }
     ```

5. **Donor History Modal** (`components/DonorHistoryModal.tsx`)
   - Features:
     - Complete donation history for specific donor
     - Real-time data fetching
     - Loading states
     - Error handling
     - Scrollable transaction list
   - Performance Optimizations:
     - Data fetched only when modal opens
     - Optimistic updates
     - Proper cleanup on close

6. **Manual Remittance Wizard** (`components/ManualRemittanceWizard.tsx`)
   - Features:
     - Multi-step form for recording offline donations
     - Dynamic donor entry with search functionality
     - Real-time validation and error handling
     - Progress tracking with visual indicators
     - Success animations and toast notifications
   - RLS Compliance:
     - Uses server actions to bypass RLS restrictions
     - Sets required 'recorded_by' field to satisfy RLS policies
     - Comprehensive error handling and logging
     - Fallback mechanisms for failed submissions
   - Implementation Notes:
       - Server action in `actions/donations.ts` handles RLS bypass
       - Critical fix: Setting 'recorded_by' field to finance officer's ID (not missionary_id)
       - Detailed logging for troubleshooting permission issues
       - Individual transaction processing for better error isolation

7. **Donation Submission Action** (`actions/donations.ts`)
   - Features:
     - Server-side action that bypasses RLS using admin client
     - Comprehensive validation of donation entries
     - Detailed logging for troubleshooting
     - Individual transaction processing
     - Fallback mechanisms for failed submissions
   - RLS Compliance:
     - Uses admin client with service role key
     - Sets 'recorded_by' field to satisfy RLS policies
     - Handles materialized view refresh errors
   - Implementation Notes:
     - Critical fix: Setting 'recorded_by' field to finance officer's ID (not missionary_id)
     - Detailed logging for troubleshooting permission issues
     - Fallback to RPC for failed submissions
     - Partial success handling for multiple donations

8. **Missionary Dashboard Overview** (`components/missionary-dashboard/OverviewTab.tsx`)
   - Features:
     - Comprehensive dashboard with donation statistics
     - Recent donation list integration
     - Robust data fetching architecture
     - Foreign key relationship handling
     - Fallback mechanisms for data inconsistencies
   - Advanced Query Strategy:
     - Two-step query approach to avoid problematic joins
     - Separate fetching of donations and donor information
     - Manual data linking with TypeScript Maps
     - Fallback donor names for missing records
     - Detailed documentation through code comments
   - Benefits:
     - Resilient to database inconsistencies
     - Graceful handling of missing relationships
     - Improved type safety with TypeScript Maps
     - Enhanced maintainability with comprehensive comments
     - Better debugging capabilities with targeted error handling

#### Database Schema
```sql
donor_donations (
  id bigserial primary key,
  missionary_id uuid references auth.users(id),
  donor_id uuid references donors(id),
  amount numeric(10,2),
  date timestamptz,
  source varchar(20),
  status varchar(20),
  recorded_by uuid references auth.users(id),
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
)

donors (
  id uuid primary key,
  name text not null,
  email text,
  phone text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
)
```

#### Integration Points
1. **User Management**
   - Donor profile management
   - Staff recording permissions
   - Missionary assignment

2. **Church Management**
   - Church-specific donation tracking
   - Local church reporting
   - Staff permissions

3. **Reporting System**
   - Donation analytics
   - Trend analysis
   - Goal tracking
   - Performance metrics

#### Security Considerations
1. **Data Validation**
   - Amount validation
   - Email format checking
   - Required field validation
   - Date range validation
   - Foreign key relationship validation

2. **Access Control**
   - Role-based permissions
   - Church-specific access
   - Audit trail via recorded_by
   - Data integrity protection
   - RLS policy compliance with proper field validation
   - Server actions to bypass RLS when needed

3. **Error Handling**
   - Form validation errors
   - API error handling
   - Database error recovery
   - Network error handling
   - Foreign key relationship error handling
   - Resilient rendering with fallback data
   - RLS permission error diagnostics and resolution

### Data Processing
1. **Donation Analysis**
   - Pivot table generation for monthly trends
   - Efficient data grouping and aggregation
   - Real-time calculations and updates
   - Progressive loading for large datasets

2. **Search and Filtering**
   - Debounced search implementation
   - Client-side filtering optimization
   - Server-side query optimization

3. **Statistical Analysis**
   - Monthly trend calculations
   - Goal progress tracking
   - Donor activity metrics
   - Real-time aggregations
   - Progressive data loading for large datasets

4. **Resilient Query Architecture**
   - Two-step query approach for problematic foreign key relationships
   - Separate fetching of related data to avoid join failures
   - Manual data linking in JavaScript for robust relationships
   - Fallback mechanisms for missing or inconsistent data
   - Enhanced error logging and diagnostics for query failures
   - Type-safe data handling with TypeScript Maps and interfaces
   - Example implementation in `components/missionary-dashboard/OverviewTab.tsx`

### State Management
1. **Client-Side State**
   - React's useState for component state
   - Custom hooks for shared logic
   - Optimistic updates for better UX

2. **Server State**
   - Supabase real-time subscriptions
   - Efficient data caching
   - Optimistic updates with rollback

### Performance Optimizations
1. **Data Loading**
   - Progressive loading for large datasets
   - Efficient data structures
   - Memoization of expensive calculations

2. **UI Optimizations**
   - Virtualized scrolling
   - Debounced inputs
   - Lazy-loaded modals
   - Optimized re-renders

3. **Chart Optimizations**
   - Lazy loaded visualization components
   - Memoized data transformations
   - Efficient chart library (Recharts)
   - Touch-friendly interactions
   - Responsive design patterns

### Error Handling
1. **Client-Side**
   - Proper TypeScript error types
   - User-friendly error messages
   - Graceful fallbacks
   - Loading states
   - Resilient rendering with fallback data
   - Comprehensive error logging

2. **Server-Side**
   - Supabase error handling
   - Type-safe error responses
   - Error logging and monitoring
   - Resilient query patterns

## Known Technical Debt
1. TypeScript errors in approval components
2. Missing component imports
3. Pagination implementation needs improvement
4. Error state handling could be more robust
5. Test coverage needs expansion
6. Foreign key relationships in database need audit and potential restructuring
7. Donor-donation relationship needs validation and data cleanup

## Development Environment
- Next.js 13+ with App Router
- Supabase for backend and auth
- Tailwind CSS for styling
- TypeScript for type safety
- Shadcn/UI for components 

# Navigation Components

The navigation system is built with a modular approach, featuring role-specific components and responsive design.

## Core Components

1. **Main Navbar** (`components/navbar.tsx`)
   - Global navigation bar with role-based dashboard selector
   - Integrated user authentication status
   - Dark mode support with Tailwind CSS
   - Responsive design with mobile optimization
   - SuperAdmin features:
     - Dashboard switcher
     - Profile selector for missionary view

2. **Role-Specific Sidebars**
   - **SuperAdmin Sidebar** (`components/SuperAdminSidebar.tsx`)
     - Access to Churches, Staff, Reports, and Settings
     - Mobile-responsive sheet navigation
     - URL-based active state management
   
   - **Lead Pastor Sidebar** (`components/LeadPastorSidebar.tsx`)
     - Focused interface for approvals and reports
     - Tabbed navigation for pending and approved requests
     - Mobile-optimized sheet navigation

   - **Missionary Sidebar** (`components/Sidebar.tsx`)
     - Dynamic navigation based on user role
     - Conditional rendering for campus directors
     - Integrated with authentication state

## Integration Points

1. **Authentication System**
   - Seamless integration with Supabase auth
   - Role-based access control
   - Automatic redirection based on user roles

2. **State Management**
   - URL-based state persistence
   - Real-time role updates
   - Efficient re-renders with React hooks

3. **User Experience**
   - Consistent styling across components
   - Smooth transitions and animations
   - Intuitive mobile navigation

## Performance Considerations

1. **Code Splitting**
   - Dynamic imports for role-specific components
   - Lazy loading of secondary navigation elements
   - Optimized bundle size

2. **State Updates**
   - Minimized re-renders with proper hook usage
   - Efficient role-based component switching
   - Optimized mobile navigation interactions

## Common Features

1. **Responsive Design**
   - Mobile-first approach with adaptive layouts
   - Sheet-based navigation for mobile devices
   - Consistent styling across breakpoints

2. **Theme Support**
   - Dark mode integration
   - Customizable color schemes
   - Consistent component styling

3. **Accessibility**
   - ARIA labels for navigation elements
   - Keyboard navigation support
   - Screen reader optimization

## Security Measures

1. **Role Validation**
   - Server-side role verification
   - Protected route access
   - Secure role-based rendering

2. **Navigation Guards**
   - Authenticated route protection
   - Role-based access control
   - Secure dashboard switching

## Error Handling

1. **Navigation Failures**
   - Graceful fallback for invalid routes
   - Clear error messaging
   - Automatic redirection for unauthorized access

2. **State Recovery**
   - Persistent navigation state
   - Recovery from failed transitions
   - Automatic error boundary handling 

# Utility Components

The application features a set of reusable utility components that enhance user experience and maintainability.

## Core Components

1. **Empty State** (`components/EmptyState.tsx`)
   - Consistent empty state presentation
   - Customizable icon, title, and description
   - Responsive design with Tailwind CSS
   - Themeable through CSS variables

2. **Pagination Controls** (`components/PaginationControls.tsx`)
   - Flexible pagination interface
   - Customizable page size selector
   - Responsive design for mobile and desktop
   - Integrated with Shadcn UI components
   - Features:
     - Page navigation (Previous/Next)
     - Items per page selector
     - Current page indicator
     - Disabled state handling

3. **Loading States**
   - Consistent loading indicators using Lucide React
   - Animated spinner with `Loader2` component
   - Context-aware loading states
   - Integrated with async operations

## Integration Points

1. **Data Display**
   - Table components integration
   - List view integration
   - Modal loading states
   - Form submission states

2. **User Feedback**
   - Error state handling
   - Success state presentation
   - Loading state indication
   - Empty state management

## Performance Considerations

1. **Component Optimization**
   - Minimal re-renders
   - Efficient state updates
   - Lazy loading support
   - Memoized components when needed

2. **Resource Management**
   - Efficient DOM updates
   - Optimized animations
   - Minimal layout shifts
   - Responsive image handling

## Common Features

1. **Accessibility**
   - ARIA labels
   - Keyboard navigation
   - Screen reader support
   - Focus management

2. **Theming**
   - Dark mode support
   - CSS variable integration
   - Consistent styling
   - Customizable appearance

3. **Error Handling**
   - Graceful fallbacks
   - Error boundaries
   - User-friendly messages
   - Recovery options

## Best Practices

1. **Component Design**
   - Single responsibility
   - Prop validation
   - TypeScript integration
   - Consistent API design

2. **Code Organization**
   - Modular structure
   - Clear dependencies
   - Reusable patterns
   - Documentation

3. **Testing**
   - Unit test coverage
   - Integration testing
   - Accessibility testing
   - Performance monitoring 

## SuperAdmin Dashboard

### Core Components
1. **Dashboard Layout** (`app/dashboard/superadmin/page.tsx`)
   - Dynamic tab-based interface
   - Role-based access validation
   - Real-time data fetching
   - Integrated error handling

2. **Navigation** (`components/SuperAdminSidebar.tsx`)
   - Responsive sidebar with mobile support
   - Tab-based navigation (Churches, Staff, Reports, Settings)
   - Dynamic route handling
   - Clean UI with active state indicators

3. **Feature Modules**
   - Churches Management (`components/ChurchesList.tsx`)
   - Staff Management (`components/UsersList.tsx`)
   - Global Reports (`components/GlobalReportsTab.tsx`)
   - System Settings (`components/settings/SettingsLayout.tsx`)

### Integration Points
1. **Authentication & Authorization**
   - Supabase Auth integration
   - Role validation via `getUserRole`
   - Protected route handling
   - Session management

2. **Data Management**
   - Real-time church data synchronization
   - User profile management
   - Role-based access control
   - Cross-component state management

### Performance Considerations
1. **Data Loading**
   - Parallel data fetching for churches and users
   - Efficient data merging for user profiles
   - Optimized component rendering
   - Dynamic imports for code splitting

2. **State Management**
   - Tab-based content switching
   - Efficient data caching
   - Optimistic updates
   - Real-time synchronization

### Security Measures
1. **Access Control**
   - Strict role validation
   - Protected route handling
   - Secure data fetching
   - Audit logging

2. **Data Protection**
   - Encrypted communication
   - Secure session handling
   - Input validation
   - Error boundary implementation

### Best Practices
1. **Code Organization**
   - Modular component structure
   - Clear separation of concerns
   - Type-safe implementations
   - Comprehensive error handling

2. **User Experience**
   - Responsive design patterns
   - Progressive loading
   - Clear navigation
   - Consistent error messaging 

## GlobalReportsTab Component

### Overview
The GlobalReportsTab is a comprehensive reporting interface for SuperAdmins to monitor and analyze donation patterns across all missionaries, churches, and partners.

### Core Features
1. **Top-Level Metrics**
   - Total donations for current month
   - Current total percentage across all missionaries
   - Last month's total percentage
   - Count of missionaries below 80% goal last month

2. **Data Management**
   - Real-time data fetching via Supabase
   - Efficient data aggregation and caching
   - 13-month historical data tracking
   - Pagination and filtering capabilities

3. **Sub-Components**
   - `MissionariesTable`: Detailed view of all missionary donations and goals
   - `ChurchesTable`: Church-wise aggregation of missionary data
   - `PartnersTable`: Comprehensive partner contribution tracking
   - `TopMetricsCards`: Summary cards for key performance indicators

4. **Interactive Features**
   - Detailed modal views for missionaries, churches, and partners
   - Real-time search and filtering
   - Customizable page size for tables
   - Drill-down capabilities for detailed analysis

### Performance Optimizations
- Memoized calculations for expensive operations
- Efficient data structures for O(1) lookups
- Paginated data display
- Progressive loading for large datasets
- Debounced search functionality

### Integration Points
- Supabase real-time data sync
- Role-based access control
- Church management system
- Donation tracking system

### Security Measures
- Data access validation
- Role-based permissions
- Secure data transmission
- Input sanitization

### Best Practices
- Modular component architecture
- Efficient state management
- Comprehensive error handling
- Responsive design patterns
- Type-safe implementations 