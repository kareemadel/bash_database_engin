#!/bin/bash

# This will view main menu where a user can use, create or delete a database.

while true; do
    clear;
    printf "What do you want to do?\n";
    printf "1) Create a new database.\n";
    printf "2) Use an existing database.\n";
    printf "3) Delete a database.\n";
    if [ ! -z "$DATABASE" ]; then
        echo "4) Use \"$DATABASE\" database.";
    fi
    if [ ! -z "$TABLE" ]; then
        echo "5) Use \"$TABLE\" table.";
    fi
    printf "q) Enter q to exit.\n";
    printf "Your choice: ";
    if ! read ; then
        exit 1;
    fi
    case "$REPLY" in
        1)
            source ./helper_scripts/database/create_database.sh;
            return;
            ;;
        2)
            source ./helper_scripts/database/select_database.sh;
            return;
            ;;
        3)
            source ./helper_scripts/database/delete_database.sh;
            return;
            ;;
        4)
            if [ -n "$DATABASE" ]; then
                CURRENT_MENU=1;
                return;
            fi
            ;;
        5)
            if [ -n "$TABLE" ]; then
                CURRENT_MENU=2;
                return;
            fi
            ;;
        q)
            exit 0;
            ;;
        *)
            ;;
    esac
done
REPLY=;
