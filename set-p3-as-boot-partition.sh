#!/bin/sh

set -u -e

p3_uuid=$(blkid /dev/mmcblk*p3 | sed 's/.* UUID="//; s/".*//') # TODO Test this

sed -Ei.bak "s/^rootdev=.*/rootdev=UUID=$p3_uuid/" /boot/ubootEnv.txt
