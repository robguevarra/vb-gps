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

-- Insert Mock Users
DO $$
DECLARE
    missionary_name TEXT;
    missionary_id UUID;
    local_church_count INT := 11; -- Number of local churches
BEGIN
    FOR missionary_name IN 
        SELECT unnest(ARRAY[
            'Dan Joash Bagadiong', 'Cielo Marie Angeles', 'Sarah Grace De Peralta', 'Dahlia Delos Reyes', 
            'Caroll Jane Perez', 'Ma. Jirah Joy Rivera', 'Emmanuel Victoria', 'Mary Florenz Krizza Anzures', 
            'A-J De Guzman', 'Ariane Lingat', 'Genriel Santiago', 'Desimae Vhiel Susi', 'John Ian Susi', 
            'Princess Blessie Ventic', 'Emily Dionisio', 'Ma. Bernadette Sheyne Mariano', 'Ronald Carlo Bechayda', 
            'Ben-joe Ryell Prada', 'Mar Loyd Quinto', 'Rose Ann Solo', 'Jemica Dela Cruz', 'Paul Ryan Pasia', 
            'Laira Santos', 'Christine Joy Velasco', 'Roberto Del Rosario Jr.', 'Michael Macale', 'Wendy Cainong', 
            'Diana Camaso', 'Christian Reyes', 'Mary Anne Mañosa', 'Jhomar Carlo Salazar'
        ]) LOOP
        missionary_id := uuid_generate_v4();
        INSERT INTO auth.users (id, email) VALUES (missionary_id, missionary_name || '@example.com');
        INSERT INTO profiles (id, full_name, role, local_church_id, monthly_goal) VALUES
        (missionary_id, missionary_name, 'missionary', (FLOOR(RANDOM() * local_church_count) + 1), (RANDOM() * 30000 + 20000)::NUMERIC(10,2));
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