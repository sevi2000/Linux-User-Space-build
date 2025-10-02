#!/bin/sh

# Run this on the board, outside of chroot

set -u -e

mountpoint /mnt || mount /dev/mmcblk*p3 /mnt

printf "Enter current date in format '2024-01-22 16:45:33': "
read -r current_date

printf %s "$current_date" | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$' > /dev/null || {
    echo "Invalid date format" >&2
    exit 1
}

printf '%s\n' "$current_date" > /mnt/time.txt

exec /mnt/chroot.sh --login
