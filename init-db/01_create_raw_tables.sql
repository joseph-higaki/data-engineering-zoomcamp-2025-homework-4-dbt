/*
Parametrize database name
Parametrize schema
*/
\c dtc_zoomcamp_2025_nyc_tripdata

CREATE TABLE ext_green_tripdata (
    VendorID TEXT,
    lpep_pickup_datetime TEXT,
    lpep_dropoff_datetime TEXT,
    store_and_fwd_flag TEXT,
    RatecodeID TEXT,
    PULocationID TEXT,
    DOLocationID TEXT,
    passenger_count TEXT,
    trip_distance TEXT,
    fare_amount TEXT,
    extra TEXT,
    mta_tax TEXT,
    tip_amount TEXT,
    tolls_amount TEXT,
    ehail_fee TEXT,
    improvement_surcharge TEXT,
    total_amount TEXT,
    payment_type TEXT,
    trip_type TEXT,
    congestion_surcharge TEXT
);

CREATE TABLE ext_yellow_tripdata (
    VendorID TEXT,
    tpep_pickup_datetime TEXT,
    tpep_dropoff_datetime TEXT,
    passenger_count TEXT,
    trip_distance TEXT,
    RatecodeID TEXT,
    store_and_fwd_flag TEXT,
    PULocationID TEXT,
    DOLocationID TEXT,
    payment_type TEXT,
    fare_amount TEXT,
    extra TEXT,
    mta_tax TEXT,
    tip_amount TEXT,
    tolls_amount TEXT,
    improvement_surcharge TEXT,
    total_amount TEXT,
    congestion_surcharge TEXT
);

CREATE TABLE ext_fhv_tripdata (
    dispatching_base_num TEXT,
    pickup_datetime TEXT,
    dropOff_datetime TEXT,
    PUlocationID TEXT,
    DOlocationID TEXT,
    SR_Flag TEXT,
    Affiliated_base_number TEXT
);