#!/bin/bash

# This will view main menu where a user can use, create or delete a database.

while true; do
    clear;
    printf "What do you want to do?\n";
    printf "1) Create a new database.\n";
    printf "2) Use an existing database.\n";
    printf "3) Delete a database.\n";
    if [ ! -z "$DATABASE" ]; then
        printf "4) Use \"$DATABASE\" database.\n";
    fi
    if [ ! -z "$TABLE" ]; then
        printf "4) Use \"$TABLE\" table.\n";
    fi
    printf "q) Enter q to exit.\n";
    printf "Your choice: ";
    if ! read ; then
        exit 1;
    fi
    case "$REPLY" in
        1)
            source ./helper_scripts/database/create_database.sh;
            break;
            ;;
        2)
            source ./helper_scripts/database/select_database.sh;
            break;
            ;;
        3)
            source ./helper_scripts/database/delete_database.sh;
            break;
            ;;
        4)
            if [ -n "$DATABASE" ]; then
                source ./helper_scripts/database/use_database.sh;
                break;
            fi
            ;;
        5)
            if [ -n "$TABLE" ]; then
                source ./helper_scripts/table/use_table.sh;
                break;
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
