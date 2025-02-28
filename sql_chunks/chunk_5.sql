BEGIN;
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
INSERT INTO realtime.schema_migrations VALUES (20211116045059, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211116050929, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211116051442, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211116212300, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211116213355, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211116213934, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211116214523, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211122062447, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211124070109, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211202204204, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211202204605, '2025-02-21 14:12:31');
INSERT INTO realtime.schema_migrations VALUES (20211210212804, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20211228014915, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220107221237, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220228202821, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220312004840, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220603231003, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220603232444, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220615214548, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220712093339, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220908172859, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20220916233421, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20230119133233, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20230128025114, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20230128025212, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20230227211149, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20230228184745, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20230308225145, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20230328144023, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20231018144023, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20231204144023, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20231204144024, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20231204144025, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240108234812, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240109165339, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240227174441, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240311171622, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240321100241, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240401105812, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240418121054, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240523004032, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240618124746, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240801235015, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240805133720, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240827160934, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240919163303, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20240919163305, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241019105805, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241030150047, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241108114728, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241121104152, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241130184212, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241220035512, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241220123912, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20241224161212, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20250107150512, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20250110162412, '2025-02-21 14:12:32');
INSERT INTO realtime.schema_migrations VALUES (20250123174212, '2025-02-21 14:12:32');


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO storage.migrations VALUES (0, 'create-migrations-table', 'e18db593bcde2aca2a408c4d1100f6abba2195df', '2025-02-04 04:08:17.050773');
INSERT INTO storage.migrations VALUES (1, 'initialmigration', '6ab16121fbaa08bbd11b712d05f358f9b555d777', '2025-02-04 04:08:17.055204');
INSERT INTO storage.migrations VALUES (2, 'storage-schema', '5c7968fd083fcea04050c1b7f6253c9771b99011', '2025-02-04 04:08:17.058046');
INSERT INTO storage.migrations VALUES (3, 'pathtoken-column', '2cb1b0004b817b29d5b0a971af16bafeede4b70d', '2025-02-04 04:08:17.066846');
INSERT INTO storage.migrations VALUES (4, 'add-migrations-rls', '427c5b63fe1c5937495d9c635c263ee7a5905058', '2025-02-04 04:08:17.088194');
INSERT INTO storage.migrations VALUES (5, 'add-size-functions', '79e081a1455b63666c1294a440f8ad4b1e6a7f84', '2025-02-04 04:08:17.091093');
INSERT INTO storage.migrations VALUES (6, 'change-column-name-in-get-size', 'f93f62afdf6613ee5e7e815b30d02dc990201044', '2025-02-04 04:08:17.094736');
INSERT INTO storage.migrations VALUES (7, 'add-rls-to-buckets', 'e7e7f86adbc51049f341dfe8d30256c1abca17aa', '2025-02-04 04:08:17.097955');
INSERT INTO storage.migrations VALUES (8, 'add-public-to-buckets', 'fd670db39ed65f9d08b01db09d6202503ca2bab3', '2025-02-04 04:08:17.101573');
INSERT INTO storage.migrations VALUES (9, 'fix-search-function', '3a0af29f42e35a4d101c259ed955b67e1bee6825', '2025-02-04 04:08:17.104848');
INSERT INTO storage.migrations VALUES (10, 'search-files-search-function', '68dc14822daad0ffac3746a502234f486182ef6e', '2025-02-04 04:08:17.108241');
INSERT INTO storage.migrations VALUES (11, 'add-trigger-to-auto-update-updated_at-column', '7425bdb14366d1739fa8a18c83100636d74dcaa2', '2025-02-04 04:08:17.112113');
INSERT INTO storage.migrations VALUES (12, 'add-automatic-avif-detection-flag', '8e92e1266eb29518b6a4c5313ab8f29dd0d08df9', '2025-02-04 04:08:17.117212');
INSERT INTO storage.migrations VALUES (13, 'add-bucket-custom-limits', 'cce962054138135cd9a8c4bcd531598684b25e7d', '2025-02-04 04:08:17.120224');
INSERT INTO storage.migrations VALUES (14, 'use-bytes-for-max-size', '941c41b346f9802b411f06f30e972ad4744dad27', '2025-02-04 04:08:17.12314');
INSERT INTO storage.migrations VALUES (15, 'add-can-insert-object-function', '934146bc38ead475f4ef4b555c524ee5d66799e5', '2025-02-04 04:08:17.153874');
INSERT INTO storage.migrations VALUES (16, 'add-version', '76debf38d3fd07dcfc747ca49096457d95b1221b', '2025-02-04 04:08:17.15897');
INSERT INTO storage.migrations VALUES (17, 'drop-owner-foreign-key', 'f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101', '2025-02-04 04:08:17.16168');
INSERT INTO storage.migrations VALUES (18, 'add_owner_id_column_deprecate_owner', 'e7a511b379110b08e2f214be852c35414749fe66', '2025-02-04 04:08:17.166194');
INSERT INTO storage.migrations VALUES (19, 'alter-default-value-objects-id', '02e5e22a78626187e00d173dc45f58fa66a4f043', '2025-02-04 04:08:17.169977');
INSERT INTO storage.migrations VALUES (20, 'list-objects-with-delimiter', 'cd694ae708e51ba82bf012bba00caf4f3b6393b7', '2025-02-04 04:08:17.173675');
INSERT INTO storage.migrations VALUES (21, 's3-multipart-uploads', '8c804d4a566c40cd1e4cc5b3725a664a9303657f', '2025-02-04 04:08:17.182562');
INSERT INTO storage.migrations VALUES (22, 's3-multipart-uploads-big-ints', '9737dc258d2397953c9953d9b86920b8be0cdb73', '2025-02-04 04:08:17.207526');
INSERT INTO storage.migrations VALUES (23, 'optimize-search-function', '9d7e604cddc4b56a5422dc68c9313f4a1b6f132c', '2025-02-04 04:08:17.236663');
INSERT INTO storage.migrations VALUES (24, 'operation-function', '8312e37c2bf9e76bbe841aa5fda889206d2bf8aa', '2025-02-04 04:08:17.242238');
INSERT INTO storage.migrations VALUES (25, 'custom-metadata', '67eb93b7e8d401cafcdc97f9ac779e71a79bfe03', '2025-02-04 04:08:17.246213');


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--



--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

INSERT INTO supabase_functions.migrations VALUES ('initial', '2025-02-04 04:08:04.652089+00');
INSERT INTO supabase_functions.migrations VALUES ('20210809183423_update_grants', '2025-02-04 04:08:04.652089+00');


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

INSERT INTO supabase_migrations.schema_migrations VALUES ('20240101000001', '{"-- Create tables

CREATE TABLE local_churches (

  id BIGSERIAL PRIMARY KEY,

  name TEXT NOT NULL,

  district_id BIGINT,

  lead_pastor_id UUID

)","CREATE TABLE districts (

  id BIGSERIAL PRIMARY KEY,

  name TEXT NOT NULL,

  province_id BIGINT

)","CREATE TABLE profiles (

  id UUID PRIMARY KEY REFERENCES auth.users(id),

  full_name TEXT NOT NULL,

  role TEXT NOT NULL CHECK (role IN (''missionary'', ''campus_director'', ''lead_pastor'', ''finance_officer'', ''superadmin'')),

  local_church_id BIGINT NOT NULL REFERENCES local_churches(id),

  campus_director_id UUID REFERENCES profiles(id),

  monthly_goal NUMERIC(10,2) DEFAULT 0,

  surplus_balance NUMERIC(10,2) DEFAULT 0,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  updated_at TIMESTAMPTZ DEFAULT NOW()

)","CREATE TABLE donations (

  id BIGSERIAL PRIMARY KEY,

  missionary_id UUID NOT NULL REFERENCES profiles(id),

  donor_name TEXT,

  amount NUMERIC(10,2) NOT NULL,

  date TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  source TEXT NOT NULL CHECK (source IN (''online'', ''offline'')),

  status TEXT NOT NULL CHECK (status IN (''completed'', ''refunded'', ''failed'')),

  created_by UUID REFERENCES profiles(id)

)","CREATE TABLE surplus_requests (

  id BIGSERIAL PRIMARY KEY,

  missionary_id UUID NOT NULL REFERENCES profiles(id),

  amount_requested NUMERIC(10,2) NOT NULL,

  reason TEXT NOT NULL,

  status TEXT NOT NULL CHECK (status IN (''pending'', ''approved'', ''rejected'')),

  campus_director_approval TEXT NOT NULL CHECK (campus_director_approval IN (''none'', ''approved'', ''rejected'')) DEFAULT ''none'',

  lead_pastor_approval TEXT NOT NULL CHECK (lead_pastor_approval IN (''none'', ''approved'', ''rejected'', ''override'')) DEFAULT ''none'',

  created_at TIMESTAMPTZ DEFAULT NOW(),

  updated_at TIMESTAMPTZ DEFAULT NOW()

)","CREATE TABLE leave_requests (

  id BIGSERIAL PRIMARY KEY,

  requester_id UUID NOT NULL REFERENCES profiles(id),

  start_date DATE NOT NULL,

  end_date DATE NOT NULL,

  reason TEXT NOT NULL,

  status TEXT NOT NULL CHECK (status IN (''pending'', ''approved'', ''rejected'')),

  campus_director_approval TEXT NOT NULL CHECK (campus_director_approval IN (''none'', ''approved'', ''rejected'')) DEFAULT ''none'',

  lead_pastor_approval TEXT NOT NULL CHECK (lead_pastor_approval IN (''none'', ''approved'', ''rejected'', ''override'')) DEFAULT ''none'',

  created_at TIMESTAMPTZ DEFAULT NOW(),

  updated_at TIMESTAMPTZ DEFAULT NOW(),

  type TEXT NOT NULL CHECK (type IN (''sick'', ''vacation'')) DEFAULT ''sick''

)","CREATE TABLE donors (

  id BIGSERIAL PRIMARY KEY,

  name TEXT NOT NULL,

  email TEXT,

  phone TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW()

)","CREATE TABLE donor_donations (

  id BIGSERIAL PRIMARY KEY,

  donor_id BIGINT NOT NULL REFERENCES donors(id),

  missionary_id UUID NOT NULL REFERENCES profiles(id),

  amount NUMERIC(10,2) NOT NULL,

  date TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  source TEXT NOT NULL CHECK (source IN (''online'', ''offline'')),

  status TEXT NOT NULL CHECK (status IN (''completed'', ''refunded'', ''failed''))

)","-- Add foreign key constraints

ALTER TABLE profiles

ADD CONSTRAINT fk_local_church

FOREIGN KEY (local_church_id)

REFERENCES local_churches(id)","ALTER TABLE donations

ADD CONSTRAINT fk_missionary

FOREIGN KEY (missionary_id)

REFERENCES profiles(id)","-- Add indexes and security policies as needed

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY","ALTER TABLE donations ENABLE ROW LEVEL SECURITY","-- Add indexes for optimization

CREATE INDEX idx_missionary_id ON donations(missionary_id)","CREATE INDEX idx_local_church_id ON profiles(local_church_id)","CREATE INDEX idx_donor_id ON donor_donations(donor_id)","CREATE INDEX idx_missionary_id_donor_donations ON donor_donations(missionary_id)","-- Add row-level security policies

ALTER TABLE leave_requests ENABLE ROW LEVEL SECURITY","-- Example security policy (customize as needed)

DROP POLICY IF EXISTS select_own_profile ON profiles","CREATE POLICY select_own_profile ON profiles

FOR SELECT USING (

  id = auth.uid() OR 

  auth.uid() = ''e3ecacd9-c6bc-4b9e-a632-acb4476a7337'' -- Superadmin UUID

)","CREATE POLICY select_own_donations ON donations

  FOR SELECT

  USING (missionary_id = auth.uid())","CREATE POLICY insert_own_leave_requests ON leave_requests

FOR INSERT WITH CHECK (

  requester_id = auth.uid()

)","CREATE POLICY select_own_leave_requests ON leave_requests

FOR SELECT USING (

  requester_id = auth.uid()

)","-- Add similar policies for surplus_requests

CREATE POLICY insert_own_surplus_requests ON surplus_requests

FOR INSERT WITH CHECK (

  missionary_id = auth.uid()

)","CREATE POLICY select_own_surplus_requests ON surplus_requests

FOR SELECT USING (

  missionary_id = auth.uid()

)"}', 'initial_schema');
INSERT INTO supabase_migrations.schema_migrations VALUES ('20250208123027', '{"-- Drop policies if they exist
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''select_own_donations'' AND tablename = ''donations'') THEN
        DROP POLICY \"select_own_donations\" ON \"public\".\"donations\";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''insert_leave_requests'' AND tablename = ''leave_requests'') THEN
        DROP POLICY \"insert_leave_requests\" ON \"public\".\"leave_requests\";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''insert_surplus_requests'' AND tablename = ''surplus_requests'') THEN
        DROP POLICY \"insert_surplus_requests\" ON \"public\".\"surplus_requests\";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''select_surplus_requests'' AND tablename = ''surplus_requests'') THEN
        DROP POLICY \"select_surplus_requests\" ON \"public\".\"surplus_requests\";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''select_own_profile'' AND tablename = ''profiles'') THEN
        DROP POLICY \"select_own_profile\" ON \"public\".\"profiles\";
    END IF;
END $$","-- Revoke permissions if table exists
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = ''donations'' AND schemaname = ''public'') THEN
        REVOKE ALL ON TABLE \"public\".\"donations\" FROM \"anon\", \"authenticated\", \"service_role\";
        
        -- Drop constraints if they exist
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''donations_created_by_fkey'') THEN
            ALTER TABLE \"public\".\"donations\" DROP CONSTRAINT \"donations_created_by_fkey\";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''donations_missionary_id_fkey'') THEN
            ALTER TABLE \"public\".\"donations\" DROP CONSTRAINT \"donations_missionary_id_fkey\";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''donations_source_check'') THEN
            ALTER TABLE \"public\".\"donations\" DROP CONSTRAINT \"donations_source_check\";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''donations_status_check'') THEN
            ALTER TABLE \"public\".\"donations\" DROP CONSTRAINT \"donations_status_check\";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''fk_missionary'') THEN
            ALTER TABLE \"public\".\"donations\" DROP CONSTRAINT \"fk_missionary\";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''donations_pkey'') THEN
            ALTER TABLE \"public\".\"donations\" DROP CONSTRAINT \"donations_pkey\";
        END IF;
        
        -- Drop indexes
        DROP INDEX IF EXISTS \"public\".\"donations_pkey\";
        DROP INDEX IF EXISTS \"public\".\"idx_missionary_id\";
        
        -- Drop the table
        DROP TABLE \"public\".\"donations\";
    END IF;
END $$","-- Drop sequence if exists
DROP SEQUENCE IF EXISTS \"public\".\"donations_id_seq\"","-- Add columns and constraints to existing tables
ALTER TABLE \"public\".\"leave_requests\" ADD COLUMN IF NOT EXISTS \"lead_pastor_notes\" text","ALTER TABLE \"public\".\"leave_requests\" DISABLE ROW LEVEL SECURITY","ALTER TABLE \"public\".\"surplus_requests\" ADD COLUMN IF NOT EXISTS \"lead_pastor_notes\" text","-- Add constraints with existence checks
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''leave_requests_lead_pastor_approval_check'') THEN
        ALTER TABLE \"public\".\"leave_requests\" ADD CONSTRAINT \"leave_requests_lead_pastor_approval_check\" 
        CHECK ((lead_pastor_approval = ANY (ARRAY[''none''::text, ''approved''::text, ''rejected''::text, ''override-approved''::text, ''override-rejected''::text]))) NOT VALID;
        
        ALTER TABLE \"public\".\"leave_requests\" VALIDATE CONSTRAINT \"leave_requests_lead_pastor_approval_check\";
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = ''surplus_requests_lead_pastor_approval_check'') THEN
        ALTER TABLE \"public\".\"surplus_requests\" ADD CONSTRAINT \"surplus_requests_lead_pastor_approval_check\" 
        CHECK ((lead_pastor_approval = ANY (ARRAY[''none''::text, ''approved''::text, ''rejected''::text, ''override-approved''::text, ''override-rejected''::text]))) NOT VALID;
        
        ALTER TABLE \"public\".\"surplus_requests\" VALIDATE CONSTRAINT \"surplus_requests_lead_pastor_approval_check\";
    END IF;
END $$","-- Create policies
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''insert_own_leave_requests'' AND tablename = ''leave_requests'') THEN
        CREATE POLICY \"insert_own_leave_requests\"
        ON \"public\".\"leave_requests\"
        AS permissive
        FOR insert
        TO public
        WITH CHECK (((requester_id = auth.uid()) OR (( SELECT profiles.role
           FROM profiles
          WHERE (profiles.id = auth.uid())) = ''superadmin''::text)));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''Enable read access for all users'' AND tablename = ''profiles'') THEN
        CREATE POLICY \"Enable read access for all users\"
        ON \"public\".\"profiles\"
        AS permissive
        FOR select
        TO public
        USING (((id = auth.uid()) OR (auth.email() = ''robneil@gmail.com''::text)));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''insert_own_surplus_requests'' AND tablename = ''surplus_requests'') THEN
        CREATE POLICY \"insert_own_surplus_requests\"
        ON \"public\".\"surplus_requests\"
        AS permissive
        FOR insert
        TO public
        WITH CHECK ((missionary_id = auth.uid()));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''select_own_surplus_requests'' AND tablename = ''surplus_requests'') THEN
        CREATE POLICY \"select_own_surplus_requests\"
        ON \"public\".\"surplus_requests\"
        AS permissive
        FOR select
        TO public
        USING ((missionary_id = auth.uid()));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = ''select_own_profile'' AND tablename = ''profiles'') THEN
        CREATE POLICY \"select_own_profile\"
        ON \"public\".\"profiles\"
        AS permissive
        FOR select
        TO public
        USING (((id = auth.uid()) OR (auth.uid() = ''aebdeee3-427f-4d5b-832d-8c4ebaecdddc''::uuid)));
    END IF;
END $$"}', 'feb8-current_db_state');
INSERT INTO supabase_migrations.schema_migrations VALUES ('20250208145227', '{"DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_schema = ''public'' 
        AND table_name = ''donor_donations'' 
        AND column_name = ''notes''
    ) THEN
        ALTER TABLE \"public\".\"donor_donations\" ADD COLUMN \"notes\" text;
    END IF;
END $$"}', 'feb8-current_db_statev2');
INSERT INTO supabase_migrations.schema_migrations VALUES ('20250225140632', '{"-- Create materialized view for missionary monthly stats

CREATE MATERIALIZED VIEW IF NOT EXISTS missionary_monthly_stats AS

WITH monthly_donations AS (

  SELECT 

    missionary_id,

    to_char(date_trunc(''month'', date), ''YYYY-MM'') as month,

    SUM(amount) as total_donations

  FROM donor_donations 

  WHERE status = ''completed''

  GROUP BY missionary_id, to_char(date_trunc(''month'', date), ''YYYY-MM'')

)

SELECT 

  p.id as missionary_id,

  p.monthly_goal,

  md.month,

  COALESCE(md.total_donations, 0) as total_donations,

  CASE 

    WHEN p.monthly_goal > 0 THEN 

      ROUND((COALESCE(md.total_donations, 0)::numeric / p.monthly_goal::numeric) * 100, 2)

    ELSE 0

  END as goal_percentage

FROM profiles p

LEFT JOIN monthly_donations md ON p.id = md.missionary_id

WHERE p.role = ''missionary''","-- Create an index on the month field for better query performance

CREATE INDEX IF NOT EXISTS missionary_monthly_stats_month_idx ON missionary_monthly_stats(month)","-- Create a function to refresh the materialized view

CREATE OR REPLACE FUNCTION refresh_missionary_monthly_stats()

RETURNS trigger

LANGUAGE plpgsql

AS $$

BEGIN

  REFRESH MATERIALIZED VIEW CONCURRENTLY missionary_monthly_stats;

  RETURN NULL;

END;

$$","-- Create triggers to refresh the view when donations change

DROP TRIGGER IF EXISTS refresh_missionary_stats_on_donation ON donor_donations","CREATE TRIGGER refresh_missionary_stats_on_donation

  AFTER INSERT OR UPDATE OR DELETE

  ON donor_donations

  FOR EACH STATEMENT

  EXECUTE FUNCTION refresh_missionary_monthly_stats()","-- Create trigger to refresh when missionary goals are updated

DROP TRIGGER IF EXISTS refresh_missionary_stats_on_profile ON profiles","CREATE TRIGGER refresh_missionary_stats_on_profile

  AFTER UPDATE OF monthly_goal

  ON profiles

  FOR EACH STATEMENT

  EXECUTE FUNCTION refresh_missionary_monthly_stats()","-- Down Migration

-- DROP TRIGGER IF EXISTS refresh_missionary_stats_on_donation ON donor_donations;

-- DROP TRIGGER IF EXISTS refresh_missionary_stats_on_profile ON profiles;

-- DROP FUNCTION IF EXISTS refresh_missionary_monthly_stats();

-- DROP MATERIALIZED VIEW IF EXISTS missionary_monthly_stats;"}', 'create_missionary_stats_view');


--
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

INSERT INTO supabase_migrations.seed_files VALUES ('supabase/seed.sql', 'f1043d63f0cd5916fbd23500ea8745472b70763b6389c02f4c3cb023da9d5831');


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 485, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: districts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.districts_id_seq', 1, false);


--
-- Name: donor_donations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donor_donations_id_seq', 2122, true);


--
-- Name: donors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donors_id_seq', 723, true);


--
-- Name: leave_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_requests_id_seq', 236, true);


--
-- Name: local_churches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.local_churches_id_seq', 1, false);


--
-- Name: surplus_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.surplus_requests_id_seq', 145, true);


--
-- Name: webhook_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhook_logs_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

COMMIT;
