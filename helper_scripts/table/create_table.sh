#!/bin/bash

# enable extglob option
shopt -s extglob;

source ./helper_scripts/generic/helper_functions.sh

source ./helper_scripts/generic/choose_name.sh "table";
table_name="$REPLY";
if [ -z "$REPLY" ]; then
    n
    return
fi
printf "Please enter the number of the columns in the table: ";
source ./helper_scripts/generic/read_integer.sh;
if [ -z "$REPLY" ]; then
    return
fi
number_of_columns="$REPLY";
i=0;
colmun_names=();
while [ $i -lt $number_of_columns ]; do
    source ./helper_scripts/generic/choose_name.sh "column $((i+1))" "${colmun_names[@]}";
    if [ -z "$REPLY" ]; then
        return
    fi
    colmun_names+=( "$REPLY" );
    while true; do
        printf "Please select the data type of column %d.\n" $(($i + 1));
        printf "1) Integer.\n";
        printf "2) String.\n";
        printf "Your choice: ";
        if ! read -r; then
            return;
        fi
        case $REPLY in
            1)
                data_types[$i]="int";
                ((i++));
                break;
                ;;
            2)
                data_types[$i]="str";
                ((i++));
                break;
                ;;
            *)
                ;;
        esac
    done
done
while true; do
    printf "Please select the primary key.\n";
    i=1;
    for column in "${colmun_names[@]}"; do
        echo "$i) $column";
        ((i++));
    done
    printf "Your choice: ";
    if ! read; then
        return;
        break;
    fi
    case "$REPLY" in
        +([[:digit:]]))
        if [ $REPLY -gt 0 -a $REPLY -le ${#colmun_names[@]} ]; then
            PK="$((REPLY-1))";
            break;
        fi
        ;;
    *)
        ;;
    esac
done
create_table "$DATABASE" "$table_name" "$number_of_columns" "$PK" colmun_names[@] data_types[@];
echo "You have created the table $TABLE successfully.";
read;
REPLY=;
source ./helper_scripts/table/use_table.sh;
