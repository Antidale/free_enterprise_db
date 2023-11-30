create schema if not exists tournament;

create table if not exists tournament.tournaments(
    id serial primary key,
    guild_id text not null,
    guild_name text not null,
    tracking_channel_id text not null,
    tracking_message_id text not null,
    role_id text not null,
    tournament_name text not null,
    registration_start timestamptz,
    registration_end timestamptz,
    UNIQUE(guild_id, tournament_name)
);

create table if not exists tournament.entrants(
    id serial primary key,
    user_id text UNIQUE,
    user_name text NOT NULL,
    pronouns text DEFAULT ''
);

create table if not exists tournament.registrations(
    tournament_id int references tournament.tournaments(id),
    entrant_id int references tournament.entrants(id),
    user_name_alias text,
    registered_on timestamp DEFAULT now()
);