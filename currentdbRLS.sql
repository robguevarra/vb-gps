[
  {
    "schema_name": "public",
    "table_name": "donor_donations",
    "policy_name": "donor_donations_xendit_update_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "UPDATE",
    "filter_condition": "true",
    "check_condition": "true"
  },
  {
    "schema_name": "public",
    "table_name": "invoice_items",
    "policy_name": "invoice_items_insert_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "INSERT",
    "filter_condition": null,
    "check_condition": "((EXISTS ( SELECT 1\n   FROM payment_transactions\n  WHERE (((payment_transactions.invoice_id)::text = (invoice_items.invoice_id)::text) AND (payment_transactions.created_by = auth.uid())))) OR (EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text]))))))"
  },
  {
    "schema_name": "public",
    "table_name": "invoice_items",
    "policy_name": "invoice_items_select_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "((EXISTS ( SELECT 1\n   FROM payment_transactions\n  WHERE (((payment_transactions.invoice_id)::text = (invoice_items.invoice_id)::text) AND (payment_transactions.created_by = auth.uid())))) OR (EXISTS ( SELECT 1\n   FROM donor_donations\n  WHERE ((donor_donations.id = invoice_items.donation_id) AND (donor_donations.missionary_id = auth.uid())))) OR (EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text, 'lead_pastor'::text]))))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "payment_transactions",
    "policy_name": "payment_transactions_insert_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "INSERT",
    "filter_condition": null,
    "check_condition": "(auth.uid() = created_by)"
  },
  {
    "schema_name": "public",
    "table_name": "payment_transactions",
    "policy_name": "payment_transactions_select_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "((auth.uid() = created_by) OR (EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text, 'lead_pastor'::text]))))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "webhook_logs",
    "policy_name": "webhook_logs_insert_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "INSERT",
    "filter_condition": null,
    "check_condition": "true"
  },
  {
    "schema_name": "public",
    "table_name": "webhook_logs",
    "policy_name": "webhook_logs_select_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'superadmin'::text))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "system_settings",
    "policy_name": "Superadmin access only",
    "is_permissive": "RESTRICTIVE",
    "roles": "{public}",
    "command": "ALL",
    "filter_condition": "(auth.uid() IN ( SELECT profiles.id\n   FROM profiles\n  WHERE (profiles.role = 'superadmin'::text)))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "profiles",
    "policy_name": "campus_director_view_church_profiles",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM user_roles ur\n  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'campus_director'::text) AND (profiles.local_church_id = ur.local_church_id))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "donor_donations",
    "policy_name": "donor_donations_insert_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "INSERT",
    "filter_condition": null,
    "check_condition": "((recorded_by = auth.uid()) OR (missionary_id = auth.uid()) OR (EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['campus_director'::text, 'lead_pastor'::text, 'finance_officer'::text, 'superadmin'::text]))))))"
  },
  {
    "schema_name": "public",
    "table_name": "donor_donations",
    "policy_name": "donor_donations_select_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "((missionary_id = auth.uid()) OR (recorded_by = auth.uid()) OR (EXISTS ( SELECT 1\n   FROM profiles admin\n  WHERE ((admin.id = auth.uid()) AND (admin.role = ANY (ARRAY['campus_director'::text, 'lead_pastor'::text])) AND (donor_donations.missionary_id IN ( SELECT profiles.id\n           FROM profiles\n          WHERE (profiles.local_church_id = admin.local_church_id)))))) OR (EXISTS ( SELECT 1\n   FROM profiles admin2\n  WHERE ((admin2.id = auth.uid()) AND (admin2.role = ANY (ARRAY['finance_officer'::text, 'superadmin'::text]))))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "donors",
    "policy_name": "donors_select_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM profiles p\n  WHERE ((p.id = auth.uid()) AND ((p.role = ANY (ARRAY['finance_officer'::text, 'superadmin'::text])) OR ((p.role = 'missionary'::text) AND (EXISTS ( SELECT 1\n           FROM donor_donations dd\n          WHERE ((dd.donor_id = donors.id) AND (dd.missionary_id = p.id))))) OR ((p.role = ANY (ARRAY['campus_director'::text, 'lead_pastor'::text])) AND (EXISTS ( SELECT 1\n           FROM (donor_donations dd\n             JOIN profiles p2 ON ((p2.id = dd.missionary_id)))\n          WHERE ((dd.donor_id = donors.id) AND (p2.local_church_id = p.local_church_id)))))))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "profiles",
    "policy_name": "finance_officer_view_church_profiles",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM user_roles ur\n  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'finance_officer'::text) AND (profiles.local_church_id = ur.local_church_id))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "leave_requests",
    "policy_name": "insert_own_leave_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "INSERT",
    "filter_condition": null,
    "check_condition": "((requester_id = auth.uid()) OR (( SELECT profiles.role\n   FROM profiles\n  WHERE (profiles.id = auth.uid())) = 'superadmin'::text))"
  },
  {
    "schema_name": "public",
    "table_name": "surplus_requests",
    "policy_name": "insert_own_surplus_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "INSERT",
    "filter_condition": null,
    "check_condition": "(missionary_id = auth.uid())"
  },
  {
    "schema_name": "public",
    "table_name": "profiles",
    "policy_name": "lead_pastor_view_church_profiles",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM user_roles ur\n  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'lead_pastor'::text) AND (profiles.local_church_id = ur.local_church_id))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "local_churches",
    "policy_name": "local_churches_select_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND ((profiles.role = ANY (ARRAY['superadmin'::text, 'finance_officer'::text])) OR (profiles.local_church_id = local_churches.id)))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "profiles",
    "policy_name": "read_own_profile",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(id = auth.uid())",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "profiles",
    "policy_name": "superadmin_access_profiles",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "ALL",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM user_roles ur\n  WHERE ((ur.user_id = auth.uid()) AND (ur.role = 'superadmin'::text))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "user_roles",
    "policy_name": "user_roles_select_policy",
    "is_permissive": "PERMISSIVE",
    "roles": "{public}",
    "command": "SELECT",
    "filter_condition": "(user_id = auth.uid())",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "leave_requests",
    "policy_name": "view_own_leave_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "SELECT",
    "filter_condition": "(requester_id = auth.uid())",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "leave_requests",
    "policy_name": "campus_director_view_church_leave_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM (profiles cd\n     JOIN profiles missionary ON ((missionary.local_church_id = cd.local_church_id)))\n  WHERE ((cd.id = auth.uid()) AND (cd.role = ('campus_director'::text || 'lead_pastor'::text)) AND (leave_requests.requester_id = missionary.id))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "leave_requests",
    "policy_name": "campus_director_approve_leave_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "UPDATE",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM (profiles cd\n     JOIN profiles missionary ON ((missionary.local_church_id = cd.local_church_id)))\n  WHERE ((cd.id = auth.uid()) AND (cd.role = 'campus_director'::text) AND (leave_requests.requester_id = missionary.id))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "surplus_requests",
    "policy_name": "view_own_surplus_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "SELECT",
    "filter_condition": "(missionary_id = auth.uid())",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "surplus_requests",
    "policy_name": "campus_director_view_church_surplus_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "SELECT",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM (profiles cd\n     JOIN profiles missionary ON ((missionary.local_church_id = cd.local_church_id)))\n  WHERE ((cd.id = auth.uid()) AND (cd.role = 'campus_director'::text) AND (surplus_requests.missionary_id = missionary.id))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "surplus_requests",
    "policy_name": "campus_director_approve_surplus_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "UPDATE",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM (profiles cd\n     JOIN profiles missionary ON ((missionary.local_church_id = cd.local_church_id)))\n  WHERE ((cd.id = auth.uid()) AND (cd.role = 'campus_director'::text) AND (surplus_requests.missionary_id = missionary.id))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "leave_requests",
    "policy_name": "superadmin_access_leave_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "ALL",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'superadmin'::text))))",
    "check_condition": null
  },
  {
    "schema_name": "public",
    "table_name": "surplus_requests",
    "policy_name": "superadmin_access_surplus_requests",
    "is_permissive": "PERMISSIVE",
    "roles": "{authenticated}",
    "command": "ALL",
    "filter_condition": "(EXISTS ( SELECT 1\n   FROM profiles\n  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'superadmin'::text))))",
    "check_condition": null
  }
]