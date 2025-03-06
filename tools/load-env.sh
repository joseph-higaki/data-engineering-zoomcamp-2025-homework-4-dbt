#!/bin/bash
# Load environment variables from .env file
# Useful before start executing dbt commands
export $(grep -v '^#' /workspaces/data-engineering-zoomcamp-2025-homework-4-dbt/.env | xargs)