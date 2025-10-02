#!/bin/bash

# Run this on your PC
# This script will mount and unmount

# Run cd /tmp/p3; sudo mklost+found to recreate a deleted lost+found

set -u -e -o pipefail
PATH=$(dirname -- "$(realpath -- "$0")"):$PATH

shopt -s extglob

action=$1

script_dir=$(dirname -- "$(realpath -- "$0")") # Fullpath to unix-2023

p2=/dev/disk/by-uuid/87b559d2-f127-46b6-837c-e05955149f25 # Ad
p3=/dev/disk/by-uuid/56752e43-b0fe-4505-b6b1-8a6369d82fdd

[ -e "$p2" -a -e "$p3" ] || {
    p2=/dev/disk/by-uuid/87b559d2-f127-46b6-837c-e05955149f25 # Sd
    p3=/dev/disk/by-uuid/8e02704c-2a93-42b5-97a9-fa62676bfbe7
}

[ -e "$p2" -a -e "$p3" ]

mount.sh "$p2" /tmp/p2
mount.sh "$p3" /tmp/p3

sudo cp -vf -- "$script_dir"/{enter-chroot,mount,set-p3-as-boot-partition}.sh /tmp/p2/

if [ "$action" = all ]; then
    IFS=$'\n'
    #shopt -s extglob # Due to a bug in Bash, this can't be here
    sudo rm -vrf /tmp/p3/!(lost+found) $(find /tmp/p3/ -mindepth 1 -maxdepth 1 -name '.*')

    sudo cp -vr -- "$script_dir"/stage1/upc/. /tmp/p3/
    sudo cp -vr -- "$script_dir"/stage1/sources /tmp/p3/
    sudo mkdir -pv /tmp/p3/unix-2023
    sudo cp -vr -- "$script_dir"/!(stage1) /tmp/p3/unix-2023/
elif [ "$action" = update ]; then
     # No --delete
    sudo rsync -av --exclude=/stage1 '--exclude=/.*' "$script_dir"/ /tmp/p3/unix-2023
fi

sudo umount /tmp/p2 /tmp/p3
echo "Running 'sudo sync'" >&2
sudo sync
