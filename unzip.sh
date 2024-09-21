#!/usr/bin/env bash

if [[ -z $1 || ${1##*.} != 'zip' ]]; then
    echo "Error: Need to pass zip file path"
    exit 1
fi

unzip -d . "$1"
find package/ -type f -name ParatextLite -exec chmod +x {} +