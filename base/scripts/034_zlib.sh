#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"

ZLIB_VER=zlib-1.2.13

tar -xf "${ZLIB_VER}.tar.xz"

cd "$ZLIB_VER"

./configure --prefix=/usr
 make
 make install

rm -fv /usr/lib/libz.a
