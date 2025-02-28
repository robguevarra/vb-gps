create sequence "public"."webhook_logs_id_seq";

drop policy "Enable read access for all users" on "public"."profiles";

drop policy "select_own_profile" on "public"."profiles";

alter table "public"."leave_requests" drop constraint "leave_requests_lead_pastor_approval_check";

alter table "public"."surplus_requests" drop constraint "surplus_requests_lead_pastor_approval_check";

create table "public"."invoice_items" (
    "id" uuid not null default gen_random_uuid(),
    "invoice_id" character varying(100),
    "donation_id" bigint,
    "amount" numeric(10,2),
    "missionary_id" uuid,
    "donor_id" bigint,
    "created_at" timestamp with time zone default now()
);


alter table "public"."invoice_items" enable row level security;

create table "public"."payment_transactions" (
    "id" uuid not null default gen_random_uuid(),
    "reference_id" character varying(100),
    "invoice_id" character varying(100),
    "invoice_url" text,
    "status" character varying(50),
    "amount" numeric(10,2),
    "fee_amount" numeric(10,2),
    "currency" character varying(10) default 'PHP'::character varying,
    "payment_method" character varying(50),
    "payment_channel" character varying(50),
    "payment_details" jsonb,
    "payer_email" character varying(255),
    "payer_name" character varying(255),
    "created_by" uuid,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now(),
    "expires_at" timestamp with time zone,
    "paid_at" timestamp with time zone
);


alter table "public"."payment_transactions" enable row level security;

create table "public"."system_settings" (
    "id" text not null default 'global'::text,
    "surplus_allocation_percent" numeric(5,2) not null default 10.00,
    "default_monthly_goal" numeric(10,2) not null default 10000.00,
    "leave_policies" jsonb not null default '{"max_leave_days": 15, "approval_required": true}'::jsonb,
    "updated_at" timestamp with time zone default timezone('utc'::text, now())
);


alter table "public"."system_settings" enable row level security;

create table "public"."user_roles" (
    "user_id" uuid not null,
    "role" text not null,
    "created_at" timestamp with time zone default now(),
    "local_church_id" bigint
);


alter table "public"."user_roles" enable row level security;

create table "public"."webhook_logs" (
    "id" bigint not null default nextval('webhook_logs_id_seq'::regclass),
    "payload" jsonb,
    "created_at" timestamp with time zone default now()
);


alter table "public"."webhook_logs" enable row level security;

alter table "public"."districts" enable row level security;

alter table "public"."donor_donations" add column "fee_amount" numeric(10,2);

alter table "public"."donor_donations" add column "invoice_id" character varying(100);

alter table "public"."donor_donations" add column "invoice_url" text;

alter table "public"."donor_donations" add column "payment_channel" character varying(50);

alter table "public"."donor_donations" add column "payment_date" timestamp with time zone;

alter table "public"."donor_donations" add column "payment_details" jsonb;

alter table "public"."donor_donations" add column "payment_id" character varying(100);

alter table "public"."donor_donations" add column "payment_method" character varying(50);

alter table "public"."donor_donations" add column "payment_status" character varying(50);

alter table "public"."donor_donations" add column "recorded_by" uuid;

alter table "public"."donor_donations" enable row level security;

alter table "public"."donors" enable row level security;

alter table "public"."leave_requests" enable row level security;

alter table "public"."local_churches" enable row level security;

alter table "public"."surplus_requests" enable row level security;

alter sequence "public"."webhook_logs_id_seq" owned by "public"."webhook_logs"."id";

CREATE INDEX idx_donor_donations_composite ON public.donor_donations USING btree (missionary_id, date, donor_id);

CREATE INDEX idx_donor_donations_date ON public.donor_donations USING btree (date);

CREATE INDEX idx_donor_donations_donor_id ON public.donor_donations USING btree (donor_id);

CREATE INDEX idx_donor_donations_invoice ON public.donor_donations USING btree (invoice_id);

CREATE INDEX idx_donor_donations_missionary_id ON public.donor_donations USING btree (missionary_id);

CREATE INDEX idx_donor_donations_payment ON public.donor_donations USING btree (payment_id);

CREATE INDEX idx_donors_name ON public.donors USING btree (name);

CREATE INDEX idx_invoice_items_donation ON public.invoice_items USING btree (donation_id);

CREATE INDEX idx_invoice_items_invoice ON public.invoice_items USING btree (invoice_id);

CREATE INDEX idx_local_churches_name ON public.local_churches USING btree (name);

CREATE INDEX idx_payment_transactions_invoice ON public.payment_transactions USING btree (invoice_id);

CREATE INDEX idx_payment_transactions_reference ON public.payment_transactions USING btree (reference_id);

CREATE INDEX idx_payment_transactions_status ON public.payment_transactions USING btree (status);

CREATE INDEX idx_profiles_local_church_id ON public.profiles USING btree (local_church_id);

CREATE INDEX idx_profiles_role ON public.profiles USING btree (role);

CREATE INDEX idx_profiles_role_local_church ON public.profiles USING btree (role, local_church_id);

CREATE UNIQUE INDEX invoice_items_pkey ON public.invoice_items USING btree (id);

CREATE UNIQUE INDEX payment_transactions_invoice_id_key ON public.payment_transactions USING btree (invoice_id);

CREATE UNIQUE INDEX payment_transactions_pkey ON public.payment_transactions USING btree (id);

CREATE UNIQUE INDEX payment_transactions_reference_id_key ON public.payment_transactions USING btree (reference_id);

CREATE UNIQUE INDEX system_settings_pkey ON public.system_settings USING btree (id);

CREATE UNIQUE INDEX user_roles_pkey ON public.user_roles USING btree (user_id);

CREATE UNIQUE INDEX webhook_logs_pkey ON public.webhook_logs USING btree (id);

alter table "public"."invoice_items" add constraint "invoice_items_pkey" PRIMARY KEY using index "invoice_items_pkey";

alter table "public"."payment_transactions" add constraint "payment_transactions_pkey" PRIMARY KEY using index "payment_transactions_pkey";

alter table "public"."system_settings" add constraint "system_settings_pkey" PRIMARY KEY using index "system_settings_pkey";

alter table "public"."user_roles" add constraint "user_roles_pkey" PRIMARY KEY using index "user_roles_pkey";

alter table "public"."webhook_logs" add constraint "webhook_logs_pkey" PRIMARY KEY using index "webhook_logs_pkey";

alter table "public"."invoice_items" add constraint "invoice_items_donation_id_fkey" FOREIGN KEY (donation_id) REFERENCES donor_donations(id) not valid;

alter table "public"."invoice_items" validate constraint "invoice_items_donation_id_fkey";

alter table "public"."invoice_items" add constraint "invoice_items_donor_id_fkey" FOREIGN KEY (donor_id) REFERENCES donors(id) not valid;

alter table "public"."invoice_items" validate constraint "invoice_items_donor_id_fkey";

alter table "public"."invoice_items" add constraint "invoice_items_invoice_id_fkey" FOREIGN KEY (invoice_id) REFERENCES payment_transactions(invoice_id) not valid;

alter table "public"."invoice_items" validate constraint "invoice_items_invoice_id_fkey";

alter table "public"."invoice_items" add constraint "invoice_items_missionary_id_fkey" FOREIGN KEY (missionary_id) REFERENCES auth.users(id) not valid;

alter table "public"."invoice_items" validate constraint "invoice_items_missionary_id_fkey";

alter table "public"."payment_transactions" add constraint "payment_transactions_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."payment_transactions" validate constraint "payment_transactions_created_by_fkey";

alter table "public"."payment_transactions" add constraint "payment_transactions_invoice_id_key" UNIQUE using index "payment_transactions_invoice_id_key";

alter table "public"."payment_transactions" add constraint "payment_transactions_reference_id_key" UNIQUE using index "payment_transactions_reference_id_key";

alter table "public"."user_roles" add constraint "user_roles_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."user_roles" validate constraint "user_roles_user_id_fkey";

alter table "public"."leave_requests" add constraint "leave_requests_lead_pastor_approval_check" CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) not valid;

alter table "public"."leave_requests" validate constraint "leave_requests_lead_pastor_approval_check";

alter table "public"."surplus_requests" add constraint "surplus_requests_lead_pastor_approval_check" CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) not valid;

alter table "public"."surplus_requests" validate constraint "surplus_requests_lead_pastor_approval_check";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.bulk_insert_donations(donations jsonb)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.create_bulk_donation(p_missionary_id uuid, p_invoice_id text, p_external_id text, p_total_amount numeric, p_donor_entries jsonb)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.current_local_church()
 RETURNS text
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT local_church_id::text FROM user_roles WHERE user_id = auth.uid();
$function$
;

CREATE OR REPLACE FUNCTION public.debug_donor_donation_conditions(p_donation_id bigint, p_user uuid)
 RETURNS TABLE(donation_id bigint, is_missionary boolean, is_recorded_by boolean, is_admin_same_church boolean, is_finance_or_superadmin boolean)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.debug_donor_visibility(p_donor_id bigint, p_user uuid)
 RETURNS TABLE(donor_id bigint, has_missionary_donation boolean, has_admin_donation boolean, has_finance_donation boolean)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.debug_insert_donation(p_donor_id bigint, p_missionary_id uuid, p_amount numeric, p_date timestamp with time zone, p_source text, p_status text, p_notes text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.disable_materialized_view_refresh()
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  -- Set a session variable that can be checked by triggers
  PERFORM set_config('app.disable_mat_view_refresh', 'true', false);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.enable_materialized_view_refresh()
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  -- Clear the session variable
  PERFORM set_config('app.disable_mat_view_refresh', 'false', false);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.execute_sql(sql_query text, params jsonb DEFAULT '{}'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_top_metrics()
 RETURNS TABLE(total_donations_this_month numeric, current_percent_all_missionaries numeric, last_month_percent_all_missionaries numeric, count_below_80_last_month integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_user_jwt_claims()
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.insert_donation_with_privileges(p_missionary_id uuid, p_donor_id bigint, p_amount numeric, p_date timestamp with time zone, p_source text, p_status text, p_recorded_by uuid, p_payment_id character varying)
 RETURNS bigint
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.insert_donations_batch(donations jsonb)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.insert_single_donation(donor_id bigint, amount numeric, missionary_id uuid, donation_date timestamp with time zone, source text, status text, notes text DEFAULT NULL::text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  -- Direct insert using parameters
  -- This bypasses any triggers that would refresh the materialized view
  EXECUTE 'INSERT INTO donor_donations(donor_id, missionary_id, amount, date, source, status, notes) 
           VALUES ($1, $2, $3, $4, $5, $6, $7)'
  USING donor_id, missionary_id, amount, donation_date, source, status, notes;
  
  -- Note: We deliberately do not refresh the materialized view here
END;
$function$
;

create or replace view "public"."monthly_donation_totals" as  SELECT donor_donations.missionary_id,
    date_trunc('month'::text, donor_donations.date) AS month,
    sum(donor_donations.amount) AS total_amount,
    count(DISTINCT donor_donations.donor_id) AS unique_donors
   FROM donor_donations
  WHERE (donor_donations.date >= (now() - '1 year 1 mon'::interval))
  GROUP BY donor_donations.missionary_id, (date_trunc('month'::text, donor_donations.date));


CREATE OR REPLACE FUNCTION public.refresh_donation_views()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.should_refresh_materialized_views()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Check if our session variable is set to 'true'
  RETURN coalesce(current_setting('app.disable_mat_view_refresh', true), 'false') <> 'true';
END;
$function$
;

CREATE OR REPLACE FUNCTION public.refresh_missionary_monthly_stats()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Check if materialized view refresh is disabled
  IF should_refresh_materialized_views() THEN
    -- Only refresh if not disabled
    REFRESH MATERIALIZED VIEW missionary_monthly_stats;
  END IF;
  RETURN NEW;
END;
$function$
;

grant delete on table "public"."invoice_items" to "anon";

grant insert on table "public"."invoice_items" to "anon";

grant references on table "public"."invoice_items" to "anon";

grant select on table "public"."invoice_items" to "anon";

grant trigger on table "public"."invoice_items" to "anon";

grant truncate on table "public"."invoice_items" to "anon";

grant update on table "public"."invoice_items" to "anon";

grant delete on table "public"."invoice_items" to "authenticated";

grant insert on table "public"."invoice_items" to "authenticated";

grant references on table "public"."invoice_items" to "authenticated";

grant select on table "public"."invoice_items" to "authenticated";

grant trigger on table "public"."invoice_items" to "authenticated";

grant truncate on table "public"."invoice_items" to "authenticated";

grant update on table "public"."invoice_items" to "authenticated";

grant delete on table "public"."invoice_items" to "service_role";

grant insert on table "public"."invoice_items" to "service_role";

grant references on table "public"."invoice_items" to "service_role";

grant select on table "public"."invoice_items" to "service_role";

grant trigger on table "public"."invoice_items" to "service_role";

grant truncate on table "public"."invoice_items" to "service_role";

grant update on table "public"."invoice_items" to "service_role";

grant delete on table "public"."payment_transactions" to "anon";

grant insert on table "public"."payment_transactions" to "anon";

grant references on table "public"."payment_transactions" to "anon";

grant select on table "public"."payment_transactions" to "anon";

grant trigger on table "public"."payment_transactions" to "anon";

grant truncate on table "public"."payment_transactions" to "anon";

grant update on table "public"."payment_transactions" to "anon";

grant delete on table "public"."payment_transactions" to "authenticated";

grant insert on table "public"."payment_transactions" to "authenticated";

grant references on table "public"."payment_transactions" to "authenticated";

grant select on table "public"."payment_transactions" to "authenticated";

grant trigger on table "public"."payment_transactions" to "authenticated";

grant truncate on table "public"."payment_transactions" to "authenticated";

grant update on table "public"."payment_transactions" to "authenticated";

grant delete on table "public"."payment_transactions" to "service_role";

grant insert on table "public"."payment_transactions" to "service_role";

grant references on table "public"."payment_transactions" to "service_role";

grant select on table "public"."payment_transactions" to "service_role";

grant trigger on table "public"."payment_transactions" to "service_role";

grant truncate on table "public"."payment_transactions" to "service_role";

grant update on table "public"."payment_transactions" to "service_role";

grant delete on table "public"."system_settings" to "anon";

grant insert on table "public"."system_settings" to "anon";

grant references on table "public"."system_settings" to "anon";

grant select on table "public"."system_settings" to "anon";

grant trigger on table "public"."system_settings" to "anon";

grant truncate on table "public"."system_settings" to "anon";

grant update on table "public"."system_settings" to "anon";

grant delete on table "public"."system_settings" to "authenticated";

grant insert on table "public"."system_settings" to "authenticated";

grant references on table "public"."system_settings" to "authenticated";

grant select on table "public"."system_settings" to "authenticated";

grant trigger on table "public"."system_settings" to "authenticated";

grant truncate on table "public"."system_settings" to "authenticated";

grant update on table "public"."system_settings" to "authenticated";

grant delete on table "public"."system_settings" to "service_role";

grant insert on table "public"."system_settings" to "service_role";

grant references on table "public"."system_settings" to "service_role";

grant select on table "public"."system_settings" to "service_role";

grant trigger on table "public"."system_settings" to "service_role";

grant truncate on table "public"."system_settings" to "service_role";

grant update on table "public"."system_settings" to "service_role";

grant delete on table "public"."user_roles" to "anon";

grant insert on table "public"."user_roles" to "anon";

grant references on table "public"."user_roles" to "anon";

grant select on table "public"."user_roles" to "anon";

grant trigger on table "public"."user_roles" to "anon";

grant truncate on table "public"."user_roles" to "anon";

grant update on table "public"."user_roles" to "anon";

grant delete on table "public"."user_roles" to "authenticated";

grant insert on table "public"."user_roles" to "authenticated";

grant references on table "public"."user_roles" to "authenticated";

grant select on table "public"."user_roles" to "authenticated";

grant trigger on table "public"."user_roles" to "authenticated";

grant truncate on table "public"."user_roles" to "authenticated";

grant update on table "public"."user_roles" to "authenticated";

grant delete on table "public"."user_roles" to "service_role";

grant insert on table "public"."user_roles" to "service_role";

grant references on table "public"."user_roles" to "service_role";

grant select on table "public"."user_roles" to "service_role";

grant trigger on table "public"."user_roles" to "service_role";

grant truncate on table "public"."user_roles" to "service_role";

grant update on table "public"."user_roles" to "service_role";

grant delete on table "public"."webhook_logs" to "anon";

grant insert on table "public"."webhook_logs" to "anon";

grant references on table "public"."webhook_logs" to "anon";

grant select on table "public"."webhook_logs" to "anon";

grant trigger on table "public"."webhook_logs" to "anon";

grant truncate on table "public"."webhook_logs" to "anon";

grant update on table "public"."webhook_logs" to "anon";

grant delete on table "public"."webhook_logs" to "authenticated";

grant insert on table "public"."webhook_logs" to "authenticated";

grant references on table "public"."webhook_logs" to "authenticated";

grant select on table "public"."webhook_logs" to "authenticated";

grant trigger on table "public"."webhook_logs" to "authenticated";

grant truncate on table "public"."webhook_logs" to "authenticated";

grant update on table "public"."webhook_logs" to "authenticated";

grant delete on table "public"."webhook_logs" to "service_role";

grant insert on table "public"."webhook_logs" to "service_role";

grant references on table "public"."webhook_logs" to "service_role";

grant select on table "public"."webhook_logs" to "service_role";

grant trigger on table "public"."webhook_logs" to "service_role";

grant truncate on table "public"."webhook_logs" to "service_role";

grant update on table "public"."webhook_logs" to "service_role";

create policy "donor_donations_insert_policy"
on "public"."donor_donations"
as permissive
for insert
to public
with check (((recorded_by = auth.uid()) OR (missionary_id = auth.uid()) OR (EXISTS ( SELECT 1
   FROM profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['campus_director'::text, 'lead_pastor'::text, 'finance_officer'::text, 'superadmin'::text])))))));


create policy "donor_donations_select_policy"
on "public"."donor_donations"
as permissive
for select
to public
using (((missionary_id = auth.uid()) OR (recorded_by = auth.uid()) OR (EXISTS ( SELECT 1
   FROM profiles admin
  WHERE ((admin.id = auth.uid()) AND (admin.role = ANY (ARRAY['campus_director'::text, 'lead_pastor'::text])) AND (donor_donations.missionary_id IN ( SELECT profiles.id
           FROM profiles
          WHERE (profiles.local_church_id = admin.local_church_id)))))) OR (EXISTS ( SELECT 1
   FROM profiles admin2
  WHERE ((admin2.id = auth.uid()) AND (admin2.role = ANY (ARRAY['finance_officer'::text, 'superadmin'::text])))))));


create policy "donor_donations_xendit_update_policy"
on "public"."donor_donations"
as permissive
for update
to public
using (true)
with check (true);


create policy "donors_select_policy"
on "public"."donors"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM profiles p
  WHERE ((p.id = auth.uid()) AND ((p.role = ANY (ARRAY['finance_officer'::text, 'superadmin'::text])) OR ((p.role = 'missionary'::text) AND (EXISTS ( SELECT 1
           FROM donor_donations dd
          WHERE ((dd.donor_id = donors.id) AND (dd.missionary_id = p.id))))) OR ((p.role = ANY (ARRAY['campus_director'::text, 'lead_pastor'::text])) AND (EXISTS ( SELECT 1
           FROM (donor_donations dd
             JOIN profiles p2 ON ((p2.id = dd.missionary_id)))
          WHERE ((dd.donor_id = donors.id) AND (p2.local_church_id = p.local_church_id))))))))));


create policy "invoice_items_insert_policy"
on "public"."invoice_items"
as permissive
for insert
to public
with check (((EXISTS ( SELECT 1
   FROM payment_transactions
  WHERE (((payment_transactions.invoice_id)::text = (invoice_items.invoice_id)::text) AND (payment_transactions.created_by = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text])))))));


create policy "invoice_items_select_policy"
on "public"."invoice_items"
as permissive
for select
to public
using (((EXISTS ( SELECT 1
   FROM payment_transactions
  WHERE (((payment_transactions.invoice_id)::text = (invoice_items.invoice_id)::text) AND (payment_transactions.created_by = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM donor_donations
  WHERE ((donor_donations.id = invoice_items.donation_id) AND (donor_donations.missionary_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text, 'lead_pastor'::text])))))));


create policy "Lead pastors can view their church requests"
on "public"."leave_requests"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM (profiles pastor
     JOIN profiles missionary ON ((missionary.local_church_id = pastor.local_church_id)))
  WHERE ((pastor.id = auth.uid()) AND (pastor.role = 'lead_pastor'::text) AND (leave_requests.requester_id = missionary.id)))));


create policy "local_churches_select_policy"
on "public"."local_churches"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM profiles
  WHERE ((profiles.id = auth.uid()) AND ((profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text])) OR (profiles.local_church_id = local_churches.id))))));


create policy "payment_transactions_insert_policy"
on "public"."payment_transactions"
as permissive
for insert
to public
with check ((auth.uid() = created_by));


create policy "payment_transactions_select_policy"
on "public"."payment_transactions"
as permissive
for select
to public
using (((auth.uid() = created_by) OR (EXISTS ( SELECT 1
   FROM profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text, 'lead_pastor'::text])))))));


create policy "campus_director_view_church_profiles"
on "public"."profiles"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM user_roles ur
  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'campus_director'::text) AND (profiles.local_church_id = ur.local_church_id)))));


create policy "finance_officer_view_church_profiles"
on "public"."profiles"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM user_roles ur
  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'finance_officer'::text) AND (profiles.local_church_id = ur.local_church_id)))));


create policy "lead_pastor_view_church_profiles"
on "public"."profiles"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM user_roles ur
  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'lead_pastor'::text) AND (profiles.local_church_id = ur.local_church_id)))));


create policy "read_own_profile"
on "public"."profiles"
as permissive
for select
to public
using ((id = auth.uid()));


create policy "superadmin_access_profiles"
on "public"."profiles"
as permissive
for all
to public
using ((EXISTS ( SELECT 1
   FROM user_roles ur
  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'superadmin'::text)))));


create policy "approve_surplus_requests"
on "public"."surplus_requests"
as permissive
for update
to public
using ((EXISTS ( SELECT 1
   FROM profiles p
  WHERE ((p.id = auth.uid()) AND (((p.role = 'campus_director'::text) AND (EXISTS ( SELECT 1
           FROM profiles m
          WHERE ((m.id = surplus_requests.missionary_id) AND (m.local_church_id = p.local_church_id))))) OR ((p.role = 'lead_pastor'::text) AND (EXISTS ( SELECT 1
           FROM profiles m
          WHERE ((m.id = surplus_requests.missionary_id) AND (m.local_church_id = p.local_church_id))))) OR (p.role = 'superadmin'::text))))));


create policy "view_surplus_requests"
on "public"."surplus_requests"
as permissive
for select
to public
using (((missionary_id = auth.uid()) OR (EXISTS ( SELECT 1
   FROM profiles p
  WHERE ((p.id = auth.uid()) AND (((p.role = ANY (ARRAY['campus_director'::text, 'lead_pastor'::text])) AND (EXISTS ( SELECT 1
           FROM profiles m
          WHERE ((m.id = surplus_requests.missionary_id) AND (m.local_church_id = p.local_church_id))))) OR (p.role = 'superadmin'::text)))))));


create policy "Superadmin access only"
on "public"."system_settings"
as restrictive
for all
to public
using ((auth.uid() IN ( SELECT profiles.id
   FROM profiles
  WHERE (profiles.role = 'superadmin'::text))));


create policy "user_roles_select_policy"
on "public"."user_roles"
as permissive
for select
to public
using ((user_id = auth.uid()));


create policy "webhook_logs_insert_policy"
on "public"."webhook_logs"
as permissive
for insert
to public
with check (true);


create policy "webhook_logs_select_policy"
on "public"."webhook_logs"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'superadmin'::text)))));


CREATE TRIGGER payment_update_trigger AFTER UPDATE OF status ON public.payment_transactions FOR EACH ROW WHEN ((((new.status)::text = 'COMPLETED'::text) AND ((old.status)::text <> 'COMPLETED'::text))) EXECUTE FUNCTION refresh_donation_views();


