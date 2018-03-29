#!/bin/bash

# This script takes 2 arguments, the first is a path
# the second is the type of files in the path, it then views a select statement of the form
#Please select one of the following $2
#

# unset items variable
unset items;
# enable extglob option
shopt -s extglob;
REPLY=;
path="$(readlink -m $1)";

items=($(ls -A "$path"));

if [ ${#items[@]} -eq 0 ]; then
    printf "You don't have any $2.\n"
    read;
    REPLY=;
    return;
fi

while true; do
    clear;
    i=1;
    printf "Please select a $2 or enter b to go to previous menu.\n";
    for item in "${items[@]}"; do
        printf "%d) %s\n" "$i" "$item";
        ((i++));
    done
    printf "Your choice: ";
    if ! read; then
        break;
    fi
    case "$REPLY" in
        +([[:digit:]]))
            if [ "$REPLY" -le "${#items[@]}" -a "$REPLY" -gt 0 ]; then
                REPLY="${items[$((REPLY-1))]}";
                break;
            fi
            ;;
        b)
            REPLY=;
            break;
            ;;
        *)
            ;;
    esac
done
