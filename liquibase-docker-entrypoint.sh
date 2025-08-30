#!/bin/bash
set -e

echo "param-1: $1"

echo "POSTGRES_DB $POSTGRES_DB";
echo "POSTGRES_USER $POSTGRES_USER";
echo "DB_IP $DB_IP";
echo "DB_PORT $DB_PORT";

if [[ "$1" != "deploy" && "$1" != "rollback" ]]; then
    echo "set first parameter to either 'deploy' or 'rollback'"
    exit 1
fi


if [ "$1" = "deploy" ]; then
    echo "deploy starting"
    sleep 5;
    liquibase update \
        --username=$POSTGRES_USER \
        --password=$DB_PASSWORD \
        --changelog-file=changelog.xml \
        --url=jdbc:postgresql://$DB_IP:$DB_PORT/$POSTGRES_DB;
    exit 0;
fi


if [ "$1" = "rollback" ]; then
    echo "rollback starting";
    sleep 5;
    liquibase rollback $2 \
        --username=$POSTGRES_USER \
        --password=$DB_PASSWORD \
        --changelog-file=changelog.xml \
        --url=jdbc:postgresql://$DB_IP:$DB_PORT/$POSTGRES_DB;
    exit 0;
fi

echo "end liquibase-docker-entrypoint.sh";
