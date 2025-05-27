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
);

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
	notes text[]
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

create table seeds.rolled_seeds (
	id serial primary key,
	user_id text not null,
	flagset text not null,
	link text not null,
	fe_version text not null,
	seed text not null,
	verification text not null
	logged_on timestamp DEFAULT now()
);

create table seeds.saved_html (
	rolled_seed_id int references seeds.rolled_seeds(id),
	patch_html text not null
);

create table races.race_detail (
	id serial primary key,
	room_name text not null,
	race_type text not null,
	race_host text not null,
	/* things like 
		Description (from racetime), 
		opened by (both, although racetime will have racingway's id unless it was opened via discord),
		Blame (that people could add)
		team composition ?
	*/
	πmetadata jsonb not null
);

create table races.racers (
	id serial primary key,
	user_id text not null,
	display_name text not null
);

create table races.race_entrants (
	race_id int references races.race_detail(id),
	entrant_id int references races.racers(id),
	finish_time time,
	racer_comment text
);
