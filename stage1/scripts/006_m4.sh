#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

M4_VER=m4-1.4.19

wget -nc "https://ftp.gnu.org/gnu/m4/${M4_VER}.tar.xz"
tar -xf "${M4_VER}.tar.xz"

cd "$M4_VER"

./configure --prefix=/usr                 \
            --host="$UPC_TARGET"              \
            --build=$(build-aux/config.guess) \

set +e
make
set -e -o pipefail

make               \
        DESTDIR="$UPC" \
        install-exec
