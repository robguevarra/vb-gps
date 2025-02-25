-- Create materialized view for missionary monthly stats
CREATE MATERIALIZED VIEW IF NOT EXISTS missionary_monthly_stats AS
WITH RECURSIVE 
  date_range AS (
    -- Generate a series of months from the earliest donation to current month
    SELECT 
      date_trunc('month', min(date)) as month_start,
      date_trunc('month', CURRENT_DATE) as month_end
    FROM donor_donations
    UNION ALL
    SELECT 
      month_start + interval '1 month',
      month_end
    FROM date_range
    WHERE month_start < month_end
  ),
  months AS (
    SELECT DISTINCT to_char(month_start, 'YYYY-MM') as month
    FROM date_range
  ),
  monthly_donations AS (
    SELECT 
      missionary_id,
      to_char(date_trunc('month', date), 'YYYY-MM') as month,
      SUM(amount) as total_donations
    FROM donor_donations 
    WHERE status = 'completed'
    GROUP BY missionary_id, to_char(date_trunc('month', date), 'YYYY-MM')
  ),
  missionary_months AS (
    -- Cross join missionaries with all months
    SELECT 
      p.id as missionary_id,
      p.monthly_goal,
      m.month
    FROM profiles p
    CROSS JOIN months m
    WHERE p.role = 'missionary'
  )
SELECT 
  mm.missionary_id,
  mm.monthly_goal,
  mm.month,
  COALESCE(md.total_donations, 0) as total_donations,
  CASE 
    WHEN mm.monthly_goal > 0 THEN 
      ROUND((COALESCE(md.total_donations, 0)::numeric / mm.monthly_goal::numeric) * 100, 2)
    ELSE 0
  END as goal_percentage
FROM missionary_months mm
LEFT JOIN monthly_donations md ON mm.missionary_id = md.missionary_id AND mm.month = md.month;

-- Create an index on the month field for better query performance
CREATE INDEX IF NOT EXISTS missionary_monthly_stats_month_idx ON missionary_monthly_stats(month);

-- Create a function to refresh the materialized view
CREATE OR REPLACE FUNCTION refresh_missionary_monthly_stats()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY missionary_monthly_stats;
  RETURN NULL;
END;
$$;

-- Create triggers to refresh the view when donations change
DROP TRIGGER IF EXISTS refresh_missionary_stats_on_donation ON donor_donations;
CREATE TRIGGER refresh_missionary_stats_on_donation
  AFTER INSERT OR UPDATE OR DELETE
  ON donor_donations
  FOR EACH STATEMENT
  EXECUTE FUNCTION refresh_missionary_monthly_stats();

-- Create trigger to refresh when missionary goals are updated
DROP TRIGGER IF EXISTS refresh_missionary_stats_on_profile ON profiles;
CREATE TRIGGER refresh_missionary_stats_on_profile
  AFTER UPDATE OF monthly_goal
  ON profiles
  FOR EACH STATEMENT
  EXECUTE FUNCTION refresh_missionary_monthly_stats();

-- Down Migration
-- DROP TRIGGER IF EXISTS refresh_missionary_stats_on_donation ON donor_donations;
-- DROP TRIGGER IF EXISTS refresh_missionary_stats_on_profile ON profiles;
-- DROP FUNCTION IF EXISTS refresh_missionary_monthly_stats();
-- DROP MATERIALIZED VIEW IF EXISTS missionary_monthly_stats;
