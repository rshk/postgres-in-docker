#!/bin/bash

CONTAINER_NAME=my-postgres-database
VOLUME_NAME="${CONTAINER_NAME}-data"
POSTGRES_VERSION=14
POSTGRES_PASSWORD=mysecretpassword
POSTGRES_IMAGE=postgres-plus:${POSTGRES_VERSION}
PUBLISH_PORT=5432


case "$1" in
    build)
        docker build -t "${POSTGRES_IMAGE}" --build-arg PG_MAJOR_VERSION="${POSTGRES_VERSION}" .
        ;;
    start)
        docker run --rm --name "$CONTAINER_NAME" \
               -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
               --detach --publish "${PUBLISH_PORT}":5432 \
               --mount type=volume,src="$VOLUME_NAME",target=/var/lib/postgresql/data \
               "$POSTGRES_IMAGE"
        ;;
    stop)
        docker kill "$CONTAINER_NAME"
        ;;
    shell)
        docker exec -it "$CONTAINER_NAME" psql -U postgres "${@:2}"
        ;;
    psql)
        docker exec -i "$CONTAINER_NAME" psql -U postgres "${@:2}"
        ;;
    cleanup)
        docker volume rm "$VOLUME_NAME"
        ;;
    *)
        cat <<EOF
Usage: db.sh <command>

Commands:
    build
        Build the docker image (prerequisite)
    start
        Start docker container in the background
    stop
        Stop docker container
    shell
        Start an interactive psql session with the server
    psql
        Start a psql session with the server, without allocating a terminal.
        Useful for piping, eg ./db.sh < myquery.sql
    cleanup
        Delete docker volume attached to the container
EOF
        ;;
esac
