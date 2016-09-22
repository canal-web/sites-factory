#!/bin/bash

# Create a database, eventually prefixed with the username
if [[ $PROVIDED_USER != false ]]; then
    DATABASE_CREATE=$THE_USER$SITE_NAME
    DATABASE_USER=$THE_USER
else
    DATABASE_CREATE=$(echo "$SITE_NAME" | sed 's/[\._-]//g')
    DATABASE_USER=$DATABASE_CREATE
fi

sudo cat $CREATE_SQL_TEMPLATE | sed -e "s,DATABASE_CREATE,${DATABASE_CREATE},g" | sed -e "s,CURRENT_USER,${DATABASE_USER},g" | sed -e "s,NEW_DB_PASSWORD,${NEW_DB_PASSWORD},g" > $CREATE_SQL


mysql -u${SQL_USER} -p${SQL_PASSWD} < $CREATE_SQL

echo "Database Created"
# Populate the database if a database name is given
if [[ $PROVIDED_DATABASE != false ]]; then
    mysqldump -u$SQL_USER -p$SQL_PASSWD $PROVIDED_DATABASE > dbtmp.sql
    mysql -u$SQL_USER -p$SQL_PASSWD $DATABASE_CREATE < dbtmp.sql
    sudo rm dbtmp.sql
    echo "Database populated"
fi
