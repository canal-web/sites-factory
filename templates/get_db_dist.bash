#!/bin/bash
set -e
DIR=`dirname $0`
DIR=`readlink -f $DIR`
cd $DIR

#Variables names to be modified
SITE_NAME=ARG
SUB_DOMAIN=_SUB_DOMAIN
LOCAL_HOST="${SUB_DOMAIN}.DOMAIN_NAME"
SITE_FOLDER=FOLDER_SITE_NAME
CURRENT_USER=LOCAL_USER
GROUP=GROUP_NAME
SITE_BASE=TOKENSITEBASE
DB_NAME=MASTER_DB_NAME
DB_USERNAME=MASTER_DB_USER
DB_PASSWORD=MASTER_PASSWD_DB
LOCAL_DB_NAME=LOCALDBNAME
LOCAL_DB_PASSWORD=LOCAL_PASSWD_DB
LOCAL_DB_USER=LOCALDBUSERTOKEN
FILES_FOLDER="${SITE_BASE}/httpdocs"
CHILD_SITE_URL=CHILD_DOMAIN
MASTER_SITE_URL=MASTER_DOMAIN
PATH_LOCAL_SITES=PATH_LOCAL_SITES_TOKEN


function die
{
        echo "$@" >&2
        exit 1
}

for TESTDIR in $DIR/../$SITE_FOLDER
do
        [ -d "$TESTDIR" ] || die "Directory $TESTDIR does not exist"
done



# copy db
mysqldump -u$DB_USERNAME -p$DB_PASSWORD $DB_NAME > dbtmp.sql
mysql -u$LOCAL_DB_USER -p$LOCAL_DB_PASSWORD $LOCAL_DB_NAME < dbtmp.sql
rm dbtmp.sql

# Specific actions for each CMS
