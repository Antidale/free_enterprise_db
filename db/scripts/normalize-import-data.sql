insert into encounters.boss_fights(battle)
select distinct battle
from import.boss_data
order by battle;

insert into locations.boss_fights (battle_location)
select distinct battle_location
from import.boss_data
order by battle_location;

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
	notes
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
	string_to_array(Notes, '^^')
from import.boss_data
join encounters.boss_fights
	on import.boss_data.battle = encounters.boss_fights.battle
join locations.boss_fights
	on import.boss_data.battle_location = locations.boss_fights.battle_location;

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
	, status_inflicted
	, casts
	, throwable
	, long_range
	, two_handed
	, icon
	, notes
	, tier
	, price
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
	, Coalesce(icon, '')
	, Coalesce(notes, '')
	, Tier
	, Price::int
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
	, icon
	, notes
	, tier
	, price
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
	, Coalesce(Icon, '')
	, Coalesce(Notes, '')
	, Tier::int
	, Price::int
from import.equipment_data
where EquipType = 'Armor';
