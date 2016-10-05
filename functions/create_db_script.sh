# And generate the get db script!
sudo cat "${DIR}/templates/get_db_dist.bash" | sed \
-e "s,ARG,${SITE_NAME}," \
-e "s,DOMAIN_NAME,${DOMAIN_NAME}," \
-e "s,_SUB_DOMAIN,${SUB_DOMAIN}," \
-e "s,FOLDER_SITE_NAME,${FOLDER_SITE_NAME}," \
-e "s,LOCAL_USER,${THE_USER}," \
-e "s,GROUP_NAME,${LOCAL_GROUP}," \
-e "s,TOKENSITEBASE,${LOCAL_DIR}httpdocs," \
-e "s,LOCALDBNAME,$THE_USER$SITE_NAME," \
-e "s,LOCAL_PASSWD_DB,${NEW_DB_PASSWORD}," \
-e "s,LOCALDBUSERTOKEN,${THE_USER}," \
-e "s,MASTER_PASSWD_DB,${SQL_PASSWD}," \
-e "s,MASTER_DB_NAME,${PROVIDED_DATABASE}," \
-e "s,MASTER_DB_USER,${SQL_USER}," \
-e "s,MASTER_DOMAIN,${PROVIDED_DATABASE}.${DOMAIN_NAME}," \
-e "s,CHILD_DOMAIN,${SUB_DOMAIN}.${DOMAIN_NAME}," \
-e "s,PATH_LOCAL_SITES_TOKEN,${PATH_LOCAL_SITES}," \
 > "$USER_BIN/get_db-${SITE_NAME}.bash"
sudo chmod +x "$USER_BIN/get_db-${SITE_NAME}.bash"
sudo chown $THE_USER.$LOCAL_GROUP "$USER_BIN/get_db-$SITE_NAME.bash"

# Add specific instructions for CMS
if [[ $USED_CMS != false && -f "$DIR/templates/${USED_CMS}/specific.sh" ]]; then
    sudo cat "$DIR/templates/${USED_CMS}/specific.sh" >> "$USER_BIN/get_db-${SITE_NAME}.bash"
fi

echo "Please check the generated get_db script."
