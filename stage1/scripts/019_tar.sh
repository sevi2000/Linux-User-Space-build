#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

TAR_VER=tar-1.34

wget -nc "https://ftp.gnu.org/gnu/tar/${TAR_VER}.tar.xz"
tar -xf "${TAR_VER}.tar.xz"

cd "$TAR_VER"

./configure --prefix=/usr                     \
                --host="$UPC_TARGET"              \
                --build=$(build-aux/config.guess)
make
make               \
        DESTDIR="$UPC" \
        install
