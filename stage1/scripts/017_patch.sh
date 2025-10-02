#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

PATCH_VER=patch-2.7.6

wget -nc "https://ftp.gnu.org/gnu/patch/${PATCH_VER}.tar.xz"
tar -xf "${PATCH_VER}.tar.xz"


cd "$PATCH_VER"

./configure --prefix=/usr                     \
                --host="$UPC_TARGET"              \
                --build=$(build-aux/config.guess)

make
make               \
        DESTDIR="$UPC" \
        install
