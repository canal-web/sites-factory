# Change the URLS

mysql -u$LOCAL_DB_USER -p$LOCAL_DB_PASSWORD $LOCAL_DB_NAME -e "
UPDATE wp_options
SET option_value = replace(option_value, 'http://${MASTER_SITE_URL}', 'http://${CHILD_SITE_URL}')
WHERE option_name = 'home'
OR option_name = 'siteurl';
UPDATE wp_posts
SET guid = REPLACE (guid, 'http://${MASTER_SITE_URL}', 'http://${CHILD_SITE_URL}');
UPDATE wp_posts
SET post_content = REPLACE (post_content, 'http://${MASTER_SITE_URL}', 'http://${CHILD_SITE_URL}');
UPDATE wp_postmeta
SET meta_value = REPLACE (meta_value, 'http://${MASTER_SITE_URL}','http://${CHILD_SITE_URL}');
"
