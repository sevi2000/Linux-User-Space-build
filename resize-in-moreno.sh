#!/bin/bash

mount /dev/mmcblk*p2 /mnt; /unix-2023/chroot-run-cmd.sh /usr/bin/resize
