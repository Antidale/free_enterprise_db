
-- name of boss fight (e.g. "fabul gauntlet", "antlion")
drop table if exists encounters.boss_fights;

create table encounters.boss_fights(
	id serial primary key,
	battle text
);

insert into encounters.boss_fights(battle)
select distinct battle
from import.import_data
order by battle;


-- location of boss fight
drop table if exists locations.boss_fights;

create table locations.boss_fights (
	id serial primary key,
	battle_location text
);

insert into locations.boss_fights (battle_location)
select distinct battle_location
from import.import_data
order by battle_location;

-- Rest of insert
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
	script_values text[]
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
	script_values
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
	array_remove(
		Array[
			ScriptValue1,
			ScriptValue2,
			ScriptValue3,
			ScriptValue4],
		null
		)
from import.import_data
join encounters.boss_fights
	on import.import_data.battle = encounters.boss_fights.battle
join locations.boss_fights
	on import.import_data.battle_location = locations.boss_fights.battle_location;
