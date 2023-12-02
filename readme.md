# free_enterprise

This is a project that will set up the schema, tables, and data for the [FreeEnterprise.Api](https://github.com/Antidale/FreeEnterprise.Api).

## Usage

```sh
cd /path/to/folder/db/

sh build.sh
```

## Description
### [build.sh](./db/build.sh)
* Creates the $FE_PGDATABASE if it doesn't exist
* runs create-schema.sql
* runs create-tables.sql
* copies the boss_scaling_stats.csv to the import.boss_stats table
* copies the equipment_stats.csv to the import.equipment_stats table
* runs normalize-import-data.sql
* runs tournament-schema.sql

### [create-schema.sql](./db/scripts/create-schema.sql)
* creates the following schemas
	* encounters
	* locations
	* stats
	* import
	* equipment

### [create-tables.sql](./db/scripts/create-tables.sql)
* creates the following tables
	* encounters.boss_fights
	* locations.boss_fights
	* stats.bosses
	* equipment.base
	* equipment.weapons
	* equipment.armor

### [normalize-import.sql](./db/scripts/normalize-import.sql)
* inserts distinct boss fight name (battle) from import.bossdata into encounters.boss_fights
* inserts distinct boss locations (battle_location) from import.bossdata into encounters_
* inserts into stats.bosses the remaining unimported columns from import.boss_data
* the *.boss_fights tables are both linked to stats.bosses by a foreign key.

### [tourament-schem.sql](./db/scripts/tournament-schema.sql)
* creates tournament schema if it doesn't exist
* creates tournaments, entrants, and registrations tables if they don't exist

## Requirements
* postgres
* psql in your PATH
* build.sh is marked as executable (`chmod +x build.sql`)
* A database user with the CREATEDB role. Preferably not the SUPERUSER for the instance
* the following environment variables:
	* $FE_PGDATABASE
	* $FE_PGUSER
	* $FE_PGHOST
* a .pg-pass file that supplies the password for the user you're signing in with.
* the port is currently assumed to be the standad port of postgres

### Additional Help with postgres
* After your first connection as the super user, create the slightly more limted user with this (with your own good password, of course): `Create user free_enterprise with login createdb password 'Your Good Password';`
