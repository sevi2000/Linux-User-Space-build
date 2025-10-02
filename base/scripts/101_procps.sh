#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf procps-ng-4.0.0.tar.xz
cd procps-ng-4.0.0
./configure --prefix=/usr                         \
                --docdir="/usr/share/doc/procps-ng-4.0.0" \
                --disable-static                      \
                --disable-kill                        \
                --with-systemd
make
make install

