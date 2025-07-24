-- select id from races.race_detail where room_name = 'ff4fe/odd-kainazzo-0938'
-- except
-- select min(id) as id from races.race_detail where race_detail.room_name = 'ff4fe/odd-kainazzo-0938'
-- order by id

select id
    , 'https://racetime.gg/'::text || room_name
    , metadata['Description'] as "Description"
    , metadata['Status'] as "Status"
From races.race_detail
where metadata['Goal'] = to_jsonb('All Forked Cup team tournament'::text)
-- and metadata['Description'] = to_jsonb(''::text)
and metadata['Status'] is null
order by id;

select * from races.race_detail;
select * from seeds.rolled_seeds order by id;

-- update races.race_detail
-- set metadata['Status'] = to_jsonb('Canceled'::text)
-- where id = 86;

-- update races.race_detail
-- set metadata['Status'] = to_jsonb('Canceled'::text)
-- where id = 109;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Guerin vs Blues Eclipse (FBF)'::text)
-- where id = 111;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('keddril vs lordgoober (ACE)'::text)
-- where id = 115;

-- update races.race_detail
-- set metadata['Status'] = to_jsonb('Canceled'::text)
-- where id = 116;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('GilmokToo vs RobsatPlays (FBF)'::text)
-- where id = 117;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Vitasia vs Cubsrule21 (ACE)'::text)
-- where id = 127;

-- update races.race_detail
-- set metadata['Status'] = to_jsonb('NotRecorded'::text)
-- where id = 131;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('keddril vs OneFreeFitz (ACE)'::text)
-- where id = 141;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Boney vs JohnBirckhead (ACE)'::text)
-- where id = 149;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Tybalt2010 vs IAmDMar (ZZA)'::text)
-- where id = 154;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Slippery42 vs Vitasia (ACE)'::text)
-- where id = 157;

-- insert into races.race_detail(room_name, race_type, race_host, metadata)
-- values
-- ('ff4fe/amazing-grenade-8041', 'FFA', 'Racetime.gg', '{
--     "Goal": "All Forked Cup team tournament",
--     "Description": "FoxLisk vs Possumorpheus"
-- }'::jsonb),
-- ('ff4fe/grumpy-green-3216', 'FFA', 'Racetime.gg', '{
--     "Goal": "All Forked Cup team tournament",
--     "Description": "JohnBirckhead vs OneFreeFitz"
-- }'::jsonb),
-- ('ff4fe/flying-cream-6659', 'FFA', 'Racetime.gg', '{
--     "Goal": "All Forked Cup team tournament",
--     "Description": "Leaf vs tallgrant"
-- }'::jsonb)
-- ;
