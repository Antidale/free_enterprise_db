create schema if not exists import;
create schema if not exists stats;
create schema if not exists locations;
create schema if not exists encounters;

drop table if exists import.import_data cascade;
drop table if exists stats.bosses cascade;
drop table if exists locations.boss_fights cascade;
drop table if exists encounters.boss_fights cascade;

create table import.import_data(
	Battle text
	, battle_location text
	, Enemy text
	, Lvl text
	, HP text
	, XP text
	, GP text
	, AtkMult text
	, HitPercent text
	, Atk text
	, DefMul text
	, Evade text
	, Defense text
	, MDefMult text
	, MagicEvade text
	, MDef text
	, MinSpd text
	, MaxSpd text
	, SpellPower text
	, ScriptValue1 text
	, ScriptValue2 text
	, ScriptValue3 text
	, ScriptValue4 text
);
COPY import.import_data from '/Users/scottwyngarden/Projects/ffiv_fe_boss_stats/db/boss_scaling_stats.csv' with delimiter ',' header csv;

-- name of boss fight (e.g. "fabul gauntlet", "antlion")
drop table if exists encounters.boss_fights;
select distinct battle
into encounters.boss_fights
from import.import_data
order by battle;

alter table encounters.boss_fights
add id serial primary key;


-- location of boss fight
drop table if exists locations.boss_fights;

select distinct (battle_location) as battle_location
into locations.boss_fights
from import.import_data
order by battle_location;

alter table locations.boss_fights
add id serial primary key;

-- drop table if exists stats.bosses;
-- select distinct battle
-- into stats.bosses
-- from import.import_data;

-- alter table stats.bosses
-- add id serial primary key;

create table stats.bosses(
	id serial primary key,
	location_id int references locations.boss_fights(id),
	battle_id int references encounters.boss_fights(id),
	enemy text,
	level int not null default 0,
	hit_points int not null default 0,
	experience_points int not null default 0,
	gil int not null default 0,
	attack_multiplier int not null default 0,
	attack_percent int not null default 0,
	attack_power int not null default 0,
	defense_multiplier int not null default 0,
	evade int not null default 0,
	defense int not null default 0,
	magic_defense_multiplier int not null default 0,
	magic_evade int not null default 0,
	magic_defense int not null default 0,
	min_speed int not null default 0,
	max_speed int not null default 0,
	spell_power int not null default 0,
	script_value_1 text,
	script_value_2 text,
	script_value_3 text,
	script_value_4 text
);

insert into stats.bosses(
	location_id,
	battle_id,
	enemy,
	level,
	hit_points,
	experience_points,
	gil,
	attack_multiplier,
	attack_percent,
	attack_power,
	defense_multiplier,
	evade,
	defense,
	magic_defense_multiplier,
	magic_evade,
	magic_defense,
	min_speed,
	max_speed,
	spell_power,
	script_value_1,
	script_value_2,
	script_value_3,
	script_value_4
)
select
	locations.boss_fights.id,
	encounters.boss_fights.id,
	Enemy,
	Lvl::int,
	HP::int,
	XP::int,
	GP::int,
	AtkMult::int,
	HitPercent::int,
	Atk::int,
	DefMul::int,
	Evade::int,
	Defense::int,
	MDefMult::int,
	MagicEvade::int,
	MDef::int,
	MinSpd::int,
	MaxSpd::int,
	NullIf(SpellPower, '')::int,
	ScriptValue1,
	ScriptValue2,
	ScriptValue3,
	ScriptValue4
from import.import_data
join encounters.boss_fights on import.import_data.battle = encounters.boss_fights.battle
join locations.boss_fights on import.import_data.battle_location = locations.boss_fights.battle_location;
