#!/bin/sh

export UPC=/mnt

# Clean-up function, in a handler

trap cleanup INT

cleanup() {
    # 3. Umount

    for d in sys proc run dev; do
        umount "$UPC"/"$d"
    done

    # 4. Save clock
    date +"%Y-%m-%d %H:%M:%S" > "$UPC"/time.txt
}

# 0. Restore clock

(date +"%Y-%m-%d %H:%M:%S"; cat "$UPC"/time.txt) | sort -n | tail -1 > "$UPC"/time.txt.tmp
mv "$UPC"/time.txt.tmp "$UPC"/time.txt
date -s "$(cat $UPC/time.txt)"

# 1. Preparing Virtual Kernel File Systems 

for d in dev proc sys run; do
    mkdir -pv "$UPC"/"$d"
done

mount -v --bind /dev "$UPC/dev"
mount -vt proc proc "$UPC/proc"
mount -vt sysfs sysfs "$UPC/sys"
mount -vt tmpfs tmpfs "$UPC/run"

# 2. Entering the Chroot Environment

chroot "$UPC" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(upc chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    "$@"

# 3. Clean-up procedure
cleanup
