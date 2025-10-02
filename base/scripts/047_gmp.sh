#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf gmp-6.2.1.tar.xz
cd gmp-6.2.1
./configure --prefix=/usr                      \
                --enable-cxx                       \
                --disable-static                   \
                --docdir="/usr/share/doc/gmp-6.2.1"
make
make install
