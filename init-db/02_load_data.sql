
\c dtc_zoomcamp_2025_nyc_tripdata

TRUNCATE ext_green_tripdata;

DO $$ 
DECLARE 
    month INTEGER;
    year INTEGER;
BEGIN 
    FOR year IN 2019..2020 LOOP
        FOR month IN 1..12 LOOP
            BEGIN
                EXECUTE format('COPY ext_green_tripdata FROM ''/var/lib/postgresql/.init_data/green_tripdata_%s-%s.csv'' WITH (FORMAT csv, HEADER true);', year, to_char(month, 'FM00'));
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE NOTICE 'File for %-% does not exist, skipping...', year, to_char(month, 'FM00');
            END;
        END LOOP;
    END LOOP;
END $$;