#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf autoconf-2.71.tar.xz
cd autoconf-2.71
./configure --prefix=/usr
make
make install
