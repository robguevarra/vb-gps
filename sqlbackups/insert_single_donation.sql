-- Function to insert a single donation without triggering materialized view refresh

-- This function allows inserting a single donation record directly into the donor_donations table
-- without triggering the materialized view refresh that requires additional permissions.

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
SECURITY DEFINER -- Run with privileges of the function creator (important!)
AS $$
BEGIN
  -- Direct insert using parameters
  -- This bypasses any triggers that would refresh the materialized view
  EXECUTE 'INSERT INTO donor_donations(donor_id, missionary_id, amount, date, source, status, notes) 
           VALUES ($1, $2, $3, $4, $5, $6, $7)'
  USING donor_id, missionary_id, amount, donation_date, source, status, notes;
  
  -- Note: We deliberately do not refresh the materialized view here
END;
$$;

-- Grant execute permission to the service role
GRANT EXECUTE ON FUNCTION insert_single_donation(BIGINT, NUMERIC, UUID, TIMESTAMP WITH TIME ZONE, TEXT, TEXT, TEXT) TO service_role;

-- INSTRUCTIONS:
-- Copy this SQL and run it in your Supabase SQL Editor to create the function
-- This only needs to be done once 