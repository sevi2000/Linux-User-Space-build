#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

XZ_VER=xz-5.2.6

wget -nc "https://tukaani.org/xz/${XZ_VER}.tar.xz"
tar -xf "${XZ_VER}.tar.xz"

cd "$XZ_VER"

./configure --prefix=/usr                       \
                --host="$UPC_TARGET"                \
                --build=$(build-aux/config.guess)   \
                --disable-static                    \
                --docdir="/usr/share/doc/${XZ_VER}"
make
make               \
        DESTDIR="$UPC" \
        install
rm -v "$UPC/usr/lib/liblzma.la"
