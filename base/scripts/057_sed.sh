#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf sed-4.8.tar.xz
cd sed-4.8
./configure --prefix=/usr
make
make install
