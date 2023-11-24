#!usr/bin/bash

if psql -d ${DB_NAME} -h $FE_PGHOST -U $FE_PGUSER -c '\q' 2>&1; 
then
   echo "database ${DB_NAME} exists. skipping create"
else
    createdb $FE_PGDATABASE -U $FE_PGUSER -h $FE_PGHOST    
fi

psql -h $FE_PGHOST  -d $FE_PGDATABASE -U $FE_PGUSER -f ./scripts/schema-def.sql

psql -h $FE_PGHOST -d $FE_PGDATABASE -U $FE_PGUSER -c "\copy import.boss_data FROM './data/boss_scaling_stats.csv' with (format csv,header true, delimiter ',');"

psql -h $FE_PGHOST -d $FE_PGDATABASE -U $FE_PGUSER -c "\copy import.equipment_data FROM './data/equipment_stats.csv' with (format csv, header true, delimiter ',');"

psql -h $FE_PGHOST -d $FE_PGDATABASE -U $FE_PGUSER -f ./scripts/normalize-import.sql

psql -h $FE_PGHOST -d $FE_PGDATABASE -U $FE_PGUSER -f ./scripts/tournament-schema.sql
