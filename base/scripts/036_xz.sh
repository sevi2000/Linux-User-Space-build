#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"

XZ_VER=xz-5.2.6
tar -xf "${XZ_VER}.tar.xz"

cd "$XZ_VER"

./configure --prefix=/usr                     \
                --disable-static                  \
                --docdir="/usr/share/doc/$XZ_VER"
make
make install
