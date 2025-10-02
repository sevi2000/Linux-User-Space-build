#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf gdbm-1.23.tar.gz
cd gdbm-1.23
./configure --prefix=/usr    \
                --disable-static \
                --enable-libgdbm-compat
make
make install
