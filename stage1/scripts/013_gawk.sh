#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

GAWK_VER=gawk-5.1.1

wget -nc "https://ftp.gnu.org/gnu/gawk/${GAWK_VER}.tar.xz"
tar -xf "${GAWK_VER}.tar.xz"

cd "$GAWK_VER"

sed -i 's/extras//' Makefile.in
./configure --prefix=/usr                     \
                --host="$UPC_TARGET"              \
                --build=$(build-aux/config.guess)
make
make               \
        DESTDIR="$UPC" \
        install
