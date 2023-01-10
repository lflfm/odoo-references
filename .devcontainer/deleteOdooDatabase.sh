#!/bin/bash

export PGPASSWORD=odoopostgres
_dbuser=odoopostgres
_dbname=odoopostgres
_dbhost=db
psql -h $_dbhost -U $_dbuser -d $_dbname -c "SELECT version();"
psql -h $_dbhost -U $_dbuser -d $_dbname -c "CREATE DATABASE temp_db_for_drop;"
psql -h $_dbhost -U $_dbuser -d temp_db_for_drop -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$_dbname';"
psql -h $_dbhost -U $_dbuser -d temp_db_for_drop -c "DROP DATABASE $_dbname WITH (FORCE);"
psql -h $_dbhost -U $_dbuser -d temp_db_for_drop -c "CREATE DATABASE $_dbname;"
psql -h $_dbhost -U $_dbuser -d $_dbname -c "DROP DATABASE temp_db_for_drop WITH (FORCE);"

echo "Unless there were some errors (we didn't add any checks), the DB should be empty and ready to be initiated by Odoo."
