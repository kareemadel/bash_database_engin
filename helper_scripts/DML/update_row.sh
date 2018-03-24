#!/bin/bash

source helper_scripts/generic/helper_functions.sh

number_of_columns="$(get_number_of_columns $DATABASE $TABLE)";
data_types=( $(get_data_types $DATABASE $TABLE) );
column_names=( $(get_column_names $DATABASE $TABLE) );
PK="$(get_PK $DATABASE $TABLE)";


valid_value=;
while [ -z "$valid_value" ]; do
    echo -n "Please inert the value of ${column_names[$PK]} (${data_types[$PK]}): ";
    if [ "${data_types[$PK]}" = "int" ]; then
        source ./helper_scripts/generic/read_integer.sh "accept_null"
        if [ -z "$REPLY" ]; then
            return
        elif [ "$REPLY" = "null" ]; then
            REPLY=;
        fi
    elif [ "${data_types[$PK]}" = "str" ]; then
        if ! IFS=$'\n' read -r; then
            return
        fi
    fi
    message=;
    row=;
    if is_null "$REPLY"; then
        message="Primary key can't be null.\n";
    elif find_row "$REPLY" "$DATABASE" "$TABLE" "$PK"; then
        message="${message}There is no such row.\n";
    else
        row=$?;
        lines=$(cat "./databases/data/$DATABASE/$TABLE" | wc -l)
        if [ $row -le $lines -a $row -gt 0 ]; then
            while true; do
                printf "Please select the column you want to update.\n";
                i=1;
                for column in "${column_names[@]}"; do
                    echo "$i) $column";
                    ((i++));
                done
                printf "Your choice: ";
                if ! read; then
                    return;
                fi
                case "$REPLY" in
                    +([[:digit:]]))
                    if [ $REPLY -gt 0 -a $REPLY -le ${#column_names[@]} ]; then
                        col_index="$((REPLY-1))";
                        break;
                    fi
                    ;;
                *)
                    ;;
            esac
        done
        if get_column_value "$DATABASE" "$TABLE" "$col_index" "$PK" "${column_names[$col_index]}" "${data_types[$col_index]}"; then
            new_value="$(encode_text $REPLY)";
            col_number=$((col_index+1));
            awk -v value="$new_value" -v field="$col_number" -v line="$row" 'BEGIN{
                FS=":";
                OFS=":";
                value = value;
                field = field;
                line = line;
            } {
                if (NR == line)
                    {
                        $field = value;
                    }
                print $0;
            }' "./databases/data/$DATABASE/$TABLE" > tmp && mv tmp "./databases/data/$DATABASE/$TABLE";
        else
            return;
        fi
        read;
        return
    fi
fi
if [ -z "$message" ]; then
    valid_value="true";
else
    valid_value=;
    printf "\n%b" "$message";
fi
done
