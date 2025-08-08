-- drop table races.race_entrants;
-- drop table races.racers;

-- create table races.racers (
-- 	id serial primary key,
-- 	discord_id text default '',
-- 	discord_display_name text default '',
-- 	racetime_display_name text default '',
-- 	racetime_id text default '',
-- 	twitch_name text default ''
-- );

-- create table races.race_entrants (
-- 	race_id int references races.race_detail(id),
-- 	entrant_id int references races.racers(id),
-- 	finish_time interval,
-- 	placement smallint,
-- 	/*
-- 		for racetime, will have things like:
-- 		comment (if present)
-- 		points change
-- 		status (finished/cancelled/dq probably?)
-- 	*/
-- 	metadata jsonb
-- );

select * from races.racers limit 1; where racetime_id = '7QXz83KAaaWeZDjr'order by id;
select * from races.race_detail order by id;
select * from races.race_entrants;

delete from races.race_entrants where entrant_id > 2; -- 754
delete from races.race_detail where id > 56; -- 246
delete from races.racers where id > 2; -- 103

select * from races.race_detail order by id;

select id, metadata->>'Status' as Status
from races.race_detail
where room_name = 'neutral-green-2350'
and metadata ? 'Status'
union 
select id, '' as Status
from races.race_detail
where room_name = 'neutral-green-2350'
order by status desc
limit 1
;


-- delete from races.racers where id > 2;
-- insert into races.race_entrants(entrant_id, race_id, finish_time, placement)
--     select id, 396, 'P0DT01H21M26.925519S'::interval, 1
--     from races.racers where racetime_id = '5zbdeWeeJ6WYPK8O'


-- insert into races.race_entrants(entrant_id, race_id,  metadata )
-- select id, 4, '{
--  "status": "dnf"
-- }'::jsonb
-- from races.racers where racetime_id = '14'

-- insert into races.race_entrants(entrant_id, race_id, finish_time, placement, metadata)
-- select id, 1294, 'P0DT01H13M42.041393S'::interval, 1, '{}'::jsonb
-- from races.racers where racetime_id = '7QXz83KAaaWeZDjr'
-- returning entrant_id;
select * from races.race_detail order by id;

