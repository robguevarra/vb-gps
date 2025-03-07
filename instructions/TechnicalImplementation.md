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

## Online Payment Integration (Xendit)

### Overview
The Xendit integration enables online donations through a secure payment gateway, allowing donors to contribute directly to missionaries or churches through various payment methods.

### Core Components

1. **Xendit Service** (`lib/xendit.ts`)
   - Features:
     - Invoice creation with proper validation
     - Webhook signature verification
     - Invoice status checking
     - Comprehensive error handling
   - Implementation Notes:
     - Uses Xendit API v2 for invoice creation
     - Implements HMAC-based webhook verification
     - Handles various payment methods (credit card, virtual account, e-wallet)
     - Provides detailed error information for troubleshooting
     - Implements secure logging practices without exposing sensitive data

2. **API Endpoints**
   - **Create Invoice** (`app/api/xendit/create-invoice/route.ts`)
     - Features:
       - Request validation using Zod
       - Donor record creation/update
       - Transaction record creation
       - Invoice item tracking
       - Xendit invoice generation
     - Implementation Notes:
       - Uses service role client to bypass RLS
       - Sets system user ID for created records
       - Handles various edge cases and errors
       - Provides secure logging without exposing sensitive information
       - Implements proper error handling and validation

   - **Webhook Handler** (`app/api/xendit-webhook/route.ts`)
     - Features:
       - Webhook signature verification
       - Event-based processing (paid, expired)
       - Transaction status updates
       - Donation record creation on successful payment
       - Comprehensive error handling and logging
     - Implementation Notes:
       - Uses service role client to bypass RLS
       - Implements custom database function for donation creation
       - Handles various webhook event types
       - Provides secure logging without exposing sensitive data
       - Implements robust error handling

   - **Invoice Status** (`app/api/xendit/invoice-status/[invoiceId]/route.ts`)
     - Features:
       - Real-time invoice status checking
       - Transaction status synchronization
       - Error handling and logging
     - Implementation Notes:
       - Uses service role client to bypass RLS
       - Provides detailed status information for frontend
       - Implements secure logging practices

3. **Frontend Components**
   - **Online Payment Wizard** (`components/OnlinePaymentWizard.tsx`)
     - Features:
       - Multi-step donation form
       - Recipient selection (missionary/church)
       - Amount entry with validation
       - Donor information collection
       - Payment method selection
       - Success/failure handling
     - Implementation Notes:
       - Uses React Hook Form with Zod validation
       - Implements responsive design for mobile and desktop
       - Provides real-time validation feedback
       - Handles various edge cases and errors
       - Implements secure logging without exposing sensitive data

   - **Bulk Online Payment Wizard** (`components/BulkOnlinePaymentWizard.tsx`)
     - Features:
       - Multiple partner entry with amounts
       - Single payment link generation for total amount
       - Individual donation records for each partner
       - Real-time partner search and creation
       - Mobile-friendly interface
     - Implementation Notes:
       - Implements secure logging practices
       - Provides comprehensive error handling
       - Uses secure storage for payment information
       - Implements proper validation for all inputs

   - **Payment Status Pages**
     - **Success Page** (`app/payment/success/page.tsx`)
       - Features:
         - Payment confirmation display
         - Receipt information
         - Return to home option
     - **Failure Page** (`app/payment/failure/page.tsx`)
       - Features:
         - Error information display
         - Retry payment option
         - Contact support option

### Database Schema

```sql
-- Payment Transactions Table
payment_transactions (
  id uuid primary key default uuid_generate_v4(),
  reference_id text unique,
  invoice_id text unique,
  invoice_url text,
  amount numeric(10,2) not null,
  status text not null check (status in ('pending', 'paid', 'expired', 'failed')),
  payment_method text,
  payment_channel text,
  payer_name text,
  payer_email text,
  payment_details jsonb,
  created_by uuid references auth.users(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  expires_at timestamptz,
  paid_at timestamptz
);

-- Invoice Items Table
invoice_items (
  id uuid primary key default uuid_generate_v4(),
  invoice_id text,
  donation_id bigint references donor_donations(id),
  amount numeric(10,2),
  missionary_id uuid references auth.users(id),
  donor_id bigint references donors(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Webhook Logs Table
webhook_logs (
  id uuid primary key default uuid_generate_v4(),
  webhook_id text,
  event_type text,
  payload jsonb,
  signature text,
  ip_address text,
  status text,
  processing_errors text,
  created_by uuid references auth.users(id),
  created_at timestamptz default now()
);
```

### Materialized View Solution

#### Problem
The system uses a materialized view (`missionary_monthly_stats`) to track missionary donation statistics. When creating donation records through the webhook handler, the system encountered permission issues with refreshing this materialized view.

#### Solution
1. **Custom Database Function** (`insert_single_donation`)
   ```sql
   CREATE OR REPLACE FUNCTION insert_single_donation(
     donor_id BIGINT,
     amount NUMERIC,
     missionary_id UUID,
     donation_date TIMESTAMP WITH TIME ZONE,
     source TEXT,
     status TEXT,
     notes TEXT DEFAULT NULL
   )
   RETURNS VOID
   LANGUAGE plpgsql
   SECURITY DEFINER -- Run with privileges of the function creator
   AS $$
   BEGIN
     -- Direct insert using parameters
     -- This bypasses any triggers that would refresh the materialized view
     EXECUTE 'INSERT INTO donor_donations(donor_id, missionary_id, amount, date, source, status, notes) 
              VALUES ($1, $2, $3, $4, $5, $6, $7)'
     USING donor_id, missionary_id, amount, donation_date, source, status, notes;
   END;
   $$;
   ```

   - **Key Features**:
     - `SECURITY DEFINER`: Runs with the privileges of the function creator (database owner)
     - Direct SQL execution: Bypasses triggers that would refresh the materialized view
     - Parameter validation: Ensures all required fields are provided
     - Error handling: Propagates errors to the calling function

   - **Implementation Notes**:
     - The webhook handler calls this function via RPC instead of directly inserting
     - This bypasses the trigger that would refresh the materialized view
     - The materialized view can be refreshed separately on a schedule

2. **Webhook Handler Integration**
   ```typescript
   // Use direct SQL query to bypass materialized view refresh
   const { error: donationError } = await supabase.rpc(
     'insert_single_donation',
     {
       donor_id: item.donor_id,
       amount: item.amount || transaction.amount,
       missionary_id: item.missionary_id,
       donation_date: new Date().toISOString(),
       source: 'online',
       status: 'completed',
       notes: `Payment via ${payload.payment_method || "unknown"} (${payload.payment_channel || "unknown"})`
     }
   );
   ```

   - **Key Features**:
     - Uses Supabase RPC to call the custom function
     - Provides all required parameters
     - Handles errors gracefully
     - Includes detailed payment information in notes

### Security Considerations

1. **Webhook Verification**
   - HMAC-based signature verification
   - IP address logging
   - Comprehensive request logging
   - Development mode bypass option (for testing)

2. **Data Protection**
   - Secure storage of payment details
   - Minimal storage of sensitive information
   - Proper error handling to prevent information leakage
   - Audit trail via webhook logs
   - Removal of sensitive data from logs
   - Secure handling of payment information

3. **Access Control**
   - Service role client for bypassing RLS
   - System user ID for created records
   - SECURITY DEFINER function for elevated privileges
   - Proper error handling and logging
   - Principle of least privilege for database operations

4. **Secure Logging**
   - Removal of sensitive data from console logs
   - Redaction of API keys and credentials
   - Structured logging without sensitive information
   - Proper error handling without exposing internal details
   - Comprehensive audit trail for security events

### Payment Flow

1. **Invoice Creation**
   - User submits donation form
   - System creates payment_transaction record with status="pending"
   - System creates invoice_item record linking the transaction to potential donation
   - System generates Xendit invoice and provides payment URL
   - User is redirected to Xendit payment page

2. **Payment Processing**
   - User completes payment on Xendit platform
   - Xendit sends webhook with event="invoice.paid" to our webhook endpoint
   - System verifies webhook signature
   - System updates payment_transaction record to status="paid"
   - System creates donor_donation record with status="completed" using the custom function
   - System updates invoice_item with the donation reference

3. **Payment Expiration**
   - If payment is not completed within expiry time, Xendit sends webhook with event="invoice.expired"
   - System verifies webhook signature
   - System updates payment_transaction record to status="expired"
   - No donor_donation record is created for expired payments

### Best Practices

1. **Error Handling**
   - Comprehensive error logging
   - Graceful error recovery
   - User-friendly error messages
   - Detailed troubleshooting information
   - Secure error handling without exposing sensitive data

2. **Security**
   - Webhook signature verification
   - Secure storage of payment details
   - Proper error handling to prevent information leakage
   - Audit trail via webhook logs
   - Removal of sensitive data from logs
   - Regular security audits of payment-related code

3. **Performance**
   - Efficient database operations
   - Minimal database queries
   - Proper indexing of payment-related tables
   - Custom function for bypassing materialized view refresh

4. **Maintainability**
   - Modular code structure
   - Comprehensive documentation
   - Clear separation of concerns
   - Detailed logging for troubleshooting
   - Secure coding practices

## Frontend Developer Guide for Xendit Integration

This section provides frontend developers with practical guidance on implementing Xendit payment integration in their components.

### Available Components and Hooks

#### 1. BulkOnlinePaymentWizard Component

The `BulkOnlinePaymentWizard` is a comprehensive component for collecting donations from multiple partners using a single payment link.

```tsx
import { BulkOnlinePaymentWizard } from "@/components/BulkOnlinePaymentWizard";

// Usage example
<BulkOnlinePaymentWizard
  missionaryId={missionaryId}
  missionaryName={missionaryName}
  title="Manual Remittance"
  onSuccess={() => {
    // Handle successful payment link generation
    setPaymentStatus("pending");
    toast({
      title: "Success",
      description: "Payment process initiated successfully",
    });
  }}
  onError={(error) => {
    // Handle error in payment link generation
    setPaymentStatus("failed");
    toast({
      title: "Error",
      description: `Payment process failed: ${error}`,
      variant: "destructive"
    });
  }}
/>
```

**Props:**
- `missionaryId` (string): ID of the missionary generating the payment link
- `missionaryName` (string): Name of the missionary (for display purposes)
- `title` (string, optional): Custom title for the wizard
- `onSuccess` (function, optional): Callback function after successful link generation
- `onError` (function, optional): Callback function after link generation failure

#### 2. ManualRemittanceTabWrapper Component

This component wraps the `BulkOnlinePaymentWizard` and manages payment state, including status tracking and polling.

```tsx
import { ManualRemittanceTabWrapper } from "@/components/missionary-dashboard/ManualRemittanceTab";

// Usage example
<ManualRemittanceTabWrapper missionaryId={userId} />
```

**Props:**
- `missionaryId` (string): ID of the missionary

#### 3. Payment State Management

For custom implementations, you can use the following pattern to manage payment state:

```tsx
// Store payment state
const storePaymentState = (missionaryId, invoiceId, amount) => {
  const paymentState = {
    missionaryId: missionaryId,
    invoiceId: invoiceId,
    amount: amount,
    timestamp: new Date().toISOString()
  };
  localStorage.setItem(`payment_state_${missionaryId}`, JSON.stringify(paymentState));
  
  // Set payment status to pending
  localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
    status: "pending",
    timestamp: new Date().toISOString()
  }));
};

// Retrieve payment state
const getPaymentState = (missionaryId) => {
  const paymentStateStr = localStorage.getItem(`payment_state_${missionaryId}`);
  if (!paymentStateStr) return null;
  
  try {
    return JSON.parse(paymentStateStr);
  } catch (err) {
    console.error("Error parsing payment state:", err);
    return null;
  }
};

// Get payment status
const getPaymentStatus = (missionaryId) => {
  const statusStr = localStorage.getItem(`payment_status_${missionaryId}`);
  if (!statusStr) return null;
  
  try {
    return JSON.parse(statusStr);
  } catch (err) {
    console.error("Error parsing payment status:", err);
    return null;
  }
};

// Reset payment state
const resetPaymentState = (missionaryId) => {
  localStorage.removeItem(`payment_status_${missionaryId}`);
  localStorage.removeItem(`payment_state_${missionaryId}`);
  
  // Clear any polling intervals
  const pollingId = localStorage.getItem(`payment_polling_${missionaryId}`);
  if (pollingId) {
    clearInterval(parseInt(pollingId));
    localStorage.removeItem(`payment_polling_${missionaryId}`);
  }
};
```

#### 4. Payment Status Polling

To implement payment status polling in your components:

```tsx
const startPaymentStatusPolling = (invoiceId, missionaryId) => {
  // Clear any existing interval first
  const existingPollingId = localStorage.getItem(`payment_polling_${missionaryId}`);
  if (existingPollingId) {
    clearInterval(parseInt(existingPollingId));
  }
  
  // Set up interval to check payment status
  const intervalId = window.setInterval(async () => {
    try {
      // Check payment status using API
      const response = await fetch(`/api/xendit/check-invoice?invoiceId=${invoiceId}`);
      if (!response.ok) return;
      
      const data = await response.json();
      
      if (data.status === "PAID") {
        // Handle successful payment
        localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
          status: "completed",
          timestamp: new Date().toISOString()
        }));
        
        // Clear the interval
        clearInterval(intervalId);
        localStorage.removeItem(`payment_polling_${missionaryId}`);
      } else if (data.status === "EXPIRED" || data.status === "FAILED") {
        // Handle failed payment
        localStorage.setItem(`payment_status_${missionaryId}`, JSON.stringify({
          status: "failed",
          timestamp: new Date().toISOString()
        }));
        
        // Clear the interval
        clearInterval(intervalId);
        localStorage.removeItem(`payment_polling_${missionaryId}`);
      }
    } catch (error) {
      console.error("Error checking payment status:", error);
    }
  }, 5000); // Check every 5 seconds
  
  // Store interval ID for cleanup
  localStorage.setItem(`payment_polling_${missionaryId}`, intervalId.toString());
  
  // Auto-cleanup after 10 minutes
  setTimeout(() => {
    clearInterval(intervalId);
    localStorage.removeItem(`payment_polling_${missionaryId}`);
  }, 600000);
};
```

### API Endpoints for Frontend Integration

#### 1. Create Invoice Endpoint

```typescript
// Example: Creating a payment invoice
const createPaymentInvoice = async (data) => {
  try {
    const response = await fetch("/api/xendit/create-invoice", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        donationType: "missionary", // or "church"
        recipientId: data.missionaryId,
        amount: parseFloat(data.amount),
        donor: {
          name: data.donorName,
          email: data.donorEmail,
        },
        notes: data.notes || `Donation for ${data.missionaryName}`,
        payment_details: data.paymentDetails || {},
      }),
    });
    
    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.error || "Failed to create payment");
    }
    
    return await response.json();
  } catch (error) {
    console.error("Error creating payment:", error);
    throw error;
  }
};
```

**Request Body:**
```json
{
  "donationType": "missionary", // or "church"
  "recipientId": "missionary-uuid",
  "amount": 1000,
  "donor": {
    "name": "Donor Name",
    "email": "donor@example.com"
  },
  "notes": "Donation notes",
  "payment_details": {
    // Additional metadata for the payment
  }
}
```

**Response:**
```json
{
  "invoiceId": "xendit-invoice-id",
  "invoiceUrl": "https://checkout.xendit.co/web/invoice-id",
  "status": "PENDING"
}
```

#### 2. Check Invoice Status Endpoint

```typescript
// Example: Checking payment status
const checkPaymentStatus = async (invoiceId) => {
  try {
    const response = await fetch(`/api/xendit/check-invoice?invoiceId=${invoiceId}`);
    
    if (!response.ok) {
      throw new Error("Failed to check payment status");
    }
    
    return await response.json();
  } catch (error) {
    console.error("Error checking payment status:", error);
    throw error;
  }
};
```

**Response:**
```json
{
  "id": "xendit-invoice-id",
  "external_id": "external-id",
  "status": "PAID", // or "PENDING", "EXPIRED", "FAILED"
  "amount": 1000
}
```

#### 3. Bulk Payment Creation

For creating payments with multiple donors:

```typescript
// Example: Creating a bulk payment
const createBulkPayment = async (data) => {
  try {
    const response = await fetch("/api/xendit/create-invoice", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        donationType: "missionary",
        recipientId: data.missionaryId,
        amount: parseFloat(data.totalAmount),
        donor: {
          name: data.contactName,
          email: data.contactEmail,
        },
        notes: `Bulk donation for ${data.missionaryName}`,
        payment_details: {
          isBulkDonation: true,
          donors: data.donors.map(donor => ({
            donorId: donor.id,
            donorName: donor.name,
            amount: parseFloat(donor.amount)
          })),
          recipientId: data.missionaryId,
          recipientName: data.missionaryName
        }
      }),
    });
    
    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.error || "Failed to create bulk payment");
    }
    
    return await response.json();
  } catch (error) {
    console.error("Error creating bulk payment:", error);
    throw error;
  }
};
```

### Implementation Examples

#### 1. Simple Payment Form

```tsx
import { useState } from "react";
import { toast } from "@/hooks/use-toast";

export function SimplePaymentForm({ missionaryId, missionaryName }) {
  const [amount, setAmount] = useState("");
  const [donorName, setDonorName] = useState("");
  const [donorEmail, setDonorEmail] = useState("");
  const [loading, setLoading] = useState(false);
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    
    try {
      const response = await fetch("/api/xendit/create-invoice", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          donationType: "missionary",
          recipientId: missionaryId,
          amount: parseFloat(amount),
          donor: {
            name: donorName,
            email: donorEmail,
          },
          notes: `Donation for ${missionaryName}`,
        }),
      });
      
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || "Failed to create payment");
      }
      
      const data = await response.json();
      
      // Store payment info for status checking
      localStorage.setItem(`payment_${missionaryId}`, JSON.stringify({
        invoiceId: data.invoiceId,
        amount: amount,
        timestamp: new Date().toISOString()
      }));
      
      // Open payment page in new tab
      window.open(data.invoiceUrl, '_blank', 'noopener,noreferrer');
      
      toast({
        title: "Success",
        description: "Payment link generated successfully",
      });
    } catch (error) {
      toast({
        title: "Error",
        description: error.message || "Failed to create payment",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <div className="space-y-4">
        <div>
          <label htmlFor="amount">Donation Amount</label>
          <input
            id="amount"
            type="number"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            placeholder="0.00"
            required
          />
        </div>
        
        <div>
          <label htmlFor="donorName">Your Name</label>
          <input
            id="donorName"
            type="text"
            value={donorName}
            onChange={(e) => setDonorName(e.target.value)}
            placeholder="John Doe"
            required
          />
        </div>
        
        <div>
          <label htmlFor="donorEmail">Your Email</label>
          <input
            id="donorEmail"
            type="email"
            value={donorEmail}
            onChange={(e) => setDonorEmail(e.target.value)}
            placeholder="john@example.com"
            required
          />
        </div>
        
        <button
          type="submit"
          disabled={loading}
        >
          {loading ? "Processing..." : "Donate Now"}
        </button>
      </div>
    </form>
  );
}
```

#### 2. Payment Status Monitor

```tsx
import { useState, useEffect } from "react";

export function PaymentStatusMonitor({ invoiceId, missionaryId }) {
  const [status, setStatus] = useState("pending");
  
  useEffect(() => {
    // Check status immediately
    checkPaymentStatus();
    
    // Set up polling
    const intervalId = setInterval(checkPaymentStatus, 5000);
    
    // Cleanup
    return () => clearInterval(intervalId);
    
    async function checkPaymentStatus() {
      try {
        const response = await fetch(`/api/xendit/check-invoice?invoiceId=${invoiceId}`);
        if (!response.ok) return;
        
        const data = await response.json();
        
        if (data.status === "PAID") {
          setStatus("completed");
          clearInterval(intervalId);
        } else if (data.status === "EXPIRED" || data.status === "FAILED") {
          setStatus("failed");
          clearInterval(intervalId);
        }
      } catch (error) {
        console.error("Error checking payment status:", error);
      }
    }
  }, [invoiceId, missionaryId]);
  
  return (
    <div>
      {status === "pending" && (
        <div className="bg-yellow-50 p-4 rounded-md">
          <h3 className="text-yellow-800 font-medium">Payment in Progress</h3>
          <p className="text-yellow-700">Please complete your payment in the opened tab.</p>
        </div>
      )}
      
      {status === "completed" && (
        <div className="bg-green-50 p-4 rounded-md">
          <h3 className="text-green-800 font-medium">Payment Completed</h3>
          <p className="text-green-700">Your payment has been successfully processed.</p>
        </div>
      )}
      
      {status === "failed" && (
        <div className="bg-red-50 p-4 rounded-md">
          <h3 className="text-red-800 font-medium">Payment Failed</h3>
          <p className="text-red-700">There was an issue with your payment. Please try again.</p>
        </div>
      )}
    </div>
  );
}
```

### Best Practices for Frontend Developers

1. **Security**
   - Never log sensitive payment information (API keys, card details)
   - Don't store sensitive payment details in localStorage or sessionStorage
   - Use environment variables for API endpoints in production
   - Implement proper validation for all user inputs
   - Handle errors gracefully without exposing sensitive information

2. **User Experience**
   - Provide clear loading states during API calls
   - Display meaningful error messages when payments fail
   - Implement proper validation with helpful error messages
   - Offer a way to retry failed payments
   - Provide clear instructions for completing payments

3. **Performance**
   - Implement debouncing for user inputs
   - Use optimistic UI updates where appropriate
   - Clean up intervals and event listeners to prevent memory leaks
   - Implement proper error boundaries to prevent UI crashes

4. **Testing**
   - Use Xendit test cards for development:
     - Success: 4000000000000002
     - Failure: 4000000000000036
     - Authentication Required: 4000000000000028
   - Test the complete payment flow, including success and failure scenarios
   - Test with different payment methods (credit card, e-wallet, etc.)
   - Verify that webhooks are properly processed

### Troubleshooting Common Issues

1. **Payment Not Showing as Completed**
   - Check if the webhook URL is properly configured
   - Verify that the webhook signature verification is working
   - Check if the payment status is correctly updated in the database
   - Ensure that the polling mechanism is working correctly

2. **Payment Link Not Working**
   - Verify that the invoice was created successfully
   - Check if the invoice URL is correct
   - Ensure that the Xendit account is properly configured
   - Verify that the payment methods are enabled in the Xendit dashboard

3. **Webhook Not Receiving Events**
   - Check if the webhook URL is accessible from the internet
   - Verify that the webhook secret is correctly configured
   - Check server logs for any errors in the webhook handler
   - Use ngrok or similar tool for local testing

4. **Database Errors**
   - Check if the system user ID is correctly configured
   - Verify that the database schema is up to date
   - Check if the custom database function is properly installed
   - Ensure that the RLS policies are correctly configured

// ... existing code ... 