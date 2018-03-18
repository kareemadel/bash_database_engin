#!/bin/bash

# this will show the users the operartion he can do on a database.

while true; do
    clear;
    printf "You are now in \"$DATABASE\" database.\n";
    printf "What do you want to do?\n";
    printf "1) Create a new table.\n";
    printf "2) Use an existing table.\n";
    printf "3) Drop a table.\n";
    if [ ! -z "$TABLE" ]; then
        printf "4) Use \"$TABLE\" table.\n";
    fi
    printf "b) Enter b to go back to main menu.\n"
    printf "q) Enter q to exit.\n";
    printf "Your choide: ";
    if ! read; then
        break;
    fi
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
        b)
            CURRENT_MENU=0;
            break;
            ;;
        q)
            exit 0;
            ;;
        *)
            ;;
    esac
done
