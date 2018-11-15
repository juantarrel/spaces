#!/bin/bash

#./sed-spaces.sh [file-path] [-f | --fix] [-h | --help]

function usage() {
    echo "USAGE: $0 [file-path] [-f | --fix] [-h | --help]"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

while [ $# -gt 0 ]
do
    case "$1" in
        -f|--fix )
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
