#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf psmisc-23.5.tar.xz
cd psmisc-23.5
./configure --prefix=/usr
make
make install
