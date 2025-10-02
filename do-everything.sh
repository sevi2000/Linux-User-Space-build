#!/bin/bash

# Launch this on board inside of chroot
# You are supposed to run this script from the directory where the 001_...sh scripts are located

# Launches all scripts of form ^[0-9]{3}_.+\.sh$ in the current directory and performs an incremental backup each time

source "$(dirname -- "$(realpath -- "$0")")"/base.sh ""

# Evade set -u
# start_at is included in scripts to run
start_at=${1+"$1"}

# up_to is included in scripts to run
up_to=${2+"$2"}

scripts=$(ls scripts | grep -E "^[0-9]{3}_.+\.sh$" | sort -V)

[ "$start_at" ] && scripts=$(grep -FxA2000000000 -- "$start_at" <<< "$scripts")

[ "$up_to" ] && scripts=$(grep -FxB2000000000 -- "$up_to" <<< "$scripts")

[ "$scripts" ] || {
    print-err "There are no scripts to run"
    exit 1
}

if [ ! "$start_at" ]; then
    [[ $PWD =~ /stage1$ ]] && rm -rvf upc upc-inc
    [[ $PWD =~ /stage2$ ]] && rm -rvf mnt-inc
    [[ $PWD =~ /base$ ]] && {
        rm -rvf mnt-inc
        cp -rl ../stage2/mnt-inc mnt-inc
    }
fi

#[[ $PWD =~ /stage2$ ]] && current_date=$(stdout set-date.sh)

for i in $scripts; do
#    if [[ $PWD =~ /stage2$ ]]; then
#        do-step.sh "$i" "$current_date"
#    else
     time do-step.sh "$i"
#    fi
done
