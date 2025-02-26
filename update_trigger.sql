-- Modify trigger function to respect the disable_mat_view_refresh session variable

-- This adds a check to any existing trigger function that refreshes the materialized view
-- to skip the refresh if our session variable is set

-- First, let's create a function to check if refresh is disabled
CREATE OR REPLACE FUNCTION should_refresh_materialized_views()
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
  -- Check if our session variable is set to 'true'
  RETURN coalesce(current_setting('app.disable_mat_view_refresh', true), 'false') <> 'true';
END;
$$;

-- Now we can modify the trigger function that refreshes missionary_monthly_stats
-- This assumes the trigger function is named refresh_missionary_monthly_stats()
-- You'll need to adjust this to match your actual trigger function name

CREATE OR REPLACE FUNCTION refresh_missionary_monthly_stats()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  -- Check if materialized view refresh is disabled
  IF should_refresh_materialized_views() THEN
    -- Only refresh if not disabled
    REFRESH MATERIALIZED VIEW missionary_monthly_stats;
  END IF;
  RETURN NEW;
END;
$$;

-- INSTRUCTIONS: 
-- 1. Find the actual name of your trigger function that refreshes missionary_monthly_stats
-- 2. Replace 'refresh_missionary_monthly_stats' with your actual function name
-- 3. Run this SQL in your Supabase SQL Editor
-- 4. This only needs to be done once 