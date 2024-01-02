create schema if not exists info;

drop table info.guides;

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
('Death of upt Co', 'fcoughlin shows off very special Zeromus fight', 'https://www.twitch.tv/videos/293657539', 'Video', 'Edward Zermous upt Co no64 G64'),
('Door Grind', 'a video showing a couple methods of killing Doors in Sealed Cave', 'https://www.twitch.tv/videos/1086216532', 'Video', 'Door Grind Sealed Cave'),
('PB2J Jumps', 'a video demonstrating many of the shortcuts available in PushBToJump (pb2j) seeds', 'https://www.twitch.tv/videos/672286142', 'Video', 'PB2J Skips pushbtojump'),
('So You Think You Can Jump', 'Written guide to learning the pushbtojump flag', 'https://docs.google.com/document/d/1YYY5ODIeSoup2yT5dcIP6zNTx8-oLBTMPSr2CEaaXYQ', 'Article', 'PB2J pushbtojump guide'),
('PB2J Inventory Warp', 'Aexoden demonstrates how the pb2j flag can enable some true game breaking', 'https://www.youtube.com/watch?v=TUJhO64z-ZI', 'Video', 'PB2J pushbtojump Inventory Warp'),
('PB2J on GDQ Random Number Generation', 'Gambit017 hops through a PB2J seed on the GDQ Random Number Generation show', 'https://youtu.be/OoatsifY4vQ?t=7136', 'Video', 'PB2J pushbtojump GDQ Games Done Quick');
('FE Newbies Guide', 'riversmccown provides a wealth of information for players on their first runs. A very solid introduction and foundation for Free Enterprise.', 'https://docs.google.com/document/d/1a1t3H4aX-yB2_wM67iKy_dwdCjJzY4qAyWfKzRCv8Og', 'Article', 'Newbie Guide Overview Get Started')
('Newbies Guide to Glitches', 'riversmccown outlines the glitches in FE and provides links to videos and further explanations', 'https://docs.google.com/document/d/1X2TR4yKmkw9jZbILG-YsJPI6MPeecF3gqDJ06bAiiPQ', 'Article', 'Glitches Newbie Guide Overview Get Started')

;

select exists (select * from pg_type where typname = 'linkType' and typnamespace = (select oid from pg_namespace where nspname = 'info'));

DO $$ BEGIN
    IF to_regtype('linkType') IS NULL THEN
        create TYPE linkType as ENUM ('Article', 'Image', 'Video');
    END IF;
END $$;

