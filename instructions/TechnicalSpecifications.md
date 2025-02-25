# Staff Portal - Technical Specifications

## 1. Xendit Integration

### Overview
Integration with Xendit payment gateway to enable online donations.

### Technical Requirements

#### 1.1 Backend Implementation
1. **Webhook Endpoint**
   ```typescript
   // app/api/xendit-webhook/route.ts
   export async function POST(req: Request) {
     // Validate Xendit signature
     // Process payment notification
     // Update donation status
     // Send confirmation emails
   }
   ```

2. **Database Changes**
   ```sql
   -- Add new columns to donor_donations
   ALTER TABLE donor_donations
   ADD COLUMN xendit_reference varchar(100),
   ADD COLUMN payment_method varchar(50),
   ADD COLUMN payment_channel varchar(50),
   ADD COLUMN payment_details jsonb;

   -- Add indexes
   CREATE INDEX idx_xendit_reference ON donor_donations(xendit_reference);
   CREATE INDEX idx_payment_method ON donor_donations(payment_method);
   ```

3. **Environment Variables**
   ```env
   XENDIT_SECRET_KEY=
   XENDIT_WEBHOOK_TOKEN=
   XENDIT_CALLBACK_TOKEN=
   ```

#### 1.2 Frontend Components
1. **Payment Modal**
   - File: `components/payments/XenditPaymentModal.tsx`
   - Features:
     - Payment method selection
     - Amount input
     - Donor information
     - Success/failure handling

2. **Payment Status**
   - File: `components/payments/PaymentStatusIndicator.tsx`
   - Features:
     - Real-time status updates
     - Payment confirmation
     - Error handling

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