#!/bin/bash

function join_by { 
    typeset d=$1;
    shift;
    echo -n "$1";
    shift;
    printf "%b" "${@/#/$d}";
}

number_of_columns="$(get_number_of_columns $DATABASE $TABLE)"
data_types=($(get_data_types $DATABASE $TABLE));
column_names=($(get_column_names $DATABASE $TABLE));
PK="$(get_PK $DATABASE $TABLE)";
data_types["$PK"]="${data_types[$PK]}(PK)";

join_by '\t||\t' "${column_names[@]}";
echo
join_by '\t||\t' "${data_types[@]}";
echo
printf '%100s\n' | tr ' ' -
