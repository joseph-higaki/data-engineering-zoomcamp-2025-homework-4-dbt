select 
	'ext_green_tripdata',
	(SELECT  count(1) FROM {{ source('nyc_tripdata', 'ext_green_tripdata') }})

union all
select 
	'ext_yellow_tripdata',
	(SELECT  count(1) FROM {{ source('nyc_tripdata', 'ext_yellow_tripdata') }})
union all
select 
	'ext_fhv_tripdata',
	(SELECT  count(1) FROM {{ source('nyc_tripdata', 'ext_fhv_tripdata') }})
	