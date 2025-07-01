
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

-- select id from races.race_detail where room_name = 'ff4fe/odd-kainazzo-0938'
-- except
-- select min(id) as id from races.race_detail where race_detail.room_name = 'ff4fe/odd-kainazzo-0938'
-- order by id

select id, 'https://racetime.gg/'::text || room_name, metadata['Description'] from races.race_detail
where metadata['Goal'] = to_jsonb('All Forked Cup team tournament'::text)
order by id

select * from races.race_detail;


-- update races.race_detail
-- set metadata['Description'] = to_jsonb('Tournament! Race! Kyrios vs BluesEclipse [FBF]'::text)    
-- where id = 81;




select * from seeds.rolled_seeds order by id;
select * from races.race_detail;
