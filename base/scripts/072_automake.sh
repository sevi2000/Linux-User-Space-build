#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf automake-1.16.5.tar.xz
cd automake-1.16.5
./configure                                 \
        --prefix=/usr                           \
        --docdir="/usr/share/doc/automake-1.16.5"
make
make install
