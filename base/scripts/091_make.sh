#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf make-4.3.tar.gz
cd make-4.3
./configure         \
        --prefix=/usr
make
make install


