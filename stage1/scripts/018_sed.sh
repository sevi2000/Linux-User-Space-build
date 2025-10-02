#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

SED_VER=sed-4.8

wget -nc "https://ftp.gnu.org/gnu/sed/${SED_VER}.tar.xz"
tar -xf "${SED_VER}.tar.xz"

cd "$SED_VER"

./configure --prefix=/usr        \
                --host="$UPC_TARGET"
make
make               \
        DESTDIR="$UPC" \
        install
