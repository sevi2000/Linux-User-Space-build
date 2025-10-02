#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf libtool-2.4.7.tar.xz
cd libtool-2.4.7
./configure --prefix=/usr
make
make install
rm -fv /usr/lib/libltdl.a
