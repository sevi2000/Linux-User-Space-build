#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf gzip-1.12.tar.xz
cd gzip-1.12
./configure \
        --prefix=/usr
make
make install

