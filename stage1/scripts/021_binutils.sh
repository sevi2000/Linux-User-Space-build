#!/bin/bash

source scripts/000_setup.sh
BINUTILS_VER=binutils-2.39

cd "$SOURCES"

rm -fR "$BINUTILS_VER"
tar -xf "${BINUTILS_VER}.tar.xz"

cd "$BINUTILS_VER"

sed '6009s/$add_dir//' -i ltmain.sh

mkdir -vp build
cd       build

../configure                   \
        --prefix=/usr              \
        --build=$(../config.guess) \
        --host="$UPC_TARGET"       \
        --disable-nls              \
        --enable-shared            \
        --enable-gprofng=no        \
        --disable-werror           \
        --enable-64-bit-bfd

make
make               \
        DESTDIR="$UPC" \
        install
rm -v "$UPC"/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}
