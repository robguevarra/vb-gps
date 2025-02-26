# Staff Portal - Technical Specifications

## 1. Xendit Integration

### Overview
Integration with Xendit payment gateway to enable online donations through the website and manual remittance flows.

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

-- Add indexes
CREATE INDEX idx_payment_transactions_reference ON payment_transactions(reference_id);
CREATE INDEX idx_payment_transactions_invoice ON payment_transactions(invoice_id);
CREATE INDEX idx_payment_transactions_status ON payment_transactions(status);
CREATE INDEX idx_invoice_items_invoice ON invoice_items(invoice_id);
CREATE INDEX idx_invoice_items_donation ON invoice_items(donation_id);
CREATE INDEX idx_donor_donations_payment ON donor_donations(payment_id);
```

#### 1.2 Backend Implementation

1. **API Endpoints**

   1. **Create Invoice Endpoint**
   ```typescript
   // app/api/xendit/create-invoice/route.ts
   export async function POST(req: Request) {
     // Validate request
     // Create transaction record with pending status
     // Call Xendit API to create invoice
     // Store invoice details
     // Return invoice URL for redirection
   }
   ```

   2. **Webhook Endpoint**
   ```typescript
   // app/api/xendit/webhook/route.ts
   export async function POST(req: Request) {
     // Verify Xendit signature
     // Extract transaction details
     // Update payment_transactions record
     // Update associated donor_donations records
     // Trigger notifications
     // Return acknowledgment
   }
   ```

   3. **Invoice Status Endpoint**
   ```typescript
   // app/api/xendit/invoice-status/[invoiceId]/route.ts
   export async function GET(req: Request, { params }: { params: { invoiceId: string } }) {
     // Fetch latest status from database
     // Optionally verify with Xendit API
     // Return status and related information
   }
   ```

2. **Xendit Service**
   ```typescript
   // lib/xendit.ts
   export class XenditService {
     // Initialize with API keys
     constructor(apiKey: string, callbackToken: string) { /* ... */ }
     
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
     verifyWebhookSignature(payload: any, signature: string): boolean;
     
     // Get invoice status
     async getInvoiceStatus(invoiceId: string): Promise<XenditInvoiceStatus>;
   }
   ```

3. **Environment Variables**
   ```env
   XENDIT_SECRET_KEY=
   XENDIT_PUBLIC_KEY=
   XENDIT_WEBHOOK_TOKEN=
   XENDIT_CALLBACK_URL=https://your-domain.com/api/xendit/webhook
   XENDIT_SUCCESS_REDIRECT_URL=https://your-domain.com/payment/success
   XENDIT_FAILURE_REDIRECT_URL=https://your-domain.com/payment/failure
   ```

#### 1.3 Frontend Components

1. **Payment Flow Components**

   1. **Single Donation Payment Modal**
   ```typescript
   // components/payments/SingleDonationModal.tsx
   "use client"
   
   interface SingleDonationModalProps {
     missionaryId: string;
     missionaryName: string;
     onSuccess?: () => void;
     onCancel?: () => void;
   }
   
   export function SingleDonationModal({ missionaryId, missionaryName, onSuccess, onCancel }: SingleDonationModalProps) {
     // Handle donation form
     // Call create-invoice API
     // Redirect to Xendit payment page
     // Handle payment status checks
   }
   ```

   2. **Enhanced ManualRemittanceWizard**
   ```typescript
   // components/payments/EnhancedRemittanceWizard.tsx
   "use client"
   
   interface EnhancedRemittanceWizardProps {
     missionaryId: string;
     onSuccess?: () => void;
     onCancel?: () => void;
   }
   
   export function EnhancedRemittanceWizard({ missionaryId, onSuccess, onCancel }: EnhancedRemittanceWizardProps) {
     // Extend existing ManualRemittanceWizard
     // Add payment processing step
     // Handle Xendit redirect
     // Process payment confirmation
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

2. **Payment Success/Failure Pages**
   ```typescript
   // app/payment/success/page.tsx
   // app/payment/failure/page.tsx
   ```

#### 1.4 Security Considerations

1. **Data Protection**
   - Encrypt sensitive payment data
   - Implement proper validation for all inputs
   - Follow PCI DSS guidelines for payment handling

2. **API Security**
   - Validate Xendit callbacks using webhook signatures
   - Implement rate limiting on payment endpoints
   - Use HTTPS for all communications
   - Implement proper error handling with secure error messages

3. **Fraud Prevention**
   - Implement transaction limits
   - Monitor for suspicious activity
   - Add logging for all payment operations

#### 1.5 Testing Strategy

1. **Unit Tests**
   - Test Xendit service functions
   - Test webhook signature validation
   - Test payment status handling

2. **Integration Tests**
   - Test end-to-end payment flow
   - Test webhook handling
   - Test database updates

3. **Sandbox Testing**
   - Use Xendit sandbox environment
   - Test various payment methods
   - Test success and failure scenarios

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