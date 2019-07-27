# Red1 Project

This project contains code for playing around with data retrieved from the [NASA Cassini Missions](http://archive.redfour.io/cassini/cassini_data.zip) using PostgreSQL.

## Pre-requisites

1. `docker`, available [here](https://docs.docker.com/install/)
2. GNU `make`, available [here](https://www.gnu.org/software/make/)

## How can I run this?

`make start`: Starts the postgres server running in a Docker container, allowing for reproducibiltiy across operating systems. Note: This target runs a rudimentary database migration. If you just want to start the postgres server /without/ running migrations, the `.pg_start` make target is available.

`make psql`: Starts a `psql` client connected to the running postgres server

`make bash`: Starts a networked client container for modifying the filesystem on the postgres server container directly. This is useful for tinkering with files on the host from the postgres server container (for example, DB migrations and data).

## FAQ

Archived data can be found at: http://archive.redfour.io/
