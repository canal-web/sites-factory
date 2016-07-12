# Git repositories path

GIT_PATH='/var/git'

# Path of user's instances

USER_INSTANCE_PATH='/home'

# Path to

PATH_LOCAL_SITES="/var/www/vhosts/"

# Host for the sites

LOCAL_HOST="localhost"

# Optional suffix of SITE_NAME

SUFFIX_SITENAME=''

# Local user group

LOCAL_GROUP='www-data'

# User used for the folders creation

USER_PERMISSIONS=''

# SQL user for creations

SQL_USER=""

# File for SQL creation

CREATE_SQL="$DIR/templates/create_db_and_user.sql"

# Template for SQL creation

CREATE_SQL_TEMPLATE="$DIR/templates/create_db_and_user.sql.template"


# Domain name

DOMAIN_NAME="example.com"

# Apache config template

APACHE_CONF_TEMPLATE="$DIR/templates/TOKENAPACHE.conf"

# Apache vhosts path

APACHE_PATH="/etc/apache2/sites-available/"
