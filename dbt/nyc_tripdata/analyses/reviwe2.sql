with a as (
    SELECT *
    FROM {{ ref("fact_trips")}}
    where cast(pickup_datetime as date) = '2019-07-01'
    order by pickup_datetime asc
    limit 10
)
select * from a
-- 6 minutes NO INDEX where cast(pickup_datetime as date) = '2019-07-01'


