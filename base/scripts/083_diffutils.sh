#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf diffutils-3.8.tar.xz
cd diffutils-3.8
./configure \
        --prefix=/usr
make
make install



