#!/bin/bash

source ./helper_scripts/generic/helper_functions.sh;

clear;
source ./helper_scripts/generic/items_menu.sh "./databases/metadata" "database";
if [ -n "$REPLY" ]; then
    delete_database "$REPLY";
fi
