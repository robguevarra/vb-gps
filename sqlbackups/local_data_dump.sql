

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."bulk_insert_donations"("donations" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
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


ALTER FUNCTION "public"."bulk_insert_donations"("donations" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_bulk_donation"("p_missionary_id" "uuid", "p_invoice_id" "text", "p_external_id" "text", "p_total_amount" numeric, "p_donor_entries" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_transaction_id UUID;
  v_donor_entry JSONB;
  v_invoice_item_id UUID;
BEGIN
  -- Create transaction record
  INSERT INTO transactions (
    missionary_id,
    invoice_id,
    reference_id,
    amount,
    status,
    payment_method,
    payment_channel,
    payment_details,
    created_at
  ) VALUES (
    p_missionary_id,
    p_invoice_id,
    p_external_id,
    p_total_amount,
    'pending',
    'online',
    'xendit',
    jsonb_build_object(
      'invoice_id', p_invoice_id,
      'external_id', p_external_id,
      'bulk', true,
      'donor_count', jsonb_array_length(p_donor_entries)
    ),
    NOW()
  ) RETURNING id INTO v_transaction_id;
  
  -- Log the transaction creation
  RAISE NOTICE 'Created transaction % for missionary % with invoice %', 
    v_transaction_id, p_missionary_id, p_invoice_id;
  
  -- Create invoice items for each donor
  FOR v_donor_entry IN SELECT * FROM jsonb_array_elements(p_donor_entries)
  LOOP
    -- Create invoice item
    INSERT INTO invoice_items (
      invoice_id,
      transaction_id,
      missionary_id,
      donor_id,
      amount,
      created_at
    ) VALUES (
      p_invoice_id,
      v_transaction_id,
      p_missionary_id,
      (v_donor_entry->>'donor_id')::UUID,
      (v_donor_entry->>'amount')::NUMERIC,
      NOW()
    ) RETURNING id INTO v_invoice_item_id;
    
    -- Log the invoice item creation
    RAISE NOTICE 'Created invoice item % for donor % with amount %', 
      v_invoice_item_id, v_donor_entry->>'donor_id', v_donor_entry->>'amount';
  END LOOP;
  
  -- Log completion
  RAISE NOTICE 'Bulk donation processing completed for invoice % with % donors', 
    p_invoice_id, jsonb_array_length(p_donor_entries);
END;
$$;


ALTER FUNCTION "public"."create_bulk_donation"("p_missionary_id" "uuid", "p_invoice_id" "text", "p_external_id" "text", "p_total_amount" numeric, "p_donor_entries" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."current_local_church"() RETURNS "text"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT local_church_id::text FROM user_roles WHERE user_id = auth.uid();
$$;


ALTER FUNCTION "public"."current_local_church"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."debug_donor_donation_conditions"("p_donation_id" bigint, "p_user" "uuid") RETURNS TABLE("donation_id" bigint, "is_missionary" boolean, "is_recorded_by" boolean, "is_admin_same_church" boolean, "is_finance_or_superadmin" boolean)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN QUERY
  SELECT
    dd.id,
    -- Check if the donation belongs to the current user (missionary)
    (dd.missionary_id = p_user) AS is_missionary,
    -- Check if the donation was recorded by the current user
    (dd.recorded_by = p_user) AS is_recorded_by,
    -- For campus directors/lead pastors: donation's missionary must be in the same church as the admin.
    EXISTS (
      SELECT 1
      FROM public.profiles AS admin
      WHERE admin.id = p_user
        AND admin.role IN ('campus_director', 'lead_pastor')
        AND dd.missionary_id IN (
          SELECT id FROM public.profiles WHERE local_church_id = admin.local_church_id
        )
    ) AS is_admin_same_church,
    -- For finance officers/superadmins: condition returns true if the current user is one.
    EXISTS (
      SELECT 1
      FROM public.profiles AS admin2
      WHERE admin2.id = p_user
        AND admin2.role IN ('finance_officer', 'superadmin')
    ) AS is_finance_or_superadmin
  FROM public.donor_donations dd
  WHERE dd.id = p_donation_id;
END;
$$;


ALTER FUNCTION "public"."debug_donor_donation_conditions"("p_donation_id" bigint, "p_user" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."debug_donor_visibility"("p_donor_id" bigint, "p_user" "uuid") RETURNS TABLE("donor_id" bigint, "has_missionary_donation" boolean, "has_admin_donation" boolean, "has_finance_donation" boolean)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN QUERY
  SELECT
    d.id,
    -- Check if there's a donation for this donor where the current user is the missionary.
    EXISTS (
      SELECT 1 
      FROM public.donor_donations dd
      WHERE dd.donor_id = d.id AND dd.missionary_id = p_user
    ) AS has_missionary_donation,
    -- Check if the current user is a campus director or lead pastor and there's a donation 
    -- for this donor from a missionary in the same church.
    EXISTS (
      SELECT 1
      FROM public.profiles AS admin
      WHERE admin.id = p_user
        AND admin.role IN ('campus_director', 'lead_pastor')
        AND EXISTS (
          SELECT 1 
          FROM public.donor_donations dd2
          WHERE dd2.donor_id = d.id
            AND dd2.missionary_id IN (
              SELECT id FROM public.profiles WHERE local_church_id = admin.local_church_id
            )
        )
    ) AS has_admin_donation,
    -- Check if the current user is a finance officer or superadmin and there's any donation 
    -- for this donor.
    EXISTS (
      SELECT 1
      FROM public.profiles AS admin2
      WHERE admin2.id = p_user
        AND admin2.role IN ('finance_officer', 'superadmin')
        AND EXISTS (
          SELECT 1 
          FROM public.donor_donations dd3
          WHERE dd3.donor_id = d.id
        )
    ) AS has_finance_donation
  FROM public.donors d
  WHERE d.id = p_donor_id;
END;
$$;


ALTER FUNCTION "public"."debug_donor_visibility"("p_donor_id" bigint, "p_user" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."debug_insert_donation"("p_donor_id" bigint, "p_missionary_id" "uuid", "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_notes" "text" DEFAULT NULL::"text") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  result JSONB;
  error_message TEXT;
  success BOOLEAN := FALSE;
BEGIN
  -- Attempt to insert with error capture
  BEGIN
    -- Direct insert using parameters
    INSERT INTO donor_donations(
      donor_id, 
      missionary_id, 
      amount, 
      date, 
      source, 
      status, 
      notes
    ) 
    VALUES (
      p_donor_id, 
      p_missionary_id, 
      p_amount, 
      p_date, 
      p_source, 
      p_status, 
      p_notes
    )
    RETURNING to_jsonb(donor_donations.*) INTO result;
    
    success := TRUE;
  EXCEPTION WHEN OTHERS THEN
    -- Capture the error
    error_message := SQLERRM;
    
    -- Log the error details
    RAISE NOTICE 'Error inserting donation: %', error_message;
    
    -- Create error result
    result := jsonb_build_object(
      'error', error_message,
      'sqlstate', SQLSTATE,
      'donor_id', p_donor_id,
      'missionary_id', p_missionary_id,
      'amount', p_amount
    );
  END;
  
  -- Return success or error information
  RETURN jsonb_build_object(
    'success', success,
    'result', result
  );
END;
$$;


ALTER FUNCTION "public"."debug_insert_donation"("p_donor_id" bigint, "p_missionary_id" "uuid", "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_notes" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."disable_materialized_view_refresh"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Set a session variable that can be checked by triggers
  PERFORM set_config('app.disable_mat_view_refresh', 'true', false);
END;
$$;


ALTER FUNCTION "public"."disable_materialized_view_refresh"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."enable_materialized_view_refresh"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Clear the session variable
  PERFORM set_config('app.disable_mat_view_refresh', 'false', false);
END;
$$;


ALTER FUNCTION "public"."enable_materialized_view_refresh"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."execute_sql"("sql_query" "text", "params" "jsonb" DEFAULT '{}'::"jsonb") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $_$
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
$_$;


ALTER FUNCTION "public"."execute_sql"("sql_query" "text", "params" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_auth_email"() RETURNS "text"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN (SELECT email FROM auth.users WHERE id = auth.uid());
END;
$$;


ALTER FUNCTION "public"."get_auth_email"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_top_metrics"() RETURNS TABLE("total_donations_this_month" numeric, "current_percent_all_missionaries" numeric, "last_month_percent_all_missionaries" numeric, "count_below_80_last_month" integer)
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  current_month text;
  last_month text;
BEGIN
  -- Get current and last month in YYYY-MM format
  current_month := to_char(current_date, 'YYYY-MM');
  last_month := to_char(current_date - interval '1 month', 'YYYY-MM');

  RETURN QUERY
  WITH missionary_goals AS (
    SELECT 
      p.id,
      p.monthly_goal,
      COALESCE(current_month_donations.total, 0) as current_month_total,
      COALESCE(last_month_donations.total, 0) as last_month_total
    FROM profiles p
    LEFT JOIN (
      SELECT 
        missionary_id,
        SUM(amount) as total
      FROM donor_donations
      WHERE to_char(date, 'YYYY-MM') = current_month
      GROUP BY missionary_id
    ) current_month_donations ON p.id = current_month_donations.missionary_id
    LEFT JOIN (
      SELECT 
        missionary_id,
        SUM(amount) as total
      FROM donor_donations
      WHERE to_char(date, 'YYYY-MM') = last_month
      GROUP BY missionary_id
    ) last_month_donations ON p.id = last_month_donations.missionary_id
    WHERE p.role IN ('missionary', 'campus_director')
  )
  SELECT
    COALESCE(SUM(current_month_total), 0) as total_donations_this_month,
    CASE 
      WHEN SUM(monthly_goal) > 0 
      THEN (SUM(current_month_total) / SUM(monthly_goal)) * 100 
      ELSE 0 
    END as current_percent_all_missionaries,
    CASE 
      WHEN SUM(monthly_goal) > 0 
      THEN (SUM(last_month_total) / SUM(monthly_goal)) * 100 
      ELSE 0 
    END as last_month_percent_all_missionaries,
    COUNT(CASE 
      WHEN monthly_goal > 0 AND (last_month_total / monthly_goal) < 0.8 
      THEN 1 
    END) as count_below_80_last_month
  FROM missionary_goals;
END;
$$;


ALTER FUNCTION "public"."get_top_metrics"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_jwt_claims"() RETURNS "jsonb"
    LANGUAGE "plpgsql" STABLE
    AS $$
declare
  claims jsonb;
begin
  select 
    jsonb_build_object(
      'role', role,
      'local_church_id', local_church_id
    )
  into claims
  from public.profiles
  where id = auth.uid();
  
  return claims;
end;
$$;


ALTER FUNCTION "public"."get_user_jwt_claims"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."insert_donation_with_privileges"("p_missionary_id" "uuid", "p_donor_id" bigint, "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_recorded_by" "uuid", "p_payment_id" character varying) RETURNS bigint
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_donation_id BIGINT;
BEGIN
  INSERT INTO donor_donations(
    missionary_id,
    donor_id,
    amount,
    date,
    source,
    status,
    recorded_by,
    payment_id
  ) VALUES (
    p_missionary_id,
    p_donor_id,
    p_amount,
    p_date,
    p_source,
    p_status,
    p_recorded_by,
    p_payment_id
  ) RETURNING id INTO v_donation_id;
  
  RETURN v_donation_id;
END;
$$;


ALTER FUNCTION "public"."insert_donation_with_privileges"("p_missionary_id" "uuid", "p_donor_id" bigint, "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_recorded_by" "uuid", "p_payment_id" character varying) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."insert_donations_batch"("donations" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Loop through each donation in the JSON array
  FOR i IN 0..jsonb_array_length(donations) - 1 LOOP
    -- Insert each donation record
    INSERT INTO donor_donations (
      donor_id,
      missionary_id,
      amount,
      date,
      source,
      status,
      notes
    ) VALUES (
      (donations->i->>'donor_id')::bigint,
      (donations->i->>'missionary_id')::uuid,
      (donations->i->>'amount')::numeric,
      (donations->i->>'date')::timestamptz,
      donations->i->>'source',
      donations->i->>'status',
      donations->i->>'notes'
    );
  END LOOP;
  
  -- Note: We deliberately don't refresh materialized views here
  -- to avoid permission issues
END;
$$;


ALTER FUNCTION "public"."insert_donations_batch"("donations" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."insert_single_donation"("donor_id" bigint, "amount" numeric, "missionary_id" "uuid", "donation_date" timestamp with time zone, "source" "text", "status" "text", "notes" "text" DEFAULT NULL::"text") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $_$
BEGIN
  -- Direct insert using parameters
  -- This bypasses any triggers that would refresh the materialized view
  EXECUTE 'INSERT INTO donor_donations(donor_id, missionary_id, amount, date, source, status, notes) 
           VALUES ($1, $2, $3, $4, $5, $6, $7)'
  USING donor_id, missionary_id, amount, donation_date, source, status, notes;
  
  -- Note: We deliberately do not refresh the materialized view here
END;
$_$;


ALTER FUNCTION "public"."insert_single_donation"("donor_id" bigint, "amount" numeric, "missionary_id" "uuid", "donation_date" timestamp with time zone, "source" "text", "status" "text", "notes" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_superadmin"() RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 
    FROM user_roles 
    WHERE user_id = auth.uid() 
    AND role = 'superadmin'
  );
END;
$$;


ALTER FUNCTION "public"."is_superadmin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."refresh_donation_views"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Check if the materialized views exist before refreshing them
  -- This avoids errors if the views don't exist
  PERFORM 1 FROM pg_matviews WHERE matviewname = 'monthly_donation_totals';
  IF FOUND THEN
    EXECUTE 'REFRESH MATERIALIZED VIEW CONCURRENTLY monthly_donation_totals';
  END IF;
  
  PERFORM 1 FROM pg_matviews WHERE matviewname = 'donor_donation_summary';
  IF FOUND THEN
    EXECUTE 'REFRESH MATERIALIZED VIEW CONCURRENTLY donor_donation_summary';
  END IF;
  
  RETURN NEW;
EXCEPTION
  WHEN OTHERS THEN
    -- Log the error but don't fail the transaction
    RAISE WARNING 'Error refreshing materialized views: %', SQLERRM;
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."refresh_donation_views"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."refresh_missionary_monthly_stats"() RETURNS "trigger"
    LANGUAGE "plpgsql"
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


ALTER FUNCTION "public"."refresh_missionary_monthly_stats"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."should_refresh_materialized_views"() RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Check if our session variable is set to 'true'
  RETURN coalesce(current_setting('app.disable_mat_view_refresh', true), 'false') <> 'true';
END;
$$;


ALTER FUNCTION "public"."should_refresh_materialized_views"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."districts" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "province_id" bigint
);


ALTER TABLE "public"."districts" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."districts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."districts_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."districts_id_seq" OWNED BY "public"."districts"."id";



CREATE TABLE IF NOT EXISTS "public"."donor_donations" (
    "id" bigint NOT NULL,
    "donor_id" bigint NOT NULL,
    "missionary_id" "uuid" NOT NULL,
    "amount" numeric(10,2) NOT NULL,
    "date" timestamp with time zone DEFAULT "now"() NOT NULL,
    "source" "text" NOT NULL,
    "status" "text" NOT NULL,
    "notes" "text",
    "fee_amount" numeric(10,2),
    "invoice_id" character varying(100),
    "invoice_url" "text",
    "payment_channel" character varying(50),
    "payment_date" timestamp with time zone,
    "payment_details" "jsonb",
    "payment_id" character varying(100),
    "payment_method" character varying(50),
    "payment_status" character varying(50),
    "recorded_by" "uuid",
    CONSTRAINT "donor_donations_source_check" CHECK (("source" = ANY (ARRAY['online'::"text", 'offline'::"text"]))),
    CONSTRAINT "donor_donations_status_check" CHECK (("status" = ANY (ARRAY['completed'::"text", 'refunded'::"text", 'failed'::"text"])))
);


ALTER TABLE "public"."donor_donations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."donor_donations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."donor_donations_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."donor_donations_id_seq" OWNED BY "public"."donor_donations"."id";



CREATE TABLE IF NOT EXISTS "public"."donors" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "email" "text",
    "phone" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."donors" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."donors_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."donors_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."donors_id_seq" OWNED BY "public"."donors"."id";



CREATE TABLE IF NOT EXISTS "public"."invoice_items" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "invoice_id" character varying(100),
    "donation_id" bigint,
    "amount" numeric(10,2),
    "missionary_id" "uuid",
    "donor_id" bigint,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."invoice_items" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."leave_requests" (
    "id" bigint NOT NULL,
    "requester_id" "uuid" NOT NULL,
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "reason" "text" NOT NULL,
    "status" "text" NOT NULL,
    "campus_director_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "campus_director_notes" "text",
    "lead_pastor_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "type" "text" DEFAULT 'sick'::"text" NOT NULL,
    "lead_pastor_notes" "text",
    CONSTRAINT "leave_requests_campus_director_approval_check" CHECK (("campus_director_approval" = ANY (ARRAY['none'::"text", 'approved'::"text", 'rejected'::"text"]))),
    CONSTRAINT "leave_requests_lead_pastor_approval_check" CHECK (("lead_pastor_approval" = ANY (ARRAY['none'::"text", 'approved'::"text", 'rejected'::"text", 'override-approved'::"text", 'override-rejected'::"text"]))),
    CONSTRAINT "leave_requests_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'approved'::"text", 'rejected'::"text"]))),
    CONSTRAINT "leave_requests_type_check" CHECK (("type" = ANY (ARRAY['sick'::"text", 'vacation'::"text"])))
);


ALTER TABLE "public"."leave_requests" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."leave_requests_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."leave_requests_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."leave_requests_id_seq" OWNED BY "public"."leave_requests"."id";



CREATE TABLE IF NOT EXISTS "public"."local_churches" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "district_id" bigint,
    "lead_pastor_id" "uuid"
);


ALTER TABLE "public"."local_churches" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."local_churches_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."local_churches_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."local_churches_id_seq" OWNED BY "public"."local_churches"."id";



CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "full_name" "text" NOT NULL,
    "role" "text" NOT NULL,
    "local_church_id" bigint NOT NULL,
    "campus_director_id" "uuid",
    "monthly_goal" numeric(10,2) DEFAULT 0,
    "surplus_balance" numeric(10,2) DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "profiles_role_check" CHECK (("role" = ANY (ARRAY['missionary'::"text", 'campus_director'::"text", 'lead_pastor'::"text", 'finance_officer'::"text", 'superadmin'::"text"])))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE MATERIALIZED VIEW "public"."missionary_monthly_stats" AS
 WITH RECURSIVE "date_range" AS (
         SELECT "date_trunc"('month'::"text", "min"("donor_donations"."date")) AS "month_start",
            "date_trunc"('month'::"text", (CURRENT_DATE)::timestamp with time zone) AS "month_end"
           FROM "public"."donor_donations"
        UNION ALL
         SELECT ("date_range"."month_start" + '1 mon'::interval),
            "date_range"."month_end"
           FROM "date_range"
          WHERE ("date_range"."month_start" < "date_range"."month_end")
        ), "months" AS (
         SELECT DISTINCT "to_char"("date_range"."month_start", 'YYYY-MM'::"text") AS "month"
           FROM "date_range"
        ), "monthly_donations" AS (
         SELECT "donor_donations"."missionary_id",
            "to_char"("date_trunc"('month'::"text", "donor_donations"."date"), 'YYYY-MM'::"text") AS "month",
            "sum"("donor_donations"."amount") AS "total_donations"
           FROM "public"."donor_donations"
          WHERE ("donor_donations"."status" = 'completed'::"text")
          GROUP BY "donor_donations"."missionary_id", ("to_char"("date_trunc"('month'::"text", "donor_donations"."date"), 'YYYY-MM'::"text"))
        ), "missionary_months" AS (
         SELECT "p"."id" AS "missionary_id",
            "p"."monthly_goal",
            "m"."month"
           FROM ("public"."profiles" "p"
             CROSS JOIN "months" "m")
          WHERE ("p"."role" = 'missionary'::"text")
        )
 SELECT "mm"."missionary_id",
    "mm"."monthly_goal",
    "mm"."month",
    COALESCE("md"."total_donations", (0)::numeric) AS "total_donations",
        CASE
            WHEN ("mm"."monthly_goal" > (0)::numeric) THEN "round"(((COALESCE("md"."total_donations", (0)::numeric) / ("mm"."monthly_goal")::numeric) * (100)::numeric), 2)
            ELSE (0)::numeric
        END AS "goal_percentage"
   FROM ("missionary_months" "mm"
     LEFT JOIN "monthly_donations" "md" ON ((("mm"."missionary_id" = "md"."missionary_id") AND ("mm"."month" = "md"."month"))))
  WITH NO DATA;


ALTER TABLE "public"."missionary_monthly_stats" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."monthly_donation_totals" AS
 SELECT "donor_donations"."missionary_id",
    "date_trunc"('month'::"text", "donor_donations"."date") AS "month",
    "sum"("donor_donations"."amount") AS "total_amount",
    "count"(DISTINCT "donor_donations"."donor_id") AS "unique_donors"
   FROM "public"."donor_donations"
  WHERE ("donor_donations"."date" >= ("now"() - '1 year 1 mon'::interval))
  GROUP BY "donor_donations"."missionary_id", ("date_trunc"('month'::"text", "donor_donations"."date"));


ALTER TABLE "public"."monthly_donation_totals" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."payment_transactions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "reference_id" character varying(100),
    "invoice_id" character varying(100),
    "invoice_url" "text",
    "status" character varying(50),
    "amount" numeric(10,2),
    "fee_amount" numeric(10,2),
    "currency" character varying(10) DEFAULT 'PHP'::character varying,
    "payment_method" character varying(50),
    "payment_channel" character varying(50),
    "payment_details" "jsonb",
    "payer_email" character varying(255),
    "payer_name" character varying(255),
    "created_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "expires_at" timestamp with time zone,
    "paid_at" timestamp with time zone
);


ALTER TABLE "public"."payment_transactions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."surplus_requests" (
    "id" bigint NOT NULL,
    "missionary_id" "uuid" NOT NULL,
    "amount_requested" numeric(10,2) NOT NULL,
    "reason" "text" NOT NULL,
    "status" "text" NOT NULL,
    "campus_director_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "campus_director_notes" "text",
    "lead_pastor_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "lead_pastor_notes" "text",
    CONSTRAINT "surplus_requests_campus_director_approval_check" CHECK (("campus_director_approval" = ANY (ARRAY['none'::"text", 'approved'::"text", 'rejected'::"text"]))),
    CONSTRAINT "surplus_requests_lead_pastor_approval_check" CHECK (("lead_pastor_approval" = ANY (ARRAY['none'::"text", 'approved'::"text", 'rejected'::"text", 'override-approved'::"text", 'override-rejected'::"text"]))),
    CONSTRAINT "surplus_requests_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'approved'::"text", 'rejected'::"text"])))
);


ALTER TABLE "public"."surplus_requests" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."surplus_requests_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."surplus_requests_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."surplus_requests_id_seq" OWNED BY "public"."surplus_requests"."id";



CREATE TABLE IF NOT EXISTS "public"."system_settings" (
    "id" "text" DEFAULT 'global'::"text" NOT NULL,
    "surplus_allocation_percent" numeric(5,2) DEFAULT 10.00 NOT NULL,
    "default_monthly_goal" numeric(10,2) DEFAULT 10000.00 NOT NULL,
    "leave_policies" "jsonb" DEFAULT '{"max_leave_days": 15, "approval_required": true}'::"jsonb" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"())
);


ALTER TABLE "public"."system_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_roles" (
    "user_id" "uuid" NOT NULL,
    "role" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "local_church_id" bigint
);


ALTER TABLE "public"."user_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."webhook_logs" (
    "id" bigint NOT NULL,
    "payload" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."webhook_logs" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."webhook_logs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."webhook_logs_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."webhook_logs_id_seq" OWNED BY "public"."webhook_logs"."id";



ALTER TABLE ONLY "public"."districts" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."districts_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."donor_donations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."donor_donations_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."donors" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."donors_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."leave_requests" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."leave_requests_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."local_churches" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."local_churches_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."surplus_requests" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."surplus_requests_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."webhook_logs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."webhook_logs_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."districts"
    ADD CONSTRAINT "districts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."donor_donations"
    ADD CONSTRAINT "donor_donations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."donors"
    ADD CONSTRAINT "donors_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."invoice_items"
    ADD CONSTRAINT "invoice_items_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."leave_requests"
    ADD CONSTRAINT "leave_requests_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."local_churches"
    ADD CONSTRAINT "local_churches_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."payment_transactions"
    ADD CONSTRAINT "payment_transactions_invoice_id_key" UNIQUE ("invoice_id");



ALTER TABLE ONLY "public"."payment_transactions"
    ADD CONSTRAINT "payment_transactions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."payment_transactions"
    ADD CONSTRAINT "payment_transactions_reference_id_key" UNIQUE ("reference_id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."surplus_requests"
    ADD CONSTRAINT "surplus_requests_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."system_settings"
    ADD CONSTRAINT "system_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."webhook_logs"
    ADD CONSTRAINT "webhook_logs_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_donor_donations_composite" ON "public"."donor_donations" USING "btree" ("missionary_id", "date", "donor_id");



CREATE INDEX "idx_donor_donations_date" ON "public"."donor_donations" USING "btree" ("date");



CREATE INDEX "idx_donor_donations_donor_id" ON "public"."donor_donations" USING "btree" ("donor_id");



CREATE INDEX "idx_donor_donations_invoice" ON "public"."donor_donations" USING "btree" ("invoice_id");



CREATE INDEX "idx_donor_donations_missionary_id" ON "public"."donor_donations" USING "btree" ("missionary_id");



CREATE INDEX "idx_donor_donations_payment" ON "public"."donor_donations" USING "btree" ("payment_id");



CREATE INDEX "idx_donor_id" ON "public"."donor_donations" USING "btree" ("donor_id");



CREATE INDEX "idx_donors_name" ON "public"."donors" USING "btree" ("name");



CREATE INDEX "idx_invoice_items_donation" ON "public"."invoice_items" USING "btree" ("donation_id");



CREATE INDEX "idx_invoice_items_invoice" ON "public"."invoice_items" USING "btree" ("invoice_id");



CREATE INDEX "idx_local_church_id" ON "public"."profiles" USING "btree" ("local_church_id");



CREATE INDEX "idx_local_churches_name" ON "public"."local_churches" USING "btree" ("name");



CREATE INDEX "idx_missionary_id_donor_donations" ON "public"."donor_donations" USING "btree" ("missionary_id");



CREATE INDEX "idx_payment_transactions_invoice" ON "public"."payment_transactions" USING "btree" ("invoice_id");



CREATE INDEX "idx_payment_transactions_reference" ON "public"."payment_transactions" USING "btree" ("reference_id");



CREATE INDEX "idx_payment_transactions_status" ON "public"."payment_transactions" USING "btree" ("status");



CREATE INDEX "idx_profiles_local_church_id" ON "public"."profiles" USING "btree" ("local_church_id");



CREATE INDEX "idx_profiles_role" ON "public"."profiles" USING "btree" ("role");



CREATE INDEX "idx_profiles_role_local_church" ON "public"."profiles" USING "btree" ("role", "local_church_id");



CREATE INDEX "missionary_monthly_stats_month_idx" ON "public"."missionary_monthly_stats" USING "btree" ("month");



CREATE OR REPLACE TRIGGER "payment_update_trigger" AFTER UPDATE OF "status" ON "public"."payment_transactions" FOR EACH ROW WHEN (((("new"."status")::"text" = 'COMPLETED'::"text") AND (("old"."status")::"text" <> 'COMPLETED'::"text"))) EXECUTE FUNCTION "public"."refresh_donation_views"();



CREATE OR REPLACE TRIGGER "refresh_missionary_stats_on_donation" AFTER INSERT OR DELETE OR UPDATE ON "public"."donor_donations" FOR EACH STATEMENT EXECUTE FUNCTION "public"."refresh_missionary_monthly_stats"();



CREATE OR REPLACE TRIGGER "refresh_missionary_stats_on_profile" AFTER UPDATE OF "monthly_goal" ON "public"."profiles" FOR EACH STATEMENT EXECUTE FUNCTION "public"."refresh_missionary_monthly_stats"();



ALTER TABLE ONLY "public"."donor_donations"
    ADD CONSTRAINT "donor_donations_donor_id_fkey" FOREIGN KEY ("donor_id") REFERENCES "public"."donors"("id");



ALTER TABLE ONLY "public"."donor_donations"
    ADD CONSTRAINT "donor_donations_missionary_id_fkey" FOREIGN KEY ("missionary_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "fk_local_church" FOREIGN KEY ("local_church_id") REFERENCES "public"."local_churches"("id");



ALTER TABLE ONLY "public"."invoice_items"
    ADD CONSTRAINT "invoice_items_donation_id_fkey" FOREIGN KEY ("donation_id") REFERENCES "public"."donor_donations"("id");



ALTER TABLE ONLY "public"."invoice_items"
    ADD CONSTRAINT "invoice_items_donor_id_fkey" FOREIGN KEY ("donor_id") REFERENCES "public"."donors"("id");



ALTER TABLE ONLY "public"."invoice_items"
    ADD CONSTRAINT "invoice_items_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "public"."payment_transactions"("invoice_id");



ALTER TABLE ONLY "public"."invoice_items"
    ADD CONSTRAINT "invoice_items_missionary_id_fkey" FOREIGN KEY ("missionary_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."leave_requests"
    ADD CONSTRAINT "leave_requests_requester_id_fkey" FOREIGN KEY ("requester_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."payment_transactions"
    ADD CONSTRAINT "payment_transactions_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_campus_director_id_fkey" FOREIGN KEY ("campus_director_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_local_church_id_fkey" FOREIGN KEY ("local_church_id") REFERENCES "public"."local_churches"("id");



ALTER TABLE ONLY "public"."surplus_requests"
    ADD CONSTRAINT "surplus_requests_missionary_id_fkey" FOREIGN KEY ("missionary_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Lead pastors can view their church requests" ON "public"."leave_requests" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM ("public"."profiles" "pastor"
     JOIN "public"."profiles" "missionary" ON (("missionary"."local_church_id" = "pastor"."local_church_id")))
  WHERE (("pastor"."id" = "auth"."uid"()) AND ("pastor"."role" = 'lead_pastor'::"text") AND ("leave_requests"."requester_id" = "missionary"."id")))));



CREATE POLICY "Superadmin access only" ON "public"."system_settings" AS RESTRICTIVE USING (("auth"."uid"() IN ( SELECT "profiles"."id"
   FROM "public"."profiles"
  WHERE ("profiles"."role" = 'superadmin'::"text"))));



CREATE POLICY "approve_surplus_requests" ON "public"."surplus_requests" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ((("p"."role" = 'campus_director'::"text") AND (EXISTS ( SELECT 1
           FROM "public"."profiles" "m"
          WHERE (("m"."id" = "surplus_requests"."missionary_id") AND ("m"."local_church_id" = "p"."local_church_id"))))) OR (("p"."role" = 'lead_pastor'::"text") AND (EXISTS ( SELECT 1
           FROM "public"."profiles" "m"
          WHERE (("m"."id" = "surplus_requests"."missionary_id") AND ("m"."local_church_id" = "p"."local_church_id"))))) OR ("p"."role" = 'superadmin'::"text"))))));



CREATE POLICY "campus_director_view_church_profiles" ON "public"."profiles" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles" "ur"
  WHERE (("ur"."user_id" = "auth"."uid"()) AND ("ur"."role" = 'campus_director'::"text") AND ("profiles"."local_church_id" = "ur"."local_church_id")))));



ALTER TABLE "public"."districts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."donor_donations" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "donor_donations_insert_policy" ON "public"."donor_donations" FOR INSERT WITH CHECK ((("recorded_by" = "auth"."uid"()) OR ("missionary_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['campus_director'::"text", 'lead_pastor'::"text", 'finance_officer'::"text", 'superadmin'::"text"])))))));



CREATE POLICY "donor_donations_select_policy" ON "public"."donor_donations" FOR SELECT USING ((("missionary_id" = "auth"."uid"()) OR ("recorded_by" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."profiles" "admin"
  WHERE (("admin"."id" = "auth"."uid"()) AND ("admin"."role" = ANY (ARRAY['campus_director'::"text", 'lead_pastor'::"text"])) AND ("donor_donations"."missionary_id" IN ( SELECT "profiles"."id"
           FROM "public"."profiles"
          WHERE ("profiles"."local_church_id" = "admin"."local_church_id")))))) OR (EXISTS ( SELECT 1
   FROM "public"."profiles" "admin2"
  WHERE (("admin2"."id" = "auth"."uid"()) AND ("admin2"."role" = ANY (ARRAY['finance_officer'::"text", 'superadmin'::"text"])))))));



CREATE POLICY "donor_donations_xendit_update_policy" ON "public"."donor_donations" FOR UPDATE USING (true) WITH CHECK (true);



ALTER TABLE "public"."donors" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "donors_select_policy" ON "public"."donors" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND (("p"."role" = ANY (ARRAY['finance_officer'::"text", 'superadmin'::"text"])) OR (("p"."role" = 'missionary'::"text") AND (EXISTS ( SELECT 1
           FROM "public"."donor_donations" "dd"
          WHERE (("dd"."donor_id" = "donors"."id") AND ("dd"."missionary_id" = "p"."id"))))) OR (("p"."role" = ANY (ARRAY['campus_director'::"text", 'lead_pastor'::"text"])) AND (EXISTS ( SELECT 1
           FROM ("public"."donor_donations" "dd"
             JOIN "public"."profiles" "p2" ON (("p2"."id" = "dd"."missionary_id")))
          WHERE (("dd"."donor_id" = "donors"."id") AND ("p2"."local_church_id" = "p"."local_church_id"))))))))));



CREATE POLICY "finance_officer_view_church_profiles" ON "public"."profiles" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles" "ur"
  WHERE (("ur"."user_id" = "auth"."uid"()) AND ("ur"."role" = 'finance_officer'::"text") AND ("profiles"."local_church_id" = "ur"."local_church_id")))));



CREATE POLICY "insert_own_leave_requests" ON "public"."leave_requests" FOR INSERT WITH CHECK ((("requester_id" = "auth"."uid"()) OR (( SELECT "profiles"."role"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "auth"."uid"())) = 'superadmin'::"text")));



CREATE POLICY "insert_own_surplus_requests" ON "public"."surplus_requests" FOR INSERT WITH CHECK (("missionary_id" = "auth"."uid"()));



ALTER TABLE "public"."invoice_items" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "invoice_items_insert_policy" ON "public"."invoice_items" FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."payment_transactions"
  WHERE ((("payment_transactions"."invoice_id")::"text" = ("invoice_items"."invoice_id")::"text") AND ("payment_transactions"."created_by" = "auth"."uid"())))) OR (EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['superadmin'::"text", 'finance_officer'::"text"])))))));



CREATE POLICY "invoice_items_select_policy" ON "public"."invoice_items" FOR SELECT USING (((EXISTS ( SELECT 1
   FROM "public"."payment_transactions"
  WHERE ((("payment_transactions"."invoice_id")::"text" = ("invoice_items"."invoice_id")::"text") AND ("payment_transactions"."created_by" = "auth"."uid"())))) OR (EXISTS ( SELECT 1
   FROM "public"."donor_donations"
  WHERE (("donor_donations"."id" = "invoice_items"."donation_id") AND ("donor_donations"."missionary_id" = "auth"."uid"())))) OR (EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['superadmin'::"text", 'finance_officer'::"text", 'lead_pastor'::"text"])))))));



CREATE POLICY "lead_pastor_view_church_profiles" ON "public"."profiles" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles" "ur"
  WHERE (("ur"."user_id" = "auth"."uid"()) AND ("ur"."role" = 'lead_pastor'::"text") AND ("profiles"."local_church_id" = "ur"."local_church_id")))));



ALTER TABLE "public"."leave_requests" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."local_churches" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "local_churches_select_policy" ON "public"."local_churches" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND (("profiles"."role" = ANY (ARRAY['superadmin'::"text", 'finance_officer'::"text"])) OR ("profiles"."local_church_id" = "local_churches"."id"))))));



ALTER TABLE "public"."payment_transactions" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "payment_transactions_insert_policy" ON "public"."payment_transactions" FOR INSERT WITH CHECK (("auth"."uid"() = "created_by"));



CREATE POLICY "payment_transactions_select_policy" ON "public"."payment_transactions" FOR SELECT USING ((("auth"."uid"() = "created_by") OR (EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['superadmin'::"text", 'finance_officer'::"text", 'lead_pastor'::"text"])))))));



ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "read_own_profile" ON "public"."profiles" FOR SELECT USING (("id" = "auth"."uid"()));



CREATE POLICY "select_leave_requests" ON "public"."leave_requests" FOR SELECT USING ((("requester_id" = "auth"."uid"()) OR (( SELECT "profiles"."role"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "auth"."uid"())) = 'superadmin'::"text")));



CREATE POLICY "select_own_surplus_requests" ON "public"."surplus_requests" FOR SELECT USING (("missionary_id" = "auth"."uid"()));



CREATE POLICY "superadmin_access_profiles" ON "public"."profiles" USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles" "ur"
  WHERE (("ur"."user_id" = "auth"."uid"()) AND ("ur"."role" = 'superadmin'::"text")))));



ALTER TABLE "public"."surplus_requests" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."system_settings" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_roles_select_policy" ON "public"."user_roles" FOR SELECT USING (("user_id" = "auth"."uid"()));



CREATE POLICY "view_surplus_requests" ON "public"."surplus_requests" FOR SELECT USING ((("missionary_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ((("p"."role" = ANY (ARRAY['campus_director'::"text", 'lead_pastor'::"text"])) AND (EXISTS ( SELECT 1
           FROM "public"."profiles" "m"
          WHERE (("m"."id" = "surplus_requests"."missionary_id") AND ("m"."local_church_id" = "p"."local_church_id"))))) OR ("p"."role" = 'superadmin'::"text")))))));



ALTER TABLE "public"."webhook_logs" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "webhook_logs_insert_policy" ON "public"."webhook_logs" FOR INSERT WITH CHECK (true);



CREATE POLICY "webhook_logs_select_policy" ON "public"."webhook_logs" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = 'superadmin'::"text")))));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";




















































































































































































GRANT ALL ON FUNCTION "public"."bulk_insert_donations"("donations" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."bulk_insert_donations"("donations" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."bulk_insert_donations"("donations" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."create_bulk_donation"("p_missionary_id" "uuid", "p_invoice_id" "text", "p_external_id" "text", "p_total_amount" numeric, "p_donor_entries" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."create_bulk_donation"("p_missionary_id" "uuid", "p_invoice_id" "text", "p_external_id" "text", "p_total_amount" numeric, "p_donor_entries" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_bulk_donation"("p_missionary_id" "uuid", "p_invoice_id" "text", "p_external_id" "text", "p_total_amount" numeric, "p_donor_entries" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."current_local_church"() TO "anon";
GRANT ALL ON FUNCTION "public"."current_local_church"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."current_local_church"() TO "service_role";



GRANT ALL ON FUNCTION "public"."debug_donor_donation_conditions"("p_donation_id" bigint, "p_user" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."debug_donor_donation_conditions"("p_donation_id" bigint, "p_user" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."debug_donor_donation_conditions"("p_donation_id" bigint, "p_user" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."debug_donor_visibility"("p_donor_id" bigint, "p_user" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."debug_donor_visibility"("p_donor_id" bigint, "p_user" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."debug_donor_visibility"("p_donor_id" bigint, "p_user" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."debug_insert_donation"("p_donor_id" bigint, "p_missionary_id" "uuid", "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_notes" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."debug_insert_donation"("p_donor_id" bigint, "p_missionary_id" "uuid", "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_notes" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."debug_insert_donation"("p_donor_id" bigint, "p_missionary_id" "uuid", "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_notes" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."disable_materialized_view_refresh"() TO "anon";
GRANT ALL ON FUNCTION "public"."disable_materialized_view_refresh"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."disable_materialized_view_refresh"() TO "service_role";



GRANT ALL ON FUNCTION "public"."enable_materialized_view_refresh"() TO "anon";
GRANT ALL ON FUNCTION "public"."enable_materialized_view_refresh"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enable_materialized_view_refresh"() TO "service_role";



GRANT ALL ON FUNCTION "public"."execute_sql"("sql_query" "text", "params" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."execute_sql"("sql_query" "text", "params" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."execute_sql"("sql_query" "text", "params" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_auth_email"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_auth_email"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_auth_email"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_top_metrics"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_top_metrics"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_top_metrics"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_user_jwt_claims"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_jwt_claims"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_jwt_claims"() TO "service_role";



GRANT ALL ON FUNCTION "public"."insert_donation_with_privileges"("p_missionary_id" "uuid", "p_donor_id" bigint, "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_recorded_by" "uuid", "p_payment_id" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."insert_donation_with_privileges"("p_missionary_id" "uuid", "p_donor_id" bigint, "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_recorded_by" "uuid", "p_payment_id" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."insert_donation_with_privileges"("p_missionary_id" "uuid", "p_donor_id" bigint, "p_amount" numeric, "p_date" timestamp with time zone, "p_source" "text", "p_status" "text", "p_recorded_by" "uuid", "p_payment_id" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."insert_donations_batch"("donations" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."insert_donations_batch"("donations" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."insert_donations_batch"("donations" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."insert_single_donation"("donor_id" bigint, "amount" numeric, "missionary_id" "uuid", "donation_date" timestamp with time zone, "source" "text", "status" "text", "notes" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."insert_single_donation"("donor_id" bigint, "amount" numeric, "missionary_id" "uuid", "donation_date" timestamp with time zone, "source" "text", "status" "text", "notes" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."insert_single_donation"("donor_id" bigint, "amount" numeric, "missionary_id" "uuid", "donation_date" timestamp with time zone, "source" "text", "status" "text", "notes" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_superadmin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_superadmin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_superadmin"() TO "service_role";



GRANT ALL ON FUNCTION "public"."refresh_donation_views"() TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_donation_views"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_donation_views"() TO "service_role";



GRANT ALL ON FUNCTION "public"."refresh_missionary_monthly_stats"() TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_missionary_monthly_stats"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_missionary_monthly_stats"() TO "service_role";



GRANT ALL ON FUNCTION "public"."should_refresh_materialized_views"() TO "anon";
GRANT ALL ON FUNCTION "public"."should_refresh_materialized_views"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."should_refresh_materialized_views"() TO "service_role";


















GRANT ALL ON TABLE "public"."districts" TO "anon";
GRANT ALL ON TABLE "public"."districts" TO "authenticated";
GRANT ALL ON TABLE "public"."districts" TO "service_role";



GRANT ALL ON SEQUENCE "public"."districts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."districts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."districts_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."donor_donations" TO "anon";
GRANT ALL ON TABLE "public"."donor_donations" TO "authenticated";
GRANT ALL ON TABLE "public"."donor_donations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."donor_donations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."donor_donations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."donor_donations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."donors" TO "anon";
GRANT ALL ON TABLE "public"."donors" TO "authenticated";
GRANT ALL ON TABLE "public"."donors" TO "service_role";



GRANT ALL ON SEQUENCE "public"."donors_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."donors_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."donors_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."invoice_items" TO "anon";
GRANT ALL ON TABLE "public"."invoice_items" TO "authenticated";
GRANT ALL ON TABLE "public"."invoice_items" TO "service_role";



GRANT ALL ON TABLE "public"."leave_requests" TO "anon";
GRANT ALL ON TABLE "public"."leave_requests" TO "authenticated";
GRANT ALL ON TABLE "public"."leave_requests" TO "service_role";



GRANT ALL ON SEQUENCE "public"."leave_requests_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."leave_requests_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."leave_requests_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."local_churches" TO "anon";
GRANT ALL ON TABLE "public"."local_churches" TO "authenticated";
GRANT ALL ON TABLE "public"."local_churches" TO "service_role";



GRANT ALL ON SEQUENCE "public"."local_churches_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."local_churches_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."local_churches_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."missionary_monthly_stats" TO "anon";
GRANT ALL ON TABLE "public"."missionary_monthly_stats" TO "authenticated";
GRANT ALL ON TABLE "public"."missionary_monthly_stats" TO "service_role";



GRANT ALL ON TABLE "public"."monthly_donation_totals" TO "anon";
GRANT ALL ON TABLE "public"."monthly_donation_totals" TO "authenticated";
GRANT ALL ON TABLE "public"."monthly_donation_totals" TO "service_role";



GRANT ALL ON TABLE "public"."payment_transactions" TO "anon";
GRANT ALL ON TABLE "public"."payment_transactions" TO "authenticated";
GRANT ALL ON TABLE "public"."payment_transactions" TO "service_role";



GRANT ALL ON TABLE "public"."surplus_requests" TO "anon";
GRANT ALL ON TABLE "public"."surplus_requests" TO "authenticated";
GRANT ALL ON TABLE "public"."surplus_requests" TO "service_role";



GRANT ALL ON SEQUENCE "public"."surplus_requests_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."surplus_requests_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."surplus_requests_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."system_settings" TO "anon";
GRANT ALL ON TABLE "public"."system_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."system_settings" TO "service_role";



GRANT ALL ON TABLE "public"."user_roles" TO "anon";
GRANT ALL ON TABLE "public"."user_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."user_roles" TO "service_role";



GRANT ALL ON TABLE "public"."webhook_logs" TO "anon";
GRANT ALL ON TABLE "public"."webhook_logs" TO "authenticated";
GRANT ALL ON TABLE "public"."webhook_logs" TO "service_role";



GRANT ALL ON SEQUENCE "public"."webhook_logs_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."webhook_logs_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."webhook_logs_id_seq" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
