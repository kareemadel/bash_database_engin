#!/bin/bash

source helper_scripts/generic/helper_functions.sh

number_of_columns="$(get_number_of_columns $DATABASE $TABLE)"
data_types=($(get_data_types $DATABASE $TABLE))
column_names=($(get_column_names $DATABASE $TABLE))
PK="$(get_PK $DATABASE $TABLE)"

valid_value=
while [ -z "$valid_value" ]; do
	echo -n "Please inert the value of ${column_names[$PK]} (${data_types[$PK]}): "
	if [ "${data_types[$PK]}" = "int" ]; then
		source ./helper_scripts/generic/read_integer.sh "accept_null"
		if [ -z "$REPLY" ]; then
			return
		elif [ "$REPLY" = "null" ]; then
			REPLY=
		fi
	elif [ "${data_types[$PK]}" = "str" ]; then
		if ! IFS=$'\n' read -r; then
			return
		fi
	fi
	message=
	row=
	if is_null "$REPLY"; then
		message="Primary key can't be null.\n"
	elif find_row "$REPLY" "$DATABASE" "$TABLE" "$PK"; then
		message="${message}There is no such row.\n"
	else
		row=$?
		lines=$(cat "./databases/data/$DATABASE/$TABLE" | wc -l)
		if [ $row -le $lines -a $row -gt 0 ]; then
			echo $row;
			awk -v line="$row" 'BEGIN{FS=":"; OFS="\t||\t";row=line} NR==row{
				for (i = 1; i <= NF; i++)
				{
					close("echo -n "$i"| xxd -p -r");
					( "echo -n "$i"| xxd -p -r" | getline $i );
				}
				print $0;
			}' "./databases/data/$DATABASE/$TABLE"
			read
		fi
	fi
	if [ -z "$message" ]; then
		valid_value="true"
	else
		valid_value=
		printf "\n%b" "$message"
	fi
done
