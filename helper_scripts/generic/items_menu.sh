#!/bin/bash

# This script takes 2 arguments, the first is a path
# the second is the type of files in the path, it then views a select statement of the form
#Please select one of the following $2
#

# unset items variable
unset items;
# enable extglob option
shopt -s extglob;

path="$(readlink -m $1)";

items=($(ls));

while true; do
    clear;
    i=0;
    printf "Please select a $2.\n";
    for item in "${items[@]}"; do
        printf "%d) %s\n" "$i" "$item";
        ((i++));
    done
    printf "Your choide: "
    read
    case "$REPLY" in
        +([[:digit:]]))
            if [ "$REPLY" -le ${$items[@]} ]; then
                break;
            fi
            ;;
    esac
done
