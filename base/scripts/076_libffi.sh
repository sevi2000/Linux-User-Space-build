#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf libffi-3.4.2.tar.gz
cd libffi-3.4.2
./configure --prefix=/usr           \
            --disable-static            \
            --with-gcc-arch=native      \
            --disable-exec-static-tramp
make
make install
