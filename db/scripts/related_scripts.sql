-- select id from races.race_detail where room_name = 'ff4fe/odd-kainazzo-0938'
-- except
-- select min(id) as id from races.race_detail where race_detail.room_name = 'ff4fe/odd-kainazzo-0938'
-- order by id

-- select rd.id as "RaceId"
--     , 'https://racetime.gg/'::text || room_name
--     , metadata['Description'] as "Description"
--     , metadata['Status'] as "Status"
-- from races.race_detail rd
-- left join seeds.rolled_seeds rs on rd.id = rs.race_id
-- where metadata['Goal'] = to_jsonb('All Forked Cup team tournament'::text)
-- and metadata['Status'] is null
-- and rs.race_id is null

-- select id
--     , 'https://racetime.gg/'::text || room_name
--     , metadata['Description'] as "Description"
--     , metadata['Status'] as "Status"
-- From races.race_detail
-- where metadata['Goal'] = to_jsonb('All Forked Cup team tournament'::text)
-- and metadata['Description'] = to_jsonb(''::text)
-- and metadata['Status'] is null
-- order by id;

-- select * from races.race_detail;
-- select * from seeds.rolled_seeds order by id;

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
-- ('clean-staleman-8620', 'FFA', 'Racetime.gg', '{
--     "Goal": "All Forked Cup team tournament",
--     "Description": "All Forked Cup Finals: JudgeJoe vs Skarcerer"
-- }'::jsonb);
-- ('ff4fe/grumpy-green-3216', 'FFA', 'Racetime.gg', '{
--     "Goal": "All Forked Cup team tournament",
--     "Description": "JohnBirckhead vs OneFreeFitz"
-- }'::jsonb),
-- ('ff4fe/flying-cream-6659', 'FFA', 'Racetime.gg', '{
--     "Goal": "All Forked Cup team tournament",
--     "Description": "Leaf vs tallgrant"
-- }'::jsonb)
-- ;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('lordgoober vs JRTate (ACE)'::text)
-- where id = 170;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Tybalt2010 vs elvensorrow (ZZA)'::text)
-- where id = 173;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Stoney vs skarcerer (ZZA)'::text)
-- where id = 185;

-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Vitasia vs Cubsrule21 (ACE)'::text)
-- where id = 186;

select rd.id as "RaceId"
    , 'https://racetime.gg/'::text || room_name
    , metadata['Description'] as "Description"
    , metadata['Status'] as "Status"
    , rs.flagset
from races.race_detail rd
left join seeds.rolled_seeds rs on rd.id = rs.race_id
where (metadata ->> 'Goal' = 'All Forked Cup team tournament' or 'All'
and flagset is not null
and null is null
and rd.metadata ->> 'Description' like '%Vitasia%'

-- explain analyze select * from races.race_detail where metadata ->> 'Description' like '%Fleury%'
-- select * from seeds.rolled_seeds where seed = '0VT3EGASV1'

-- create index idx_desc on races.race_detail using btree ((metadata ->> 'Description'));

select
      rd.id as RaceId,
      room_name as RoomName,
      race_host as RaceHost,
      race_type as RaceType,
      metadata as Metadata,
      flagset as Flagset,
      max(rs.id) as SeedId
      FROM races.race_detail rd
      left join seeds.rolled_seeds rs on rs.race_id = rd.id
      where ('updates' is null or metadata ->> 'Description' like '%updates%')
      and (null is null or rs.flagset_search @@ websearch_to_tsquery('english', null))
      group by RoomName, RaceHost, RaceType, Metadata, Flagset, RaceId
      order by RaceId
      offset 0
      limit 20
      ;

    select * from races.race_detail ORDER BY id desc limit 1;
    select * from seeds.rolled_seeds order by id desc limit 1;
    -- update races.race_detail set room_name = substring(room_name from (char_length('ff4fe/') + 1))
    select id, room_name, substring(room_name from (char_length('ff4fe/') + 1)) as "UpdatedRoomName"
    from races.race_detail
    where race_detail.race_host = 'Racetime.gg'
    and room_name like 'ff4fe/%'
    order by id;

    update races.race_detail set room_name = substring(room_name from (char_length('ff4fe/') + 1))
    --select id, room_name, substring(room_name from (char_length('ff4fe/') + 1)) as "UpdatedRoomName"
    where race_detail.race_host = 'Racetime.gg'
    and room_name like 'ff4fe/%';

    -- update races.race_detail set room_name = substring(room_name from (char_length('ff4fe/') + 1))
    select *
    from races.race_detail
    where race_detail.race_host = 'Racetime.gg'
    order by id;

with seed_id AS (
    select max (rs.id) as seed_id
    from races.race_detail rd
    left join seeds.rolled_seeds rs on rd.id = rs.race_id
    where rd.id = 36
)

select sh.patch_html
from seeds.saved_html sh
join seed_id rs on sh.rolled_seed_id = rs.seed_id;



select binary_flags from seeds.rolled_seeds order by id desc limit 1;

select 
    id
    , flagset
    , link
    , fe_version
    , seed
    , verification
    , cast(ts_rank(flagset_search, websearch_to_tsquery('english', 'pricey')) as DECIMAL) as Rank
from seeds.rolled_seeds
where (null is null or seed = null)
and (null is null or binary_flags = null)
and ('pricey' is null or flagset_search @@ websearch_to_tsquery('english', 'pricey'))
order by Rank desc, id
offset 0
limit 20
;

select * from seeds.rolled_seeds where race_id = 191;
