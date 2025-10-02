#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf patch-2.7.6.tar.xz
cd patch-2.7.6
./configure         \
        --prefix=/usr
make
make install

