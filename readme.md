
# dbt + PostgreSQL as a setup template
This is a simple dbt + postgre sql dev environment
I will be forking this one into other projects with more components or complexity

# How to run transformations

## Spin up postgresql
```bash
. run-pgdatabase.sh
```  

## Run dbt 
```bash
. load-env.sh
cd dbt/synthea_sample
dbt deps
dbt debug
dbt run
dbt test
```  
First time Setup details here: [setup.md](./setup.md)

