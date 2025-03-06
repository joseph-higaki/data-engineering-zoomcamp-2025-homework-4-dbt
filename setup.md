# Setup Environment
This section contains the steps to setup a dbt development instance with postgresql in a container

## Setting up postgresql
### Setup service `pgdatabase` at [docker-compose.yml](./docker-compose.yml) 
```docker
services:
  pgdatabase:
    container_name: pgdatabase
    image: postgres:13
    ...
```

### Create & Mount folder at host so database is persisted when containers are down
```bash
mkdir postgresql_data
```
```docker
services:
  pgdatabase:
    ...
    volumes:
      - "./postgresql_data:/var/lib/postgresql/data:rw"   # persist dev database state   
```

### Setup Docker Container initialization scripts for postgresql
These scripts are executed in order

```
init-db
├── 01_create_raw_tables.sql
└── 02_load_data.sql
```
#### [01_create_raw_tables.sql](./init-db/01_create_raw_tables.sql)
DDL scripts, creating raw landing tables, string types to capture all nuances of source systems
```sql
CREATE TABLE IF NOT EXISTS raw_conditions (
  start text,
  stop text,
  patient text,
  encounter text,
  ...
```

### Mount folder for data loading (OPTIONAL)
For the sake of simplicity, I'm mounting a set of *.csv files from folder: [./sample_data](/.sample_data) into the container running `postgresql` 

### Mount folders containing *.csv
```bash
.sample_data
├── conditions.csv
├── encounters.csv
└── patients.csv
```

```docker
services:
  pgdatabase:
    ...
    volumes:
      - "./.sample_data:/var/lib/postgresql/.init_data:ro"  # csv files / simple ingestion
      - ./init-db:/docker-entrypoint-initdb.d # sql init tables
```

#### [02_load_data.sql](./init-db/02_load_data.sql) (OPTIONAL)
Having files mounted in the postgresql container, the ingestion is done by executing a simple `COPY` statement

In a more realistic scenario, this is an ingestion first step reading from an SFTP or object storage (S3, GCS, Azure Blob Storage) 

```sql
TRUNCATE raw_conditions;
COPY raw_conditions
FROM '/var/lib/postgresql/.init_data/conditions.csv'
WITH (FORMAT csv, HEADER true);
```

### Script to spin up postgresql container
Create the script and make it executable
```sh
touch run-pgadmin.sh
chmod +x run-pgadmin.sh
```

As we may have multiple environments (dev, stg, prod), bash script to load postgresql container will ensure `.env` file is the one with the appropriate environment before `docker compose up`  the database service

[run-pgdatabase.sh](run-pgdatabase.sh)

Run postgresql database:

`. run-pgdatabase.sh dev`



## Setting up  dbt 
The dev container will have at least a dbt project
so
```sh
.
├── .devcontainer
│   ├── devcontainer.json
│   └── requirements.txt
├── <dbt project name folder>
└── dbt
    └── profiles.yml
```


### Creating  `profiles.yml` 
Before initializing dbt project
This will indicate data source connection properties
```yml
synthea_sample:
  outputs:
    dev:
      dbname: db_101
      host: pgdatabase
      pass: root
      port: 5432
      schema: public
      threads: 1
      type: postgres
      user: root
  target: dev
```

### Indicating dbt where the find `profiles.yml` 

`export DBT_PROFILES_DIR=/workspaces/dbt-core-postgres-setup/dbt`

This is also included in .dev.env`


### Initializing the dbt project folder (Only once)
To create project structure https://docs.getdbt.com/reference/commands/init 

`dbt init`
```bash
vscode ➜ /workspaces/dbt-core-postgres-setup $ cd dbt
vscode ➜ /workspaces/dbt-core-postgres-setup/dbt $ dbt init
21:36:10  Running with dbt=1.9.2
Enter a name for your project (letters, digits, underscore): synthea_sample
21:36:13  
Your new dbt project "synthea_sample" was created!

For more information on how to configure the profiles.yml file,
please consult the dbt documentation here:

  https://docs.getdbt.com/docs/configure-your-profile

One more thing:

Need help? Don't hesitate to reach out to us via GitHub issues or on Slack:

  https://community.getdbt.com/

Happy modeling!

21:36:13  Setting up your profile.
The profile synthea_sample already exists in /workspaces/dbt-core-postgres-setup/dbt/profiles.yml. Continue and overwrite it? [y/N]: N
```

```bash
.
├── .devcontainer
│   ├── devcontainer.json
│   └── requirements.txt
├── dbt
    ├── logs
    │   └── dbt.log
    ├── profiles.yml
    ├── synthea_sample
    │   ├── analyses
    │   │   └── .gitkeep
    │   ├── dbt_project.yml
    │   ├── .gitignore
    │   ├── macros
    │   │   └── .gitkeep
    │   ├── models
    │   │   └── example
    │   │       ├── my_first_dbt_model.sql
    │   │       ├── my_second_dbt_model.sql
    │   │       └── schema.yml
    │   ├── README.md
    │   ├── seeds
    │   │   └── .gitkeep
    │   ├── snapshots
    │   │   └── .gitkeep
    │   └── tests
    │       └── .gitkeep
    └── .user.yml
```
### Script to Load Env Variables befor executing dbt commands

`chmod +x /workspaces/dbt-core-postgres-setup/load-env.sh`
[load-env.sh](load-env.sh)
 will export env variables, ideally before runnning a dbt command. so that DBT_PROFILES_DIR is setup

Execute it as
` . /workspaces/dbt-core-postgres-setup/load-env.sh`

then run dbt commands as `dbt debug` 

## Setting up postgresql

## Setting up pgadmin (OPTIONAL)
For non prod environments
Should you need a SQL console

### Pre create pgadmin session folder to mount
pagadmin/sessions is created beforehand
so that we only need to register the servers connections once. 
Then they are stored in the host mounted volume 
```sh
touch run-pgadmin.sh
chmod +x run-pgadmin.sh
```
As we may have multiple environments (dev, stg, prod), bash script to load postgresql container will ensure `.env` file is the one with the appropriate environment before `docker compose up`  the database service

[run-pgadmin.sh](run-pgadmin.sh)

Run pgadmin database:

`. run-pgadmin.sh dev`
