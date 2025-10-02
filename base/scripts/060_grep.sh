#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf grep-3.7.tar.xz
cd grep-3.7
./configure --prefix=/usr
make
make install
