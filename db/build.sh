#!usr/bin/bash

psql -d postgres -U $FE_DBUSER -c "drop database if exists $FE_DBNAME"

createdb $FE_DBNAME -U $FE_DBUSER

psql -d $FE_DBNAME -U $FE_DBUSER -f ./scripts/schema-def.sql

psql -d $FE_DBNAME -U $FE_DBUSER -c "\copy import.import_data FROM './data/boss_scaling_stats.csv' with (format csv,header true, delimiter ',');"

psql -d $FE_DBNAME -U $FE_DBUSER -f ./scripts/normalize-import.sql
