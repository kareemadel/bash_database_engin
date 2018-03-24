#!/bin/bash

source helper_scripts/generic/helper_functions.sh

is_correct=;
REPLY=;
while [ "$is_correct" = "" ]; do
    if ! read number; then
        REPLY=;
        return;
    elif is_integer "$number"; then
        REPLY="$number";
        return
    elif [ "$1" = "accept_null" -a -z "$number" ]; then
        REPLY="null";
        return;
    else
        printf "Invalid Integer, try again: ";
    fi
done
