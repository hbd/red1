NAME  = euc
PG_I ?= postgres:latest
PG_CLIENT = ${NAME}_pg_client
PG_SERVER = ${NAME}_pg_server
PG_ROOT_CMD   = docker run -i -v ${PWD}:/root --link ${PG_SERVER}:postgres postgres
PG_CLIENT_CMD = docker run --name ${PG_CLIENT} --rm -it -v ${PWD}:/root --link ${PG_SERVER}:postgres postgres
PG_DB = red1

all: help

help:
	@echo "psql  - connect to db with psql"
	@echo "bash  - interact w/ postgres server in a container running bash"
	@echo "clean - cleanup env"

clean:
	@docker stop ${PG_SERVER} || true
	@rm -rf .pg_start .pg_migrate

.PHONY: psql bash

psql: .pg_migrate
	${PG_CLIENT_CMD} psql -h postgres -U postgres

bash: .pg_start
	${PG_CLIENT_CMD} bash

# Perform migrations.
.pg_migrate: .pg_start
	@for mgf in $(shell echo "ls /root/sql/" | ${PG_ROOT_CMD} bash); do \
		${PG_ROOT_CMD} psql -h postgres -U postgres ${PG_DB} -f /root/sql/$$mgf; \
	done
	@echo "Migration complete"
	@touch $@

# Start a postgres server.
.pg_start:
	@docker run --name ${PG_SERVER} -v ${PWD}:/root -d --rm ${PG_I}
	@until (echo "CREATE DATABASE ${PG_DB};" | ${PG_ROOT_CMD} psql -h postgres -U postgres > /dev/null 2> /dev/null); do \
		echo "Waiting for ${PG_SERVER}..." >&2; \
		sleep 1; \
	done
	@touch $@
