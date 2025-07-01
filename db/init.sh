#!usr/bin/bash
db=${FE_PGDATABASE}
host=$FE_PGHOST
user=$FE_PGUSER

while [ "$1" != "" ]; do
    case "${1}" in
        --host) host="$2"; shift ;;
        --db) db="$2"; shift ;;
        --user) user="$2"; shift ;;
    esac
    shift

done 

echo "DB: $db"
echo "Host: $host"
echo "User: $user"

if psql -d ${db} -h $host -U $user -c '\q' 2>&1;
then
   echo "database ${db} exists. skipping create"
else
    createdb $db -U $user -h $host    
fi

psql -h $host  -d $db -U $user -f ./scripts/create-schema.sql

psql -h $host  -d $db -U $user -f ./scripts/create-tables.sql

psql -h $host -d $db -U $user -c "\copy import.boss_data FROM './data/boss_scaling_stats.csv' with (format csv,header true, delimiter ',');"

psql -h $host -d $db -U $user -c "\copy import.equipment_data FROM './data/equipment_stats.csv' with (format csv, header true, delimiter ',');"

psql -h $host -d $db -U $user -f ./scripts/normalize-import-data.sql

psql -h $host -d $db -U $user -f ./scripts/tournament-schema.sql

psql -h $host -d $db -U $user -f ./scripts/info-schema.sql
