# README

## Checklist to make commit/push

- [ ] In `Dockerfile` update the variables `B_PREVIOUS_VERSION` and `DB_VERSION`

## Start development database

```shell
# CAREFUL: duplicated in back/01_documentation/user-guides/02_how_to_start_it.md

# docker volume create template51-postgres-data-dev
docker run --name t51db_server --rm \
  -v t51db_local:/var/lib/postgresql/data \
  -p 5001:5432 \
  -e POSTGRES_DB=t51db_schema \
  -e POSTGRES_USER=t51db_user \
  -e POSTGRES_PASSWORD=t51db_pass \
  postgres:17.6-alpine3.22 -c log_statement=all

# Checking
psql postgresql://t51db_user:t51db_pass@localhost:5001/t51db_schema
```

Command to include vars in command

```shell
docker run --name template51_liquibase_migration --rm \
  -v ./:/var/liquibase \
  -w /var/liquibase \
  -e DB_NAME=${DB_NAME} \
  -e DB_USER=${DB_USER} \
  -e DB_PASSWORD=${DB_PASSWORD} \
  -e DB_URL=${DB_URL} \
  liquibase:4.33-alpine \
  liquibase update \
    --username=$DB_USER \
    --password=$DB_PASSWORD \
    --url=$DB_URL

```

## liquibase cheat sheet

```shell
# CAREFUL: Duplicated in {journal}/dev/java/liquibase.md > Cheat sheet

# check changes pending and applied
liquibase status

# Apply all pending migrations
liquibase update

# Rollback 1 migration
liquibase rollbackCount 1

# See changes applied
liquibase history

# Create project
liquibase init project

# Rollback to tag
liquibase rollback vXX
```

## DANGER

```sql
-- reset
drop table if exists product_images;
drop table if exists products;
drop table if exists roles;
drop table if exists users_picture;
drop table if exists users_roles;
drop table if exists users;
drop table if exists databasechangelog;
drop table if exists databasechangeloglock;
```
