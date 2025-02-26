-- Function to bulk insert donations without triggering materialized view refresh

-- This function accepts an array of donation records and inserts them all
-- while bypassing any triggers that would refresh materialized views
-- It uses session_replication_role to disable triggers during the operation

CREATE OR REPLACE FUNCTION bulk_insert_donations(donations JSONB)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER -- Run with privileges of the function creator
AS $$
BEGIN
  -- Set session to replica mode which disables all triggers
  SET LOCAL session_replication_role = 'replica';
  
  -- Insert all donations
  INSERT INTO donor_donations (donor_id, amount, missionary_id, date, source, status, notes)
  SELECT 
    (elem->>'donor_id')::uuid,
    (elem->>'amount')::numeric,
    (elem->>'missionary_id')::uuid,
    (elem->>'date')::timestamp with time zone,
    elem->>'source',
    elem->>'status',
    elem->>'notes'
  FROM jsonb_array_elements(donations) AS elem;
  
  -- Return to normal mode where triggers are enabled
  SET LOCAL session_replication_role = 'origin';
END;
$$;

-- Grant execute permission to service role
GRANT EXECUTE ON FUNCTION bulk_insert_donations(JSONB) TO service_role;

-- INSTRUCTIONS:
-- Copy this SQL and run it in your Supabase SQL Editor to create the function
-- This only needs to be done once 