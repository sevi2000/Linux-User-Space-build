#!/bin/bash

source scripts/000_stage2.sh

cd $SOURCES/

BISON_VER=bison-3.8.2
tar -xf "${BISON_VER}.tar.xz"

cd "$BISON_VER"

./configure --prefix=/usr \
                --docdir="/usr/share/doc/$BISON_VER"
make
make install
