ARG PG_MAJOR_VERSION=14

FROM postgres:${PG_MAJOR_VERSION} AS postgres-plus
ARG PG_MAJOR_VERSION
RUN apt-get update
RUN apt-get -y install postgresql-plpython3-${PG_MAJOR_VERSION} postgresql-${PG_MAJOR_VERSION}-postgis-3
