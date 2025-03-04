-- Donor Search Optimization Script
-- Run this in Supabase SQL Editor to optimize donor search performance

-- Enable trigram extension for better text search
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Create optimized indexes for donor search
CREATE INDEX IF NOT EXISTS idx_donors_name_search ON donors USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_donors_email_search ON donors USING gin (email gin_trgm_ops);

-- Add comment explaining the optimization
COMMENT ON INDEX idx_donors_name_search IS 'Optimized index for partial name matching in donor search';
COMMENT ON INDEX idx_donors_email_search IS 'Optimized index for partial email matching in donor search';

-- Analyze the donors table to update statistics
ANALYZE donors;

-- Verify indexes were created
SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'donors'
    AND indexname IN ('idx_donors_name_search', 'idx_donors_email_search'); 