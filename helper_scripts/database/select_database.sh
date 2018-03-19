#!/bin/bash

clear;
source ./helper_scripts/generic/items_menu.sh "./databases/metadata" "database";
if [ -n "$REPLY" ]; then
    DATABASE="$REPLY";
    REPLY=;
    CURRENT_MENU=1;
fi
