create schema if not exists info;

DO $$ BEGIN
    IF to_regtype('linkType') IS NULL THEN
        create TYPE linkType as ENUM ('Article', 'Image', 'Video');
    Else RAISE NOTICE 'linkType already exists, skipping';
    END IF;
END $$;

create table if not exists info.guides(
    id serial primary key,
    title text,
    summary text,
    link text UNIQUE,
    link_type linkType,
    tags text,
    search tsvector generated always as (
        setweight(to_tsvector('simple',tags), 'A') || ' ' ||
        setweight(to_tsvector('english',title), 'B') || ' ' ||
        setweight(to_tsvector('english',title), 'C') :: tsvector
    ) stored
);

create index idx_search on info.guides using GIN(search);

insert into info.guides (title, summary, link, link_type, tags)
VALUES
-- ('Death of upt Co', 'fcoughlin shows off very special Zeromus fight', 'https://www.twitch.tv/videos/293657539', 'Video', 'Edward Zermous upt Co no64 G64'),
-- ('Door Grind', 'a video showing a couple methods of killing Doors in Sealed Cave', 'https://www.twitch.tv/videos/1086216532', 'Video', 'Door Grind Sealed Cave'),
-- ('PB2J Jumps', 'a video demonstrating many of the shortcuts available in PushBToJump (pb2j) seeds', 'https://www.twitch.tv/videos/672286142', 'Video', 'PB2J Skips pushbtojump'),
-- ('So You Think You Can Jump', 'Written guide to learning the pushbtojump flag', 'https://docs.google.com/document/d/1YYY5ODIeSoup2yT5dcIP6zNTx8-oLBTMPSr2CEaaXYQ', 'Article', 'PB2J pushbtojump guide'),
-- ('PB2J Inventory Warp', 'Aexoden demonstrates how the pb2j flag can enable some true game breaking', 'https://www.youtube.com/watch?v=TUJhO64z-ZI', 'Video', 'PB2J pushbtojump Inventory Warp'),
-- ('PB2J on GDQ Random Number Generation', 'Gambit017 hops through a PB2J seed on the GDQ Random Number Generation show', 'https://youtu.be/OoatsifY4vQ?t=7136', 'Video', 'PB2J pushbtojump GDQ Games Done Quick'),
('FE Newbies Guide', 'riversmccown provides a wealth of information for players on their first runs. A very solid introduction and foundation for Free Enterprise.', 'https://docs.google.com/document/d/1a1t3H4aX-yB2_wM67iKy_dwdCjJzY4qAyWfKzRCv8Og', 'Article', 'Newbie Guide Overview Get Started'),
('Newbies Guide to Glitches', 'riversmccown outlines the glitches in FE and provides links to videos and further explanations', 'https://docs.google.com/document/d/1X2TR4yKmkw9jZbILG-YsJPI6MPeecF3gqDJ06bAiiPQ', 'Article', 'Glitches Newbie Guide Overview Get Started'),
('Equipment Chart', 'SwimmyLionni compiled this image for equipment lookups. Pre 4.1 stats', 'https://imgur.com/BQz2Lsd', 'Image', 'Equipment Stats Dart Weapon Armor'),
('D.Machin Grind Finder', 'Inven demonstrates how to find the D.Machin grind fight', 'https://www.twitch.tv/videos/262928495', 'Video', 'D.Machin Grind Giant Encounter Manip Searcher'),
('D.Machin Grind Image', 'Hosted image for finding the D.Machine grind fight, from Aexoden', 'https://ff4kb.aexoden.com/static/myself086/GrindFightManip.PNG', 'Image', 'D.Machine Grind Giant Encounter Manip Searcher'),
('D.Machin Ecantrun Grind Finder', 'Simbu and TwistedFlax created this guide for setting up the D.Machin manip when Ecantrun is enabled', 'https://docs.google.com/document/d/1omLzoWgVrxFemXKvPjtWXLLwso6eNew9CRF8rMkBSCM', 'Article', 'D.Machin Grind Giant Ecantrun Searcher Encounter Manip'),
('MacGiant Ecantrun Grind Finder', 'Simbu and TwistedFlax created this guide for setting up the MacGiant manip when Ecantrun is enabled', 'https://docs.google.com/document/d/13P1RM2ExMMHS9qbTyFN59AqecOWs5r2Yp2xgWCdUjMo', 'Article', 'MacGiant Grind Giant Ecantrun Searcher Encounter Manip'),
('MacGiant Grind Finder', 'Aexoden created this to help manip the MacGiant grind fight while walking through the Giant', 'https://ff4kb.aexoden.com/tools/grind-finder/', 'Article', 'MacGiant Grind Giant Searcher Encounter Manip'),
('Common Grinds', 'A summary of many common grinds used while playing FE', 'https://wiki.ff4fe.com/doku.php?id=common_grinds', 'Article', 'D.Machin Doors Siren Yellow Gold Dragon Warlock Searcher Reaction Encounter Manip'),
('Other Step Manipulation Grinds', 'Simbu and TwistedFlax also made step manipulation charts for Warlocks, Gold Dragons (King-Ryu), Sorcerer fights, and the Reaction grind', 'https://docs.google.com/document/d/1u3vlgjO2LJB3-XQntoQw8DzpXfQ-GxHZk_79DcQg8M8', 'Article', 'Encounter Step Manip Grind Warlok Gold Dragon King-Ryu Reaction Sorcerer'),
('Grind Calculator', 'Make a copy of this spreadsheet from mxzv to help calculate how far to take your grind', 'https://docs.google.com/spreadsheets/d/1lkHY--4KtJR6TJRy7oKxJOrLI0Z-CsF5dlEkEcd5ykQ', 'Article', 'Grind Calculator Tool'),
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
('Boss Stats Lookup', 'Webiste showing boss stats and location-specific script information', 'https://info.tellah.life/boss-stats/', 'Article', 'Boss Information Stats')
;
