#!/bin/bash

# Run this on your PC
# This script will mount and unmount

set -u -e -o pipefail
PATH=$(dirname -- "$(realpath -- "$0")"):$PATH

usb_partition=/dev/disk/by-uuid/07f68027-48dd-4259-8c6c-5ee1eba0a060
usb_mountpoint=/tmp/unix-2023-usb

dir_to_copy=$(dirname -- "$(realpath -- "$0")") # Fullpath to unix-2023

mount.sh "$usb_partition" "$usb_mountpoint"

sudo rsync -av --exclude=/stage1 '--exclude=/.*' "$dir_to_copy"/ "$usb_mountpoint"/unix-2023

sudo umount "$usb_mountpoint"
sudo sync
