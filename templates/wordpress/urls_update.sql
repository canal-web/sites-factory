UPDATE wp_options
SET option_value = replace(option_value, 'http://${OLD_DOMAIN}', 'http://${LOCAL_HOST}')
WHERE option_name = 'home'
OR option_name = 'siteurl';

UPDATE wp_posts
SET guid = REPLACE (guid, 'http://${OLD_DOMAIN}', 'http://${LOCAL_HOST}');

UPDATE wp_posts
SET post_content = REPLACE (post_content, 'http://${OLD_DOMAIN}', 'http://${LOCAL_HOST}');

UPDATE wp_postmeta
SET meta_value = REPLACE (meta_value, 'http://${OLD_DOMAIN}','http://${LOCAL_HOST}');
