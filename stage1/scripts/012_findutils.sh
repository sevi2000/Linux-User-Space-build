#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

FINDUTILS_VER=findutils-4.9.0

wget -nc "https://ftp.gnu.org/gnu/findutils/${FINDUTILS_VER}.tar.xz"
tar -xf "${FINDUTILS_VER}.tar.xz"

cd "$FINDUTILS_VER"

./configure --prefix=/usr                     \
                --localstatedir=/var/lib/locate   \
                --host="$UPC_TARGET"              \
                --build=$(build-aux/config.guess)
make
make               \
        DESTDIR="$UPC" \
        install
