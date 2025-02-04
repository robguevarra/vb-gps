-- Insert Local Churches
INSERT INTO local_churches (id, name) VALUES
(1, 'Victory Malolos'),
(2, 'Victory Angat'),
(3, 'Victory Balagtas'),
(4, 'Victory Baliuag'),
(5, 'Victory San Rafael'),
(6, 'Victory San Miguel'),
(7, 'Victory Meycauayan'),
(8, 'Victory Marilao'),
(9, 'Victory Plaridel'),
(10, 'Victory Pulilan'),
(11, 'Victory Sta Maria');

-- Create Campus Directors
DO $$
DECLARE
    director_names TEXT[] := ARRAY[
        'Mar Loyd Quinto',
        'Paul Ryan Pasia', 
        'John Ian Susi',
        'Jhomar Carlo Salazar'
    ];
    director_id UUID;
    i INT;
    local_church_count INT := 11;
BEGIN
    FOREACH i IN ARRAY array[1,2,3,4] LOOP
        director_id := uuid_generate_v4();
        INSERT INTO auth.users (id, email) VALUES (director_id, lower(replace(director_names[i], ' ', '.')) || '@example.com');
        INSERT INTO profiles (id, full_name, role, local_church_id, monthly_goal) VALUES
        (director_id, director_names[i], 'campus_director', (FLOOR(RANDOM() * local_church_count) + 1), 0);
    END LOOP;
END $$;

-- Insert Missionaries with Campus Director assignments
DO $$
DECLARE
    missionary_names TEXT[] := ARRAY[
        'Dan Joash Bagadiong', 'Cielo Marie Angeles', 'Sarah Grace De Peralta', 'Dahlia Delos Reyes', 
        'Caroll Jane Perez', 'Ma. Jirah Joy Rivera', 'Emmanuel Victoria', 'Mary Florenz Krizza Anzures', 
        'A-J De Guzman', 'Ariane Lingat', 'Genriel Santiago', 'Desimae Vhiel Susi', 
        'Princess Blessie Ventic', 'Emily Dionisio', 'Ma. Bernadette Sheyne Mariano', 'Ronald Carlo Bechayda', 
        'Ben-joe Ryell Prada', 'Rose Ann Solo', 'Jemica Dela Cruz', 
        'Laira Santos', 'Christine Joy Velasco', 'Roberto Del Rosario Jr.', 'Michael Macale', 'Wendy Cainong', 
        'Diana Camaso', 'Christian Reyes', 'Mary Anne Mañosa'
    ];
    missionary_id UUID;
    local_church_count INT := 11;
    campus_directors UUID[];
BEGIN
    -- Get campus director IDs
    SELECT array_agg(id) INTO campus_directors FROM profiles WHERE role = 'campus_director';
    
    -- Insert missionaries
    FOR i IN 1..array_length(missionary_names, 1) LOOP
        missionary_id := uuid_generate_v4();
        INSERT INTO auth.users (id, email) VALUES (missionary_id, lower(replace(missionary_names[i], ' ', '.')) || '@example.com');
        INSERT INTO profiles (id, full_name, role, local_church_id, campus_director_id, monthly_goal) VALUES
        (
            missionary_id,
            missionary_names[i],
            'missionary',
            (FLOOR(RANDOM() * local_church_count) + 1),
            campus_directors[1 + floor(random() * array_length(campus_directors, 1))],
            (RANDOM() * 30000 + 20000)::NUMERIC(10,2)
        );
    END LOOP;
END $$;

-- Insert Donors
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..600 LOOP
        INSERT INTO donors (name, email, phone) VALUES
        ('Donor ' || i, 'donor' || i || '@example.com', '09' || i || '1234567');
    END LOOP;
END $$;

-- Insert Donations
DO $$
DECLARE
    donor_id INT;
    missionary_id UUID;
    donation_date DATE;
    amount NUMERIC(10,2);
BEGIN
    FOR donor_id IN 1..600 LOOP
        SELECT id INTO missionary_id FROM profiles ORDER BY RANDOM() LIMIT 1;
        FOR donation_date IN (SELECT generate_series('2023-01-01'::date, '2023-03-01'::date, '1 month'::interval)) LOOP
            amount := (RANDOM() * 5000 + 1000)::NUMERIC(10,2);
            INSERT INTO donor_donations (donor_id, missionary_id, amount, date, source, status) VALUES
            (donor_id, missionary_id, amount, donation_date, 'online', 'completed');
        END LOOP;
    END LOOP;
END $$;

DO $$
DECLARE
    missionary_id UUID;
    start_date DATE;
    end_date DATE;
    reason TEXT;
    status TEXT;
BEGIN
    FOR missionary_id IN (SELECT id FROM profiles WHERE role = 'missionary') LOOP
        FOR i IN 1..5 LOOP  -- Generate 5 leave requests per missionary
            start_date := (CURRENT_DATE + (RANDOM() * 30)::INT)::DATE;
            end_date := start_date + (RANDOM() * 10)::INT;
            reason := 'Leave for personal reasons';
            status := CASE WHEN RANDOM() < 0.5 THEN 'approved' ELSE 'pending' END;

            INSERT INTO leave_requests (requester_id, start_date, end_date, reason, status, campus_director_approval, lead_pastor_approval)
            VALUES (missionary_id, start_date, end_date, reason, status, 'none', 'none');
        END LOOP;
    END LOOP;
END $$;

-- Generate Random Surplus Requests
DO $$
DECLARE
    missionary_id UUID;
    amount_requested NUMERIC(10,2);
    reason TEXT;
    status TEXT;
BEGIN
    FOR missionary_id IN (SELECT id FROM profiles WHERE role = 'missionary') LOOP
        FOR i IN 1..5 LOOP  -- Generate 5 surplus requests per missionary
            amount_requested := (RANDOM() * 5000 + 1000)::NUMERIC(10,2);
            reason := 'Request for surplus funds';
            status := CASE WHEN RANDOM() < 0.5 THEN 'approved' ELSE 'pending' END;

            INSERT INTO surplus_requests (missionary_id, amount_requested, reason, status, campus_director_approval, lead_pastor_approval)
            VALUES (missionary_id, amount_requested, reason, status, 'none', 'none');
        END LOOP;
    END LOOP;
END $$;