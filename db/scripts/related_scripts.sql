-- select id from races.race_detail where room_name = 'ff4fe/odd-kainazzo-0938'
-- except
-- select min(id) as id from races.race_detail where race_detail.room_name = 'ff4fe/odd-kainazzo-0938'
-- order by id

-- select rd.id as "RaceId"
--     , 'https://racetime.gg/ff4fe'::text || room_name
--     , metadata['Description'] as "Description"
--     , metadata['Status'] as "Status"
-- from races.race_detail rd
-- left join seeds.rolled_seeds rs on rd.id = rs.race_id
-- where metadata['Goal'] = to_jsonb('All Forked Cup team tournament'::text)
-- and metadata['Status'] is null
-- and rs.race_id is null

-- select id
--     , 'https://racetime.gg/ff4fe'::text || room_name
--     , metadata['Description'] as "Description"
--     , metadata['Status'] as "Status"
-- From races.race_detail
-- where metadata['Goal'] = to_jsonb('All Forked Cup team tournament'::text)
-- and metadata['Description'] = to_jsonb(''::text)
-- and metadata['Status'] is null
-- order by id;

-- update races.race_detail
-- set metadata['Status'] = to_jsonb('Canceled' ::text)
-- where id = 4;



select id, metadata->>'Status' from races.race_detail where id=4;
-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Guerin vs Blues Eclipse (FBF)'::text)
-- where id = 111;


insert into races.race_detail(room_name, race_type, race_host, metadata)
values
-- ('clean-staleman-8620', 'FFA', 'Racetime.gg', 
'{
 "Goal": "All Forked Cup team tournament",
 "Description": "All Forked Cup Finals: JudgeJoe vs Skarcerer"
}'::jsonb);


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


