#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf mpfr-4.1.0.tar.xz
cd mpfr-4.1.0
./configure --prefix=/usr                      \
                --disable-static                   \
                --enable-thread-safe               \
                --docdir=/usr/share/doc/mpfr-4.1.0
make
make install
