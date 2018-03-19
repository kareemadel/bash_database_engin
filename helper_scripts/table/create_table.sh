#!/bin/bash

# enable extglob option
shopt -s extglob;
source ./helper_scripts/generic/choose_name.sh "table";
if [ -z "$REPLY" ]; the
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
echo $is_correct;
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
i=1;
while true; do
    printf "Please select the primary key.\n";
    for column in "${colmun_names[@]}"; do
        printf "%d) %s\n" "$i" "$column";
        ((i++));
    done
    printf "Your choice: ";
    if ! read; then
        return;
        break;
    fi
    case "$REPLY" in
        +([[:digit:]]))
        PK="$((REPLY-1))";
        break;
        ;;
    *)
        ;;
esac
done
touch "./databases/data/$DATABASE/$TABLE";
touch "./databases/metadata/$DATABASE/$TABLE";
for ((i=0;i<"$number_of_columns";i++)); do
metadata="$metadata${data_types[$i]} ${colmun_names[$i]}";
if [ "$PK" = "$i" ]; then
    metadata="$metadata PK";
fi
metadata="${metadata}\n";
done
printf "%b" "${metadata}" > "./databases/metadata/$DATABASE/$TABLE";
TABLE="$REPLY";
printf "You have created the table $TABLE successfully.\n";
read;
REPLY=;
source ./helper_scripts/table/use_table.sh;
