#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

DIFFUTILS_VER=diffutils-3.8

wget -nc "https://ftp.gnu.org/gnu/diffutils/${DIFFUTILS_VER}.tar.xz"
tar -xf "${DIFFUTILS_VER}.tar.xz"

cd "$DIFFUTILS_VER"

./configure              \
        --prefix=/usr        \
        --host="$UPC_TARGET"
make
make               \
        DESTDIR="$UPC" \
        install
