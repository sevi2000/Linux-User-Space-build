#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf acl-2.3.1.tar.xz
cd acl-2.3.1
./configure --prefix=/usr                      \
                --disable-static                   \
                --docdir="/usr/share/doc/acl-2.3.1"
make
make install
