# Xendit Integration Test Page

This page provides a comprehensive testing environment for the Xendit payment integration in the Staff Portal application. It allows developers and testers to create test donations, check payment statuses, simulate webhook events, and view recent transactions.

## Features

### 1. Create Donation

- **Standard Donation**: Open a donation modal with customizable amount and donor details
- **Quick Donation**: Create a donation with preset amounts for faster testing
- Redirects to the Xendit payment page for completing the payment

### 2. Check Payment Status

- Enter an invoice ID to check its current status
- Live status indicator that polls the status API
- Visual feedback on payment status (pending, paid, expired, failed)

### 3. Simulate Webhook

- Generate sample webhook payloads for different payment statuses (PAID, EXPIRED)
- Customize the webhook payload with your own JSON
- Send the webhook to the webhook handler endpoint
- Test the webhook handler's response and database updates

### 4. View Recent Transactions

- List of recent payment transactions processed through Xendit
- Visual indicators for payment status
- Detailed information about each transaction
- Links to view invoices

## How to Use

### Prerequisites

1. You must be logged in to create donations
2. Xendit API keys must be configured in the environment variables
3. Database tables for payment transactions must be set up

### Testing Flow

1. **Create a Donation**:
   - Click "Open Donation Modal" or use the Quick Donation feature
   - Enter donation details and proceed to payment
   - Complete the payment on the Xendit payment page or leave it pending

2. **Check Payment Status**:
   - Copy the invoice ID from the URL or transaction list
   - Paste it in the "Check Status" tab
   - View the live status

3. **Simulate Webhook**:
   - Enter the invoice ID in the webhook tab
   - Generate a sample payload for PAID or EXPIRED status
   - Click "Simulate Webhook" to send the webhook

4. **View Transactions**:
   - Go to the "Recent Transactions" tab
   - View the list of transactions and their statuses
   - Click "Refresh" to update the list

## Environment Variables

The following environment variables are required:

- `NEXT_PUBLIC_SUPABASE_URL`: Supabase project URL
- `SUPABASE_SERVICE_ROLE_KEY`: Supabase service role key for admin access
- `XENDIT_SECRET_KEY`: Xendit API secret key
- `XENDIT_WEBHOOK_TOKEN`: Token for webhook validation
- `NEXT_PUBLIC_APP_URL`: Base URL of the application

## Security Notes

- This test page is for development and testing purposes only
- It should not be accessible in production environments
- The webhook token is exposed to the client for testing purposes only
- In production, webhook validation should be more secure

## Database Schema

The test page interacts with the following database tables:

- `payment_transactions`: Stores payment transaction records
- `invoice_items`: Links donations to payments
- `donor_donations`: Stores donation records
- `webhook_logs`: Logs webhook payloads for debugging

## API Endpoints

The test page uses the following API endpoints:

- `POST /api/xendit/create-invoice`: Creates a new invoice
- `GET /api/xendit/invoice-status/[invoiceId]`: Checks invoice status
- `POST /api/xendit-webhook`: Handles webhook notifications
- `GET /api/xendit/recent-transactions`: Fetches recent transactions
- `GET /api/test/get-webhook-token`: Gets the webhook token for testing 