contains_element () {
    local e match="$1"
    shift
    for e; do
        [[ "$e" == "$match" ]] && return 0;
    done
    return 1
}

create_database() {
    typeset database="$1";
    mkdir -p "./databases/data/$database";
    mkdir -p "./databases/metadata/$database";
}

delete_database () {
    typeset database="$1";
    rm -rf "./databases/data/$database";
    rm -rf "./databases/metadata/$database";
    clear
    if [ "$1" = "$DATABASE" ]; then
        DATABASE=;
        TABLE=;
    fi
    echo "You have delete the $1 database successfully."
    read;
}

create_table() {
    typeset database="$1";
    typeset table="$2";
    typeset number_of_columns="$3";
    typeset PK="$4";
    typeset -a column_names=( "${!5}" );
    typeset -a data_types=( "${!6}" );
    TABLE="$table";
    touch "./databases/data/$database/$table";
    touch "./databases/metadata/$database/$table";
    metadata=;
    for ((i=0;i<"$number_of_columns";i++)); do
    metadata="$metadata${data_types[$i]} ${column_names[$i]}";
    if [ "$PK" = "$i" ]; then
        metadata="$metadata PK";
    fi
    metadata="${metadata}";
    echo "${metadata}" >> "./databases/metadata/$database/$table";
    metadata=;
    done
    return;
}

encode_text() {
    typeset input_string="$1";
    echo -n "$input_string" | xxd -p | tr [:space:] \\000;
}

decode_text() {
    typeset input_string="$1";
    echo -n "$input_string" | xxd -r -p;
}

get_data_types() {
    typeset database="$1";
    typeset table="$2";
    echo "$(cut -d' ' -f 1 databases/metadata/$database/$table)"
}

get_column_names() {
    typeset database="$1";
    typeset table="$2";
    echo "$(cut -d' ' -f 2 databases/metadata/$database/$table)";
}

get_PK() {
    typeset database="$1";
    typeset table="$2";
    echo -n "$(( $(cut -d' ' -f3 "databases/metadata/$database/$table" | grep -n PK | cut -d: -f1)-1 ))";
}

get_number_of_columns() {
    typeset database="$1";
    typeset table="$2";
    wc -l < "databases/metadata/$database/$table";
}

is_integer() {
    if [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
        return 0;
    else
        return 1;
    fi
}

is_null() {
    if [ -z "$1" ]; then
        return 0;
    else
        return 1;
    fi
}

is_unique() {
    typeset value="$(encode_text "$1")";
    typeset database="$2";
    typeset table="$3";
    # column index staring from 0
    typeset column_index="$4";
    typeset column_number=$(($column_index+1));
    typeset -a values=( $(cut -d: -f "$column_number" "databases/data/$database/$table") );
    ! contains_element "$value"  "${values[@]}";
}

add_row() {
    typeset row="$1";
    typeset database="$2";
    typeset table="$3";
    echo "$row" >> "databases/data/$database/$table";
}

find_row() {
    typeset value="$(encode_text "$1")";
    typeset database="$2";
    typeset table="$3";
    # column index staring from 0
    typeset column_index="$4";
    typeset column_number=$(($column_index+1));
    typeset line_number=$(cut -d: -f $column_number "databases/data/$database/$table" | grep -n "^${value}$" | cut -d: -f 1);
    if [ -n $line_number ]; then
        return $line_number;
    else
        return 0;
    fi
}

get_column_value() {
    typeset database="$1";
    typeset table="$2";
    typeset index="$3";
    typeset PK="$4";
    typeset column_name="${5}";
    typeset data_type="${6}";
    typeset valid_value=;
    REPLY=;
    while [ -z "$valid_value" ]; do
        echo -n "Please inert the value of ${column_name} (${data_type}): ";
        if [ "${data_type}" = "int" ]; then
            source ./helper_scripts/generic/read_integer.sh "accept_null"
            if [ -z "$REPLY" ]; then
                return 1;
            elif [ "$REPLY" = "null" ]; then
                REPLY=;
            fi
        elif [ "${data_type}" = "str" ]; then
            if ! IFS=$'\n' read -r; then
                return 1;
            fi
        fi
        if [ "$PK" = "$index" ]; then
            message=;
            if is_null "$REPLY"; then
                message="Primary key can't be null.\n";
            fi
            if ! is_unique "$REPLY" "$database" "$table" "$index"; then
                message="${message}Primary key must be unique.\n"
            fi
            if [ -z "$message" ]; then
                valid_value="true";
            else
                valid_value=;
                printf "\n%b" "$message";
            fi
        else
            valid_value="true";
        fi
    done
    return 0;
}
