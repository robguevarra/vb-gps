# Xendit Integration Troubleshooting Guide

## Common Issues and Solutions

### 1. Webhook Not Updating Donation Records

#### Symptoms
- Payment is successful in Xendit dashboard
- Invoice status shows as "PAID" in Xendit
- Webhook logs show successful receipt of webhook
- `payment_transactions` table is updated correctly
- `donor_donations` table is not updated

#### Possible Causes and Solutions

##### Materialized View Permission Issues
**Problem**: The webhook handler lacks permission to refresh the `missionary_monthly_stats` materialized view.

**Solution**: 
- Use the custom `insert_single_donation` function with `SECURITY DEFINER` privilege
- Ensure the function is created by a user with appropriate permissions
- Call the function via RPC instead of direct insertion:

```typescript
const { error: donationError } = await supabase.rpc(
  'insert_single_donation',
  {
    donor_id: item.donor_id,
    amount: item.amount,
    missionary_id: item.missionary_id,
    donation_date: new Date().toISOString(),
    source: 'online',
    status: 'completed',
    notes: `Payment via ${payload.payment_method || "unknown"}`
  }
);
```

##### Missing or Invalid System User ID
**Problem**: The webhook handler uses an invalid or missing system user ID for the `created_by` field.

**Solution**:
- Ensure the system user ID is valid and exists in the `auth.users` table
- Update the webhook handler to use the correct system user ID:

```typescript
const systemUserId = 'fa5060a6-3996-46ea-ae5f-bd3fed7e251a'; // Replace with your actual system user ID
```

##### Schema Mismatch
**Problem**: The webhook handler attempts to insert fields that don't exist in the table schema.

**Solution**:
- Check the database schema for the `donor_donations` table
- Ensure all required fields are included and match the expected types
- Remove any fields that don't exist in the schema

##### Invoice Item Reference Issues
**Problem**: The webhook handler can't find the corresponding invoice item for the payment.

**Solution**:
- Ensure the invoice ID is correctly stored in both `payment_transactions` and `invoice_items` tables
- Check that the lookup query is using the correct field:

```typescript
const { data: items } = await supabase
  .from('invoice_items')
  .select('*')
  .eq('invoice_id', payload.invoice_id);
```

### 2. Webhook Signature Verification Failures

#### Symptoms
- Webhook requests are rejected with 401 Unauthorized
- Webhook logs show signature verification failures
- No updates to payment status or donation records

#### Possible Causes and Solutions

##### Incorrect Webhook Secret
**Problem**: The webhook secret used for verification doesn't match the one configured in Xendit.

**Solution**:
- Verify the webhook secret in your environment variables
- Ensure it matches the one configured in the Xendit dashboard
- Update the environment variable if necessary:

```
XENDIT_WEBHOOK_SECRET=your_correct_webhook_secret
```

##### Incorrect Signature Format
**Problem**: The webhook signature is not being parsed correctly.

**Solution**:
- Ensure the signature is extracted correctly from the request headers:

```typescript
const signature = req.headers['x-callback-token'] as string;
```

- Verify the signature verification logic:

```typescript
const isValid = verifyWebhookSignature(
  JSON.stringify(payload),
  signature,
  process.env.XENDIT_WEBHOOK_SECRET || ''
);
```

### 3. Invoice Creation Failures

#### Symptoms
- Invoice creation API returns errors
- No invoice URL is generated
- Payment flow is interrupted

#### Possible Causes and Solutions

##### Missing or Invalid API Keys
**Problem**: The Xendit API key is missing, invalid, or has insufficient permissions.

**Solution**:
- Verify the API key in your environment variables
- Ensure it has the necessary permissions in the Xendit dashboard
- Update the environment variable if necessary:

```
XENDIT_SECRET_KEY=your_correct_api_key
```

##### Invalid Invoice Parameters
**Problem**: The invoice creation request contains invalid parameters.

**Solution**:
- Check the invoice creation parameters against the Xendit API documentation
- Ensure all required fields are provided and have valid values
- Pay special attention to:
  - External ID format (must be unique)
  - Amount (must be positive and within allowed limits)
  - Currency (must be supported by Xendit)
  - Expiry date (must be in the future)

##### Network or Connectivity Issues
**Problem**: The application cannot connect to the Xendit API.

**Solution**:
- Check network connectivity
- Verify firewall settings
- Ensure the Xendit API endpoint is accessible
- Implement retry logic for transient failures

### 4. Payment Status Synchronization Issues

#### Symptoms
- Payment status in the application doesn't match Xendit dashboard
- Webhook is received but status is not updated
- Manual status checks fail

#### Possible Causes and Solutions

##### Race Conditions
**Problem**: Webhook processing and manual status checks interfere with each other.

**Solution**:
- Implement proper locking or transaction isolation
- Use database transactions to ensure atomic updates
- Add status transition validation to prevent invalid state changes

##### Webhook Processing Errors
**Problem**: Webhook is received but processing fails due to errors.

**Solution**:
- Enhance error logging in the webhook handler
- Implement comprehensive error handling
- Add retry logic for transient failures
- Store the raw webhook payload for debugging

### 5. Database Schema Issues

#### Symptoms
- Database errors when creating or updating records
- Foreign key constraint violations
- Check constraint violations

#### Possible Causes and Solutions

##### Missing Reference ID Column
**Problem**: The code attempts to use a `reference_id` column that doesn't exist in the `invoice_items` table.

**Solution**:
- Remove references to the non-existent column:

```typescript
// Before
await supabase.from('invoice_items').insert({
  invoice_id: invoice.id,
  reference_id: referenceId, // This column doesn't exist
  amount: amount,
  missionary_id: missionaryId,
  donor_id: donorId
});

// After
await supabase.from('invoice_items').insert({
  invoice_id: invoice.id,
  amount: amount,
  missionary_id: missionaryId,
  donor_id: donorId
});
```

##### Status Check Constraint Violations
**Problem**: The code attempts to set a status value that violates a check constraint.

**Solution**:
- Ensure status values match the allowed values in the check constraint:

```typescript
// For payment_transactions table
// Allowed values: 'pending', 'paid', 'expired', 'failed'
await supabase.from('payment_transactions').update({
  status: 'paid' // Must be one of the allowed values
}).eq('invoice_id', invoiceId);

// For donor_donations table
// Allowed values may differ, check the schema
await supabase.from('donor_donations').insert({
  status: 'completed' // Must be one of the allowed values
  // Other fields...
});
```

##### Foreign Key Constraint Violations
**Problem**: The code attempts to reference a non-existent record in a related table.

**Solution**:
- Ensure referenced records exist before creating related records
- Implement proper error handling for foreign key violations
- Use transactions to ensure atomicity of related operations

## Debugging Techniques

### 1. Enhanced Logging

Add detailed logging throughout the payment flow:

```typescript
console.log(`[Xendit] Processing webhook: ${event}`, {
  invoice_id: payload.invoice_id,
  status: payload.status,
  payment_method: payload.payment_method
});

// After each database operation
console.log(`[Xendit] Updated transaction status`, {
  invoice_id: payload.invoice_id,
  status: 'paid',
  result: updateResult
});
```

### 2. Database Queries for Troubleshooting

Use these queries to check the state of payment-related records:

```sql
-- Check payment transaction status
SELECT * FROM payment_transactions WHERE invoice_id = 'your_invoice_id';

-- Check invoice items
SELECT * FROM invoice_items WHERE invoice_id = 'your_invoice_id';

-- Check if donation was created
SELECT * FROM donor_donations 
WHERE id IN (
  SELECT donation_id FROM invoice_items WHERE invoice_id = 'your_invoice_id'
);

-- Check webhook logs
SELECT * FROM webhook_logs 
WHERE payload->>'invoice_id' = 'your_invoice_id' 
ORDER BY created_at DESC;
```

### 3. Webhook Testing

Use these techniques to test webhook handling:

1. **Local Testing with ngrok**:
   - Install ngrok: `npm install -g ngrok`
   - Start your local server: `npm run dev`
   - Create a tunnel: `ngrok http 3000`
   - Configure the webhook URL in Xendit dashboard: `https://your-ngrok-url.ngrok-free.app/api/xendit-webhook`
   - Make test payments and monitor the logs

2. **Manual Webhook Simulation**:
   - Use tools like Postman to send webhook payloads to your endpoint
   - Include the appropriate headers and signature
   - Monitor the logs and database for expected changes

## Environment Setup Checklist

Ensure these environment variables are correctly configured:

```
XENDIT_SECRET_KEY=your_secret_key
XENDIT_PUBLIC_KEY=your_public_key
XENDIT_WEBHOOK_SECRET=your_webhook_secret
XENDIT_CALLBACK_URL=https://your-app-url.com/api/xendit-webhook
XENDIT_SUCCESS_REDIRECT_URL=https://your-app-url.com/payment/success
XENDIT_FAILURE_REDIRECT_URL=https://your-app-url.com/payment/failure
```

## Contact Information

For additional support:
- Xendit Support: [support@xendit.co](mailto:support@xendit.co)
- Developer Documentation: [https://developers.xendit.co/](https://developers.xendit.co/)
- API Reference: [https://developers.xendit.co/api-reference/](https://developers.xendit.co/api-reference/) 