#!/bin/sh

# Called by other scripts

set -u -e

type sudo && sudo=sudo || sudo=

dev=$1
mountpoint=$2

[ -e "$dev" ]
mkdir -pv -- "$mountpoint"

dev=$(realpath "$dev")
mountpoint=$(realpath "$mountpoint")

mount | grep -F -- "$dev on $mountpoint " && exit 0

mountpoint -- "$mountpoint" && {
    $sudo umount -- "$mountpoint"
    sleep 5
}

$sudo mount -- "$dev" "$mountpoint"
