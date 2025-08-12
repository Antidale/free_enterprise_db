FROM postgres:17-alpine AS db
WORKDIR /app
COPY ./db/scripts/docker.sql /docker-entrypoint-initdb.d

