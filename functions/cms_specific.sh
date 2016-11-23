#!/bin/bash

# Detect the used CMS

USED_CMS=false

if [[ $USED_CMS == false && -d $LOCAL_DIR"/httpdocs/app/etc/" ]]; then
    USED_CMS="magento"
elif [[ $USED_CMS == false && -f $LOCAL_DIR"/httpdocs/sites/default/default.settings.php" ]]; then
    USED_CMS="drupal"
elif [[ $USED_CMS == false && -d $LOCAL_DIR"/httpdocs/wp-content" ]]; then
    USED_CMS="wordpress"
fi

if [[ $USED_CMS != false ]]; then
    source $DIR"/cms/"$USED_CMS".sh"
fi
