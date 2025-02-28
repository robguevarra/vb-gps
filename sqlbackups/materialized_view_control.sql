-- Functions to control materialized view refresh behavior

-- This creates a session variable that our triggers can check
-- to determine whether they should refresh materialized views

-- Function to disable materialized view refresh
CREATE OR REPLACE FUNCTION disable_materialized_view_refresh()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Set a session variable that can be checked by triggers
  PERFORM set_config('app.disable_mat_view_refresh', 'true', false);
END;
$$;

-- Function to re-enable materialized view refresh
CREATE OR REPLACE FUNCTION enable_materialized_view_refresh()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Clear the session variable
  PERFORM set_config('app.disable_mat_view_refresh', 'false', false);
END;
$$;

-- Grant execute permissions to the service role
GRANT EXECUTE ON FUNCTION disable_materialized_view_refresh() TO service_role;
GRANT EXECUTE ON FUNCTION enable_materialized_view_refresh() TO service_role;

-- INSTRUCTIONS:
-- Copy this SQL and run it in your Supabase SQL Editor to create these functions
-- This only needs to be done once 