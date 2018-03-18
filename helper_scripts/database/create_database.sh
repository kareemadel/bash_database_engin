#!/bin/bash

clear;

printf "Please enter the database name, the name must be unique, can can't contain spaces or slash.\n";

while IFS= read -r name; do
    if [[ "$name" = *" "* ]]; then
        message="Spaces are not allowed.";
    fi
    if [[ "$name" = *"/"* ]]; then
        if [ -z $message ]; then
            message="Slashes are not allowed.";
        else
            message="${message} Slashes are not allowed.";
        fi
    fi
    if [ -z $message ]; then
        if mkdir "./databases/$name" ; then
            if mkdir "./metadata/$name" ; then
                printf "You have created the database $name successfully.\n";
                DATABASE="$name";
                source ./helper_scripts/database/use_database.sh;
                break;
            else
                rm -r "./databases/$name";
            fi
        else
            message="A database with the same name exists, Please try another name."
        fi
    fi
    clear;
    printf "%s\n" "$message";
    printf  "Please try again: "
    message=
done
