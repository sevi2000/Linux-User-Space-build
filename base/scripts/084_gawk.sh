#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf gawk-5.1.1.tar.xz
cd gawk-5.1.1
sed -i 's/extras//' Makefile.in
./configure \
        --prefix=/usr
make
make install

