#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf check-0.15.2.tar.gz
cd check-0.15.2
./configure \
        --prefix=/usr \
        --disable-static
make
make                                   \
        docdir=/usr/share/doc/check-0.15.2 \
        install

