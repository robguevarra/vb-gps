-- Create missionary_dashboard_stats table
-- This table stores pre-calculated statistics for the missionary dashboard
-- to improve performance and reduce the need for complex queries on the client side

-- First, check if the pgcron extension exists and create it if needed
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_extension WHERE extname = 'pg_cron'
  ) THEN
    -- Try to create the extension if it doesn't exist
    BEGIN
      CREATE EXTENSION pg_cron;
    EXCEPTION WHEN OTHERS THEN
      RAISE NOTICE 'Could not create pg_cron extension. Scheduled jobs will not be created.';
    END;
  END IF;
END
$$;

CREATE TABLE IF NOT EXISTS missionary_dashboard_stats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  missionary_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  monthly_goal NUMERIC(10, 2) NOT NULL DEFAULT 0,
  current_donations NUMERIC(10, 2) NOT NULL DEFAULT 0,
  current_partners_count INTEGER NOT NULL DEFAULT 0,
  new_partners_count INTEGER NOT NULL DEFAULT 0,
  surplus_balance NUMERIC(10, 2) NOT NULL DEFAULT 0,
  last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Add a unique constraint to ensure one record per missionary
  CONSTRAINT unique_missionary_stats UNIQUE (missionary_id)
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_missionary_dashboard_stats_missionary_id ON missionary_dashboard_stats(missionary_id);

-- Create function to update missionary_dashboard_stats
CREATE OR REPLACE FUNCTION update_missionary_dashboard_stats()
RETURNS TRIGGER AS $$
DECLARE
  start_of_month TIMESTAMP;
  end_of_month TIMESTAMP;
  missionary_monthly_goal NUMERIC(10, 2);
  missionary_surplus_balance NUMERIC(10, 2);
  current_month_donations NUMERIC(10, 2);
  current_month_partners_count INTEGER;
  previous_month_partners_count INTEGER;
  new_partners_count INTEGER;
BEGIN
  -- Set date range for current month
  start_of_month := date_trunc('month', NOW());
  end_of_month := date_trunc('month', NOW() + INTERVAL '1 month') - INTERVAL '1 second';
  
  -- Get missionary's monthly goal and surplus balance from profiles
  SELECT monthly_goal, surplus_balance INTO missionary_monthly_goal, missionary_surplus_balance
  FROM profiles
  WHERE id = NEW.missionary_id;
  
  -- Calculate current month donations
  SELECT COALESCE(SUM(amount), 0) INTO current_month_donations
  FROM donor_donations
  WHERE missionary_id = NEW.missionary_id
    AND date >= start_of_month
    AND date <= end_of_month;
  
  -- Count unique donors for current month
  SELECT COUNT(DISTINCT donor_id) INTO current_month_partners_count
  FROM donor_donations
  WHERE missionary_id = NEW.missionary_id
    AND date >= start_of_month
    AND date <= end_of_month;
  
  -- Get unique donors from previous months
  WITH previous_donors AS (
    SELECT DISTINCT donor_id
    FROM donor_donations
    WHERE missionary_id = NEW.missionary_id
      AND date < start_of_month
  ),
  current_donors AS (
    SELECT DISTINCT donor_id
    FROM donor_donations
    WHERE missionary_id = NEW.missionary_id
      AND date >= start_of_month
      AND date <= end_of_month
  )
  SELECT COUNT(*) INTO new_partners_count
  FROM current_donors
  WHERE donor_id NOT IN (SELECT donor_id FROM previous_donors);
  
  -- Insert or update the stats record
  INSERT INTO missionary_dashboard_stats (
    missionary_id,
    monthly_goal,
    current_donations,
    current_partners_count,
    new_partners_count,
    surplus_balance,
    last_updated
  ) VALUES (
    NEW.missionary_id,
    missionary_monthly_goal,
    current_month_donations,
    current_month_partners_count,
    new_partners_count,
    missionary_surplus_balance,
    NOW()
  )
  ON CONFLICT (missionary_id)
  DO UPDATE SET
    monthly_goal = missionary_monthly_goal,
    current_donations = current_month_donations,
    current_partners_count = current_month_partners_count,
    new_partners_count = new_partners_count,
    surplus_balance = missionary_surplus_balance,
    last_updated = NOW();
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to update stats when donations are added/updated
CREATE OR REPLACE TRIGGER update_missionary_stats_on_donation
AFTER INSERT OR UPDATE ON donor_donations
FOR EACH ROW
EXECUTE FUNCTION update_missionary_dashboard_stats();

-- Create trigger to update stats when profiles are updated
CREATE OR REPLACE TRIGGER update_missionary_stats_on_profile_change
AFTER INSERT OR UPDATE ON profiles
FOR EACH ROW
EXECUTE FUNCTION update_missionary_dashboard_stats();

-- Create a function to refresh all missionary stats
CREATE OR REPLACE FUNCTION refresh_all_missionary_stats()
RETURNS VOID AS $$
DECLARE
  missionary_id UUID;
  start_of_month TIMESTAMP;
  end_of_month TIMESTAMP;
  missionary_monthly_goal NUMERIC(10, 2);
  missionary_surplus_balance NUMERIC(10, 2);
  current_month_donations NUMERIC(10, 2);
  current_month_partners_count INTEGER;
  new_partners_count INTEGER;
BEGIN
  -- Set date range for current month
  start_of_month := date_trunc('month', NOW());
  end_of_month := date_trunc('month', NOW() + INTERVAL '1 month') - INTERVAL '1 second';
  
  -- Loop through all missionaries and campus directors
  FOR missionary_id IN SELECT id FROM profiles WHERE role = 'missionary' OR role = 'campus_director' LOOP
    -- Get missionary's monthly goal and surplus balance
    SELECT monthly_goal, surplus_balance INTO missionary_monthly_goal, missionary_surplus_balance
    FROM profiles
    WHERE id = missionary_id;
    
    -- Calculate current month donations
    SELECT COALESCE(SUM(amount), 0) INTO current_month_donations
    FROM donor_donations
    WHERE missionary_id = missionary_id
      AND date >= start_of_month
      AND date <= end_of_month;
    
    -- Count unique donors for current month
    SELECT COUNT(DISTINCT donor_id) INTO current_month_partners_count
    FROM donor_donations
    WHERE missionary_id = missionary_id
      AND date >= start_of_month
      AND date <= end_of_month;
    
    -- Get unique donors from previous months
    WITH previous_donors AS (
      SELECT DISTINCT donor_id
      FROM donor_donations
      WHERE missionary_id = missionary_id
        AND date < start_of_month
    ),
    current_donors AS (
      SELECT DISTINCT donor_id
      FROM donor_donations
      WHERE missionary_id = missionary_id
        AND date >= start_of_month
        AND date <= end_of_month
    )
    SELECT COUNT(*) INTO new_partners_count
    FROM current_donors
    WHERE donor_id NOT IN (SELECT donor_id FROM previous_donors);
    
    -- Insert or update the stats record
    INSERT INTO missionary_dashboard_stats (
      missionary_id,
      monthly_goal,
      current_donations,
      current_partners_count,
      new_partners_count,
      surplus_balance,
      last_updated
    ) VALUES (
      missionary_id,
      missionary_monthly_goal,
      current_month_donations,
      current_month_partners_count,
      new_partners_count,
      missionary_surplus_balance,
      NOW()
    )
    ON CONFLICT (missionary_id)
    DO UPDATE SET
      monthly_goal = missionary_monthly_goal,
      current_donations = current_month_donations,
      current_partners_count = current_month_partners_count,
      new_partners_count = new_partners_count,
      surplus_balance = missionary_surplus_balance,
      last_updated = NOW();
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Schedule daily refresh if pg_cron is available
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
    PERFORM cron.schedule('daily-missionary-stats-refresh', '0 0 * * *', 'SELECT refresh_all_missionary_stats()');
  ELSE
    RAISE NOTICE 'pg_cron extension not available. Scheduled job not created.';
  END IF;
END
$$;

-- Initial population of the stats table
INSERT INTO missionary_dashboard_stats (
  missionary_id,
  monthly_goal,
  current_donations,
  current_partners_count,
  new_partners_count,
  surplus_balance
)
SELECT 
  p.id,
  p.monthly_goal,
  COALESCE(
    (SELECT SUM(amount) 
     FROM donor_donations 
     WHERE missionary_id = p.id 
       AND date >= date_trunc('month', NOW())
       AND date <= date_trunc('month', NOW() + INTERVAL '1 month') - INTERVAL '1 second'
    ), 0
  ) AS current_donations,
  COALESCE(
    (SELECT COUNT(DISTINCT donor_id) 
     FROM donor_donations 
     WHERE missionary_id = p.id 
       AND date >= date_trunc('month', NOW())
       AND date <= date_trunc('month', NOW() + INTERVAL '1 month') - INTERVAL '1 second'
    ), 0
  ) AS current_partners_count,
  COALESCE(
    (WITH previous_donors AS (
      SELECT DISTINCT donor_id
      FROM donor_donations
      WHERE missionary_id = p.id
        AND date < date_trunc('month', NOW())
    ),
    current_donors AS (
      SELECT DISTINCT donor_id
      FROM donor_donations
      WHERE missionary_id = p.id
        AND date >= date_trunc('month', NOW())
        AND date <= date_trunc('month', NOW() + INTERVAL '1 month') - INTERVAL '1 second'
    )
    SELECT COUNT(*) 
    FROM current_donors
    WHERE donor_id NOT IN (SELECT donor_id FROM previous_donors)
    ), 0
  ) AS new_partners_count,
  p.surplus_balance
FROM profiles p
WHERE p.role = 'missionary' OR p.role = 'campus_director'
ON CONFLICT (missionary_id) DO NOTHING; 