#!/bin/bash

source scripts/000_stage2.sh

cd $SOURCES/

PYTHON_VER=Python-3.10.6
tar -xf "${PYTHON_VER}.tar.xz"

cd "$PYTHON_VER"

./configure --prefix=/usr   \
                --enable-shared \
                --without-ensurepip
make
make install
