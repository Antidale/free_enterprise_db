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
