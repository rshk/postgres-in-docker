# PostgreSQL in Docker

Utility script to start a PostgreSQL server, using Docker.

## Usage

```
./db.sh build

        Build the docker image (prerequisite)

./db.sh start

        Start docker container in the background

./db.sh stop

        Stop docker container

./db.sh shell

        Start an interactive psql session with the server

./db.sh psql

        Start a psql session with the server, without allocating a terminal.
        Useful for piping, eg ./db.sh < myquery.sql

./db.sh cleanup

        Delete docker volume attached to the container
```


## What's in the box

- By default, PostgreSQL 14 is used. Adjust the version as needed in `db.sh`.
- Also installs system packages for the `postgis` and `plpython3u` extensions.
