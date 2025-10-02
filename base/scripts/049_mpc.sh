#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf mpc-1.2.1.tar.gz
cd mpc-1.2.1
./configure --prefix=/usr                      \
                --disable-static                   \
                --docdir="/usr/share/doc/mpc-1.2.1"
make
make install
