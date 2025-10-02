#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"
FILE_VER=file-5.42
tar -xf "${FILE_VER}.tar.gz"

cd "$FILE_VER"

./configure --prefix=/usr
make
make install
