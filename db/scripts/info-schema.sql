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
        setweight(to_tsvector('english',summary), 'C') :: tsvector
    ) stored
);

create index idx_search on info.guides using GIN(search);

insert into info.guides (title, summary, link, link_type, tags)
VALUES
('Death of upt Co', 'fcoughlin shows off very special Zeromus fight', 'https://www.twitch.tv/videos/293657539', 'Video', 'Edward Zermous upt Co no64 G64'),
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
('Boss Stats Lookup', 'Website showing boss stats and location-specific script information', 'https://info.tellah.life/boss-stats/', 'Article', 'Boss Information Stats'),
('Nearly 100% walkthrough', 'riversmmccown provides a thorough walkthrough of the game. A good watch for newbies', 'https://www.twitch.tv/videos/255276943', 'Video', 'Newbie Walkthrough Demonstation Dupe Glitch'),
('3x Red D. encounter manip', 'ScytheMarshall shows off, in a race, manipulating encounters to get the pack of three Red D. in the Lunar Core', 'https://www.twitch.tv/videos/1489314531?t=00h46m42s', 'Video', 'Encounter Manip Grind Red Dragon SOTW Race'),
('Plague Reflect Example', 'An example of reflecting Count and having Plague fall to self-inflicted doom', 'https://www.twitch.tv/videos/2024235833', 'Video', 'Plague Reflect Count Example'),
('Inven''s FF4fe Duplication Guide', 'Inven created a step-by-step guide, with screenshots, for how to perform the duplication glitches available when Gdupe is enabled', 'https://docs.google.com/document/d/1ccSSohY1YyFflhuAaPaTvRprBoFHtxUHh-Eqap5FL1g', 'Article', 'Gdupe Duplication Glitch Tutorial How-To Guide Weapon Armor'),
('Who''s My Anchor?', 'An image flowchart showing who the agility anchor is, and helps make it clear when both Chero and -vanilla:agility are in play', 'https://ff4-fe-info.s3.us-west-2.amazonaws.com/library-images/agility-flowchart-p.jpg', 'Image', 'Chero vanilla agility anchor'),
('Kirchin Unveils Eddy Strats', 'The first time Edward strats are used in a Free Enterprise race', 'https://youtu.be/-AxFYQBB8gE?si=GHVyvJrqAoEZ4yLI&t=3145', 'Video', 'WSOFE Edward Strats Zeromus'),
('Alt Gauntlet Formations', 'A list of all the formations for the [Alt Gauntlet](<>) at each location', 'https://wiki.ff4fe.com/doku.php?id=alt_gauntlet', 'Article', 'Alt Gauntlet Enemy Formations'),
('Evil Wall - Eddy Strats Potential', 'A reference spreadsheet for figuring out if you can use Hide to let Evil Wall beat itself up', 'https://docs.google.com/spreadsheets/d/1TQY6hGjqkC1NQGDv_M0pzPQa2xZZlAT7rzCzCNLyX1g', 'Article', 'Edward Evil Wall Hide Strats Reference Lookup'),
('Evil Wall - Eddy Strats Potential', 'A reference spreadsheet for figuring out if you can use Hide to let Evil Wall beat itself up', 'https://docs.google.com/spreadsheets/d/1TQY6hGjqkC1NQGDv_M0pzPQa2xZZlAT7rzCzCNLyX1g', 'Article', 'Edward Evil Wall Hide Strats Reference Lookup'),
('Zeromus Hide Strats', 'A write-up for how to defeat Zeromus with the power of ~~cowards!~~ Edward''s Hide Command', 'https://docs.google.com/document/d/1Xw1vsN-OROShv4ZxPcStwJ1LsmFlPcZr3IIjOBSNEww/edit#heading=h.dvcyslrwgp71', 'Article', 'Low Level Edward Zeromus Strats Reflect StarVeil'),
('1200 Strats - Full Party', 'Zilch explains how to defeat Zermous when your party has only about 1200 HP per character', 'https://www.twitch.tv/videos/1051386268', 'Video', 'Zeromus 1200 HP Strats Reflect StarVeil Vampire Cure3'),
('1200 Strats - 2 Character', 'Zilch explains how to defeat Zermous with just a couple characters having 1200 or more HP', 'https://www.twitch.tv/videos/1051391891', 'Video', 'Zeromus 1200 HP Strats Reflect StarVeil Vampire Cure3'),
('Asura Face Changing Demo', 'A demonstration of how Asura changes faces as reaction to being bopped. Uses a LUA script to display game data', 'https://www.twitch.tv/videos/2008550932', 'Asura Face Reaction Lua')
('John Birckhead Explains: Relative Agility (sort of)', 'A discussion of the math behind Relative Agility in Free Enterprise', 'https://www.twitch.tv/videos/1827822112', 'Video', 'Relative Agility Tutorial'),
('John Birckhead Explains: D.Machin grinds', 'A walkthrough for how to read the various guides for manipulating the D.Machin grind, and an example fight', 'https://www.twitch.tv/videos/1690480090', 'Video', 'D.Machin Grind Tutorial Example'),
('John Birckhead Explains: Dupe Glitch', 'A video tutorial for the duplication glitch', 'https://www.twitch.tv/videos/1745502727', 'Video', 'GDupe Dupe Glitch Tutorial'),
('FE: Family Feud Edition', 'A fun time at Johncon where FE gets a Family Feud Makover', 'https://www.twitch.tv/videos/1844514661', 'Video', 'Fun Family Feud'),
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
('Icicles', 'Just one Glance from Wyvern, and Edward changes sides', 'https://clips.twitch.tv/DepressedAmazingMomNerfRedBlaster', 'Image', 'Wyvern Edward Glance Fun'),
('Angry Cookie', 'An image of an angry looking cookie', 'https://ff4-fe-info.s3.us-west-2.amazonaws.com/fun/angry_cookie.png', 'Image', 'Angry Cookie Fun'),
('Quokka Twins', '', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Curious_quokka_twins_%2827802025295%29.jpg/640px-Curious_quokka_twins_%2827802025295%29.jpg', 'Image', 'Quokka Fun')
;
