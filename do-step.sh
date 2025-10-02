#!/bin/bash

# Launch this on board inside of chroot

source "$(dirname -- "$(realpath -- "$0")")"/base.sh "$1"

script=$1
[[ $script =~ ^[^/]+'.sh'$ ]] || {
    print-err "Pass basename of script"
    exit 1
}

#[[ $PWD =~ /stage2$ ]] && {
#    # Evade set -u
#    current_date=${2+"$2"}
#    [ "$current_date" ] || current_date=$(stdout set-date.sh)
#}

mkdir -pv logs
log_number=$(ls logs | grep -c -F "$script.log" || true)
log_file=logs/$script.log.$log_number

used_space_percentage=$(df . | awk 'NR==2 { print $5 }' | sed 's/%//')
[ "$used_space_percentage" -gt 97 ] && {
    print-err "No space left on device to do step $script" 2>&1 | tee -a -- "$log_file"
    exit 1
}

mkdir -pv generated-yaml 2>&1 | tee -a -- "$log_file"

filename_no_ext=${script%".sh"}
yaml=generated-yaml/${filename_no_ext//-/_}.yaml

dir=
[[ $PWD =~ /stage1$ ]] && dir=upc
[[ $PWD =~ /(stage2|base)$ ]] && dir=/
[ "$dir" ]

./scripts/"$script" 2>&1 | sed -u "s/^/do-step.sh $1: /" | tee -a -- "$log_file"

new_tar=$(tar-inc.sh create "$dir" "$filename_no_ext") # TODO Doesn't work: 2>&1 | tee -a -- "$log_file"

print-log "Generating YAML for step $script" 2>&1 | tee -a -- "$log_file"
echo files: > "$yaml"
tar -tf "$new_tar" | grep -v '/$' | sort | sed -E 's|^\.|  - |' >> "$yaml" || true

print-log "All commands for step $script completed successfully" 2>&1 | tee -a -- "$log_file"
