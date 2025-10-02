#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

GZIP_VER=gzip-1.12

wget -nc "https://ftp.gnu.org/gnu/gzip/${GZIP_VER}.tar.xz"
tar -xf "${GZIP_VER}.tar.xz"

cd "$GZIP_VER"

./configure              \
        --prefix=/usr        \
        --host="$UPC_TARGET"
make
make               \
        DESTDIR="$UPC" \
        install
