#!/bin/bash

clear;
source ./helper_scripts/generic/items_menu.sh "./databases/metadata/$DATABASE" "table";
if [ -n "$REPLY" ]; then
    rm -f "./databases/data/$DATABASE/$REPLY";
    rm -f "./databases/metadata/$DATABASE/$REPLY";
    if [ "REPLY" = "$TABLE" ]; then
        TABLE=;
    fi
    echo -n "You have delete the $REPLY database successfully."
    read;
fi
