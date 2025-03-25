#!/bin/bash

#DIR_PATH="/workspaces/data-engineering-zoomcamp-2025-homework-4-dbt/.init_data"
DIR_PATH=$1
echo "Input dir $DIR_PATH "
# Check if the directory exists
if [ -d "$DIR_PATH" ]; then
  echo "Directory $DIR_PATH exists, skipping dir creation"
else 
  echo "Creating directory $DIR_PATH"
  mkdir -p $DIR_PATH  
fi

# Trip types to process
TRIP_TYPES=("green" "yellow" "fhv")
for trip_type in "${TRIP_TYPES[@]}"; do
  # Download files for 2019 and 2020
  for year in {2019..2020}; do  
    for month in {01..12}; do
      FILE_NAME_GZ="$DIR_PATH/${trip_type}_tripdata_${year}-${month}.csv.gz"
      FILE_NAME="${FILE_NAME_GZ%.gz}"

       # Uncompress the file          
      echo "Evaluating $FILE_NAME"    
      if [ -f "$FILE_NAME" ]; then
        echo "File $FILE_NAME exists, skipping iteration"
        continue      
      fi

      echo "Evaluating $FILE_NAME_GZ"    
      if [ -f "$FILE_NAME_GZ" ]; then
        echo "File $FILE_NAME_GZ exists, skipping download"
      else
        # Get the file
        echo "Downloading $FILE_NAME_GZ"        
        curl -L -o "$FILE_NAME_GZ" "https://github.com/DataTalksClub/nyc-tlc-data/releases/download/${trip_type}/${trip_type}_tripdata_${year}-${month}.csv.gz"
      fi
      # Uncompress the file          
      echo "Evaluating $FILE_NAME"    
      if [ -f "$FILE_NAME" ]; then
        echo "File $FILE_NAME exists, skipping unzip"
      else
        echo "Unzipping $FILE_NAME_GZ into $FILE_NAME"
        gunzip -c $FILE_NAME_GZ > $FILE_NAME
      fi
    done
  done
done