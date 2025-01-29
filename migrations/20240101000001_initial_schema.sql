-- Create tables
CREATE TABLE local_churches (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  district_id BIGINT,
  lead_pastor_id UUID
);

CREATE TABLE districts (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  province_id BIGINT
);

CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  full_name TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('missionary', 'campus_director', 'lead_pastor', 'finance_officer', 'superadmin')),
  local_church_id BIGINT NOT NULL REFERENCES local_churches(id),
  campus_director_id UUID REFERENCES profiles(id),
  monthly_goal NUMERIC(10,2) DEFAULT 0,
  surplus_balance NUMERIC(10,2) DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE donations (
  id BIGSERIAL PRIMARY KEY,
  missionary_id UUID NOT NULL REFERENCES profiles(id),
  donor_name TEXT,
  amount NUMERIC(10,2) NOT NULL,
  date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  source TEXT NOT NULL CHECK (source IN ('online', 'offline')),
  status TEXT NOT NULL CHECK (status IN ('completed', 'refunded', 'failed')),
  created_by UUID REFERENCES profiles(id)
);

CREATE TABLE surplus_requests (
  id BIGSERIAL PRIMARY KEY,
  missionary_id UUID NOT NULL REFERENCES profiles(id),
  amount_requested NUMERIC(10,2) NOT NULL,
  reason TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('pending', 'approved', 'rejected')),
  campus_director_approval TEXT NOT NULL CHECK (campus_director_approval IN ('none', 'approved', 'rejected')) DEFAULT 'none',
  lead_pastor_approval TEXT NOT NULL CHECK (lead_pastor_approval IN ('none', 'approved', 'rejected', 'override')) DEFAULT 'none',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add foreign key constraints
ALTER TABLE profiles
ADD CONSTRAINT fk_local_church
FOREIGN KEY (local_church_id)
REFERENCES local_churches(id);

ALTER TABLE donations
ADD CONSTRAINT fk_missionary
FOREIGN KEY (missionary_id)
REFERENCES profiles(id);

-- Add indexes and security policies as needed
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE donations ENABLE ROW LEVEL SECURITY; 