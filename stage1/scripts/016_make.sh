#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

MAKE_VER=make-4.3

wget -nc "https://ftp.gnu.org/gnu/make/${MAKE_VER}.tar.gz"
tar -xf "${MAKE_VER}.tar.gz"

cd "$MAKE_VER"

./configure --prefix=/usr                     \
                --without-guile                   \
                --host="$UPC_TARGET"              \
                --build=$(build-aux/config.guess)
make
make               \
        DESTDIR="$UPC" \
        install
