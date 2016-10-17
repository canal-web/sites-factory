# Copy media files
DISTANT_FILES="${PATH_LOCAL_SITES}${MASTER_SITE_URL}/httpdocs/sites/default/files/*"

cp -R $DISTANT_FILES "${SITE_BASE}/sites/default/files/"
sudo chmod -R 777 $SITE_BASE/sites/default/files/
sudo chown -R $CURRENT_USER.$GROUP $SITE_BASE/sites/default/files/
