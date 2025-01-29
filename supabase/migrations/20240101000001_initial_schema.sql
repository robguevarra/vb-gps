-- Run these in your Supabase SQL Editor
CREATE TABLE IF NOT EXISTS local_churches (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  district_id BIGINT,
  lead_pastor_id UUID
);

-- Continue with the rest of your table creation SQL
-- ... 