create schema if not exists tournament;

create table if not exists tournament.tournaments(
    id serial primary key,
    guild_id text,
    tracking_channel_id text,
    tracking_message_id text,
    tournament_name text,
    registration_start timestamp with time zone,
    registration_end timestamp with time zone,
);

create table if not exists tournament.entrant(
    id serial primary key
    user_id text,
    user_name text,
);

create table if not exists tournament.entry(
    tournament_id int references tournaments(id)
    etrant_id int references entrants(id)
    registered_on timestamp 
);
