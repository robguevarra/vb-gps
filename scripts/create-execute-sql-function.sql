-- Function to execute arbitrary SQL with parameters
-- This function is useful for database diagnostics and maintenance

CREATE OR REPLACE FUNCTION execute_sql(sql_query TEXT, params JSONB DEFAULT '{}'::jsonb)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER -- Run with privileges of the function creator
AS $$
DECLARE
    param_name TEXT;
    param_value JSONB;
    result JSONB;
    query_with_params TEXT := sql_query;
BEGIN
    -- Replace each parameter in the query
    FOR param_name, param_value IN SELECT * FROM jsonb_each(params)
    LOOP
        query_with_params := REPLACE(
            query_with_params, 
            '$' || param_name, 
            CASE 
                WHEN jsonb_typeof(param_value) = 'string' THEN quote_literal(param_value#>>'{}')
                WHEN jsonb_typeof(param_value) = 'null' THEN 'NULL'
                ELSE param_value#>>'{}'
            END
        );
    END LOOP;

    -- Execute the query
    BEGIN
        EXECUTE query_with_params INTO result;
        
        -- If result is NULL, return success with empty result
        IF result IS NULL THEN
            result := jsonb_build_object('success', true, 'result', '[]'::jsonb);
        END IF;
    EXCEPTION WHEN OTHERS THEN
        result := jsonb_build_object(
            'success', false,
            'error', SQLERRM,
            'code', SQLSTATE
        );
    END;

    RETURN result;
END;
$$;

-- Grant execute permission to service role
GRANT EXECUTE ON FUNCTION execute_sql(TEXT, JSONB) TO service_role;

-- Test the function
SELECT execute_sql('SELECT column_name, data_type FROM information_schema.columns WHERE table_name = ''profiles'' AND table_schema = ''public'' ORDER BY ordinal_position');

-- Instructions:
-- 1. Connect to your production database using psql or the Supabase SQL Editor
-- 2. Run this script to create the execute_sql function
-- 3. This function will be used by the test-db-connection.js script to query database metadata 