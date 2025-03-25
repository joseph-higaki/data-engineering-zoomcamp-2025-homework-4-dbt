# Homework result
## Review Counts
[Review Counts](/dbt/nyc_tripdata/analyses/00-review-count-ext_tripdata.sql)

| table |	count |
| --- | --- |
| ext_green_tripdata	| 7778101 | 
| ext_yellow_tripdata	| 109047518 | 
| ext_fhv_tripdata	| 54220903| 

## Question 1: Understanding dbt model resolution
Provided you've got the following sources.yaml
```yaml
version: 2

sources:
  - name: raw_nyc_tripdata
    database: "{{ env_var('DBT_BIGQUERY_PROJECT', 'dtc_zoomcamp_2025') }}"
    schema:   "{{ env_var('DBT_BIGQUERY_SOURCE_DATASET', 'raw_nyc_tripdata') }}"
    tables:
      - name: ext_green_taxi
      - name: ext_yellow_taxi
```

with the following env variables setup where `dbt` runs:
```shell
export DBT_BIGQUERY_PROJECT=myproject
export DBT_BIGQUERY_DATASET=my_nyc_tripdata
```

What does this .sql model compile to?
```sql
select * 
from {{ source('raw_nyc_tripdata', 'ext_green_taxi' ) }}
```

- `select * from dtc_zoomcamp_2025.raw_nyc_tripdata.ext_green_taxi`
- `select * from dtc_zoomcamp_2025.my_nyc_tripdata.ext_green_taxi`
- `select * from myproject.raw_nyc_tripdata.ext_green_taxi`

**`select * from myproject.my_nyc_tripdata.ext_green_taxi`**

- `select * from dtc_zoomcamp_2025.raw_nyc_tripdata.green_taxi`


## [Question 2: dbt Variables & Dynamic Models](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/cohorts/2025/04-analytics-engineering/homework.md#question-2-dbt-variables--dynamic-models)
Test set
- command line args 60
- env vars 45
- default 30

`where pickup_datetime >= '{{ var("days_back", env_var("DAYS_BACK", "30")) }}' DAY`
1. Overriding fact materialization as view for debugging
1. First Test (No var, no env var)
    1. `dbt compile` 
    1. check target folder: `where pickup_datetime >= '30' DAY`
1. Second Test (No var, env var set)
    1. `export DAYS_BACK=45`
    1. `dbt compile` 
    1. check target folder: `where pickup_datetime >= '45' DAY`
1. Third Test ( var set , env var set)    
    1. `dbt compile --vars{days_back:60}` 
    1. check target folder: `where pickup_datetime >= '45' DAY`



