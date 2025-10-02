#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf kbd-2.5.1.tar.xz
cd kbd-2.5.1
sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
./configure         \
        --prefix=/usr   \
        --disable-vlock
make
make install

