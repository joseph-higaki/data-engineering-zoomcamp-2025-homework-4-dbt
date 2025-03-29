{{ config(
    materialized='view',
    schema='custom_schema'
) }}

select *
from {{ ref('fact_trips') }}
where pickup_datetime >= {{ dateadd("day", "-" + var("days_back", env_var("DAYS_BACK", "30")), dbt_date.today("Etc/UCT") ) }}


-- command line args 60
-- env vars 45
-- default 30
