{{ config(materialized='view') }}

select *
from {{ ref('fact_trips') }}
where pickup_datetime >= '{{ var("days_back", env_var("DAYS_BACK", "30")) }}' DAY

-- command line args 60
-- env vars 45
-- default 30
