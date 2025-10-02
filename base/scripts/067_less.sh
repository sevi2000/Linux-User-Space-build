#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf less-590.tar.gz
cd less-590
./configure           \
        --prefix=/usr     \
        --sysconfdir=/etc
make
make install
