#!/bin/bash

source helper_scripts/generic/helper_functions.sh

number_of_columns="$(get_number_of_columns $DATABASE $TABLE)";
data_types=( $(get_data_types $DATABASE $TABLE) );
column_names=( $(get_column_names $DATABASE $TABLE) );
PK="$(get_PK $DATABASE $TABLE)";
data=();

for ((i=0;i<$number_of_columns;i++)); do
    if get_column_value "$DATABASE" "$TABLE" "$i" "$PK" "${column_names[$i]}" "${data_types[$i]}"; then
        data+=( "$REPLY" );
    else
        return;
    fi
done


line=;
for ((i=0;i<number_of_columns;i++)); do
    line="${line}:$(encode_text "${data[$i]}")"
done
add_row "${line:1}" "$DATABASE" "$TABLE";
printf "You have added a row successfully.\n";
read;
