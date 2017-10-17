#!/bin/bash
set -ex
function die
{
    echo "$@" >&2
    exit 1
}

DIR=`dirname $0`
DIR=`readlink -f $DIR`

# Variables to get from command line
[ ! -z "$1" ] || die "Site name should be given as first argument"

VAR_FILES="variables/*"
CMS=false
PROVIDED_GIT=false
PROVIDED_FILES=false
PROVIDED_DATABASE=false
PROVIDED_USER=false

# Define default variables (you must duplicate the files with a "local." prefix to rewrite them)
for f in $VAR_FILES; do
    if [[ $f != *local* ]]; then
        source $f
    fi
done


# Include local variables
for f in $VAR_FILES; do
    if [[ $f == *local* ]]; then
        source $f
    fi
done

OPTIND=1

# Manage flags
while getopts ":g:f:d:u:" opt; do
 case $opt in
   g)
     PROVIDED_GIT=$OPTARG
     ;;
   f)
     PROVIDED_FILES=$OPTARG
     ;;
   d)
     PROVIDED_DATABASE=$OPTARG
     ;;
   u)
     PROVIDED_USER=$OPTARG
     ;;
   \?)
     die "Invalid option: -$OPTARG"
     ;;
   :)
     die "Option -$OPTARG requires an argument."
     ;;
 esac
done

# Check if there is an htpasswd

if [[ ! -f "$DIR/templates/htpasswd.template" ]]; then
    die "You must create an 'htpasswd.template' and put it in the templates folder to continue"
fi

# If the user does not exist
if [[ $PROVIDED_USER != false ]] && [[ ! -d "$USER_INSTANCE_PATH/$PROVIDED_USER" ]]; then
    die "The provided user does not exist, please create it before."
fi

shift $((OPTIND-1))
SITE_NAME=$1
SOURCE_NAME=$SITE_NAME
FOLDER_SITE_NAME=${SITE_NAME}${SUFFIX_SITENAME}
SUB_DOMAIN=$([ $PROVIDED_USER != false ] && echo "$PROVIDED_USER-$SITE_NAME" || echo "$SITE_NAME")




# Define the user settings the permissions
if [[ $PROVIDED_USER != false ]];then
    THE_USER=$PROVIDED_USER
else
    THE_USER=$USER_PERMISSIONS
fi


# Create folders
source 'functions/create_folders.sh'

# Copy files
source 'functions/copy_files.sh'

# Copy database
source 'functions/copy_db.sh'

# Do the CMS specific things
source 'functions/cms_specific.sh'

# Vhost setup
source 'functions/vhost_creation.sh'

# Create the database copying script
if [[ $PROVIDED_USER != false ]]; then
    source 'functions/create_db_script.sh'
fi

#Composer
if [[ -f "${LOCAL_DIR}httpdocs/composer.json" ]]; then
    su - $THE_USER -c "cd ${LOCAL_DIR}httpdocs && composer update"
fi

echo "The end."
