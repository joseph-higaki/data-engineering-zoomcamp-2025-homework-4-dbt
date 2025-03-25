\c dtc_zoomcamp_2025_nyc_tripdata

-- Truncate all external tables
TRUNCATE ext_green_tripdata, ext_yellow_tripdata, ext_fhv_tripdata;

DO $$ 
DECLARE 
    month INTEGER;
    year INTEGER;
    trip_type TEXT;
    table_name TEXT;
    file_path TEXT;
BEGIN 
    -- Loop through trip types (green, yellow, fhv)
    FOR trip_type IN (SELECT unnest(ARRAY['green', 'yellow', 'fhv'])) LOOP
        -- Construct the table name dynamically
        table_name := 'ext_' || trip_type || '_tripdata';

        -- Loop through years (2019 to 2020)
        FOR year IN 2019..2020 LOOP
            -- Loop through months (1 to 12)
            FOR month IN 1..12 LOOP
                -- Construct the file path dynamically
                file_path := format('/var/lib/postgresql/.init_data/%s_tripdata_%s-%s.csv', trip_type, year, to_char(month, 'FM00'));

                -- Attempt to copy data into the table
                BEGIN
                    EXECUTE format('COPY %I FROM %L WITH (FORMAT csv, HEADER true);', table_name, file_path);
                    RAISE NOTICE 'Successfully loaded file: %', file_path;
                EXCEPTION
                    -- Handle missing files gracefully
                    WHEN OTHERS THEN
                        RAISE NOTICE 'File for %-%-% does not exist, skipping...', trip_type, year, to_char(month, 'FM00');
                END;
            END LOOP;
        END LOOP;
    END LOOP;
END $$;