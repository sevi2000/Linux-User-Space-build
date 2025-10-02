#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf pkg-config-0.29.2.tar.gz
cd pkg-config-0.29.2
./configure --prefix=/usr                            \
                --with-internal-glib                     \
                --disable-host-tool                      \
                --docdir="/usr/share/doc/pkg-config-0.29.2"
make
make install
