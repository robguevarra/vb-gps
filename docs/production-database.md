# Production Database Guide

This guide provides information on connecting to and working with the production Supabase database for the Staff Portal application.

## Connection Details

### Supabase Project

- **Project URL**: https://dbyuhqcxjaxxbjaczmbo.supabase.co
- **Project Reference ID**: dbyuhqcxjaxxbjaczmbo

### API Keys

- **Anon Public Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRieXVocWN4amF4eGJqYWN6bWJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA3Mjg0NzAsImV4cCI6MjA1NjMwNDQ3MH0.iEvGuZA8GRul_8vJpWjpcP1sL9NJhwbt43L92iEdFZE`
- **Service Role Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRieXVocWN4amF4eGJqYWN6bWJvIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MDcyODQ3MCwiZXhwIjoyMDU2MzA0NDcwfQ.7bHAAT-9_WMesOeoS477CE6MR2rslpJ7aPSTYvESMDo`

### Direct Database Connection

For direct PostgreSQL connections:

```
postgresql://postgres:Aiourxeagne22!@db.dbyuhqcxjaxxbjaczmbo.supabase.co:5432/postgres
```

### Connection Poolers

For high-throughput applications, use the connection poolers:

- **Transaction Pooler** (recommended for most operations):
  ```
  postgresql://postgres.dbyuhqcxjaxxbjaczmbo:Aiourxeagne22!@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres
  ```

- **Session Pooler** (for long-lived connections):
  ```
  postgresql://postgres.dbyuhqcxjaxxbjaczmbo:Aiourxeagne22!@aws-0-ap-southeast-1.pooler.supabase.com:5432/postgres
  ```

## Connecting via Command Line

### Using PSQL

```bash
# Direct connection
psql -h db.dbyuhqcxjaxxbjaczmbo.supabase.co -p 5432 -d postgres -U postgres

# Transaction pooler
psql -h aws-0-ap-southeast-1.pooler.supabase.com -p 6543 -d postgres -U postgres.dbyuhqcxjaxxbjaczmbo

# Session pooler
psql -h aws-0-ap-southeast-1.pooler.supabase.com -p 5432 -d postgres -U postgres.dbyuhqcxjaxxbjaczmbo
```

When prompted for a password, enter: `Aiourxeagne22!`

## Environment Configuration

The application's `.env.local` file has been updated with the production database credentials. The following environment variables are now set:

```
NEXT_PUBLIC_SUPABASE_URL=https://dbyuhqcxjaxxbjaczmbo.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRieXVocWN4amF4eGJqYWN6bWJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA3Mjg0NzAsImV4cCI6MjA1NjMwNDQ3MH0.iEvGuZA8GRul_8vJpWjpcP1sL9NJhwbt43L92iEdFZE
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRieXVocWN4amF4eGJqYWN6bWJvIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MDcyODQ3MCwiZXhwIjoyMDU2MzA0NDcwfQ.7bHAAT-9_WMesOeoS477CE6MR2rslpJ7aPSTYvESMDo
SUPABASE_URL=postgresql://postgres:Aiourxeagne22!@db.dbyuhqcxjaxxbjaczmbo.supabase.co:5432/postgres
```

## Testing the Connection

A test script has been created to verify the database connection. Run it with:

```bash
node scripts/test-db-connection.js
```

This script will:
1. Connect to the production database
2. Run a simple query to fetch a profile
3. Test the service role permissions by fetching donation data

## Data Migration

If you need to migrate data from your development database to the production database, a template script has been provided:

```bash
node scripts/migrate-data.js
```

Before running this script:
1. Edit the script to set your development database credentials
2. Uncomment the `migrateData()` function call at the bottom of the file
3. Make sure you have backed up your production database

## Best Practices

1. **Security**:
   - Never commit database credentials to version control
   - Use environment variables for sensitive information
   - Restrict access to the production database

2. **Performance**:
   - Use the transaction pooler for most operations
   - Implement connection pooling in your application
   - Use prepared statements for repeated queries

3. **Maintenance**:
   - Regularly back up the database
   - Monitor database performance
   - Keep the schema in sync with your application

4. **Development Workflow**:
   - Use a local or development database for testing
   - Only deploy schema changes to production after thorough testing
   - Use migrations for schema changes

## Supabase Dashboard

Access the Supabase dashboard at:
https://app.supabase.com/project/dbyuhqcxjaxxbjaczmbo

From here, you can:
- Manage database tables and schema
- Configure authentication settings
- Monitor API usage
- View and manage storage
- Run SQL queries using the SQL Editor 