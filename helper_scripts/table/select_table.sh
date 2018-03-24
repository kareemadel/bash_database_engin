#!/bin/bash

clear;
source ./helper_scripts/generic/items_menu.sh "./databases/metadata/$DATABASE" "table";
if [ -n "$REPLY" ]; then
    TABLE="$REPLY";
    REPLY=;
    CURRENT_MENU=2;
fi
