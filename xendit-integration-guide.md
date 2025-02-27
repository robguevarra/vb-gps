# Xendit Integration Implementation Guide

## Project Context

### Application Overview
The Staff Portal is a comprehensive platform for managing missionary donations, approvals, and church operations. The system currently supports:

1. **Core Authentication**
   - Supabase Auth integration with role-based access control
   - User profiles with church affiliations and missionary goals
   - Multiple user roles: Missionaries, Finance Officers, Campus Directors, Lead Pastors, and SuperAdmins

2. **Donation Management**
   - Manual donation entry and remittance
   - Donor tracking and history
   - Advanced reporting system with real-time calculations
   - Optimized state management and error handling

3. **Approval Workflows**
   - Leave requests and surplus requests
   - Two-level approval system (Campus Director → Lead Pastor)
   - Request history tracking

4. **Role-Specific Dashboards**
   - Missionary dashboard with donation tracking
   - Finance officer dashboard for donation management
   - Lead pastor dashboard for approvals
   - SuperAdmin dashboard for system-wide management

### Current System Architecture

1. **Frontend**
   - Next.js 13+ with App Router
   - TypeScript for type safety
   - Tailwind CSS and Shadcn/UI for styling
   - React Server Components where possible

2. **Backend**
   - Supabase for database and authentication
   - Row Level Security (RLS) policies for data access control
   - Server actions for bypassing RLS when needed
   - Real-time subscriptions for live updates

3. **Database Schema**
   - `profiles`: User profiles with roles and church affiliations
   - `donor_donations`: Donation records with missionary and donor references
   - `donors`: Donor information
   - `surplus_requests`: Surplus withdrawal requests
   - `local_churches`: Church information

4. **Key Components**
   - `ManualRemittanceWizard`: Multi-step form for recording offline donations
   - `FinanceRemittanceWizard`: Enhanced wizard for finance officers
   - `DonationModal`: Simple donation entry form
   - `RecentDonations`: Display of recent donation transactions
   - Advanced reporting components for missionaries, churches, and partners

### Current Limitations
- Only supports manual donation entry
- No online payment processing
- Finance officers must manually record all donations
- No automated receipt generation
- Limited donor engagement options

## Xendit Integration Purpose

The Xendit integration aims to address these limitations by enabling:

1. **Online Donations**
   - Direct donations to missionaries through public profiles
   - Church/ministry donations through a central giving page
   - Streamlined payment experience for donors

2. **Automated Processing**
   - Automatic recording of successful payments
   - Real-time payment status updates
   - Reduced manual data entry for finance team

3. **Enhanced Donor Experience**
   - Multiple payment options (credit card, e-wallet, bank transfer)
   - Immediate confirmation and receipts
   - Mobile-friendly donation process

## Integration Points

### 1. Public Giving Page
- **Current Status**: Does not exist
- **Location**: Will be created at `app/giving/page.tsx`
- **Purpose**: Allow public visitors to donate to missionaries or churches
- **User Flow**:
  1. User selects missionary or church
  2. Enters donation amount and personal details
  3. Submits form and is redirected to Xendit payment page
  4. Completes payment and returns to success/failure page
  5. System automatically records donation in database

### 2. Manual Remittance Wizard Enhancement
- **Current Status**: Exists at `components/ManualRemittanceWizard.tsx`
- **Current Functionality**: 
  - Multi-step form for recording offline donations
  - Used by campus missionaries to record partner donations
  - Creates donor records and donation entries
- **Enhancement Needed**:
  - Add online payment option for partners who prefer to pay electronically
  - Generate payment links that can be shared with partners
  - Track payment status and update records automatically

### 3. Finance Dashboard Integration
- **Current Status**: Finance dashboard exists with manual remittance wizard
- **Location**: `app/dashboard/finance/page.tsx`
- **Enhancement Needed**:
  - Add payment transaction history view
  - Implement reconciliation tools for online payments
  - Add payment status indicators for pending transactions

## Database Context

### Existing Schema Relevant to Integration

```sql
-- Existing tables that will interact with Xendit integration

-- User profiles
profiles (
  id uuid references auth.users(id),
  full_name text,
  role text,
  local_church_id uuid,
  monthly_goal numeric(10,2),
  surplus_balance numeric(10,2),
  created_at timestamptz
)

-- Donation records
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

-- Donor information
donors (
  id uuid primary key,
  name text not null,
  email text,
  phone text,
  created_at timestamptz,
  updated_at timestamptz
)

-- Churches
local_churches (
  id serial primary key,
  name text not null,
  lead_pastor_id uuid references auth.users(id),
  created_at timestamptz,
  updated_at timestamptz
)
```

### RLS Policies to Consider

The system uses Row Level Security (RLS) policies that must be considered:

1. **donor_donations Table**:
   - Requires `recorded_by` field to be set to the authenticated user's ID
   - Finance officers can view all donations
   - Missionaries can only view their own donations
   - Campus directors can view donations for missionaries in their church

2. **donors Table**:
   - All authenticated users can view donors
   - Only finance officers and missionaries can create donors

## Implementation Tasks

### 1. Backend Services (Priority: High)

#### 1.1 Xendit Service Implementation
**File:** `lib/xendit.ts`
```typescript
export class XenditService {
  constructor(
    private apiKey: string,
    private webhookSecret: string,
    private callbackUrl: string,
    private successUrl: string,
    private failureUrl: string
  ) {}
  
  // Core methods to implement
  async createInvoice(params): Promise<{invoiceUrl: string, invoiceId: string}>;
  verifyWebhookSignature(payload: any, headerSignature: string): boolean;
  async getInvoiceStatus(invoiceId: string): Promise<{id: string, status: string, ...}>;
}
```

**Implementation Notes:**
- Use Xendit's Node.js SDK for reliable API communication
- Implement proper error handling with specific error types
- Add comprehensive logging for all API interactions
- Use environment variables for all sensitive credentials
- Follow Xendit's best practices for invoice creation
- Implement proper validation for all input parameters
- Use TypeScript interfaces for type safety

#### 1.2 API Endpoints

##### Create Invoice Endpoint
**File:** `app/api/xendit/create-invoice/route.ts`
```typescript
export async function POST(req: Request) {
  // 1. Validate request body (missionary/church ID, donor info, amount, type)
  // 2. Create payment_transactions record with pending status
  // 3. Create donor record if not exists
  // 4. Create pending donor_donations record
  // 5. Create invoice_items linking donations to transaction
  // 6. Call Xendit API to create invoice
  // 7. Update payment_transactions with invoice details
  // 8. Return invoice URL for redirection
}
```

**Implementation Notes:**
- Use Zod for request validation
- Implement database transactions for data consistency
- Generate unique reference IDs for tracking
- Set proper expiration times for invoices (24 hours recommended)
- Add detailed error handling with appropriate HTTP status codes
- Implement proper RLS bypass using service role
- Set 'recorded_by' field correctly to satisfy RLS policies
- For public donations (no authenticated user), set `recorded_by` to a system user ID

##### Webhook Handler
**File:** `app/api/xendit-webhook/route.ts`
```typescript
export async function POST(req: Request) {
  // 1. Verify Xendit signature from headers
  // 2. Log webhook payload to webhook_logs
  // 3. Extract payment details (status, amount, payment method)
  // 4. Update payment_transactions status
  // 5. If payment successful, update donor_donations status to completed
  // 6. If payment failed, update donor_donations status to failed
  // 7. Return 200 OK response
}
```

**Implementation Notes:**
- Verify webhook signature before processing
- Log all webhook payloads for audit purposes
- Use database transactions for atomic updates
- Handle idempotency for duplicate webhooks
- Implement proper error handling with fallbacks
- Return 200 OK even for errors (log errors but don't expose them)
- Implement retry mechanism for failed database updates
- Must use service role to bypass RLS policies

##### Invoice Status Endpoint
**File:** `app/api/xendit/invoice-status/[invoiceId]/route.ts`
```typescript
export async function GET(req: Request, { params }: { params: { invoiceId: string } }) {
  // 1. Validate invoice ID
  // 2. Fetch transaction from database
  // 3. Return status and payment details
}
```

**Implementation Notes:**
- Implement proper authentication and authorization
- Add rate limiting to prevent abuse
- Cache responses for improved performance
- Add detailed error handling

### 2. Frontend Implementation (Priority: High)

#### 2.1 Public Donation Form
**File:** `app/giving/page.tsx`
```typescript
"use client"

export default function GivingPage() {
  // 1. Form state for donation details
  // 2. Dropdown for missionary/church selection
  // 3. Input fields for donor info and amount
  // 4. Radio buttons for one-time/recurring
  // 5. Submit handler to call create-invoice API
  // 6. Loading state during API call
  // 7. Redirect to Xendit URL on success
}
```

**Implementation Notes:**
- Use React Hook Form with Zod for validation
- Implement proper loading states with UI feedback
- Add clear error messaging for form validation
- Ensure mobile-responsive design
- Implement analytics tracking for conversion metrics
- Add CSRF protection for form submission
- Use proper semantic HTML for accessibility
- Must match the existing UI design system (Shadcn/UI components)
- Should be accessible without authentication

#### 2.2 Enhanced ManualRemittanceWizard
**File:** `components/ManualRemittanceWizard.tsx`
```typescript
"use client"

// Extend existing wizard with online payment option
export function ManualRemittanceWizard() {
  // 1. Add payment method selection (offline/online)
  // 2. If online selected, prepare for Xendit redirect
  // 3. Submit handler to call create-invoice API
  // 4. Redirect to Xendit URL on success
}
```

**Implementation Notes:**
- Maintain backward compatibility with existing functionality
- Add clear UI indicators for payment method selection
- Implement proper validation for batch donations
- Add confirmation step before submission
- Ensure proper error handling and recovery
- Set 'recorded_by' field correctly to satisfy RLS policies
- Integrate with existing missionary dashboard

#### 2.3 Success/Failure Pages
**Files:** 
- `app/payment/success/page.tsx`
- `app/payment/failure/page.tsx`

**Implementation Notes:**
- Extract transaction details from URL parameters
- Display appropriate success/failure messages
- Show transaction reference for support inquiries
- Provide clear next steps for users
- Add retry options for failed payments
- Implement analytics tracking for conversion metrics
- Match existing UI design system

### 3. Security Implementation (Priority: Critical)

#### 3.1 Webhook Security
- Implement signature verification using Xendit's callback verification token
- Store webhook secret securely in environment variables
- Log all webhook attempts with IP addresses
- Implement rate limiting on webhook endpoint
- Add IP whitelisting for Xendit servers if possible

#### 3.2 Payment Data Protection
- Never log or store full credit card details
- Encrypt sensitive payment data in the database
- Implement proper input validation to prevent injection attacks
- Use HTTPS for all API communications
- Follow PCI DSS guidelines for payment handling
- Implement proper error handling with secure error messages

#### 3.3 Access Control
- Enforce proper authentication for all payment-related endpoints
- Implement role-based access control for payment management
- Use RLS policies to restrict access to payment data
- Audit all payment-related actions
- Implement proper validation for all input parameters

### 4. Testing Plan (Priority: High)

#### 4.1 Local Development Testing
1. **Environment Setup**
   - Configure Xendit sandbox environment
   - Set up ngrok for webhook testing
   - Configure test API keys in environment variables

2. **Test Cases**
   - Form validation testing
   - Invoice creation testing
   - Payment processing testing
   - Webhook handling testing
   - Error handling testing
   - Edge case testing (network failures, timeouts)

#### 4.2 Sandbox Testing
1. **Test Credit Cards**
   - Success: 4000000000000002
   - Failure: 4000000000000036
   - Authentication Required: 4000000000000028

2. **Test E-wallets**
   - OVO: Any phone number
   - DANA: Any email
   - LinkAja: Any phone number

3. **Test Bank Accounts**
   - BCA: Any account number
   - Mandiri: Any account number

#### 4.3 Production Testing
1. **Controlled Rollout**
   - Start with small test transactions
   - Monitor logs and database for issues
   - Verify webhook handling in production
   - Check payment reconciliation

### 5. Environment Variables (Priority: Critical)
```
XENDIT_SECRET_KEY=your_secret_key
XENDIT_PUBLIC_KEY=your_public_key
XENDIT_WEBHOOK_SECRET=your_webhook_secret
XENDIT_CALLBACK_URL=https://your-domain.com/api/xendit-webhook
XENDIT_SUCCESS_REDIRECT_URL=https://your-domain.com/payment/success
XENDIT_FAILURE_REDIRECT_URL=https://your-domain.com/payment/failure
```

## User Scenarios

### Scenario 1: Public Missionary Donation
1. A donor visits the public giving page
2. Selects a missionary from the dropdown
3. Enters donation amount and personal details
4. Clicks "Donate Now" button
5. Backend creates pending donation records
6. User is redirected to Xendit payment page
7. User completes payment
8. Xendit sends webhook notification
9. System updates donation status
10. User is redirected to success page

### Scenario 2: Church Donation
1. A donor visits the public giving page
2. Selects a church from the dropdown
3. Enters donation amount and personal details
4. Clicks "Donate Now" button
5. Backend creates pending donation records
6. User is redirected to Xendit payment page
7. User completes payment
8. Xendit sends webhook notification
9. System updates donation status
10. User is redirected to success page

### Scenario 3: Manual Remittance with Online Payment
1. Missionary logs into dashboard
2. Opens Manual Remittance Wizard
3. Enters donor information and amounts
4. Selects "Generate Payment Link" option
5. System creates pending donation records
6. System generates payment link
7. Missionary shares link with donor
8. Donor completes payment through Xendit
9. System receives webhook and updates records
10. Missionary sees updated donation status in dashboard

## Implementation Guidelines

### Code Quality Standards
1. **Security First**
   - Validate all inputs
   - Sanitize all outputs
   - Implement proper error handling
   - Follow secure coding practices
   - Never expose sensitive information in logs or errors

2. **Performance Optimization**
   - Use database transactions for atomic operations
   - Implement proper caching where appropriate
   - Optimize database queries
   - Minimize API calls to Xendit
   - Use efficient data structures

3. **Error Handling**
   - Implement comprehensive error handling
   - Log all errors with context
   - Provide user-friendly error messages
   - Implement fallback mechanisms
   - Add retry logic for transient failures

4. **Testing Requirements**
   - Write unit tests for all components
   - Implement integration tests for API endpoints
   - Test webhook handling thoroughly
   - Test error scenarios and edge cases
   - Verify database consistency after operations

### Database Considerations
1. **Transaction Integrity**
   - Use database transactions for all payment operations
   - Implement proper foreign key relationships
   - Add appropriate indexes for performance
   - Validate data before insertion
   - Implement proper error handling for database operations

2. **Data Consistency**
   - Ensure payment_transactions and donor_donations stay in sync
   - Implement proper status tracking
   - Add data validation before and after operations
   - Use database constraints for data integrity
   - Implement proper error recovery

### Security Best Practices
1. **API Security**
   - Validate all inputs
   - Implement rate limiting
   - Use HTTPS for all communications
   - Implement proper authentication and authorization
   - Follow the principle of least privilege

2. **Payment Security**
   - Follow PCI DSS guidelines
   - Encrypt sensitive data
   - Implement proper error handling
   - Log all payment operations for audit
   - Implement fraud detection measures

3. **Webhook Security**
   - Verify webhook signatures
   - Log all webhook attempts
   - Implement idempotency for duplicate webhooks
   - Add IP whitelisting if possible
   - Implement proper error handling

## Implementation Timeline
1. **Week 1: Backend Implementation**
   - Implement XenditService
   - Create API endpoints
   - Set up webhook handling
   - Implement database operations

2. **Week 2: Frontend Implementation**
   - Implement public giving form
   - Enhance ManualRemittanceWizard
   - Create success/failure pages
   - Implement payment status indicators

3. **Week 3: Testing and Refinement**
   - Conduct unit and integration testing
   - Test edge cases and security
   - Refine error handling
   - Optimize performance
   - Document the implementation

## Technical Challenges and Solutions

### Challenge 1: RLS Policy Compliance
**Problem**: The system uses Row Level Security (RLS) policies that require the `recorded_by` field to be set to the authenticated user's ID.

**Solution**: 
- For authenticated users, set `recorded_by` to their user ID
- For public donations, use a server action with service role to bypass RLS
- Create a system user for recording public donations
- Implement proper validation to ensure RLS compliance

### Challenge 2: Webhook Handling
**Problem**: Webhooks must be processed reliably, even with network issues or database failures.

**Solution**:
- Log all webhook payloads before processing
- Implement idempotency to handle duplicate webhooks
- Use database transactions for atomic updates
- Implement retry mechanisms for failed operations
- Return 200 OK to Xendit even if processing fails (to prevent retries)

### Challenge 3: Payment Status Tracking
**Problem**: Payment status must be accurately tracked and reflected in the UI.

**Solution**:
- Create a robust status tracking system in the database
- Implement real-time updates using Supabase subscriptions
- Add clear status indicators in the UI
- Implement polling for status updates on relevant pages
- Add comprehensive error handling for failed payments

## Contact Information
For any questions or issues during implementation, contact:
- Technical Lead: [Name]
- Project Manager: [Name]

## Additional Resources
- [Xendit API Documentation](https://developers.xendit.co/api-reference/)
- [Xendit Node.js SDK](https://github.com/xendit/xendit-node)
- [Next.js API Routes Documentation](https://nextjs.org/docs/api-routes/introduction)
- [Supabase Documentation](https://supabase.io/docs)
- [Staff Portal Codebase Repository](https://github.com/your-org/staff-portal) 