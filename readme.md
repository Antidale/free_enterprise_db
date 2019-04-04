# free_enterprise

This is a project that will set up the schema, tables, and data for the [FreeEnterprise.Api](https://github.com/Antidale/FreeEnterprise.Api).

## Usage

```sh
cd /path/to/db/scripts

sh build.sh
```

## Description
### [build.sh](./db/scripts/build.sh)
* Drops the $FE_DBNAME database
* Creates the $FE_DBNAME database
* Runs shema-def.sql
* copies the boss_scaling_stats.csv to the import table
* runs normalize-import.sql

### [schema-def.sql](./db/scripts/schema-def.sql)
* creates the following schemas
	* import
	* encounters
	* locations
	* stats
* creates the import.import_data table

### [normalize-import.sql](./db/scripts/normalize-import.sql)
* creates the following tables
	* encounters.boss_fights
	* locations.boss_fights
	* stats.bosses
* the *.boss_fights tables are both linked to stats.bosses by a foreign key.

## Requirements
* postgres
* psql in your PATH
* build.sh is marked as executable (`chmod +x build.sql`)
* A database user with the CREATEDB role. Preferably not the SUPERUSER for the instance
* the following environment variables:
	* $FE_DBNAME
	* $FE_DBUSER
* a .pg-pass file that supplies the password for the user you're signing in with.

