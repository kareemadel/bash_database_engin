#!/bin/bash

# this will show the users the operartion he can do on a database.

source ./helper_scripts/generic/helper_functions.sh;

while true; do
    clear;
    echo "You are now in \"$DATABASE\" database.";
    printf "What do you want to do?\n";
    printf "1) Create a new table.\n";
    printf "2) Use an existing table.\n";
    printf "3) Drop a table.\n";
    echo "4) Delete \"$DATABASE\" database.";
    if [ -n "$TABLE" ]; then
        echo "5) Use \"$TABLE\" table.";
    fi
    printf "b) Enter b to go back to main menu.\n"
    printf "q) Enter q to exit.\n";
    printf "Your choice: ";
    if ! read; then
        CURRENT_MENU=0;
        return;
    fi
    case "$REPLY" in
        1)
            source ./helper_scripts/table/create_table.sh;
            return;
            ;;
        2)
            source ./helper_scripts/table/select_table.sh;
            return;
            ;;
        3)
            source ./helper_scripts/table/delete_table.sh;
            return;
            ;;
        4)
            delete_database "$DATABASE";
            CURRENT_MENU=0;
            return;
            ;;
        5)
            if [ ! -z "$TABLE" ]; then
                source ./helper_scripts/table/use_table.sh;
                return;
            fi
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
