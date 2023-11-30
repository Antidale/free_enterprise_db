create table import.boss_data(
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
	, Notes text
);

create table import.equipment_data (
	  ItemName text
	, EquipType text
	, Category text
	, Attack text
	, Hit text
	, Def text
	, Evade text
	, MDef text
	, MEvade text
	, STR text
	, AGI text
	, VIT text
	, WIS text
	, WIL text
	, StatusInflicted text
	, Casts text
	, StatusProtected text
	, StrongVs text
	, Magnetic text
	, Throwable text
	, LongRange text
	, TwoHanded text
	, CanEquip text
	, Icon text
	, Notes text
	, Tier text
	, Price text
)

-- name of boss fight (e.g. "fabul gauntlet", "antlion")
create table encounters.boss_fights(
	id serial primary key,
	battle text
);

-- location of boss fight
create table locations.boss_fights (
	id serial primary key,
	battle_location text
);

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
	notes text
);

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
	, icon text
	, notes text
	, tier text
	, price int not null default 1
);

create table equipment.weapons (
	  attack int not null default 0
	, hit int not null default 0
	, status_inflicted text
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
