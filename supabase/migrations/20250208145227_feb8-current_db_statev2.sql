DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'donor_donations' 
        AND column_name = 'notes'
    ) THEN
        ALTER TABLE "public"."donor_donations" ADD COLUMN "notes" text;
    END IF;
END $$;


