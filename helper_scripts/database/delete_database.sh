#!/bin/bash

clear;
source ./helper_scripts/generic/items_menu.sh "./databases" "database";
rm -rf "./databases/$REPLY";
rm -rf "./metadata/$REPLY";
printf "You have delete the $REPLY database successfully."
read;
