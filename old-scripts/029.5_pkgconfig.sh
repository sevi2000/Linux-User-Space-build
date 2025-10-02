#!/bin/bash

source 000_stage2.sh

cd $SOURCES/

PKGCONFIG_VER=pkg-config-0.29.2
tar -xf "${PKGCONFIG_VER}.tar.gz"

cd "$PKGCONFIG_VER"

./configure --with-internal-glib --prefix=/usr

make

make install
