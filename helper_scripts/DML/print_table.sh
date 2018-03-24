#!/bin/bash

source ./helper_scripts/generic/helper_functions.sh;

awk 'BEGIN{FS=":"; OFS="\t||\t"} {
    for (i = 1; i <= NF; i++)
    {
        close("echo -n "$i"| xxd -p -r");
        ( "echo -n "$i"| xxd -p -r" | getline $i );
    }
    print $0;
}' "./databases/data/$DATABASE/$TABLE";
read;
