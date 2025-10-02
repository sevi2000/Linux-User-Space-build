#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf expat-2.5.0.tar.xz
cd expat-2.5.0
./configure                              \
        --prefix=/usr                        \
        --disable-static                     \
        --docdir="/usr/share/doc/expat-2.5.0"
make
make install
