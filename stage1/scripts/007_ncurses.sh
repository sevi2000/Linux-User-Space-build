#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

NCURSES_VER=ncurses-6.3

wget -nc "https://invisible-mirror.net/archives/ncurses/${NCURSES_VER}.tar.gz"
tar -xf "${NCURSES_VER}.tar.gz"

cd "$NCURSES_VER"

mkdir -vp build
pushd build
../configure
make -C include
make -C progs tic
popd

./configure --prefix=/usr            \
            --host="$UPC_TARGET"         \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-normal             \
            --with-cxx-shared            \
            --without-debug              \
            --without-ada                \
            --disable-stripping          \
            --enable-widec
make
make DESTDIR="$UPC"                  \
         TIC_PATH="$PWD/build/progs/tic" \
         install
echo "INPUT(-lncursesw)" > "$UPC/usr/lib/libncurses.so"
