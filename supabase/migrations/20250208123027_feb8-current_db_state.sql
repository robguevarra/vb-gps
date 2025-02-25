-- Drop policies if they exist
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_donations' AND tablename = 'donations') THEN
        DROP POLICY "select_own_donations" ON "public"."donations";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_leave_requests' AND tablename = 'leave_requests') THEN
        DROP POLICY "insert_leave_requests" ON "public"."leave_requests";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_surplus_requests' AND tablename = 'surplus_requests') THEN
        DROP POLICY "insert_surplus_requests" ON "public"."surplus_requests";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_surplus_requests' AND tablename = 'surplus_requests') THEN
        DROP POLICY "select_surplus_requests" ON "public"."surplus_requests";
    END IF;
    
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_profile' AND tablename = 'profiles') THEN
        DROP POLICY "select_own_profile" ON "public"."profiles";
    END IF;
END $$;

-- Revoke permissions if table exists
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'donations' AND schemaname = 'public') THEN
        REVOKE ALL ON TABLE "public"."donations" FROM "anon", "authenticated", "service_role";
        
        -- Drop constraints if they exist
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_created_by_fkey') THEN
            ALTER TABLE "public"."donations" DROP CONSTRAINT "donations_created_by_fkey";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_missionary_id_fkey') THEN
            ALTER TABLE "public"."donations" DROP CONSTRAINT "donations_missionary_id_fkey";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_source_check') THEN
            ALTER TABLE "public"."donations" DROP CONSTRAINT "donations_source_check";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_status_check') THEN
            ALTER TABLE "public"."donations" DROP CONSTRAINT "donations_status_check";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_missionary') THEN
            ALTER TABLE "public"."donations" DROP CONSTRAINT "fk_missionary";
        END IF;
        
        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_pkey') THEN
            ALTER TABLE "public"."donations" DROP CONSTRAINT "donations_pkey";
        END IF;
        
        -- Drop indexes
        DROP INDEX IF EXISTS "public"."donations_pkey";
        DROP INDEX IF EXISTS "public"."idx_missionary_id";
        
        -- Drop the table
        DROP TABLE "public"."donations";
    END IF;
END $$;

-- Drop sequence if exists
DROP SEQUENCE IF EXISTS "public"."donations_id_seq";

-- Add columns and constraints to existing tables
ALTER TABLE "public"."leave_requests" ADD COLUMN IF NOT EXISTS "lead_pastor_notes" text;
ALTER TABLE "public"."leave_requests" DISABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."surplus_requests" ADD COLUMN IF NOT EXISTS "lead_pastor_notes" text;

-- Add constraints with existence checks
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'leave_requests_lead_pastor_approval_check') THEN
        ALTER TABLE "public"."leave_requests" ADD CONSTRAINT "leave_requests_lead_pastor_approval_check" 
        CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) NOT VALID;
        
        ALTER TABLE "public"."leave_requests" VALIDATE CONSTRAINT "leave_requests_lead_pastor_approval_check";
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'surplus_requests_lead_pastor_approval_check') THEN
        ALTER TABLE "public"."surplus_requests" ADD CONSTRAINT "surplus_requests_lead_pastor_approval_check" 
        CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) NOT VALID;
        
        ALTER TABLE "public"."surplus_requests" VALIDATE CONSTRAINT "surplus_requests_lead_pastor_approval_check";
    END IF;
END $$;

-- Create policies
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_own_leave_requests' AND tablename = 'leave_requests') THEN
        CREATE POLICY "insert_own_leave_requests"
        ON "public"."leave_requests"
        AS permissive
        FOR insert
        TO public
        WITH CHECK (((requester_id = auth.uid()) OR (( SELECT profiles.role
           FROM profiles
          WHERE (profiles.id = auth.uid())) = 'superadmin'::text)));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Enable read access for all users' AND tablename = 'profiles') THEN
        CREATE POLICY "Enable read access for all users"
        ON "public"."profiles"
        AS permissive
        FOR select
        TO public
        USING (((id = auth.uid()) OR (auth.email() = 'robneil@gmail.com'::text)));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_own_surplus_requests' AND tablename = 'surplus_requests') THEN
        CREATE POLICY "insert_own_surplus_requests"
        ON "public"."surplus_requests"
        AS permissive
        FOR insert
        TO public
        WITH CHECK ((missionary_id = auth.uid()));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_surplus_requests' AND tablename = 'surplus_requests') THEN
        CREATE POLICY "select_own_surplus_requests"
        ON "public"."surplus_requests"
        AS permissive
        FOR select
        TO public
        USING ((missionary_id = auth.uid()));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_profile' AND tablename = 'profiles') THEN
        CREATE POLICY "select_own_profile"
        ON "public"."profiles"
        AS permissive
        FOR select
        TO public
        USING (((id = auth.uid()) OR (auth.uid() = 'aebdeee3-427f-4d5b-832d-8c4ebaecdddc'::uuid)));
    END IF;
END $$;



