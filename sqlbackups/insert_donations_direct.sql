-- Function to insert donations without triggering materialized view refresh

-- This function allows inserting donation records directly into the donor_donations table
-- without triggering the materialized view refresh that requires additional permissions.
-- It uses dynamic SQL to build an insert statement and execute it directly.

CREATE OR REPLACE FUNCTION insert_donations_direct(values_sql text, params text[])
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER -- Run with privileges of the function creator (important!)
AS $$
DECLARE
  query text;
BEGIN
  -- Build the dynamic SQL query
  query := 'INSERT INTO donor_donations (donor_id, amount, missionary_id, date, source, status) VALUES ' || values_sql;
  
  -- Execute the query with parameters
  EXECUTE query USING VARIADIC params;
  
  -- Note: We deliberately do not refresh the materialized view here
  -- This avoids the permission issue
END;
$$;

-- Grant execute permission to the service role
GRANT EXECUTE ON FUNCTION insert_donations_direct(text, text[]) TO service_role;

-- INSTRUCTIONS:
-- Copy this SQL and run it in your Supabase SQL Editor to create the function
-- This only needs to be done once
