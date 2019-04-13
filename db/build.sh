#!usr/bin/bash

psql -d postgres -h $FE_PGHOST -U $FE_PGUSER -c "drop database if exists $FE_PGDATABASE"

createdb $FE_PGDATABASE -U $FE_PGUSER -h $FE_PGHOST

psql -h $FE_PGHOST  -d $FE_PGDATABASE -U $FE_PGUSER -f ./scripts/schema-def.sql

psql -h $FE_PGHOST -d $FE_PGDATABASE -U $FE_DBUSER -c "\copy import.import_data FROM './data/boss_scaling_stats.csv' with (format csv,header true, delimiter ',');"

psql -h $FE_PGHOST -d $FE_PGDATABASE -U $FE_DBUSER -f ./scripts/normalize-import.sql
