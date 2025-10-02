#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

BASH_VER=bash-5.1.16

wget -nc "https://ftp.gnu.org/gnu/bash/${BASH_VER}.tar.gz"
tar -xf "${BASH_VER}.tar.gz"

cd "$BASH_VER"

./configure --prefix=/usr               \
            --build=$(support/config.guess) \
            --host="$UPC_TARGET"            \
            --without-bash-malloc
make
make               \
        DESTDIR="$UPC" \
        install
ln -sv bash "$UPC/bin/sh"
