SELECT  count(1) FROM {{ source('nyc_tripdata', 'ext_green_tripdata') }}
