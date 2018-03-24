#!/bin/bash

# this will show the users the operartion he can do on a table.

while true; do
    clear;
    echo "You are now in \"$TABLE\" table.";
    printf "What do you want to do?\n";
    printf "1) Insert.\n";
    printf "2) Update.\n";
    printf "3) Delete.\n";
    echo "4) Show \"$TABLE\"."
    printf "b) Enter b to go back to main menu.\n"
    printf "q) Enter q to exit.\n";
    printf "Your choice: ";
    if ! read; then
        CURRENT_MENU=1;
        return;
    fi
    case "$REPLY" in
        1)
            source ./helper_scripts/DML/insert.sh;
            ;;
        2)
            source ./helper_scripts/DML/update_row.sh;
            ;;
        3)
            source ./helper_scripts/DML/delete_row.sh;
            ;;
        4)
            source ./helper_scripts/DML/print_table.sh;
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
