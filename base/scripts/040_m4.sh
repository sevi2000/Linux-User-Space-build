#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"
tar -xf m4-1.4.19.tar.xz
cd m4-1.4.19
./configure --prefix=/usr
make
make install
