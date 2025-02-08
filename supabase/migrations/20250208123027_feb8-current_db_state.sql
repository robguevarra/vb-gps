drop policy "select_own_donations" on "public"."donations";

drop policy "insert_leave_requests" on "public"."leave_requests";

drop policy "insert_surplus_requests" on "public"."surplus_requests";

drop policy "select_surplus_requests" on "public"."surplus_requests";

drop policy "select_own_profile" on "public"."profiles";

revoke delete on table "public"."donations" from "anon";

revoke insert on table "public"."donations" from "anon";

revoke references on table "public"."donations" from "anon";

revoke select on table "public"."donations" from "anon";

revoke trigger on table "public"."donations" from "anon";

revoke truncate on table "public"."donations" from "anon";

revoke update on table "public"."donations" from "anon";

revoke delete on table "public"."donations" from "authenticated";

revoke insert on table "public"."donations" from "authenticated";

revoke references on table "public"."donations" from "authenticated";

revoke select on table "public"."donations" from "authenticated";

revoke trigger on table "public"."donations" from "authenticated";

revoke truncate on table "public"."donations" from "authenticated";

revoke update on table "public"."donations" from "authenticated";

revoke delete on table "public"."donations" from "service_role";

revoke insert on table "public"."donations" from "service_role";

revoke references on table "public"."donations" from "service_role";

revoke select on table "public"."donations" from "service_role";

revoke trigger on table "public"."donations" from "service_role";

revoke truncate on table "public"."donations" from "service_role";

revoke update on table "public"."donations" from "service_role";

alter table "public"."donations" drop constraint "donations_created_by_fkey";

alter table "public"."donations" drop constraint "donations_missionary_id_fkey";

alter table "public"."donations" drop constraint "donations_source_check";

alter table "public"."donations" drop constraint "donations_status_check";

alter table "public"."donations" drop constraint "fk_missionary";

alter table "public"."leave_requests" drop constraint "leave_requests_lead_pastor_approval_check";

alter table "public"."surplus_requests" drop constraint "surplus_requests_lead_pastor_approval_check";

alter table "public"."donations" drop constraint "donations_pkey";

drop index if exists "public"."donations_pkey";

drop index if exists "public"."idx_missionary_id";

drop table "public"."donations";

alter table "public"."leave_requests" add column "lead_pastor_notes" text;

alter table "public"."leave_requests" disable row level security;

alter table "public"."surplus_requests" add column "lead_pastor_notes" text;

drop sequence if exists "public"."donations_id_seq";

alter table "public"."leave_requests" add constraint "leave_requests_lead_pastor_approval_check" CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) not valid;

alter table "public"."leave_requests" validate constraint "leave_requests_lead_pastor_approval_check";

alter table "public"."surplus_requests" add constraint "surplus_requests_lead_pastor_approval_check" CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) not valid;

alter table "public"."surplus_requests" validate constraint "surplus_requests_lead_pastor_approval_check";

create policy "insert_own_leave_requests"
on "public"."leave_requests"
as permissive
for insert
to public
with check (((requester_id = auth.uid()) OR (( SELECT profiles.role
   FROM profiles
  WHERE (profiles.id = auth.uid())) = 'superadmin'::text)));


create policy "Enable read access for all users"
on "public"."profiles"
as permissive
for select
to public
using (((id = auth.uid()) OR (auth.email() = 'robneil@gmail.com'::text)));


create policy "insert_own_surplus_requests"
on "public"."surplus_requests"
as permissive
for insert
to public
with check ((missionary_id = auth.uid()));


create policy "select_own_surplus_requests"
on "public"."surplus_requests"
as permissive
for select
to public
using ((missionary_id = auth.uid()));


create policy "select_own_profile"
on "public"."profiles"
as permissive
for select
to public
using (((id = auth.uid()) OR (auth.uid() = 'aebdeee3-427f-4d5b-832d-8c4ebaecdddc'::uuid)));



