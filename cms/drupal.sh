#!bin/bash

## settings file
cat $DIR'/templates/drupal/settings.php' | sed -e "s/TOKENSITENAME/${DATABASE_CREATE}/g" -e "s,LOCAL_HOST,${LOCAL_HOST},g" -e "s,LOCAL_USER_DB,${DATABASE_USER},g" -e "s,LOCAL_PASSWD_DB,${NEW_DB_PASSWORD},g" >${LOCAL_DIR}httpdocs/sites/default/settings.php
