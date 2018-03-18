#!/bin/bash

export DATABASE=
export TABLE=
export COLUMN=
export CURRENT_MENU=0


while true; do
    case "$CURRENT_MENU" in
        0)
            source ./helper_scripts/database/database_menu.sh;
            ;;
        1)
            source ./helper_scripts/database/use_database.sh;
            ;;
    esac
done
