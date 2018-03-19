#!/bin/bash

clear;
source ./helper_scripts/generic/items_menu.sh "./databases/metadata" "database";
if [ -n "$REPLY" ]; then
    rm -rf "./databases/data/$REPLY";
    rm -rf "./databases/metadata/$REPLY";
    clear
    if [ "$REPLY" = "$DATABASE" ]; then
        DATABASE=;
    fi
    printf "You have delete the $REPLY database successfully."
    read;
fi
