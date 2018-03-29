#!/bin/bash
source ./helper_scripts/generic/helper_functions.sh
source ./helper_scripts/generic/choose_name.sh "database";

if [ -n "$REPLY" ]; then
    DATABASE="$REPLY";
    TABLE=;
    create_database "$REPLY";
    echo "You have created the database $REPLY successfully.";
    read;
    REPLY=;
    CURRENT_MENU=1;
    source ./helper_scripts/database/use_database.sh;
fi
