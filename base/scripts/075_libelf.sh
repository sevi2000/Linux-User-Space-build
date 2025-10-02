#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf elfutils-0.187.tar.bz2
cd elfutils-0.187
./configure --prefix=/usr            \
            --disable-debuginfod         \
            --enable-libdebuginfod=dummy
make
make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a
