-- Function to execute arbitrary SQL with parameters

-- WARNING: This function can be dangerous in production as it allows
-- arbitrary SQL execution. Use with extreme caution and proper access controls.

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
        EXECUTE query_with_params;
        result := jsonb_build_object('success', true);
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

-- INSTRUCTIONS:
-- Copy this SQL and run it in your Supabase SQL Editor to create the function
-- This only needs to be done once 

SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'donor_donations'; 