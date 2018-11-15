#!/bin/bash

#./sed-spaces.sh [file-path] [-f | --fix] [-h | --help]

function usage() {
    echo "USAGE: $0 [file-path] [-f | --fix] [-h | --help]"
    exit 1
}

FIX=0 #0-do not perform fix 1-perform fix

if [ $# -eq 0 ]; then
    usage
fi

while [ $# -gt 0 ]
do
    case "$1" in
        -f|--fix )
            FIX=1
            shift
            ;;
        -h|--help )
            usage
            shift
            ;;
        * )
            if [ -f "$1" ]; then
                FILE="$1"
                shift
            else
                usage
            fi
    esac
done

if [ $FIX -eq 1 ] && [ -f "$FILE" ]; then
    echo "Fixing spaces and tabs at the beginning and at the end of lines"
    sed -i 's/[[:blank:]]\+$//' "$FILE"
    sed -i 's/^[[:blank:]]\+//' "$FILE"
    echo "DONE"
fi

#display graphically space errors
if [ -f "$FILE" ]; then
    while IFS= read -r line
    do
        #if there is no space issue on a line, just print the line
        echo "$line" | sed -e '/[[:blank:]]\+$/q9' -e '/^[[:blank:]]\+/q7' >/dev/null
        if [ $? -eq 0 ]; then
            echo "$line"
            continue
        fi
    done < "$FILE"
fi
