#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

BINUTILS_VER=binutils-2.39
wget -nc "https://ftp.gnu.org/gnu/binutils/${BINUTILS_VER}.tar.xz"
tar -xf "${BINUTILS_VER}.tar.xz"
cd "$BINUTILS_VER/"
mkdir -pv build
cd       build

../configure                                \
        --prefix="$UPC/tools"                   \
        --with-sysroot="$UPC"                   \
        --target="$UPC_TARGET"                  \
        --disable-nls                           \
        --disable-multilib                      \
        --enable-gprofng=no                     \
        --disable-werror

make
make install
