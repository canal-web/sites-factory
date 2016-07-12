#!bin/bash

# Create var folder
if [[ ! -d ${LOCAL_DIR}httpdocs/var ]]; then
    mkdir ${LOCAL_DIR}httpdocs/var
    sudo chown -R ${THE_USER}.${LOCAL_GROUP} ${LOCAL_DIR}httpdocs/var
    sudo chmod -R 777 ${LOCAL_DIR}httpdocs/var
else
    sudo chown -R ${THE_USER}.${LOCAL_GROUP} ${LOCAL_DIR}httpdocs/var
    sudo chmod -R 777 ${LOCAL_DIR}httpdocs/var
fi


OLD_HOSTS=`mysql --silent --skip-column-names -u$DATABASE_USER -p$NEW_DB_PASSWORD $DATABASE_CREATE -e 'select GROUP_CONCAT(config_id SEPARATOR ",") from core_config_data where value like "%http%" and path like "%web/%" and path like "%secure%" GROUP BY "all"'`

mysql -u$DATABASE_USER -p$NEW_DB_PASSWORD $DATABASE_CREATE -e "UPDATE core_config_data SET value='http://${SUB_DOMAIN}.${DOMAIN_NAME}/' WHERE config_id IN ($OLD_HOSTS)"


for TMP_DIR in session locks cache
do
    rm -rf "$SITE_BASE/var/$TMP_DIR"
done


## local xml
cat $DIR'/templates/magento/local.xml.base' | sed -e "s/TOKENDATABASE/${DATABASE_CREATE}/g" -e "s,LOCAL_HOST,${LOCAL_HOST},g" -e "s,LOCAL_USER_DB,${DATABASE_USER},g" -e "s,LOCAL_PASSWD_DB,${NEW_DB_PASSWORD},g" -e "s,TOKENSITENAME,${SUB_DOMAIN}.${DOMAIN_NAME},g" > ${LOCAL_DIR}"httpdocs/app/etc/local.xml"
