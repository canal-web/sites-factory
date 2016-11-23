# WP-config creation

cat $DIR'/templates/wordpress/wp-config.php' | sed -e "s/_DB_NAME/${DATABASE_CREATE}/g" -e "s,_DB_HOST,${LOCAL_HOST},g" -e "s,_DB_USER,${DATABASE_USER},g" -e "s,_DB_PASSWORD,${NEW_DB_PASSWORD},g" >${LOCAL_DIR}httpdocs/wp-config.php
