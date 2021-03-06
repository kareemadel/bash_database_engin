#!/bin/bash

# This will view table menu where a user can use, create or drop a database.

while true; do
    clear;
    printf "You are now using $DATABASE database, ";
    printf "What do you want to do?\n";
    printf "1) Create a new table.\n";
    printf "2) Use an existing table.\n";
    printf "3) Drop a table.\n";
    if [ -n "$TABLE" ]; then
        printf "4) Go to $TABLE options.\n";
    fi
    printf "5) delete \"$DATABASE\" database.\n";
    printf "b) Enter B to go to main .\n";
    printf "q) Enter q to exit.\n";
    printf "Your choice: ";
    read
    case "$REPLY" in
        1)
            source ./helper_scripts/table/create_table.sh;
            ;;
        2)
            source ./helper_scripts/table/select_table.sh;
            ;;
        3)
            source ./helper_scripts/table/delete_table.sh;
            ;;
        4)
            if [ ! -z "$TABLE" ]; then
                source ./helper_scripts/table/use_table.sh;
            fi
            ;;
        5)
            delete_database "$DATABASE";
            ;;
        b)
            CURRENT_MENU=0;
            return;
            ;;
        q)
            exit 0;
            ;;
        *)
            ;;
    esac
done
