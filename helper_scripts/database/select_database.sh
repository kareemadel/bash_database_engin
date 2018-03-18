#!/bin/bash

clear;
source ./helper_scripts/generic/items_menu.sh "./databases/metadata" "database";
if [ ! -z "$REPLY" ]; then
    DATABASE="$REPLY";
    CURRENT_MENU=1;
fi
