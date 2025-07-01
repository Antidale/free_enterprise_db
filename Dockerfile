FROM postgres:17 AS db
WORKDIR /app
COPY ./db/scripts/docker.sql /docker-entrypoint-initdb.d

