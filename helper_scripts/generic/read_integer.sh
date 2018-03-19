#!/bin/bash

is_correct=;
REPLY=;
while [ "$is_correct" = "" ]; do
    if ! read number; then
        is_correct="0";
        REPLY=;
    elif [[ "$number" =~ ^[1-9][0-9]*$ ]]; then
        is_correct="1";
    else
        printf "Invalid Integer, try again: ";
    fi
done
REPLY="$number";
is_correct="1";
