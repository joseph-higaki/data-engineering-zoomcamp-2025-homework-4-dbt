#!/bin/bash
# Create an example file with empty values for the provided .env file
# Useful to share a template with the expected environment variables
# *********************** Usage ***********************
# $ . /workspaces/dbt-core-postgres-setup/tools/env-to-examplefiles.sh /workspaces/dbt-core-postgres-setup/.dev.env
# *****************************************************

# Check if a filename is provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"
example_filename="${filename}.example"

# Check if the input file exists
if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found."
  exit 1
fi

# Create <filename>.example with empty values
while IFS= read -r line; do
  if [[ "$line" =~ ^([^#=]+)=.*$ ]]; then
    key="${BASH_REMATCH[1]}"
    echo "$key="
  else
    echo "$line"
  fi
done < "$filename" > "$example_filename"

echo "'$example_filename' created successfully."

