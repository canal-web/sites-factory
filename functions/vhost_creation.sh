LOGS_DIR=$([ $PROVIDED_USER != false ] && echo "$USER_LOG" || echo "${LOCAL_DIR}logs")

# Create the vhost from  template
if [[ ! -f ${APACHE_PATH}${SUB_DOMAIN}.${DOMAIN_NAME}.conf ]]; then
    sudo cat $APACHE_CONF_TEMPLATE | sed -e "s,TOKENAPACHE,${SUB_DOMAIN},g" | sed -e "s,LOCAL_DIR,${LOCAL_DIR},g" | sed -e "s,LOGS_DIR,${LOGS_DIR},g" |  sed -e "s,SITE_NAME,${SITE_NAME},g" | sed -e "s,DOMAIN_NAME,${DOMAIN_NAME},g" | sed -e "s,IP_ADD_1,${IP_ADD_1},g" | sed -e "s,IP_ADD_2,${IP_ADD_2},g" | sed -e "s,IP_ADD_3,${IP_ADD_3},g" > ${SUB_DOMAIN}.${DOMAIN_NAME}.conf
    sudo mv ${SUB_DOMAIN}.${DOMAIN_NAME}.conf ${APACHE_PATH}

    # Enable the vhost
    sudo a2ensite  "${SUB_DOMAIN}.${DOMAIN_NAME}"
fi

sudo service apache2 reload
echo "The apache conf file is set up, now reloading apache service..."
