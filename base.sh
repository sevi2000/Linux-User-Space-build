#!/bin/bash

# Sourced by other scripts
# This has nothing to do with stage 3 which is called base

# When invoking read or a script that does read, prefix the command with stdout

set -u -e -o pipefail

base_dir=$(dirname -- "$(realpath -- "$BASH_SOURCE")")
PATH=$base_dir:$PATH

print-log() {
    printf '\e[1;34m%s\e[m\n' "$@" >&2
}

print-err() {
    printf '\e[1;31m%s\e[m\n' "$@" >&2
}

error-handler() {
    local exit_code=$?
    local error_line=$1
    local error_command=$(sed "${error_line}q;d" "$0" | sed -E 's/^[[:blank:]]+//')
    print-err "Error on line ${error_line}: '${error_command}', Exit code: ${exit_code}" # No need for $0
}

trap 'error-handler $LINENO' ERR

debug-handler() {
    local line=$1
    local command=$(sed -- "${line}q;d" "$0" | sed -E 's/^[[:blank:]]+//')
    print-log "Running command at line ${line}: '${command}'" # No need for $0
}

trap 'debug-handler $LINENO' DEBUG

#exec > >(trap "" INT TERM; sed -u "s/^/${0##*/}: /" >&2) # We can't do this because order is lost
#######exec 2> >(trap "" INT TERM; while read -r; do echo "$REPLY"; done >&2)

# Evade set -u
#additional_output_prefix=${1+"$1"}

# TODO This doesn't work on the board
# Prefix all output with the name of the script
#exec 3>&1
#exec 2> >(trap "" INT TERM; sed -u "s/^/$(printf '\e[1;34m')${0##*/}${additional_output_prefix:+" $additional_output_prefix"}:$(printf '\e[m') /" >&2)
#exec 1>&2

#stdout() {
#    "$@" >&3 2>&3
#}

#stdout() {
#    "$@"
#}
