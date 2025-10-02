#!/bin/bash

source scripts/000_stage2.sh

cd $SOURCES/

TEXINFO_VER=texinfo-6.8
tar -xf "${TEXINFO_VER}.tar.xz"

cd "$TEXINFO_VER"

./configure --prefix=/usr
make
make install
