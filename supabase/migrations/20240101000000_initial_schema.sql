CREATE TYPE request_status AS ENUM ('pending', 'approved', 'rejected');
CREATE TYPE approval_status AS ENUM ('none', 'approved', 'rejected', 'override');
CREATE TYPE user_role AS ENUM ('missionary', 'finance_officer', 'campus_director', 'lead_pastor', 'superadmin');

CREATE TABLE local_churches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  role user_role NOT NULL,
  monthly_goal NUMERIC DEFAULT 0,
  surplus_balance NUMERIC DEFAULT 0,
  local_church_id UUID REFERENCES local_churches ON DELETE SET NULL,
  campus_director_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE donations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  amount NUMERIC NOT NULL,
  date DATE NOT NULL,
  missionary_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  donor_name TEXT,
  source TEXT,
  status request_status DEFAULT 'pending',
  local_church_id UUID REFERENCES local_churches ON DELETE CASCADE,
  created_by UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE surplus_requests (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  amount_requested NUMERIC NOT NULL,
  reason TEXT NOT NULL,
  status request_status DEFAULT 'pending',
  missionary_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  campus_director_approval approval_status DEFAULT 'none',
  lead_pastor_approval approval_status DEFAULT 'none',
  local_church_id UUID REFERENCES local_churches ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE leave_requests (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  reason TEXT NOT NULL,
  status request_status DEFAULT 'pending',
  requester_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  campus_director_approval approval_status DEFAULT 'none',
  lead_pastor_approval approval_status DEFAULT 'none',
  local_church_id UUID REFERENCES local_churches ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE donations
ALTER COLUMN missionary_id SET NOT NULL;

CREATE INDEX idx_donations_date ON donations(date); 