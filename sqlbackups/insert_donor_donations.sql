-- Function to insert donation entries without triggering view refresh issues
CREATE OR REPLACE FUNCTION insert_donor_donations(donations_data JSONB)
