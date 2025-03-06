#!/bin/bash

# Chown the directory
echo "::: Setting up pgadmin_data directory ::: pgadmin_data/sessions"
mkdir -p pgadmin_data/sessions
echo "::: Making accesible for pgadmin user (chown 5050):::"
sudo chown -R 5050:5050  pgadmin_data  # 5050 is the user and group id of pgadmin in the container

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

# Run Docker Compose
docker compose -f docker-compose.yml up -d pgadmin