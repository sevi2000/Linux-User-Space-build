#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"
tar -xf bc-6.0.1.tar.xz
cd bc-6.0.1
CC=gcc ./configure --prefix=/usr -G -O3 -r
make
make install
