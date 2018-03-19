#!/bin/bash

source ./helper_scripts/generic/choose_name.sh "database";

if [ -n "$REPLY" ]; then
    DATABASE="$REPLY";
    mkdir -p "./databases/data/$REPLY";
    mkdir -p "./databases/metadata/$REPLY";
    printf "You have created the database $REPLY successfully.\n";
    read;
    REPLY=;
    source ./helper_scripts/database/use_database.sh;
fi
