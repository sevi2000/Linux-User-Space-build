#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf libpipeline-1.5.6.tar.gz
cd libpipeline-1.5.6
./configure         \
        --prefix=/usr
make
make install
