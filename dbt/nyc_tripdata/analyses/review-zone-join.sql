with a as (
    select *
    from {{ ref('stg_green_tripdata') }}
    where pickup_datetime >= '2019-02-01'
    order by pickup_datetime asc 
    limit 10
) 
select * from a