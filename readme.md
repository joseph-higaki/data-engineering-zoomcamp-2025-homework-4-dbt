# Troubleshoot

## WOrks!!!
select 
count(1)
 FROM  ext_yellow_tripdata

select 
count(1)
 FROM  ext_fhv_tripdata
54220903
different to You should have exactly 43,244,696 records in your FHV table


## doesn't work
SELECT  count(1) FROM {{ source('nyc_tripdata', 'ext_yellow_tripdata') }}
SELECT  count(1) FROM {{ source('nyc_tripdata', 'ext_fhv_tripdata') }}
54220903


## Also pgadmin
doesn't work
![alt text](_resources/readme.md/image.png)


##  WHAT TO DO!?

restart computer
restart containters
https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/cohorts/2025/04-analytics-engineering/homework.md
