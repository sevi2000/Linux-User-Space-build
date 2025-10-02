#!/bin/bash

source scripts/000_setup.sh
GCC_VER=gcc-12.2.0

cd "$SOURCES/$GCC_VER/libstdc++-v3"
mkdir -vp build
cd       build

../configure                                                       \
        --host="$UPC_TARGET"                                           \
        --build=$(../../config.guess)                                  \
        --prefix=/usr                                                  \
        --disable-multilib                                             \
        --disable-nls                                                  \
        --disable-libstdcxx-pch                                        \
        --with-gxx-include-dir="/tools/$UPC_TARGET/include/c++/12.2.0"

make
make               \
        DESTDIR="$UPC" \
        install
rm -v "$UPC"/usr/lib/lib{stdc++,stdc++fs,supc++}.la
