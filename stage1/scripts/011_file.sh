#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

FILE_VER=file-5.42

wget -nc "https://astron.com/pub/file/${FILE_VER}.tar.gz"
tar -xf "${FILE_VER}.tar.gz"

cd "$FILE_VER"

mkdir -pv build
pushd build
../configure --disable-bzlib      \
                 --disable-libseccomp \
                 --disable-xzlib      \
                 --disable-zlib
make
popd

./configure                   \
        --prefix=/usr             \
        --host="$UPC_TARGET"      \
        --build=$(./config.guess)
make                                   \
        FILE_COMPILE="$PWD/build/src/file"
make               \
        DESTDIR="$UPC" \
        install
rm -v "$UPC/usr/lib/libmagic.la"
