/**
 * Data Migration Script
 * 
 * This script helps migrate data from a development database to the production database.
 * It uses the Supabase JavaScript client to fetch data from the source database and
 * insert it into the target database.
 * 
 * IMPORTANT: This is a template script. You should customize it for your specific
 * migration needs before running it.
 * 
 * Run with: node scripts/migrate-data.js
 */

require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

// Source database (development)
// Replace these with your development database credentials
const SOURCE_URL = 'YOUR_DEV_SUPABASE_URL';
const SOURCE_KEY = 'YOUR_DEV_SERVICE_ROLE_KEY';

// Target database (production)
const TARGET_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const TARGET_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Tables to migrate (in order of dependencies)
const TABLES = [
  'districts',
  'local_churches',
  'profiles',
  'donors',
  'donor_donations',
  'payment_transactions',
  'invoice_items',
  'leave_requests',
  'surplus_requests',
  'system_settings',
  'user_roles',
  'webhook_logs'
];

async function migrateData() {
  console.log('Starting data migration...');
  
  // Create clients for source and target databases
  const sourceDB = createClient(SOURCE_URL, SOURCE_KEY);
  const targetDB = createClient(TARGET_URL, TARGET_KEY);
  
  // Migrate each table
  for (const table of TABLES) {
    try {
      console.log(`\nMigrating table: ${table}`);
      
      // Fetch data from source
      const { data, error } = await sourceDB
        .from(table)
        .select('*');
      
      if (error) {
        console.error(`❌ Error fetching data from ${table}:`, error.message);
        continue;
      }
      
      if (!data || data.length === 0) {
        console.log(`ℹ️ No data found in ${table}, skipping...`);
        continue;
      }
      
      console.log(`Found ${data.length} records in ${table}`);
      
      // Insert data into target
      // Process in batches of 100 to avoid request size limits
      const batchSize = 100;
      for (let i = 0; i < data.length; i += batchSize) {
        const batch = data.slice(i, i + batchSize);
        
        const { error: insertError } = await targetDB
          .from(table)
          .upsert(batch, { onConflict: 'id' });
        
        if (insertError) {
          console.error(`❌ Error inserting data into ${table}:`, insertError.message);
          continue;
        }
        
        console.log(`✅ Migrated batch ${i/batchSize + 1}/${Math.ceil(data.length/batchSize)} for ${table}`);
      }
      
      console.log(`✅ Successfully migrated ${data.length} records for ${table}`);
      
    } catch (err) {
      console.error(`❌ Unexpected error migrating ${table}:`, err.message);
    }
  }
  
  console.log('\n🎉 Migration completed!');
}

// Confirm before running
console.log('⚠️  WARNING: This script will migrate data to your production database.');
console.log('Make sure you have backed up your target database before proceeding.');
console.log('To continue, edit this script to set your source database credentials and remove this warning.');
console.log('Then uncomment the line below to run the migration.');

// Uncomment to run the migration
// migrateData(); 