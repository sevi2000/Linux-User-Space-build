#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"
tar -xf attr-2.5.1.tar.gz
cd attr-2.5.1
./configure --prefix=/usr                       \
                --disable-static                    \
                --sysconfdir=/etc                   \
                --docdir="/usr/share/doc/attr-2.5.1"
make
make install
