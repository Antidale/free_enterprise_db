
-- name of boss fight (e.g. "fabul gauntlet", "antlion")
drop table if exists encounters.boss_fights;

create table encounters.boss_fights(
	id serial primary key,
	battle text
);

insert into encounters.boss_fights(battle)
select distinct battle
from import.boss_data
order by battle;


-- location of boss fight
drop table if exists locations.boss_fights;

create table locations.boss_fights (
	id serial primary key,
	battle_location text
);

insert into locations.boss_fights (battle_location)
select distinct battle_location
from import.boss_data
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
from import.boss_data
join encounters.boss_fights
	on import.boss_data.battle = encounters.boss_fights.battle
join locations.boss_fights
	on import.boss_data.battle_location = locations.boss_fights.battle_location;

drop table if exists equipment.base;
drop table if exists equipment.weapons;
drop table if exists equipment.armor;

create table equipment.base (
	  id serial primary key
	, item_name text
	, equipment_type text
	, category text
	, str int not null default 0
	, agi int not null default 0
	, vit int not null default 0
	, wis int not null default 0
	, wil int not null default 0
	, strong_vs text
	, magnetic boolean
	, can_equip text[]
);

create table equipment.weapons (
	  attack int not null default 0
	, hit int not null default 0
	, status_influcted text
	, casts text
	, throwable boolean
	, long_range boolean
	, two_handed boolean
)
inherits (equipment.base);


create table equipment.armor (
	  def int not null default 0
	, evade int not null default 0
	, magic_def int not null default 0
	, magic_evade int not null default 0
	, status_protected text[]
)
inherits (equipment.base);

insert into equipment.weapons(
	  item_name
	, equipment_type
	, category
	, str
	, agi
	, vit
	, wis
	, wil
	, strong_vs
	, magnetic
	, can_equip
	, attack
	, hit
	, status_influcted
	, casts
	, throwable
	, long_range
	, two_handed
)
select
  ItemName
	, EquipType
	, Category
	, STR::int
	, AGI::int
	, VIT::int
	, WIS::int
	, WIL::int
	, StrongVs
	, Magnetic::boolean
	, string_to_array(replace(CanEquip, ' ', ''), ',')
	, Attack::int
	, Hit::int
	, StatusInflicted
	, Casts
	, Throwable::boolean
	, LongRange::boolean
	, TwoHanded::boolean
from import.equipment_data
where EquipType = 'Weapon';

insert into equipment.armor(
	  item_name
	, equipment_type
	, category
	, str
	, agi
	, vit
	, wis
	, wil
	, strong_vs
	, magnetic
	, can_equip
	, def
	, evade
	, magic_def
	, magic_evade
	, status_protected
)
select
	  ItemName
	, EquipType
	, Category
	, STR::int
	, AGI::int
	, VIT::int
	, WIS::int
	, WIL::int
	, StrongVs
	, Magnetic::boolean
	, string_to_array(replace(CanEquip, ' ', ''), ',')
	, Def::int
	, Evade::int
	, Coalesce(MDef, '0')::int
	, Coalesce(MEvade, '0')::int
	, string_to_array(replace(StatusProtected, ' ', ''), ',')
from import.equipment_data
where EquipType = 'Armor';
