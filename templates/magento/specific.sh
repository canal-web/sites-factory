
OLD_HOSTS=`mysql --silent --skip-column-names -u$LOCAL_DB_USER -p$LOCAL_DB_PASSWORD $LOCAL_DB_NAME -e 'select GROUP_CONCAT(config_id SEPARATOR ",") from core_config_data where value like "%http%" and path like "%web/%" and path like "%secure%" GROUP BY "all"'`

mysql -u$LOCAL_DB_USER -p$LOCAL_DB_PASSWORD $LOCAL_DB_NAME -e "UPDATE core_config_data SET value='http://${LOCAL_HOST}/' WHERE config_id IN ($OLD_HOSTS)"


for DIR in session locks cache
do
    rm -rf "$SITE_BASE/var/$DIR"
done

# Create media/var directories if not already present
mkdir ${SITE_BASE}/media/ -p
mkdir ${SITE_BASE}/var/ -p

# Copy media files
DISTANT_FILES="${PATH_LOCAL_SITES}${MASTER_SITE_URL}/httpdocs/media/*"

cp -R $DISTANT_FILES "${SITE_BASE}/media/"
sudo chmod -R 777 $SITE_BASE/media/
sudo chown -R $CURRENT_USER.$GROUP $SITE_BASE/media
sudo chmod -R 777 $SITE_BASE/var/
sudo chown -R $CURRENT_USER.$GROUP $SITE_BASE/var

