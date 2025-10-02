#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

GREP_VER=grep-3.7

wget -nc "https://ftp.gnu.org/gnu/grep/${GREP_VER}.tar.xz"
tar -xf "$GREP_VER.tar.xz"

cd "$GREP_VER"

./configure --prefix=/usr        \
                --host="$UPC_TARGET"
make
make               \
        DESTDIR="$UPC" \
        install
