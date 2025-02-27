[
  {
    "table_name": "districts",
    "column_name": "id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": "nextval('districts_id_seq'::regclass)"
  },
  {
    "table_name": "districts",
    "column_name": "name",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "districts",
    "column_name": "province_id",
    "data_type": "bigint",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": "nextval('donor_donations_id_seq'::regclass)"
  },
  {
    "table_name": "donor_donations",
    "column_name": "donor_id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "missionary_id",
    "data_type": "uuid",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "amount",
    "data_type": "numeric",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "date",
    "data_type": "timestamp with time zone",
    "is_nullable": "NO",
    "column_default": "now()"
  },
  {
    "table_name": "donor_donations",
    "column_name": "source",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "status",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "notes",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "recorded_by",
    "data_type": "uuid",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "payment_id",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "payment_status",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "payment_method",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "payment_channel",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "payment_details",
    "data_type": "jsonb",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "invoice_id",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "invoice_url",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "fee_amount",
    "data_type": "numeric",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donor_donations",
    "column_name": "payment_date",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donors",
    "column_name": "id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": "nextval('donors_id_seq'::regclass)"
  },
  {
    "table_name": "donors",
    "column_name": "name",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "donors",
    "column_name": "email",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donors",
    "column_name": "phone",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "donors",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "invoice_items",
    "column_name": "id",
    "data_type": "uuid",
    "is_nullable": "NO",
    "column_default": "gen_random_uuid()"
  },
  {
    "table_name": "invoice_items",
    "column_name": "invoice_id",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "invoice_items",
    "column_name": "donation_id",
    "data_type": "bigint",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "invoice_items",
    "column_name": "amount",
    "data_type": "numeric",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "invoice_items",
    "column_name": "missionary_id",
    "data_type": "uuid",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "invoice_items",
    "column_name": "donor_id",
    "data_type": "bigint",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "invoice_items",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "leave_requests",
    "column_name": "id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": "nextval('leave_requests_id_seq'::regclass)"
  },
  {
    "table_name": "leave_requests",
    "column_name": "requester_id",
    "data_type": "uuid",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "leave_requests",
    "column_name": "start_date",
    "data_type": "date",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "leave_requests",
    "column_name": "end_date",
    "data_type": "date",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "leave_requests",
    "column_name": "reason",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "leave_requests",
    "column_name": "status",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "leave_requests",
    "column_name": "campus_director_approval",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": "'none'::text"
  },
  {
    "table_name": "leave_requests",
    "column_name": "lead_pastor_approval",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": "'none'::text"
  },
  {
    "table_name": "leave_requests",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "leave_requests",
    "column_name": "updated_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "leave_requests",
    "column_name": "type",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": "'sick'::text"
  },
  {
    "table_name": "leave_requests",
    "column_name": "campus_director_notes",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "leave_requests",
    "column_name": "lead_pastor_notes",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "local_churches",
    "column_name": "id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": "nextval('local_churches_id_seq'::regclass)"
  },
  {
    "table_name": "local_churches",
    "column_name": "name",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "local_churches",
    "column_name": "district_id",
    "data_type": "bigint",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "local_churches",
    "column_name": "lead_pastor_id",
    "data_type": "uuid",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "monthly_donation_totals",
    "column_name": "missionary_id",
    "data_type": "uuid",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "monthly_donation_totals",
    "column_name": "month",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "monthly_donation_totals",
    "column_name": "total_amount",
    "data_type": "numeric",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "monthly_donation_totals",
    "column_name": "unique_donors",
    "data_type": "bigint",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "id",
    "data_type": "uuid",
    "is_nullable": "NO",
    "column_default": "gen_random_uuid()"
  },
  {
    "table_name": "payment_transactions",
    "column_name": "reference_id",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "invoice_id",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "invoice_url",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "status",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "amount",
    "data_type": "numeric",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "fee_amount",
    "data_type": "numeric",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "currency",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": "'PHP'::character varying"
  },
  {
    "table_name": "payment_transactions",
    "column_name": "payment_method",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "payment_channel",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "payment_details",
    "data_type": "jsonb",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "payer_email",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "payer_name",
    "data_type": "character varying",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "created_by",
    "data_type": "uuid",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "payment_transactions",
    "column_name": "updated_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "payment_transactions",
    "column_name": "expires_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "payment_transactions",
    "column_name": "paid_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "profiles",
    "column_name": "id",
    "data_type": "uuid",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "profiles",
    "column_name": "full_name",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "profiles",
    "column_name": "role",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "profiles",
    "column_name": "local_church_id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "profiles",
    "column_name": "campus_director_id",
    "data_type": "uuid",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "profiles",
    "column_name": "monthly_goal",
    "data_type": "numeric",
    "is_nullable": "YES",
    "column_default": "0"
  },
  {
    "table_name": "profiles",
    "column_name": "surplus_balance",
    "data_type": "numeric",
    "is_nullable": "YES",
    "column_default": "0"
  },
  {
    "table_name": "profiles",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "profiles",
    "column_name": "updated_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "surplus_requests",
    "column_name": "id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": "nextval('surplus_requests_id_seq'::regclass)"
  },
  {
    "table_name": "surplus_requests",
    "column_name": "missionary_id",
    "data_type": "uuid",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "surplus_requests",
    "column_name": "amount_requested",
    "data_type": "numeric",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "surplus_requests",
    "column_name": "reason",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "surplus_requests",
    "column_name": "status",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "surplus_requests",
    "column_name": "campus_director_approval",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": "'none'::text"
  },
  {
    "table_name": "surplus_requests",
    "column_name": "lead_pastor_approval",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": "'none'::text"
  },
  {
    "table_name": "surplus_requests",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "surplus_requests",
    "column_name": "updated_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "surplus_requests",
    "column_name": "campus_director_notes",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "surplus_requests",
    "column_name": "lead_pastor_notes",
    "data_type": "text",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "system_settings",
    "column_name": "id",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": "'global'::text"
  },
  {
    "table_name": "system_settings",
    "column_name": "surplus_allocation_percent",
    "data_type": "numeric",
    "is_nullable": "NO",
    "column_default": "10.00"
  },
  {
    "table_name": "system_settings",
    "column_name": "default_monthly_goal",
    "data_type": "numeric",
    "is_nullable": "NO",
    "column_default": "10000.00"
  },
  {
    "table_name": "system_settings",
    "column_name": "leave_policies",
    "data_type": "jsonb",
    "is_nullable": "NO",
    "column_default": "'{\"max_leave_days\": 15, \"approval_required\": true}'::jsonb"
  },
  {
    "table_name": "system_settings",
    "column_name": "updated_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "timezone('utc'::text, now())"
  },
  {
    "table_name": "user_roles",
    "column_name": "user_id",
    "data_type": "uuid",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "user_roles",
    "column_name": "role",
    "data_type": "text",
    "is_nullable": "NO",
    "column_default": null
  },
  {
    "table_name": "user_roles",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  },
  {
    "table_name": "user_roles",
    "column_name": "local_church_id",
    "data_type": "bigint",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "webhook_logs",
    "column_name": "id",
    "data_type": "bigint",
    "is_nullable": "NO",
    "column_default": "nextval('webhook_logs_id_seq'::regclass)"
  },
  {
    "table_name": "webhook_logs",
    "column_name": "payload",
    "data_type": "jsonb",
    "is_nullable": "YES",
    "column_default": null
  },
  {
    "table_name": "webhook_logs",
    "column_name": "created_at",
    "data_type": "timestamp with time zone",
    "is_nullable": "YES",
    "column_default": "now()"
  }
]