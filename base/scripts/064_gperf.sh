#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf gperf-3.1.tar.gz
cd gperf-3.1
./configure --prefix=/usr \
                --docdir="/usr/share/doc/gperf-3.1"
make
make install
