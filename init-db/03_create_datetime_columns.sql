-- For ext_green_tripdata
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_green_tripdata' AND column_name = 'lpep_pickup_datetime_text') THEN
        ALTER TABLE ext_green_tripdata RENAME COLUMN lpep_pickup_datetime TO lpep_pickup_datetime_text;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_green_tripdata' AND column_name = 'lpep_pickup_datetime') THEN
        ALTER TABLE ext_green_tripdata ADD COLUMN lpep_pickup_datetime TIMESTAMP;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_green_tripdata' AND column_name = 'lpep_pickup_date') THEN
        ALTER TABLE ext_green_tripdata ADD COLUMN lpep_pickup_date DATE;
    END IF;
END $$;

DROP INDEX IF EXISTS idx_green_pickup_datetime;
DROP INDEX IF EXISTS idx_green_pickup_date;

UPDATE ext_green_tripdata
    SET lpep_pickup_datetime = lpep_pickup_datetime_text::TIMESTAMP,
        lpep_pickup_date = lpep_pickup_datetime_text::DATE;


CREATE INDEX idx_green_pickup_datetime ON ext_green_tripdata (lpep_pickup_datetime);
CREATE INDEX idx_green_pickup_date ON ext_green_tripdata (lpep_pickup_date);

-- Index on vendorid
CREATE INDEX IF NOT EXISTS idx_green_vendorid ON ext_green_tripdata (vendorid);

-- Composite index on (vendorid, lpep_pickup_datetime)
CREATE INDEX IF NOT EXISTS idx_green_vendor_pickup ON ext_green_tripdata (vendorid, lpep_pickup_datetime);

-- For ext_yellow_tripdata
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_yellow_tripdata' AND column_name = 'tpep_pickup_datetime_text') THEN
        ALTER TABLE ext_yellow_tripdata RENAME COLUMN tpep_pickup_datetime TO tpep_pickup_datetime_text;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_yellow_tripdata' AND column_name = 'tpep_pickup_datetime') THEN
        ALTER TABLE ext_yellow_tripdata ADD COLUMN tpep_pickup_datetime TIMESTAMP;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_yellow_tripdata' AND column_name = 'tpep_pickup_date') THEN
        ALTER TABLE ext_yellow_tripdata ADD COLUMN tpep_pickup_date DATE;
    END IF;
END $$;

DROP INDEX IF EXISTS idx_yellow_pickup_datetime;
DROP INDEX IF EXISTS idx_yellow_pickup_date;

UPDATE ext_yellow_tripdata
    SET tpep_pickup_datetime = tpep_pickup_datetime_text::TIMESTAMP,
        tpep_pickup_date = tpep_pickup_datetime_text::DATE;


CREATE INDEX idx_yellow_pickup_datetime ON ext_yellow_tripdata (tpep_pickup_datetime);
CREATE INDEX idx_yellow_pickup_date ON ext_yellow_tripdata (tpep_pickup_date);


-- Index on vendorid
CREATE INDEX IF NOT EXISTS idx_yellow_vendorid ON ext_yellow_tripdata (vendorid);
-- Composite index on (vendorid, tpep_pickup_datetime)
CREATE INDEX IF NOT EXISTS idx_yellow_vendor_pickup ON ext_yellow_tripdata (vendorid, tpep_pickup_datetime);

-

-- For ext_fhv_tripdata
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_fhv_tripdata' AND column_name = 'pickup_datetime_text') THEN
        ALTER TABLE ext_fhv_tripdata RENAME COLUMN pickup_datetime TO pickup_datetime_text;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_fhv_tripdata' AND column_name = 'pickup_datetime') THEN
        ALTER TABLE ext_fhv_tripdata ADD COLUMN pickup_datetime TIMESTAMP;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'ext_fhv_tripdata' AND column_name = 'pickup_date') THEN
        ALTER TABLE ext_fhv_tripdata ADD COLUMN pickup_date DATE;
    END IF;
END $$;

DROP INDEX IF EXISTS idx_fhv_pickup_datetime;
DROP INDEX IF EXISTS idx_fhv_pickup_date;

UPDATE ext_fhv_tripdata
    SET pickup_datetime = pickup_datetime_text::TIMESTAMP,
        pickup_date = pickup_datetime_text::DATE;

CREATE INDEX idx_fhv_pickup_datetime ON ext_fhv_tripdata (pickup_datetime);
CREATE INDEX idx_fhv_pickup_date ON ext_fhv_tripdata (pickup_date);