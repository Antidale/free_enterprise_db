create schema if not exists import;
create schema if not exists stats;
create schema if not exists locations;
create schema if not exists encounters;
create schema if not exists equipment;

drop table if exists import.boss_data;

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
	, ScriptValue1 text
	, ScriptValue2 text
	, ScriptValue3 text
	, ScriptValue4 text
);

drop table if exists import.equipment_data;

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
)
