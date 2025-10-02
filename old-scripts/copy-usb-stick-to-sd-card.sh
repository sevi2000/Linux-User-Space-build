#!/bin/sh

# Launch this on board outside of chroot
# This script will mount and unmount

# This script and mount.sh are supposed to be at the root of p2. Running this won't make this script update itself or mount.sh.

set -u -e
PATH=$(dirname -- "$(realpath "$0")"):$PATH

mount.sh /dev/mmcblk*p3 /mnt
mount.sh /dev/sda1 /unix-2023-usb

IFS='
'

cp -va -- $(find /unix-2023-usb/unix-2023/ -mindepth 1 -maxdepth 1) /mnt/unix-2023/

sudo umount /unix-2023-usb
sudo sync
