#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"

GCC_VER=gcc-12.2.0
tar -xf "${GCC_VER}.tar.xz"

cd "$GCC_VER"

mkdir -pv build
cd       build

../configure --prefix=/usr        \
             LD=ld                    \
             --enable-languages=c,c++ \
             --disable-multilib       \
             --disable-bootstrap      \
             --with-system-zlib

make \
        -j1
make install
ln -svr /usr/bin/cpp /usr/lib

ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/12.2.0/liblto_plugin.so \
        /usr/lib/bfd-plugins/

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
