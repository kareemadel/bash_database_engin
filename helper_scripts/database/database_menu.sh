#!/bin/bash

# This will view main menu where a user can use, create or delete a database.

while true; do
    clear;
    printf "What do you want to do?\n";
    printf "1) Create a new database.\n";
    printf "2) Use an existing database.\n";
    printf "3) Delete a database.\n";
    if [ ! -z "$DATABASE" ]; then
        printf "4) Go to $DATABASE options.\n";
    fi
    if [ ! -z "$TABLE" ]; then
        printf "5) Go to $TABLE options.\n";
    fi
    printf "q) Enter q to exit.\n";
    printf "Your choide: ";
    read
    case "$REPLY" in
        1)
            source ./helper_scripts/database/create_database.sh;
            ;;
        2)
            source ./helper_scripts/database/select_database.sh;
            ;;
        3)
            source ./helper_scripts/database/delete_database.sh;
            ;;
        4)
            if [ ! -z "$DATABASE" ]; then
                source ./helper_scripts/database/use_database.sh;
            fi
            ;;
        5)
            if [ ! -z "$TABLE" ]; then
                source ./helper_scripts/table/use_table.sh;
            fi
            ;;
        q)
            exit 0;
            ;;
        *)
            ;;
    esac
done
