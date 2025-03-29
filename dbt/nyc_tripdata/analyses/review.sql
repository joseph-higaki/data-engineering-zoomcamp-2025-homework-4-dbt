SELECT min(pickup_datetime), max(pickup_datetime)
 FROM {{ ref("fact_trips")}}

