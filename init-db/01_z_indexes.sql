-- For green_tripdata
CREATE INDEX idx_green_pickup_datetime ON ext_green_tripdata (lpep_pickup_datetime);

-- For yellow_tripdata
CREATE INDEX idx_yellow_pickup_datetime ON ext_yellow_tripdata (tpep_pickup_datetime);