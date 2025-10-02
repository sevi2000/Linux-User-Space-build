#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf tar-1.34.tar.xz
cd tar-1.34
FORCE_UNSAFE_CONFIGURE=1  \
        ./configure         \
        --prefix=/usr
make
make install

