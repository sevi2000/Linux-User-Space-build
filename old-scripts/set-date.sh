#!/bin/bash

# Launch this on board inside of chroot

# Format: 2024-01-22 16:45:33

#source "$(dirname -- "$(realpath -- "$0")")"/base.sh ""
set -u -e -o pipefail

# date +"%Y-%m-%d %H:%M:%S" > "$UPC"/time.txt
# (date +"%Y-%m-%d %H:%M:%S"; cat "$UPC"/time.txt) | sort -n | tail -1 > "$UPC"/time.txt.tmp
# mv "$UPC"/time.txt.tmp "$UPC"/time.txt
# date -s "$(cat $UPC/time.txt)"

# Evade set -u
current_date=${1+"$1"}

if [ "$current_date" ]; then
    [[ $current_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}' '[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]
else
    while ! [[ $current_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}' '[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; do
        read -r -e -p "Enter date in format '2024-01-22 16:45:33': " current_date
    done
fi

printf '%s\n' "$current_date" > /time.txt
date -s "$current_date"

printf '%s\n' "$current_date"
