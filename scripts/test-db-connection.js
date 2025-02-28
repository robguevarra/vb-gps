/**
 * Database Connection Test Script
 * 
 * This script tests the connection to the Supabase production database
 * using the credentials from the .env.local file.
 * 
 * Run with: node scripts/test-db-connection.js
 */

require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

async function testConnection() {
  console.log('Testing Supabase connection...');
  
  try {
    // Create a Supabase client using the environment variables
    const supabase = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL,
      process.env.SUPABASE_SERVICE_ROLE_KEY
    );
    
    // Test profiles table
    console.log('\nTesting profiles table...');
    const { data: profiles, error: profilesError } = await supabase
      .from('profiles')
      .select('id')
      .limit(5);
    
    if (profilesError) {
      console.error('❌ Profiles query failed:', profilesError.message);
    } else {
      console.log('✅ Successfully connected to the database!');
      console.log(`Found ${profiles.length} profiles`);
      console.log('Sample profile IDs:', profiles.map(p => p.id).join(', '));
    }
    
    // Test donor_donations table
    console.log('\nTesting donor_donations table...');
    const { data: donations, error: donationsError } = await supabase
      .from('donor_donations')
      .select('id, amount, date')
      .order('date', { ascending: false })
      .limit(5);
    
    if (donationsError) {
      console.error('❌ Donations query failed:', donationsError.message);
    } else {
      console.log('✅ Successfully queried donations table!');
      console.log(`Found ${donations.length} recent donations`);
      if (donations.length > 0) {
        console.log('Most recent donation:', {
          id: donations[0].id,
          amount: donations[0].amount,
          date: donations[0].date
        });
      }
    }
    
    // Test donors table
    console.log('\nTesting donors table...');
    const { data: donors, error: donorsError } = await supabase
      .from('donors')
      .select('id, name')
      .limit(5);
    
    if (donorsError) {
      console.error('❌ Donors query failed:', donorsError.message);
    } else {
      console.log('✅ Successfully queried donors table!');
      console.log(`Found ${donors.length} donors`);
      if (donors.length > 0) {
        console.log('Sample donors:', donors.map(d => d.name).join(', '));
      }
    }
    
    // Test local_churches table
    console.log('\nTesting local_churches table...');
    const { data: churches, error: churchesError } = await supabase
      .from('local_churches')
      .select('id, name')
      .limit(5);
    
    if (churchesError) {
      console.error('❌ Churches query failed:', churchesError.message);
    } else {
      console.log('✅ Successfully queried churches table!');
      console.log(`Found ${churches.length} churches`);
      if (churches.length > 0) {
        console.log('Sample churches:', churches.map(c => c.name).join(', '));
      }
    }
    
    console.log('\n🎉 Database connection test completed!');
    
  } catch (err) {
    console.error('❌ Unexpected error:', err.message);
  }
}

testConnection(); 