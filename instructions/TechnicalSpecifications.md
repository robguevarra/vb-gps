# Staff Portal - Technical Specifications

## 1. Xendit Integration

### Overview
Integration with Xendit payment gateway to enable online donations through the website and manual remittance flows. This integration will support three key scenarios:
1. Public missionary donations
2. Public church/ministry donations
3. Staff manual remittance processing

### Current System Context
The Staff Portal currently supports manual donation entry and tracking, but lacks online payment capabilities. Key limitations include:
- Only supports manual donation entry
- No online payment processing
- Finance officers must manually record all donations
- No automated receipt generation
- Limited donor engagement options

### Integration Points
1. **Public Giving Page**
   - New component at `app/giving/page.tsx`
   - Allows public visitors to donate to missionaries or churches
   - Redirects to Xendit payment page and handles callbacks

2. **Manual Remittance Wizard Enhancement**
   - Extends existing component at `components/ManualRemittanceWizard.tsx`
   - Adds online payment option for partners
   - Generates payment links that can be shared with partners

3. **Finance Dashboard Integration**
   - Enhances existing dashboard at `app/dashboard/finance/page.tsx`
   - Adds payment transaction history and status tracking
   - Implements reconciliation tools for online payments

### Technical Requirements

#### 1.1 Database Schema Updates
```sql
-- Add new columns to donor_donations
ALTER TABLE donor_donations
ADD COLUMN payment_id varchar(100),
ADD COLUMN payment_status varchar(50),
ADD COLUMN payment_method varchar(50),
ADD COLUMN payment_channel varchar(50),
ADD COLUMN payment_details jsonb,
ADD COLUMN invoice_id varchar(100),
ADD COLUMN invoice_url text,
ADD COLUMN fee_amount numeric(10,2),
ADD COLUMN payment_date timestamptz;

-- Create payment_transactions table for tracking all payments
CREATE TABLE payment_transactions (
  id uuid primary key default gen_random_uuid(),
  reference_id varchar(100) UNIQUE,
  invoice_id varchar(100) UNIQUE,
  invoice_url text,
  status varchar(50),
  amount numeric(10,2),
  fee_amount numeric(10,2),
  currency varchar(10) DEFAULT 'PHP',
  payment_method varchar(50),
  payment_channel varchar(50),
  payment_details jsonb,
  payer_email varchar(255),
  payer_name varchar(255),
  created_by uuid references auth.users(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  expires_at timestamptz,
  paid_at timestamptz
);

-- Create invoice_items table for linking donations to payments
CREATE TABLE invoice_items (
  id uuid primary key default gen_random_uuid(),
  invoice_id varchar(100) references payment_transactions(invoice_id),
  donation_id bigint references donor_donations(id),
  amount numeric(10,2),
  missionary_id uuid references auth.users(id),
  donor_id uuid references donors(id),
  created_at timestamptz default now()
);

-- Create webhook_logs table for tracking all webhook events
CREATE TABLE webhook_logs (
  id uuid primary key default gen_random_uuid(),
  webhook_id varchar(100),
  event_type varchar(50),
  payload jsonb,
  signature varchar(255),
  ip_address inet,
  status varchar(20),
  processing_errors text,
  created_at timestamptz default now()
);

-- Add indexes
CREATE INDEX idx_payment_transactions_reference ON payment_transactions(reference_id);
CREATE INDEX idx_payment_transactions_invoice ON payment_transactions(invoice_id);
CREATE INDEX idx_payment_transactions_status ON payment_transactions(status);
CREATE INDEX idx_invoice_items_invoice ON invoice_items(invoice_id);
CREATE INDEX idx_invoice_items_donation ON invoice_items(donation_id);
CREATE INDEX idx_donor_donations_payment ON donor_donations(payment_id);
CREATE INDEX idx_webhook_logs_webhook_id ON webhook_logs(webhook_id);
CREATE INDEX idx_webhook_logs_created_at ON webhook_logs(created_at);
```

#### 1.2 Backend Implementation

1. **Xendit Service**
   ```typescript
   // lib/xendit.ts
   export class XenditService {
     constructor(
       private apiKey: string,
       private webhookSecret: string,
       private callbackUrl: string,
       private successUrl: string,
       private failureUrl: string
     ) {}
     
     // Create an invoice
     async createInvoice({
       externalId,
       amount,
       payerEmail,
       payerName,
       description,
       successRedirectUrl,
       failureRedirectUrl,
       items
     }: CreateInvoiceParams): Promise<XenditInvoice>;
     
     // Verify webhook signature
     verifyWebhookSignature(payload: any, headerSignature: string): boolean;
     
     // Get invoice status
     async getInvoiceStatus(invoiceId: string): Promise<XenditInvoiceStatus>;
   }
   ```

2. **API Endpoints**

   1. **Create Invoice Endpoint**
   ```typescript
   // app/api/xendit/create-invoice/route.ts
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

   2. **Webhook Endpoint**
   ```typescript
   // app/api/xendit-webhook/route.ts
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

   3. **Invoice Status Endpoint**
   ```typescript
   // app/api/xendit/invoice-status/[invoiceId]/route.ts
   export async function GET(req: Request, { params }: { params: { invoiceId: string } }) {
     // 1. Validate invoice ID
     // 2. Fetch transaction from database
     // 3. Return status and payment details
   }
   ```

3. **Environment Variables**
   ```env
   XENDIT_SECRET_KEY=your_secret_key
   XENDIT_PUBLIC_KEY=your_public_key
   XENDIT_WEBHOOK_SECRET=your_webhook_secret
   XENDIT_CALLBACK_URL=https://your-domain.com/api/xendit-webhook
   XENDIT_SUCCESS_REDIRECT_URL=https://your-domain.com/payment/success
   XENDIT_FAILURE_REDIRECT_URL=https://your-domain.com/payment/failure
   ```

#### 1.3 Frontend Components

1. **Public Donation Form**
   ```typescript
   // app/giving/page.tsx
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

2. **Enhanced ManualRemittanceWizard**
   ```typescript
   // components/ManualRemittanceWizard.tsx
   "use client"
   
   // Extend existing wizard with online payment option
   export function ManualRemittanceWizard() {
     // 1. Add payment method selection (offline/online)
     // 2. If online selected, prepare for Xendit redirect
     // 3. Submit handler to call create-invoice API
     // 4. Redirect to Xendit URL on success
   }
   ```

3. **Payment Status Component**
   ```typescript
   // components/payments/PaymentStatusIndicator.tsx
   "use client"
   
   interface PaymentStatusIndicatorProps {
     invoiceId: string;
     onCompleted?: () => void;
   }
   
   export function PaymentStatusIndicator({ invoiceId, onCompleted }: PaymentStatusIndicatorProps) {
     // Poll payment status API
     // Display appropriate status indicators
     // Handle success/failure states
   }
   ```

4. **Payment Success/Failure Pages**
   ```typescript
   // app/payment/success/page.tsx
   // app/payment/failure/page.tsx
   ```

#### 1.4 Security Considerations

1. **Data Protection**
   - Encrypt sensitive payment data
   - Implement proper validation for all inputs
   - Follow PCI DSS guidelines for payment handling
   - Never log or store full credit card details

2. **API Security**
   - Validate Xendit callbacks using webhook signatures
   - Implement rate limiting on payment endpoints
   - Use HTTPS for all communications
   - Implement proper error handling with secure error messages
   - Store webhook secret securely in environment variables

3. **Fraud Prevention**
   - Implement transaction limits
   - Monitor for suspicious activity
   - Add logging for all payment operations
   - Implement idempotency for duplicate webhooks

4. **RLS Policy Compliance**
   - For authenticated users, set `recorded_by` to their user ID
   - For public donations, use a server action with service role to bypass RLS
   - Create a system user for recording public donations
   - Implement proper validation to ensure RLS compliance

#### 1.5 Testing Strategy

1. **Local Development Testing**
   - Configure Xendit sandbox environment
   - Set up ngrok for webhook testing
   - Configure test API keys in environment variables
   - Test form validation and invoice creation
   - Test webhook handling and error scenarios

2. **Sandbox Testing**
   - Test Credit Cards:
     - Success: 4000000000000002
     - Failure: 4000000000000036
     - Authentication Required: 4000000000000028
   - Test E-wallets and Bank Accounts
   - Verify payment status updates
   - Test success and failure scenarios

3. **Production Testing**
   - Start with small test transactions
   - Monitor logs and database for issues
   - Verify webhook handling in production
   - Check payment reconciliation

#### 1.6 User Scenarios

1. **Public Missionary Donation**
   - User selects missionary from dropdown
   - Enters donation amount and personal details
   - Submits form and is redirected to Xendit payment page
   - Completes payment and returns to success page
   - System automatically records donation in database

2. **Church Donation**
   - User selects church from dropdown
   - Enters donation amount and personal details
   - Submits form and is redirected to Xendit payment page
   - Completes payment and returns to success page
   - System automatically records donation in database

3. **Manual Remittance with Online Payment**
   - Missionary logs into dashboard
   - Opens Manual Remittance Wizard
   - Enters donor information and amounts
   - Selects "Generate Payment Link" option
   - System creates pending donation records
   - System generates payment link
   - Missionary shares link with donor
   - Donor completes payment through Xendit
   - System receives webhook and updates records
   - Missionary sees updated donation status in dashboard

#### 1.7 Implementation Timeline
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

## 2. Email Notification System

### Overview
Comprehensive email notification system for approvals, donations, and system events.

### Technical Requirements

#### 2.1 Email Service Integration
1. **Service Setup**
   ```typescript
   // lib/email.ts
   export class EmailService {
     async sendDonationConfirmation(donation: Donation): Promise<void>;
     async sendApprovalNotification(request: Request): Promise<void>;
     async sendPartnerPledgeReminder(pledge: Pledge): Promise<void>;
   }
   ```

2. **Database Schema**
   ```sql
   CREATE TABLE email_logs (
     id bigserial primary key,
     recipient_id uuid references auth.users(id),
     template_id varchar(100),
     status varchar(20),
     sent_at timestamptz,
     error_message text,
     created_at timestamptz default now()
   );
   ```

3. **Email Templates**
   - Donation confirmation
   - Request approval/rejection
   - Partner pledge reminders
   - System notifications

## 3. Partner Management System

### Overview
Enhanced partner tracking and management system.

### Technical Requirements

#### 3.1 Database Schema
```sql
CREATE TABLE partner_pledges (
  id bigserial primary key,
  donor_id uuid references donors(id),
  missionary_id uuid references auth.users(id),
  amount numeric(10,2),
  frequency varchar(20), -- 'monthly', 'quarterly', 'annual'
  start_date date,
  end_date date,
  status varchar(20), -- 'active', 'expired', 'dormant'
  last_donation_date timestamptz,
  created_at timestamptz default now()
);

-- Add indexes
CREATE INDEX idx_partner_pledges_donor ON partner_pledges(donor_id);
CREATE INDEX idx_partner_pledges_missionary ON partner_pledges(missionary_id);
```

#### 3.2 Components
1. **Pledge Form**
   - File: `components/partners/PledgeForm.tsx`
   - Features:
     - Pledge amount input
     - Frequency selection
     - Duration setting
     - Automated reminders

2. **Partner Dashboard**
   - File: `components/partners/PartnerStatusDashboard.tsx`
   - Features:
     - Active partners overview
     - Pledge status tracking
     - Donation history
     - Partner analytics

## 4. System Logging

### Overview
Comprehensive logging system for user actions and system events.

### Technical Requirements

#### 4.1 Database Schema
```sql
CREATE TABLE system_logs (
  id bigserial primary key,
  user_id uuid references auth.users(id),
  action_type varchar(50),
  entity_type varchar(50),
  entity_id varchar(100),
  details jsonb,
  ip_address inet,
  user_agent text,
  created_at timestamptz default now()
);

-- Add indexes
CREATE INDEX idx_system_logs_user ON system_logs(user_id);
CREATE INDEX idx_system_logs_action ON system_logs(action_type);
CREATE INDEX idx_system_logs_created ON system_logs(created_at);
```

#### 4.2 Logging Service
```typescript
// lib/logging.ts
export class LoggingService {
  async logUserAction(params: {
    userId: string;
    actionType: string;
    entityType: string;
    entityId: string;
    details: any;
  }): Promise<void>;

  async logSystemEvent(params: {
    eventType: string;
    severity: string;
    details: any;
  }): Promise<void>;
}
```

## 5. Testing Requirements

### 5.1 Unit Tests
- Component tests using React Testing Library
- Service layer tests
- Utility function tests

### 5.2 Integration Tests
- API endpoint tests
- Database interaction tests
- Authentication flow tests

### 5.3 End-to-End Tests
- User journey tests
- Payment flow tests
- Approval workflow tests

## 6. Security Requirements

### 6.1 Authentication
- Multi-factor authentication support
- Session management improvements
- Password policy enforcement

### 6.2 Authorization
- Enhanced RLS policies
- Role permission granularity
- Audit logging

### 6.3 Data Protection
- Data encryption at rest
- Secure communication channels
- Regular security audits

## 7. Performance Requirements

### 7.1 Response Times
- Page load: < 2 seconds
- API responses: < 500ms
- Real-time updates: < 100ms

### 7.2 Scalability
- Support for 1000+ concurrent users
- Handle 10,000+ daily transactions
- Efficient data pagination

### 7.3 Caching
- Implementation of Redis caching
- Browser caching strategies
- API response caching 