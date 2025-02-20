

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


CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






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



CREATE TABLE IF NOT EXISTS "public"."leave_requests" (
    "id" bigint NOT NULL,
    "requester_id" "uuid" NOT NULL,
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "reason" "text" NOT NULL,
    "status" "text" NOT NULL,
    "campus_director_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "lead_pastor_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "type" "text" DEFAULT 'sick'::"text" NOT NULL,
    "campus_director_notes" "text",
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


CREATE TABLE IF NOT EXISTS "public"."surplus_requests" (
    "id" bigint NOT NULL,
    "missionary_id" "uuid" NOT NULL,
    "amount_requested" numeric(10,2) NOT NULL,
    "reason" "text" NOT NULL,
    "status" "text" NOT NULL,
    "campus_director_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "lead_pastor_approval" "text" DEFAULT 'none'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "campus_director_notes" "text",
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


ALTER TABLE ONLY "public"."districts" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."districts_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."donor_donations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."donor_donations_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."donors" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."donors_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."leave_requests" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."leave_requests_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."local_churches" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."local_churches_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."surplus_requests" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."surplus_requests_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."districts"
    ADD CONSTRAINT "districts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."donor_donations"
    ADD CONSTRAINT "donor_donations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."donors"
    ADD CONSTRAINT "donors_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."leave_requests"
    ADD CONSTRAINT "leave_requests_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."local_churches"
    ADD CONSTRAINT "local_churches_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."surplus_requests"
    ADD CONSTRAINT "surplus_requests_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."system_settings"
    ADD CONSTRAINT "system_settings_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_donor_id" ON "public"."donor_donations" USING "btree" ("donor_id");



CREATE INDEX "idx_local_church_id" ON "public"."profiles" USING "btree" ("local_church_id");



CREATE INDEX "idx_missionary_id_donor_donations" ON "public"."donor_donations" USING "btree" ("missionary_id");



ALTER TABLE ONLY "public"."donor_donations"
    ADD CONSTRAINT "donor_donations_donor_id_fkey" FOREIGN KEY ("donor_id") REFERENCES "public"."donors"("id");



ALTER TABLE ONLY "public"."donor_donations"
    ADD CONSTRAINT "donor_donations_missionary_id_fkey" FOREIGN KEY ("missionary_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "fk_local_church" FOREIGN KEY ("local_church_id") REFERENCES "public"."local_churches"("id");



ALTER TABLE ONLY "public"."leave_requests"
    ADD CONSTRAINT "leave_requests_requester_id_fkey" FOREIGN KEY ("requester_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_campus_director_id_fkey" FOREIGN KEY ("campus_director_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_local_church_id_fkey" FOREIGN KEY ("local_church_id") REFERENCES "public"."local_churches"("id");



ALTER TABLE ONLY "public"."surplus_requests"
    ADD CONSTRAINT "surplus_requests_missionary_id_fkey" FOREIGN KEY ("missionary_id") REFERENCES "public"."profiles"("id");



CREATE POLICY "Superadmin access only" ON "public"."system_settings" AS RESTRICTIVE USING (("auth"."uid"() IN ( SELECT "profiles"."id"
   FROM "public"."profiles"
  WHERE ("profiles"."role" = 'superadmin'::"text"))));



CREATE POLICY "Superadmin full access" ON "public"."profiles" FOR SELECT USING (("auth"."email"() = 'robneil@gmail.com'::"text"));



CREATE POLICY "User can view own profile" ON "public"."profiles" FOR SELECT USING (("id" = "auth"."uid"()));



CREATE POLICY "insert_own_leave_requests" ON "public"."leave_requests" FOR INSERT WITH CHECK ((("requester_id" = "auth"."uid"()) OR (( SELECT "profiles"."role"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "auth"."uid"())) = 'superadmin'::"text")));



CREATE POLICY "insert_own_surplus_requests" ON "public"."surplus_requests" FOR INSERT WITH CHECK (("missionary_id" = "auth"."uid"()));



CREATE POLICY "select_leave_requests" ON "public"."leave_requests" FOR SELECT USING ((("requester_id" = "auth"."uid"()) OR (( SELECT "profiles"."role"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "auth"."uid"())) = 'superadmin'::"text")));



CREATE POLICY "select_own_surplus_requests" ON "public"."surplus_requests" FOR SELECT USING (("missionary_id" = "auth"."uid"()));



ALTER TABLE "public"."system_settings" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


CREATE PUBLICATION "supabase_realtime_messages_publication" WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION "supabase_realtime_messages_publication" OWNER TO "supabase_admin";





GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";


























































































































































































GRANT ALL ON FUNCTION "public"."get_user_jwt_claims"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_jwt_claims"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_jwt_claims"() TO "service_role";


















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



GRANT ALL ON TABLE "public"."surplus_requests" TO "anon";
GRANT ALL ON TABLE "public"."surplus_requests" TO "authenticated";
GRANT ALL ON TABLE "public"."surplus_requests" TO "service_role";



GRANT ALL ON SEQUENCE "public"."surplus_requests_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."surplus_requests_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."surplus_requests_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."system_settings" TO "anon";
GRANT ALL ON TABLE "public"."system_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."system_settings" TO "service_role";



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
