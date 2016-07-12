LOGS_DIR=$([ $PROVIDED_USER != false ] && echo "$USER_LOG" || echo "${LOCAL_DIR}logs")

# Create the vhost from  template
if [[ ! -f ${APACHE_PATH}${SUB_DOMAIN}.${DOMAIN_NAME}.conf ]]; then
    cat $APACHE_CONF_TEMPLATE | sed -e "s,TOKENAPACHE,${SUB_DOMAIN},g" | sed -e "s,LOCAL_DIR,${LOCAL_DIR},g" | sed -e "s,LOGS_DIR,${LOGS_DIR},g" |  sed -e "s,SITE_NAME,${SITE_NAME},g" | sed -e "s,DOMAIN_NAME,${DOMAIN_NAME},g" > ${APACHE_PATH}${SUB_DOMAIN}.${DOMAIN_NAME}.conf

    # Enable the vhost
    a2ensite  "${SUB_DOMAIN}.${DOMAIN_NAME}"
fi

sudo service apache2 reload
echo "The apache conf file is set up, now reloading apache service..."
