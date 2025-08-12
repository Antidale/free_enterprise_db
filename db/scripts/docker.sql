create schema if not exists import;
create schema if not exists stats;
create schema if not exists locations;
create schema if not exists encounters;
create schema if not exists equipment;
create schema if not exists races;
create schema if not exists seeds;

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

create table if not exists races.race_detail (
	id serial primary key,
	room_name text not null,
	race_type text not null,
	race_host text not null,
	ended_at TIMESTAMP WITH TIME ZONE,
	/* things like 
		Description (from racetime), 
		opened by (both, although racetime will have racingway's id unless it was opened via discord),
		Blame (that people could add)
		team composition ?
	*/
	metadata jsonb not null
);

create index idx_desc on races.race_detail using btree ((metadata ->> 'Description'));

create table races.racers (
	id serial primary key,
	discord_id text default '',
	discord_display_name text default '',
	racetime_display_name text default '',
	racetime_id text default '',
	twitch_name text default ''
);

create index idx_racetime_name_lower on races.racers using btree(lower(racetime_display_name));
create index idx_racetime_id_lower on races.racers using btree(lower(racetime_id));
create index idx_twitch_name_lower on races.racers using btree(lower(twitch_name));

create table races.race_entrants (
	race_id int references races.race_detail(id),
	entrant_id int references races.racers(id),
	finish_time interval,
	placement smallint,
	/*
		for racetime, will have things like:
		comment (if present)
		points change
		status (finished/cancelled/dq probably?)
	*/
	metadata jsonb
);

create index idx_race_id on races.race_entrants using btree(race_id);
create index idx_entrant_id on races.race_entrants using btree(entrant_id);

create table seeds.rolled_seeds (
	id serial primary key,
	user_id text not null,
	flagset text not null,
	link text not null unique,
	fe_version text not null,
	seed text not null,
	verification text not null,
	race_id int references races.race_detail(id),
	logged_on timestamp DEFAULT now(),
	flagset_search tsvector generated always as (
        to_tsvector('simple',replace(flagset, '/', ' '))
    ) stored,
	binary_flags text default ''
);

create index idx_bin_flags on seeds.rolled_seeds using btree(binary_flags);
create index idx_flagset_search on seeds.rolled_seeds using GIN(flagset_search);

create table seeds.saved_html (
	rolled_seed_id int references seeds.rolled_seeds(id),
	patch_html text not null
);

create index idx_seed_id on seeds.saved_html using btree(rolled_seed_id);

create schema if not exists info;

DO $$ BEGIN
    IF to_regtype('linkType') IS NULL THEN
        create TYPE linkType as ENUM ('Article', 'Image', 'Video');
    Else RAISE NOTICE 'linkType already exists, skipping';
    END IF;
END $$;

create table info.guides(
    id serial primary key,
    title text,
    summary text,
    link text UNIQUE,
    link_type linkType,
    tags text,
    search tsvector generated always as (
        setweight(to_tsvector('simple',tags), 'A') || ' ' ||
        setweight(to_tsvector('english',title), 'B') || ' ' ||
        setweight(to_tsvector('english',summary), 'C') :: tsvector
    ) stored
);

create index idx_search on info.guides using GIN(search);

insert into info.guides (title, summary, link, link_type, tags)
VALUES
('Death of upt Co', 'fcoughlin shows off a very special Zeromus fight', 'https://www.twitch.tv/videos/293657539', 'Video', 'Edward Zeromus upt Co no64 G64'),
('Door Grind', 'a video showing a couple methods of killing Doors in Sealed Cave', 'https://www.twitch.tv/videos/1086216532', 'Video', 'Door Grind Sealed Cave'),
('PB2J Jumps', 'a video demonstrating many of the shortcuts available in PushBToJump (pb2j) seeds', 'https://www.twitch.tv/videos/672286142', 'Video', 'PB2J Skips pushbtojump'),
('So You Think You Can Jump', 'Written guide to learning the pushbtojump flag', 'https://docs.google.com/document/d/1YYY5ODIeSoup2yT5dcIP6zNTx8-oLBTMPSr2CEaaXYQ', 'Article', 'PB2J pushbtojump guide'),
('PB2J Inventory Warp', 'Aexoden demonstrates how the pb2j flag can enable some true game breaking', 'https://www.youtube.com/watch?v=TUJhO64z-ZI', 'Video', 'PB2J pushbtojump Inventory Warp'),
('PB2J on GDQ Random Number Generation', 'Gambit017 hops through a PB2J seed on the GDQ Random Number Generation show', 'https://youtu.be/OoatsifY4vQ?t=7136', 'Video', 'PB2J pushbtojump GDQ Games Done Quick'),
('FE Newbies Guide', 'riversmccown provides a wealth of information for players on their first runs. A very solid introduction and foundation for Free Enterprise.', 'https://docs.google.com/document/d/1a1t3H4aX-yB2_wM67iKy_dwdCjJzY4qAyWfKzRCv8Og', 'Article', 'Newbie Guide Overview Get Started'),
('Newbies Guide to Glitches', 'riversmccown outlines the glitches in FE and provides links to videos and further explanations', 'https://docs.google.com/document/d/1X2TR4yKmkw9jZbILG-YsJPI6MPeecF3gqDJ06bAiiPQ', 'Article', 'Glitches Newbie Guide Overview Get Started'),
('Equipment Chart', 'SwimmyLionni compiled this image for equipment lookups. Pre 4.1 stats', 'https://imgur.com/BQz2Lsd', 'Image', 'Equipment Stats Dart Weapon Armor'),
('D.Machin Grind Finder', 'Inven demonstrates how to find the D.Machin grind fight', 'https://www.twitch.tv/videos/262928495', 'Video', 'D.Machin Grind Giant Encounter Manip Searcher'),
('D.Machin Grind Image', 'Hosted image for finding the D.Machine grind fight, from Aexoden', 'https://ff4kb.aexoden.com/static/myself086/GrindFightManip.PNG', 'Image', 'D.Machine Grind Giant Encounter Manip Searcher'),
('D.Machin Ecantrun Grind Finder', 'Simbu and TwistedFlax created this guide for setting up the D.Machin manip when Ecantrun is enabled', 'https://docs.google.com/document/d/1omLzoWgVrxFemXKvPjtWXLLwso6eNew9CRF8rMkBSCM', 'Article', 'D.Machin D Machin Grind Giant Ecantrun Searcher Encounter Manip step Chart Manipulation'),
('MacGiant Ecantrun Grind Finder', 'Simbu and TwistedFlax created this guide for setting up the MacGiant manip when Ecantrun is enabled', 'https://docs.google.com/document/d/13P1RM2ExMMHS9qbTyFN59AqecOWs5r2Yp2xgWCdUjMo', 'Article', 'MacGiant Grind Giant Ecantrun Searcher Encounter Manip'),
('MacGiant Grind Finder', 'Aexoden created this to help manip the MacGiant grind fight while walking through the Giant', 'https://ff4kb.aexoden.com/tools/grind-finder/', 'Article', 'MacGiant Grind Giant Searcher Encounter Manip'),
('Common Grinds', 'A summary of many common grinds used while playing FE', 'https://wiki.ff4fe.com/doku.php?id=common_grinds', 'Article', 'D.Machin Doors Siren Yellow Gold Dragon Warlock Searcher Reaction Encounter Manip MacGiant Giant'),
('Other Step Manipulation Grinds', 'Simbu and TwistedFlax also made step manipulation charts for Warlocks, Gold Dragons (King-Ryu), Sorcerer fights, and the Reaction grind', 'https://docs.google.com/document/d/1u3vlgjO2LJB3-XQntoQw8DzpXfQ-GxHZk_79DcQg8M8', 'Article', 'Encounter Step Manip Grind Warlok Gold Dragon King-Ryu Reaction Sorcerer'),
('Grind Calculator', 'Make a copy of this spreadsheet from mxzv to help calculate how far to take your grind', 'https://docs.google.com/spreadsheets/d/1lkHY--4KtJR6TJRy7oKxJOrLI0Z-CsF5dlEkEcd5ykQ', 'Article', 'Grind Calculator Tool D.Machin MacGiant Orb Sister'),
('D.Machin Count Grind Lookup', 'Inven created this spreadsheet to help with a quick lookup for how many D.Machins or MacGiants you need to hit level targets', 'https://docs.google.com/spreadsheets/d/1DChwazoDnE4XeLjF_s6vraNCV__om13wtVaq9zLghns', 'Article', 'D.Machine Grind Calculator Tool MacGiant Giant'),
('The ATB System', 'A writeup on the wiki covering ATB, Relative Agility, Timers, Battle Speed, Speed Modifier and more', 'https://wiki.ff4fe.com/doku.php?id=battle_mechanics#the_atb_system', 'Article', 'RA Relative Agility ATB Battle Mechanics Speed Modifier'),
('Battle Formulas', 'Wiki writeup of damage formulas including information on crits and modifiers/multipliers for damage', 'https://wiki.ff4fe.com/doku.php?id=formulas', 'Article', 'Battle Mechanics Modifiers Formulas'),
('Algorithm FAQ', 'A guide algorithms in FFIV, and therefore Free Enterprise. From Deathlike', 'https://gamefaqs.gamespot.com/snes/522596-final-fantasy-ii/faqs/54945', 'Article', 'Battle Mechanics Algorithms Formulas Modifiers'),
('FF4FE Underlevelled Boss Strategies', 'A guide to low/underleveled boss fights from Kirchin', 'https://docs.google.com/document/d/1Xw1vsN-OROShv4ZxPcStwJ1LsmFlPcZr3IIjOBSNEww', 'Article', 'Underleveled Boss Strategies Kirchin Guide Low Level'),
('FF4FE Boss Strats', 'An article version of the /recall boss command of Tellahs Library', 'https://docs.google.com/document/d/1m_U90JG2t3Ze0fUFLMCzMSHZNYcdnIWrcr7RWAgtpBU', 'Article', 'Boss Strategies Guide Low Level'),
('Relative Agility', 'The wiki article containing basic information about Relative Agility', 'https://wiki.ff4fe.com/doku.php?id=relative_agility', 'Article', 'RA Relative Agility'),
('Speed Modifier', 'Wiki article detailing how the Speed Modifer works in FF4', 'https://wiki.ff4fe.com/doku.php?id=speed_modifier', 'Article', 'Speed Modifier Fast Slow SilkWeb Hermes'),
('Battle Timers', 'Wiki article detailing various timers in battle', 'https://wiki.ff4fe.com/doku.php?id=battle_timers', 'Article', 'Battle Timer STop Sap Poison Stone Wall Count Chain ATB Speed Modifier'),
('RA Calculator', 'Relative Agility calculator made by fcoughlin', 'https://script.google.com/macros/s/AKfycbxs62kk70KyBAxk2xhlLme2NM1MC_MyP4l8LhcF5_EQSyjLz5E/exec', 'Article', 'RA Relative Agility Calculator'),
('Valvalis Reference Chart', 'Chart compiled by Inven showing the defenses Valvalis gets while in Tornado form', 'https://docs.google.com/spreadsheets/d/1tVQFvlQ_4oWCn0EE9d7QAGrYW3w2IbZzuO2MWuUC8ww', 'Article', 'Valvalis Reference Chart Tornado Defenses'),
('Boss Location Summary Chart', 'Chart listing values of a single enemy fight for each boss location. Contains DKC and Val details', 'https://info.tellah.life/', 'Article', 'Boss Location Summary DKC Valvalis HP Speed Tornado'),
('Boss Info Lookup', 'An app from Dustygriff showing stats of boss fights at specific locations. Includes RA chart', 'https://tgriffin89.github.io/ff4app/', 'Article', 'Boss Information Stats RA'),
('Boss Stats Lookup', 'Website showing boss stats and location-specific script information', 'https://info.tellah.life/boss-stats/', 'Article', 'Boss Information Stats'),
('Nearly 100% walkthrough', 'riversmmccown provides a thorough walkthrough of the game. A good watch for newbies', 'https://www.twitch.tv/videos/255276943', 'Video', 'Newbie Walkthrough Demonstation Dupe Glitch'),
('3x Red D. encounter manip', 'ScytheMarshall shows off, in a race, manipulating encounters to get the pack of three Red D. in the Lunar Core', 'https://www.twitch.tv/videos/1489314531?t=00h46m42s', 'Video', 'Encounter Manip Grind Red Dragon SOTW Race'),
('Plague Reflect Example', 'An example of reflecting Count and having Plague fall to self-inflicted doom', 'https://www.twitch.tv/videos/2024235833', 'Video', 'Plague Reflect Count Example'),
('Inven''s FF4fe Duplication Guide', 'Inven created a step-by-step guide, with screenshots, for how to perform the duplication glitches available when Gdupe is enabled', 'https://docs.google.com/document/d/1ccSSohY1YyFflhuAaPaTvRprBoFHtxUHh-Eqap5FL1g', 'Article', 'Gdupe Duplication Glitch Tutorial How-To Guide Weapon Armor'),
('Who''s My Anchor?', 'An image flowchart showing who the agility anchor is, and helps make it clear when both Chero and -vanilla:agility are in play', 'https://ff4-fe-info.s3.us-west-2.amazonaws.com/library-images/agility-flowchart-p.jpg', 'Image', 'Chero vanilla agility anchor'),
('Kirchin Unveils Eddy Strats', 'The first time Edward strats are used in a Free Enterprise race', 'https://youtu.be/-AxFYQBB8gE?si=GHVyvJrqAoEZ4yLI&t=3145', 'Video', 'WSOFE Edward Strats Zeromus'),
('Alt Gauntlet Formations', 'A list of all the formations for the [Alt Gauntlet](<https://wiki.ff4fe.com/doku.php?id=boss_randomization#alt_gauntlet>) at each location', 'https://wiki.ff4fe.com/doku.php?id=alt_gauntlet', 'Article', 'Alt Gauntlet Enemy Formations'),
('Evil Wall - Eddy Strats Potential', 'A reference spreadsheet for figuring out if you can use Hide to let Evil Wall beat itself up', 'https://docs.google.com/spreadsheets/d/1TQY6hGjqkC1NQGDv_M0pzPQa2xZZlAT7rzCzCNLyX1g', 'Article', 'Edward Evil Wall Hide Strats Reference Lookup'),
('Zeromus Hide Strats', 'A write-up for how to defeat Zeromus with the power of ~~cowards!~~ Edward''s Hide Command', 'https://docs.google.com/document/d/1Xw1vsN-OROShv4ZxPcStwJ1LsmFlPcZr3IIjOBSNEww/edit#heading=h.dvcyslrwgp71', 'Article', 'Low Level Edward Zeromus Strats Reflect StarVeil'),
('1200 Strats - Full Party', 'Zilch explains how to defeat Zeromus when your party has only about 1200 HP per character', 'https://www.twitch.tv/videos/1051386268', 'Video', 'Zeromus 1200 HP Strats Reflect StarVeil Vampire Cure3'),
('1200 Strats - 2 Character', 'Zilch explains how to defeat Zeromus with just a couple characters having 1200 or more HP', 'https://www.twitch.tv/videos/1051391891', 'Video', 'Zeromus 1200 HP Strats Reflect StarVeil Vampire Cure3'),
('Asura Face Changing Demo', 'A demonstration of how Asura changes faces as reaction to being bopped. Uses a LUA script to display game data', 'https://www.twitch.tv/videos/2008550932', 'Video', 'Asura Face Reaction Lua'),
('John Birckhead Explains: Relative Agility (sort of)', 'A discussion of the math behind Relative Agility in Free Enterprise', 'https://www.twitch.tv/videos/1827822112', 'Video', 'Relative Agility Tutorial'),
('John Birckhead Explains: D.Machin grinds', 'A walkthrough for how to read the various guides for manipulating the D.Machin grind, and an example fight', 'https://www.twitch.tv/videos/1690480090', 'Video', 'D.Machin Grind Tutorial Example'),
('John Birckhead Explains: Dupe Glitch', 'A video tutorial for the duplication glitch', 'https://www.twitch.tv/videos/1745502727', 'Video', 'GDupe Dupe Glitch Tutorial'),
('FE: Family Feud Edition', 'A fun time at Johncon where FE gets a Family Feud Makeover', 'https://www.twitch.tv/videos/1844514661', 'Video', 'Fun Family Feud'),
('Fireless D.Machin Example', 'Possumorpheus demonstrates having a Fireless D.Machin fight, once the setup is complete', 'https://www.twitch.tv/videos/1199410956', 'Video', 'D.Machine Fireless Example Grind'),
('Charming, Palom, Charming', 'Palom has had enough with carrying the team, it''s time to Meteo', 'https://clips.twitch.tv/SilkyUnsightlyMeatloafCmonBruh', 'Video', 'Palom Charm Meteo Party Wipe Fun'),
('4x Run Buffer', 'xPankraz shows off his skills and gets four run-buffered StarVeils off against Wyvern at BS1', 'https://www.twitch.tv/xpankraz/clip/DoubtfulBeautifulDumplingsStinkyCheese-VDL_dEo1KNlaWwit', 'Video', 'Run Buffer Wyvern Fun'),
('Tricker, Tricked', 'riversmccown has a little fun at the Tricker''s expense', 'https://clips.twitch.tv/CooperativeDoubtfulChipmunkPRChase', 'Video', 'Tricker Fun'),
('OMG Rules Doc', 'Tournament rules document for the Omnidextrous Memers Guild', 'https://docs.google.com/document/d/11xQ960qk1wUKcTD8woIpErU-IM78Bhe66DGAy8popXI', 'Article', 'Tournament Rules Document OMG'),
('EEL Rules Doc', 'Tournament rules document for the Eblan Elixir League', 'https://docs.google.com/document/d/1yeL-YbxRm78lTjnKaEDgMWY8lzs18i-vMvKk3Z5beU4', 'Article', 'Tournament Rules Document EEL'),
('ZZ5 Rules Doc', 'Tournament rules document for the Highway to the Zemus Zone 5', 'https://docs.google.com/document/d/1te372V9VFnNGtlhiXdgYqlG9jLPFhhNbwAQv48n9PCQ', 'Article', 'Tournament Rules Document ZZ5 Zemus Zone'),
('Adamant Cup Rules Doc', 'Tournament rules document for the Adamant Cup', 'https://docs.google.com/document/d/1ANxHkY7apd10HEmvNi1f7fRA-tbwy6xjwxbGKdKOsgc', 'Article', 'Tournament Rules Document Adamant Cup'),
('ZZ4 Rules Doc', 'Tournament rules document for Highw4y to the Zemus Zone', 'https://docs.google.com/document/d/1ZfvIdHtXBaMbt9JbhPKTVIJnCluECSoVQFrGr0AEUus', 'Article', 'Tournament Rules Document ZZ4 Zemus Zone'),
('LHL Rules Doc', 'Tournament rules document for the Lali-Ho League', 'https://docs.google.com/document/d/18vkxAUVWogbppOGAHwmvzPU_XwZNxRrCw2z85wOE_eg', 'Article', 'Tournament Rules Document LHL'),
('ZZ3 Rules Doc', 'Tournament rules document for the Highway to the 3mus Zone', 'https://docs.google.com/document/d/1eLRwhP1tBWIaQCYOjvxe7usao9i4hPzo4Rf6E__Coqo', 'Article', 'Tournament Rules Document ZZ3 Flowchart'),
('FG Rules Doc', 'Tournament rules document for the Fabul Gauntlet', 'https://docs.google.com/document/d/12Al-UQoM0SEX6TRzepaLxTITbxObcNtVN2obG6jSZvE', 'Article', 'Tournament Rules Document FG'),
('HOpen Rules Doc', 'Tournament rules document for the Hummingway Open', 'https://docs.google.com/document/d/1MsJgGg8qZKHr5ODz8mIeG3bXb-Z6Xe7W0WwTdULVoDk', 'Article', 'Tournament Rules Document HOpen'),
('ZZ2 Rules Doc', 'Tournament rules document for the Highway 2 the Zemus Zone', 'https://docs.google.com/document/d/1m7K9PxOQTsxSZ3euSVHtT5bmasVdu4zlzGJmiBYVAAA', 'Article', 'Tournament Rules Document ZZ2'),
('WSOFE Rules Doc', 'Tournament rules document for the World Series of Free Enterprise', 'https://docs.google.com/document/d/1jMvPPrPNAKfLZiTQwzBPuC8TkaafLRqXo0Zp2D8UCL0', 'Article', 'Tournament Rules Document WSOFE'),
('2v2 Twinvitational Rules Doc', 'Tournament rules document for the 2v2 Twinvitational', 'https://docs.google.com/document/d/1gfx_sMtSXv1OaPyRmrEUKZCtkeKhxooqXgJst7Vnnck', 'Article', 'Tournament Rules Document Twinvitational 2v2'),
('ZZ1 Rules Doc', 'Tournament rules document for the Highway to the Zemus Zone', 'https://docs.google.com/document/d/1RWsHy6e0gAb9c-4GFsxccR0sLJQ34ySLVQlf8MXZ1sA', 'Article', 'Tournament Rules Document ZZ1'),
('Whichburn Strikes Again', 'Just one Glance from Wyvern, and Edward changes sides', 'https://clips.twitch.tv/DepressedAmazingMomNerfRedBlaster', 'Video', 'Wyvern Edward Glance Fun'),
('Heritage Minute: Senator Crocodile', 'SchalaKitty explains the origins of Senator Crocodile', 'https://clips.twitch.tv/VictoriousInterestingSproutImGlitch-aNcPxwCy25eiUeKB', 'Video', 'Fun Alt Gauntlet Heritage'),
('Icicles', 'An image of icicles. Brr!', 'https://ff4-fe-info.s3.us-west-2.amazonaws.com/fun/brr.jpg', 'Image', 'Brr Fun'),
('Angry Cookie', 'An image of an angry looking cookie', 'https://ff4-fe-info.s3.us-west-2.amazonaws.com/fun/angry_cookie.png', 'Image', 'Angry Cookie Fun'),
('Quokka Twins', 'Surprise! Cuteness!', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Curious_quokka_twins_%2827802025295%29.jpg/640px-Curious_quokka_twins_%2827802025295%29.jpg', 'Image', 'Quokka Fun'),
('Sneaky Backrow Yang', 'mxzv used the Sneak glitch to backrow Yang in a ZZ3 race', 'https://youtu.be/InmECENpUAg?si=OTsZHKaVB6jENPaP&t=1990', 'Video', 'Charm Harp Gbackrow Glitches Yang Example'),
('Save!', 'Rhybon doesn''t save, Schala''s soul is hurt', 'https://www.twitch.tv/freeenterprise/clip/AthleticTawdryDonutLitFam-b21Enu3oTvRPD3Wn', 'Video', 'Save Wyvern Fun'),
('Buzzed by guest commentary', 'To infinity and beyond!', 'https://www.twitch.tv/freeenterprise/clip/TemperedPlainTrollFloof', 'Video', 'Fun Cheddar Buzz Lightyear'),
('No One', 'Shakes like Gaston. . .', 'https://www.twitch.tv/freeenterprise/clip/AverageSillyGazelleBabyRage', 'Video', 'Fun Filk Gaston'),
('Squirt joins comms', 'Nightdew''s kitty decides to offer some thoughts', 'https://www.twitch.tv/freeenterprise/clip/NurturingLitigiousPresidentDoritosChip', 'Video', 'Fun Commentary Kitten'),
('B0ard on B0ardAI', 'A clip of Muppetsinspace getting the secrets of B0ardAI right from B0ardface', 'https://www.twitch.tv/freeenterprise/clip/TawdryDeterminedDonkeyPJSalt', 'Video', 'Fun Interview B0ardAI'),
('PYP Standings', 'The tournament standings for Inven''s Pick Your Poison tournament', 'https://docs.google.com/spreadsheets/d/1xx7OcYD2QTYPqFkYDLuo4xc5JTrM56rKhc_cJ6eetTU', 'Article', 'Tournament Standings PYP Pick Your Poison Draft'),
('Hap B Leap Year Standings', 'The tournament standings for Antidale''s Hap B Leap Year tournament', '', 'Article', 'Tournament Standings Hap B Leap Year Jump pb2j'),
('FF4FE Draft', 'Draft from randomly generated cards to make a Free Enterprise flagset. By Galeswift', 'https://www.ff4fedraft.com/', 'Article', 'Draft Website'),
('Pick Your Poison Rules Doc', 'Tournament rules document for the Pick Your Poison side tournament', 'https://docs.google.com/document/d/1_qYon9DqJpDSVb384119-XL9xIgAq8s-DssBYqhSEB8', 'Article', 'PYP Pick Your Poison Side Tournament Rules Doc Draft'),
('Pick Your Poison Draft Helper', 'A helper website to track drafted flags for the Pick Your Poison tournament', 'https://www.tellah.life/Poison/', 'Article', 'PYP Pick Your Poison Draft Helper'),
('Hap B Leap Year Rules Doc', 'Tournament rules document for the Hap B Leap Year side tournament', 'https://docs.google.com/document/d/1uXWiiT6guhWD7DHNrujqH-UUVJVA_jEWY775w25l4qk', 'Article', 'Hap B Leap Year Side Tournament Rules Doc'),
('KI Locations Spreadsheet', 'A spreadsheet with notes on locations where Key Items can be found, the vanilla KI rewarded there, and what K flag enables them', 'https://docs.google.com/spreadsheets/d/1ZZH92GG8AWiQV5u6SJlXP6KFFqoqIQdXUW1u10kdM3Q', 'Article', 'KI Reference Spreadsheet Kmain Kmoon Ksummon Kmiab'),
('FE Enemy Lookups', 'Spreadsheet with tons of enemy data, with tabs to help look up enemies with various properties. Make a copy of your own!', 'https://docs.google.com/spreadsheets/d/1_4ZXg5ZvOiIHP7WAmHFnk6jQEeEXyxO8mY8cn3qbR2M', 'Article', 'Enemy Lookup Resist Weakness Data Race Alt Gauntlet'),
('Cmaybe probabilities', 'ScytheMarshall did the math on the probabilities of various Cmaybe compositions', 'https://docs.google.com/spreadsheets/d/1SQAk-VPj5tATwO6wOgm79-GDdVOqd8nAz8aeYA3-TJU', 'Article', 'Character maybe cmaybe probability'),
('Vanilla MIAB Locations', 'xPankraz created this guide to the vanilla Monsters! chests with both location and strategies', 'https://docs.google.com/document/d/1F93iM_F73UW_uFIB7R_ioVHxJVvlpKmjG41dGLIBsnU', 'Article', 'MIAB Monsters Chest Guide'),
('Spell Data', 'A wiki listing of all the spell data including what levels characters learn spells with and without the `jspells` flag', 'https://wiki.ff4fe.com/doku.php?id=spell_data', 'Article', 'Armor Berserk Blink Charm Cure1 Cure2 Cure3 Cure4 Dispel Exit Fast Float Heal Hold Life1 Life2 Mute Peep Shell Sight Size Slow Wall White Drain Fatal Fire1 Fire2 Fire3 Ice1 Ice2 Ice3 Lit1 Lit2 Lit3 Meteo Nuke Piggy Psych Quake Sleep Stone Stop Toad Venom Virus Warp Weak Comet Flare Flame Flood Blitz Smoke Pin Image Chocobo Shiva Indra Jinn Levia Baham Asura 2 Asura 1 Bomb Mist Imp Mage Cockatrice Asura 3 Sylph Titan Odin'),
('Plinking Demonstration', 'TheLCC demonstrates plinking and adds a place where it impacts equipping', 'https://www.twitch.tv/videos/42248258', 'Video', 'plink plinking tutorial guide menuing menu'),
('Plinking Demonstration', 'Soleras demonstrates quick menu movement in this plinking tutorial', 'https://www.twitch.tv/videos/1127779621', 'Video', 'plink plinking tutorial guide menuing menu'),
('Key Item Safety Checks', 'Documentation for Key Item safety checks, and the Kunsafe flag', 'https://wiki.ff4fe.com/doku.php?id=key_item_randomization#safety_checks', 'Article', 'Kunsafe safety unsafe documentation'),
('Boss Safety Checks', 'Documentation for the Boss safety checks, and the Bunsafe flag', 'https://wiki.ff4fe.com/doku.php?id=boss_randomization#safety_checks', 'Article', 'Bunsafe safety unsafe documentation Golbez Wyvern Valvalis Odin DKC Pain'),
('Shop Safety Guarantees', 'Documentation for the Shop safety Guarantees, and the Bunsafe flag', 'https://wiki.ff4fe.com/doku.php?id=shop_randomization#safety_guarantees', 'Article', 'Sunsafe safety unsafe documentation shops'),
('Post Pitfall Return Warp', 'ScytheMarshall shows you how to get back up to Upper Babil after you step on that pitfall', 'https://clips.twitch.tv/PlacidOilyBasenjiCopyThis-7uTzd3BHY5gmXdeE', 'Video', 'Pitfall Babil Return'),
('Who Needs a Pink Tail?', 'Tybalt gambles and comes up with more than gold.', 'https://www.twitch.tv/rpglimitbreak/clip/GleamingEndearingRavenThunBeast-UJkCj7Imtkiag5o3', 'Video', 'Pink Puff Adamant Armor Drop'),
('Wiki Glossary', 'Get the lowdown on some terms and concepts in FE', 'https://wiki.ff4fe.com/doku.php?id=glossary','Article', '1200 strats Agility Anchor Back Row Glitch Battle Speed Crumble Skip Eddy Strats Fu Palom and Friends Life Glitch Lock Nerf Plink Reflect Run Buffer Slingshot Thunderstruck Wyvern Standard Time Wombo Combo'),
('Character Stats', 'An overview of what each of the five stats does in FFIV, as well as where character level is included in formulas', 'https://wiki.ff4fe.com/doku.php?id=character_stats_explained', 'Article', 'str strength agi agility vit vitality wisdom wis will level character stats'),
('Battle Mechanics', 'A fairly detailed look the various systems related to battles in FFIV. Includes links to sources for more detail and relevant extra information', 'https://wiki.ff4fe.com/doku.php?id=battle_mechanics', 'Article', 'str agi strength agility battle mechanics formula will wis wisdom atb relative agility timer battle speed run buffering algorithm'),
('Checks In Time', 'Timings for how long certain checks or actions take', 'https://docs.google.com/spreadsheets/d/1v14Intwz-kGhiKNq1aax53yeGA45b2Mb4Z3ELW6rxc8/edit#gid=0', 'Article', 'Check Timings How Long'),
('Tallgrant Explains: Relative Agility', 'Tallgrant discusses Relative Agility and the ATB system', 'https://www.youtube.com/playlist?list=PLRXyrx0u7NaXlYCFVw6Mdf0dQaiFpuFoG', 'Video', 'RA Relative Agility Anchor ATB Active Time Battle'),
('ZZ6 Rules document', 'Tournament rules document for the Zemus Zone 6 tournament', 'https://docs.google.com/document/d/1Bo7btycSUeuo9Lg0Mj08Rb40km4xT54vcQ8Hx9U-BuY', 'Article', 'ZZ6 Rules Document'),
('Consolidated Grind Charts', 'A Consolidation of various grind charts with some extra explanation', 'https://docs.google.com/document/d/1bQ5KmvBkB4UcQAzFoie3W4rnMkRLFJZUpBNgP4FJkPA', 'Article', 'D.Machine MacGiant Red D Dragon grind charts guide'),
('3x Red Dragon step chart', 'Step chart for getting the triple red dragon grind', 'https://docs.google.com/spreadsheets/d/1y-Afxk2xXivvT_nLdQAM6ljnKKBYqTnkHeGsrFbvbkw', 'Article', 'Red D Dragon grind step charts guide'),
('Need for Speed (Modifiers)', 'A chart for how fast and slow alter the effective Relative Agility in battle', 'https://docs.google.com/spreadsheets/d/1FeeL7GnBnaGdvbeUgmpj9HjwQW4QfpINAdPNugNSOgM', 'Article', 'RA Speed Modifier Lookup chart Fast Slow Hermes Silkweb'),
('Tpro Treasure Probability Curves', 'Wiki page listing the tpro treasure probability curves', 'https://wiki.ff4fe.com/doku.php?id=treasure_probability_curves', 'Article', 'Treasure Probably tpro curves'),
('Twildish Treasure Probability Curves', 'Wiki page listing the tpro treasure probability curves', 'https://wiki.ff4fe.com/doku.php?id=treasure_probability_curves_twildish', 'Article', 'Treasure Probably twildish curves'),
('FF4 Encounter Finder', 'Simbu created a page to help in creation of any step chart', 'https://simbu95.github.io/FF4EncounterFinder/', 'Article', 'Encounter Seed Finder Step Route Chart'),
('Wiki: Useful Tools', 'The wiki page with links to lots of useful tools, including trackers and lookup spreadsheets', 'https://wiki.ff4fe.com/doku.php?id=useful_tools', 'Article', 'Useful tools trackers autotrackers lookup charts'),
('Wiki: Enemy List', 'Wiki page with links to all the enemy scripts and information. Stats are for vanilla locaitons.', 'https://wiki.ff4fe.com/doku.php?id=enemy_list', 'Article', 'Enemy List Scripts'),
('FF4 KB: Enemy List', 'Aexoden''s Knowledge Base page for all enemy scripts and information. Stats are for vanilla, including JP and EZ Type data', 'https://ff4kb.aexoden.com/info/monsters/', 'Article', 'Enemy List Knowledge Base JP EZ Type'),
('FE Forks', 'A listing of public forks of the FE GitHub repository', 'https://github.com/HungryTenor/FreeEnterprise4/forks?include=active%2Cinactive%2Cnetwork&page=1&period=2y&sort_by=last_updated', 'Article', 'FE Open Source Forks'),
('FE Repository', 'The GitHub repository for open sourced Free Enterprise', 'https://github.com/HungryTenor/FreeEnterprise4', 'Article', 'GitHub Repository Free Enterprise'),
('Wiki: FE New Flag', 'Wiki page from sgrunt listing the steps required to add a new flag to your fork of FE', 'https://wiki.ff4fe.com/doku.php?id=dev:adding_a_new_flag', 'Article', 'New Flag Open Source Help'),
('Wiki: FE dev documentation', 'Wiki page listing some resources and links for developing your fork of FE', 'https://wiki.ff4fe.com/doku.php?id=dev:home', 'Article', 'FE Fork Documentation Help'),
('Wiki: Character Data', 'Wiki page with links to various character data pages', 'https://wiki.ff4fe.com/doku.php?id=character_data', 'Article', 'Character Data Summary'),
('DKC Level Chart', 'Level chart for Dark Knight Cecil', 'https://wiki.ff4fe.com/doku.php?id=dkc_stats_raw', 'Article', 'DKC Dark Knight Cecil Stats Level Up'),
('DKC Equipment List', 'A detailed list of equipment DKC can equip', 'https://wiki.ff4fe.com/doku.php?id=dkc_equipment', 'Article', 'DKC Dark Knight Cecil Equipment'),
('DKC Summary', 'Summary page for Dark Knight Cecil', 'https://wiki.ff4fe.com/doku.php?id=dark_knight_cecil', 'Article', 'DKC Character Summary Dark Knight Cecil'),
('Cecil (Paladin) Level Chart', 'Level chart for Paladin Cecil', 'https://wiki.ff4fe.com/doku.php?id=paladin_stats', 'Article', 'Paladin Cecil Stats Level Up'),
('Cecil (Paladin) Equipment List', 'A detailed list of equipment Paladin Cecil can equip', 'https://wiki.ff4fe.com/doku.php?id=paladin_equipment', 'Article', 'Paladin Cecil Equipment'),
('Cecil (Paladin) Summary', 'Summary page for Paladin Cecil', 'https://wiki.ff4fe.com/doku.php?id=paladin_cecil', 'Article', 'Character Summary Paladin Cecil'),
('Kain Level Chart', 'Level chart for Kain', 'https://wiki.ff4fe.com/doku.php?id=kain_stats_raw', 'Article', 'Kain Stats Level Up'),
('Kain Equipment List', 'A detailed list of equipment Kain can equip', 'https://wiki.ff4fe.com/doku.php?id=kain_equipment', 'Article', 'Kain Equipment'),
('Kain Summary', 'Summary page for Kain', 'https://wiki.ff4fe.com/doku.php?id=kain', 'Article', 'Kain Character Summary '),
('Rydia Level Chart', 'Level chart for Rydia', 'https://wiki.ff4fe.com/doku.php?id=rydia_stats_raw', 'Article', 'Rydia Stats Level Up'),
('Rydia Equipment List', 'A detailed list of equipment Rydia can equip', 'https://wiki.ff4fe.com/doku.php?id=rydia_equipment', 'Article', 'Rydia Equipment'),
('Rydia Summary', 'Summary page for Rydia', 'https://wiki.ff4fe.com/doku.php?id=rydia', 'Article', 'Character Summary Rydia'),
('Tellah Level Chart', 'Level chart for Tellah', 'https://wiki.ff4fe.com/doku.php?id=tellah_stats_raw', 'Article', 'Tellah Stats Level Up'),
('Tellah Equipment List', 'A detailed list of equipment Tellah can equip', 'https://wiki.ff4fe.com/doku.php?id=tellah_equipment', 'Article', 'Tellah Equipment'),
('Tellah Summary', 'Summary page for Tellah', 'https://wiki.ff4fe.com/doku.php?id=tellah', 'Article', 'Tellah Character Summary'),

('Edward Level Chart', 'Level chart for Edward', 'https://wiki.ff4fe.com/doku.php?id=edward_stats_raw', 'Article', 'Edward Stats Level Up'),
('Edward Equipment List', 'A detailed list of equipment Edward can equip', 'https://wiki.ff4fe.com/doku.php?id=edward_equipment', 'Article', 'Edward Equipment'),
('Edward Summary', 'Summary page for Edward', 'https://wiki.ff4fe.com/doku.php?id=edward', 'Article', 'Edward Character Summary'),

('Rosa Level Chart', 'Level chart for Rosa', 'https://wiki.ff4fe.com/doku.php?id=Rosa_stats_raw', 'Article', 'Rosa Stats Level Up'),
('Rosa Equipment List', 'A detailed list of equipment Rosa can equip', 'https://wiki.ff4fe.com/doku.php?id=Rosa_equipment', 'Article', 'Rosa Equipment'),
('Rosa Summary', 'Summary page for Rosa', 'https://wiki.ff4fe.com/doku.php?id=Rosa', 'Article', 'Rosa Character Summary'),

('Yang Level Chart', 'Level chart for Yang', 'https://wiki.ff4fe.com/doku.php?id=Yang_stats_raw', 'Article', 'Yang Stats Level Up'),
('Yang Equipment List', 'A detailed list of equipment Yang can equip', 'https://wiki.ff4fe.com/doku.php?id=Yang_equipment', 'Article', 'Yang Equipment'),
('Yang Summary', 'Summary page for Yang', 'https://wiki.ff4fe.com/doku.php?id=yang', 'Article', 'Yang Character Summary'),

('Palom Level Chart', 'Level chart for Palom', 'https://wiki.ff4fe.com/doku.php?id=Palom_stats_raw', 'Article', 'Palom Stats Level Up'),
('Palom Equipment List', 'A detailed list of equipment Palom can equip', 'https://wiki.ff4fe.com/doku.php?id=Palom_equipment', 'Article', 'Palom Equipment'),
('Palom Summary', 'Summary page for Palom', 'https://wiki.ff4fe.com/doku.php?id=Palom', 'Article', 'Palom Character Summary'),

('Porom Level Chart', 'Level chart for Porom', 'https://wiki.ff4fe.com/doku.php?id=porom_stats_raw', 'Article', 'Porom Stats Level Up'),
('Porom Equipment List', 'A detailed list of equipment Porom can equip', 'https://wiki.ff4fe.com/doku.php?id=porom_equipment', 'Article', 'Porom Equipment'),
('Porom Summary', 'Summary page for Porom', 'https://wiki.ff4fe.com/doku.php?id=porom', 'Article', 'Porom Character Summary'),

('Cid Level Chart', 'Level chart for Cid', 'https://wiki.ff4fe.com/doku.php?id=Cid_stats_raw', 'Article', 'Cid Stats Level Up'),
('Cid Equipment List', 'A detailed list of equipment Cid can equip', 'https://wiki.ff4fe.com/doku.php?id=Cid_equipment', 'Article', 'Cid Equipment'),
('Cid Summary', 'Summary page for Cid', 'https://wiki.ff4fe.com/doku.php?id=cid', 'Article', 'Cid Character Summary'),

('Edge Level Chart', 'Level chart for Edge', 'https://wiki.ff4fe.com/doku.php?id=Edge_stats_raw', 'Article', 'Edge Stats Level Up'),
('Edge Equipment List', 'A detailed list of equipment Edge can equip', 'https://wiki.ff4fe.com/doku.php?id=Edge_equipment', 'Article', 'Edge Equipment'),
('Edge Summary', 'Summary page for Edge', 'https://wiki.ff4fe.com/doku.php?id=edge', 'Article', 'Edge Character Summary'),

('FuSoYa Level Chart', 'Level chart for FuSoYa', 'https://wiki.ff4fe.com/doku.php?id=FuSoYa_stats_raw', 'Article', 'FuSoYa Stats Level Up'),
('FuSoYa Equipment List', 'A detailed list of equipment FuSoYa can equip', 'https://wiki.ff4fe.com/doku.php?id=FuSoYa_equipment', 'Article', 'FuSoYa Equipment'),
('FuSoYa Summary', 'Summary page for FuSoYa', 'https://wiki.ff4fe.com/doku.php?id=FuSoYa', 'Article', 'FuSoYa Character Summary'),
('Thunderstruck Odin Example', 'A demonstration of using Hide to help with Thunderstruck strats', 'https://www.twitch.tv/videos/1524671396?collection=4SYUrOKspxfvvw', 'Video', 'Thunderstruck Odin Edward Hide'),
('Zemus Zone VI Playlist', 'The official playlist of restreams for Highway to the Zemus Zone VI', 'https://www.youtube.com/playlist?list=PLIhBU7viDbCbskpxLzQZ7ciLMysbpO0Na', 'Video', 'ZZ6 Zemus Zone Six VOD playlist youtube'),
('FreeEnterprise YouTube Playlist Page', 'All the playlists from the FreeEnterprise YouTube channel', 'https://www.youtube.com/@FreeEnterprise/playlists', 'Video', 'VOD playlist YouTube youtube FreeEnterprise'),
('FF4fe ATB Agility Basics', 'riversmccown covers some agility and atb basics, with a Lua script helping show normally hidden values', 'https://www.youtube.com/watch?v=WIGOO3T-j-8&list=PLIhBU7viDbCbeBD_9Da53YxaJZ3f8UIms&index=1', 'Video', 'ATB agility tutorial LUA riversmccown rivers'),
('Kmain/Ksummon Odds', 'A spreadsheet from TwistedFlax helping you determine Ksummon and Kmoon check odds, given current conditions in a seed', 'https://docs.google.com/spreadsheets/d/1L8MKeFXnbyV1w5MRsvgRseAH_nvsrI1GiQUPz3bf1cM/edit?gid=160243468#gid=160243468', 'Article', 'odds probability kmain ksummon key item'),
('D2T Rules Doc', 'Doorway To Tomorrow side tournament rules document', 'https://docs.google.com/document/d/1J8t6vjcPptrqd5SRwaCpEkuAZ-uoMiIeMqJFmFEGhdY/', 'Article', 'Tournament Rules Document D2T Doorway To Tomorrow Side Tournament'),
('Penguin8r vs ZZ1 Rules Doc ', 'Penguin8r performs the 64 floor glitch during a Zemus Zone 1 race', 'https://youtu.be/CGprbT1ahro?si=VGtFOFD2wJqm8Ull&t=3987', 'Video', 'ZZ1 Penguin8r 64 glitch'),
('100k seed KI placements', 'A spreadsheet with 100k spoiler logs analyzed for multiple flagsets', 'https://docs.google.com/spreadsheets/d/1IzvTW7YT2teP5NvhAOkZ3PRJCqFg1E-gu4TbBjJODw0', 'Article', '100,000 100000 100k spoiler analysis'),
('AFC Rules Doc', 'All Forked Cup tournament rules document', 'https://docs.google.com/document/d/1O3Kr5gB0niU2KCArtXzjmnCmFFEBwgVA7Nas7FIGANM', 'Article', 'AFC Butt Fumble Rules Document Team Tournament ACE FBF ZZA')
;
