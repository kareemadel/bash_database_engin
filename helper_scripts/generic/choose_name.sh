#!/bin/bash
#This script takes 1 argument, the type of the name
source ./helper_scripts/generic/helper_functions.sh;
clear;

printf "Please enter the $1 name, the name must be unique, and can't contain spaces or slash.\n";
is_correct=;
REPLY=;
while IFS= read -r name; do
    message=
    if [[ "$name" = "" ]]; then
        message="The name can't be empty.";
    fi
    if [[ "$name" =~ [[:space:]]+ ]]; then
        message="Spaces are not allowed.";
    fi
    if [[ "$name" = "." ]]; then
        message="The name can't be a dot.";
    fi
    if [[ "$name" = ".." ]]; then
        message="The name can't be a double dot.";
    fi
    if [[ "$name" = *"/"* ]]; then
        if [ -z $message ]; then
            message="Slashes are not allowed.";
        else
            message="${message} Slashes are not allowed.";
        fi
    fi
    case "$1" in
        "database")
            if [ -z "$message" ]; then
                if [ -d "./databases/data/$name" -o -d "./databases/metadata/$name" ]; then
                    message="A $1 with the same name exists, Please try another name."
                else
                    REPLY="$name";
                    return;
                fi
            fi
            ;;
        "table")
            if [ -z "$message" ]; then
                if [ -e "./databases/data/$DATABASE/$name" -o -e "./databases/metadata/$DATABASE/$name" ]; then
                    message="A $1 with the same name exists, Please try another name.";
                else
                    REPLY="$name";
                    return;
                fi
            fi
            ;;
        "column"*)
            if [ -z "$message" ]; then
                if contains_element "$name" "${@:2}"; then
                    message="A column with the same name exists, Please try another name.";
                else
                    REPLY="$name";
                    return;
                fi
            fi
            ;;
        *)
            ;;
    esac
    clear;
    printf "%s\n" "$message";
    printf  "Please try again: "
done
REPLY=;
