#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf binutils-2.39.tar.xz
cd binutils-2.39
mkdir -vp build
cd       build
../configure --prefix=/usr       \
                 --sysconfdir=/etc   \
                 --enable-gold       \
                 --enable-ld=default \
                 --enable-plugins    \
                 --enable-shared     \
                 --disable-werror    \
                 --enable-64-bit-bfd \
                 --with-system-zlib
make \
        -j1 \
        tooldir=/usr
make tooldir=/usr install
rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.a
