#!/bin/bash

# Create needed directories
if [[ $PROVIDED_USER != false ]]; then
    #create folder in user home and chmod etc.
    LOCAL_DIR="${USER_INSTANCE_PATH}/${PROVIDED_USER}/${FOLDER_SITE_NAME}/"
    if [[ ! -d $LOCAL_DIR ]]; then
        USER_BIN=$USER_INSTANCE_PATH/$PROVIDED_USER/bin
        USER_WEB="${USER_INSTANCE_PATH}/${PROVIDED_USER}/${FOLDER_SITE_NAME}/httpdocs"
        USER_LOG=$USER_INSTANCE_PATH/$PROVIDED_USER/logs

        su - $THE_USER -c "mkdir -p $USER_BIN"
        su - $THE_USER -c "mkdir -p $USER_WEB"
        su - $THE_USER -c "mkdir -p $USER_LOG"

        echo "Directories have been created in ${LOCAL_DIR}."

        for TEST_DIR in $USER_BIN $USER_WEB $USER_LOG
        do
                [ -d "$TEST_DIR" ] || die "Directory $TEST_DIR does not exist"
        done
    fi
else
    #create folder in var/www
    LOCAL_DIR="${PATH_LOCAL_SITES}${FOLDER_SITE_NAME}.${DOMAIN_NAME}/"
    if [[ ! -d $LOCAL_DIR ]]; then
        sudo mkdir -p "${LOCAL_DIR}httpdocs"
        sudo mkdir -p "${LOCAL_DIR}production"
        sudo chown -R ${THE_USER}.${LOCAL_GROUP} ${LOCAL_DIR}
        sudo chmod g+w ${LOCAL_DIR}
        sudo mkdir -p "${LOCAL_DIR}logs"
        sudo mkdir -p "${LOCAL_DIR}bin"
        echo "Directories have been created in ${LOCAL_DIR}."

        INSTANCE_MERE_URL="http://${SUB_DOMAIN}.${DOMAIN_NAME}/"
        git clone git@github.com:canal-web/sites-deployment.git ${LOCAL_DIR}production
        cat "${LOCAL_DIR}production/settings/default.local_params.sh" | sed \
        -e "s,_LOCAL_URL,${INSTANCE_MERE_URL}," \
        -e "s,_LOCAL_ROOTDIR,${LOCAL_DIR}httpdocs," \
        -e "s,_LOCAL_SQL_HOST,${LOCAL_HOST}," \
        -e "s,_LOCAL_SQL_USER,${SQL_USER}," \
        -e "s,_LOCAL_SQL_PASSWORD,${SQL_PASSWD}," \
        -e "s,_LOCAL_SQL_DATABASE,$(echo "$PROVIDED_DATABASE" | sed 's/[\._-]//g')," \
         > "${LOCAL_DIR}production/settings/local_params.sh"
    fi
fi
