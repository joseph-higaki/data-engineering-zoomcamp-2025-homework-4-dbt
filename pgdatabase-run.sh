#!/bin/bash
#Default environment file
ENV_SOURCE=".dev.env"

# Check for specific environment requests
if [ "$1" == "dev" ]; then
  ENV_SOURCE=".dev.env"
elif [ "$1" == "staging" ]; then
  ENV_SOURCE=".staging.env"
elif [ "$1" == "prod" ]; then
  ENV_SOURCE=".prod.env"
fi
echo "Using file $ENV_SOURCE and linking it to .env for docker compose use" 

# links the selected environment file to .env
ln -sf "$ENV_SOURCE" .env

# Download source files
DIR_PATH="/workspaces/data-engineering-zoomcamp-2025-homework-4-dbt/.init_data"
echo $DIR_PATH
. /workspaces/data-engineering-zoomcamp-2025-homework-4-dbt/pgdatabase-download-source.sh $DIR_PATH

# Run Docker Compose
docker compose -f docker-compose.yml up pgdatabase

# Delete the downloaded files
#rm -f $DIR_PATH/*.csv $DIR_PATH/*.csv.gz