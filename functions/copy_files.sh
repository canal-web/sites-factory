#!/bin/bash

# Checking if we must clone or create a git repository
if [[ $PROVIDED_GIT != false ]]; then
    REPO_PATH=$GIT_PATH'/'$PROVIDED_GIT'/'
    if [[ -d $REPO_PATH ]]; then
        su - $THE_USER -c "git clone ${REPO_PATH} ${LOCAL_DIR}httpdocs/"
        NEW_REPO=false
    else
        # Creation of the repository
        sudo mkdir ${GIT_PATH}'/'${PROVIDED_GIT}'/'
        sudo chown -R $THE_USER.$LOCAL_GROUP $REPO_PATH

        su - $THE_USER -c "cd $REPO_PATH && git init --bare --shared"
        NEW_REPO=true
    fi
fi

# In case of new site, copy the files and create the first commit
if [[ $PROVIDED_FILES != false ]]; then
    cd ${LOCAL_DIR}'httpdocs/'
    sudo  rsync -avz  --exclude "var/" --exclude ".git/" ${PATH_LOCAL_SITES}${PROVIDED_FILES}.${DOMAIN_NAME}/httpdocs/ .
    sudo cp -R ${PATH_LOCAL_SITES}${PROVIDED_FILES}.${DOMAIN_NAME}/httpdocs/.htaccess .
    sudo cp -R ${PATH_LOCAL_SITES}${PROVIDED_FILES}.${DOMAIN_NAME}/httpdocs/.gitignore .
    sudo chown -R $THE_USER.$LOCAL_GROUP .

    if [[ $NEW_REPO == true ]]; then
        su - $THE_USER -c "$DIR/functions/new_git_init.sh ${LOCAL_DIR}httpdocs/ $REPO_PATH"
    fi

    cd $DIR
fi

sudo cp "$DIR/templates/htpasswd.template" $LOCAL_DIR'httpdocs/.htpasswd'
sudo chown $THE_USER.$LOCAL_GROUP $LOCAL_DIR'httpdocs/.htpasswd'
